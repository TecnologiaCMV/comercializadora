USE [DB_A57E86_lluviadesarrollo]
GO
/****** Object:  StoredProcedure [dbo].[SP_REALIZA_VENTA]    Script Date: 12/09/2020 11:39:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		guarda la venta en el sistema
status			200 = ok
				-1	= error
*/

ALTER proc [dbo].[SP_REALIZA_VENTA]

	@xml					AS XML, 
	@idCliente				int,
	@idFactFormaPago		int,
	@idFactUsoCFDI			int,
	@idVenta				int,
	@idUsuario				int,
	@idEstacion				int,
	@aplicaIVA				int,
	@numClientesAtendidos	int,
	@tipoVenta				int,  -- 1-Normal / 2-Devolucion / 3-Agregar Productos a la venta
	@motivoDevolucion		varchar(255),
	@idPedidoEspecial       int=0

as

	begin -- principal
	
		begin try

			begin --declaraciones 

				declare @status					int = 200,
						@mensaje				varchar(255) = 'Se registro la venta correctamente.',
						@error_line				varchar(255) = '',
						@error_procedure		varchar(255) = '',
						@tran_name				varchar(32) = 'REALIZA_VTA',
						@tran_count				int = @@trancount,
						@tran_scope				bit = 0,						
						@totalProductos			int = 0,
						@montoTotal				money = 0,
						@descuento				money = 0.0,
						@ini					int = 0, 
						@fin					int = 0,
						@fecha					datetime,
						@cantProductosLiq       int=0


				create table
					#Ventas
						(	
							contador			int identity(1,1),
							idCliente			int,
							cantidad			float,
							fechaAlta			datetime,
							montoTotal			money,
							idUsuario			int,
							idStatusVenta		int,
							idFactFormaPago		int
						)

				create table
					#VentasDetalle
						(
							idVentaDetalle					int,
							idVenta							int,
							idProducto						int,
							cantidad						float,
							contadorProductosPorPrecio		int,
							monto							money,
							cantidadActualInvGeneral		float,
							cantidadAnteriorInvGeneral		float						
						)

				create table 
					#cantidades 
						(  
							id			int identity(1,1),
							cantidad	int
						)

				create table 
					#idProductos 
						(  
							id			int identity(1,1),
							idProducto	int
						)

				create table
					#productosDevueltos
						(
							id					int identity(1,1),
							productosDevueltos	int	
						)

				create table
					#idVentaDetalle
						(
							id					int identity(1,1),
							idVentaDetalle		int	
						)

			end  --declaraciones 

			begin -- principal

				begin -- inicio transaccion
					if @tran_count = 0
						begin tran @tran_name
					else
						save tran @tran_name
					select @tran_scope = 1
				end -- inicio transaccion

				select @idFactFormaPago = coalesce(@idFactFormaPago, '1')
				select @fecha = coalesce(@fecha, dbo.FechaActual())

				insert into #cantidades (cantidad)
				SELECT Ventas.cantidad.value('.','NVARCHAR(200)') AS cantidad FROM @xml.nodes('//cantidad') as Ventas(cantidad) 

				insert into #idProductos (idProducto)
				SELECT Ventas.idProducto.value('.','NVARCHAR(200)') AS idProducto FROM @xml.nodes('//idProducto') as Ventas(idProducto)

				insert into #productosDevueltos (productosDevueltos)
				SELECT Ventas.productosDevueltos.value('.','NVARCHAR(200)') AS productosDevueltos FROM @xml.nodes('//productosDevueltos') as Ventas(productosDevueltos)

				insert into #idVentaDetalle (idVentaDetalle)
				SELECT Ventas.idVentaDetalle.value('.','NVARCHAR(200)') AS idVentaDetalle FROM @xml.nodes('//idVentaDetalle') as Ventas(idVentaDetalle)
				
				-- validamos si el cliente tiene descuento por aplicar
				select	@descuento = t.descuento
				from	clientes c
						inner join CatTipoCliente t
							on c.idTipoCliente = t.idTipoCliente
				where	c.idCliente = @idCliente				

				-- universo de venta de productos
				select	p.idProducto, c.cantidad, cast(0 as int) as contador, cast(0 as money) as costo, cast(0 as money) as precioPorProducto,
						coalesce(p.precioIndividual, 0) as precioIndividual, coalesce(p.precioMenudeo, 0) as precioMenudeo, 
						cast(0 as money) as precioRango, @aplicaIVA as aplicaIVA ,  cast(0 as money) as  montoIva, 
						cast(0 as money) as  montoVenta, cast(0 as money) as  precioVenta, cast(0 as money) as porcentajeDescuentoCliente
				into	#vta
				from	#cantidades c
						inner join #idProductos p_
							on c.id = p_.id
						inner join Productos p
							on p.idProducto = p_.idProducto
							

				if ( @tipoVenta = 1 )
				begin  --  1-Normal 

					select @totalProductos = sum(cantidad) from #vta
				
					-- primero precios individual y menudeo
					update	#vta
					set		costo =	case
										when @totalProductos >= 12 then cantidad * precioMenudeo
										else cantidad * precioIndividual
									end,
							precioVenta =	case
												when @totalProductos >= 12 then precioMenudeo
												else precioIndividual
											end

					-- se actualiza el precio de venta y el precio del rango con que se hizo la venta en caso q exista un precio de rango
					update	#vta
					set		#vta.precioVenta = a.precioRango,
							#vta.precioRango = a.precioRango
					from	(
								select	v.idProducto, v.cantidad, ppp.costo as precioRango, ppp.min, ppp.max
								from	#vta v
											inner join ProductosPorPrecio ppp
												on ppp.idProducto = v.idProducto
											inner join (select idProducto,max(max) maxCantRango 
														from ProductosPorPrecio 
														where
														activo = cast(1 as bit)
														group by idProducto) maxRango 
												on ppp.idProducto=maxRango.idProducto
								where	ppp.activo = cast(1 as bit)
									--and	v.cantidad between ppp.min and ppp.max
									and	v.cantidad>=min and v.cantidad<=case when v.cantidad>maxCantRango and max=maxCantRango
									then v.cantidad else max end

							)A
					where	#vta.idProducto = a.idProducto


					-- si hay descuento
					if ( @descuento > 0.0 )
					begin
						update	#vta set #vta.porcentajeDescuentoCliente = @descuento
						update	#vta set #vta.precioVenta = #vta.precioVenta - (#vta.precioVenta * ( @descuento / 100 ))
					end

					-- actualizamos el precio final
					update	#vta 
					set		#vta.costo = precioVenta * cantidad

					if ( @aplicaIVA = 1 )
						begin
							update	#vta
							set		montoIva = costo * 0.16
						end

					update	#vta
					set		montoVenta = costo --+ montoIva

					-- si existe el producto en el inventario general
					if  exists	( 
										select 1 from #vta v left join InventarioGeneral g on v.idProducto=g.idProducto
										where g.idProducto is null
									)
					begin
						select @mensaje = 'El producto no se encuentra en el inventario.'
						raiserror (@mensaje, 11, -1)
					end

					-- si el producto no tiene un precio asignado en tabla de productos 
					if exists ( select 1 from #vta where montoVenta <= 0 )
					begin
						select @mensaje = 'El producto no tiene un precio asignado.'
						raiserror (@mensaje, 11, -1)
					end

					----validamos pedido especial
					if(@idPedidoEspecial>0)
					begin					
					   
					   declare @idEstatusPedidoInterno int					   

					  if not exists(select 1 from PedidosInternos where idPedidoInterno=@idPedidoEspecial and idTipoPedidoInterno=2)
					    raiserror('El número de ticket de pedido especial no existe', 11, -1)

					   select @idEstatusPedidoInterno=idEstatusPedidoInterno from PedidosInternos where idPedidoInterno=@idPedidoEspecial
					  
					  if (@idEstatusPedidoInterno!=4)
					  begin
					     declare @msg varchar(100)
						 select @msg='El pedido especial se encuentra en estatus de ' + coalesce((select descripcion from catestatuspedidointerno where idEstatusPedidoInterno=@idEstatusPedidoInterno),'')
					     raiserror(@msg, 11, -1)
					  end

					  if exists(select 1 from PedidosInternos where idPedidoInterno=@idPedidoEspecial and idAlmacenOrigen<>(select idAlmacen from usuarios where idUsuario=@idUsuario))
					    raiserror('El pedido especial no pertenece a tu almacen', 11, -1)

					end
				
					-- si todo bien
						select @montoTotal = sum(montoVenta+montoIva) from #vta

					-- inserta en tablas fisicas
						insert into Ventas (idCliente,cantidad,fechaAlta,montoTotal,idUsuario,idStatusVenta,idFactFormaPago,idFactUsoCFDI,idEstacion)
						select	@idCliente as idCliente, @totalProductos as cantidad , dbo.FechaActual() as fechaAlta, 
								@montoTotal as montoTotal, @idUsuario as idUsuario, 1 as idStatusVenta,
								@idFactFormaPago as idFactFormaPago, @idFactUsoCFDI as idFactUsoCFDI, @idEstacion as idEstacion 

						select @idVenta = max(idVenta)  from Ventas


					-- se inserta el detalle de los productos que se vendieron
						insert into 
							VentasDetalle 
								(
									idVenta,idProducto,cantidad,contadorProductosPorPrecio,monto,cantidadActualInvGeneral,cantidadAnteriorInvGeneral,
									precioIndividual,precioMenudeo,precioRango,montoIVA,precioVenta
								)
						select	@idVenta as idVenta, v.idProducto, v.cantidad, v.contador, v.montoVenta, i.cantidad - v.cantidad as cantidadActualInvGeneral,
								i.cantidad as cantidadAnteriorInvGeneral, v.precioIndividual, v.precioMenudeo, v.precioRango, v.montoIva, v.precioVenta
						from	#vta v
								inner join InventarioGeneral i
									on v.idProducto = i.idProducto



					-- calculamos las existencias del inventario despues de la venta
					select idProducto, sum(cantidad) as cantidad into #totProductos from #vta group by idProducto

					select	idInventarioDetalle, id.idProducto, id.cantidad, fechaAlta, id.idUbicacion, 
							fechaActualizacion, cast(0 as int) as cantidadDescontada, 
							cast(0 as int) as cantidadFinal
					into	#tempExistencias 
					from	Usuarios u
								inner join Almacenes a
									on a.idAlmacen = u.idAlmacen
								inner join Ubicacion ub
									on ub.idAlmacen = a.idAlmacen
								inner join InventarioDetalle id
									on id.idUbicacion = ub.idUbicacion
								inner join #totProductos p
									on p.idProducto = id.idProducto
					where	u.idUsuario = @idUsuario
						and	id.cantidad > 0

					if not exists ( select 1 from #tempExistencias)
						begin
							select @mensaje = 'No se realizo la venta, no se cuenta con suficientes existencias en el inventario.'
							raiserror (@mensaje, 11, -1)
						end


					-- se calcula de que ubicaciones se van a descontar los productos
					select @ini = min(idProducto), @fin= max(idProducto) from #totProductos

					while ( @ini <= @fin )
						begin
							declare	@cantidadProductos as int = 0
							select	@cantidadProductos = cantidad from #totProductos where idProducto = @ini

							while ( @cantidadProductos > 0 )
								begin
									declare @cantidadDest as int = 0, @idInventarioDetalle as int = 0
									select	@cantidadDest = coalesce(max(cantidad), 0) from #tempExistencias where idProducto = @ini and cantidadDescontada = 0
									select	@idInventarioDetalle = idInventarioDetalle from #tempExistencias where idProducto = @ini and cantidadDescontada = 0 and cantidad = @cantidadDest

									-- si ya no hay ubicaciones con existencias a descontar
									if ( @cantidadDest = 0 )
										begin
											update  #tempExistencias set cantidadDescontada = (select cantidad from #totProductos where idProducto = @ini)
											where	idProducto = @ini
											select @cantidadProductos = 0
										end
									else
										begin
											if ( @cantidadDest >= @cantidadProductos )
												begin 
													update #tempExistencias set cantidadDescontada = @cantidadProductos 
													where idProducto = @ini and idInventarioDetalle = @idInventarioDetalle
													select @cantidadProductos = 0 
												end
											else
												begin
													update	#tempExistencias set cantidadDescontada = @cantidadDest
													where	 idProducto = @ini and idInventarioDetalle = @idInventarioDetalle
													select @cantidadProductos = @cantidadProductos - @cantidadDest						
												end
										end 
								end

							select @ini = min(idProducto) from #totProductos where idProducto > @ini

						end  -- while ( @ini <= @fin )

						update	#tempExistencias
						set		cantidadFinal = cantidad - cantidadDescontada

						-- si el inventario de los productos vendidos queda negativo se paso de productos = rollback
						if  exists	( select 1 from #tempExistencias where cantidadFinal < 0 )
						begin
							select @mensaje = 'No se realizo la venta, no se cuenta con suficientes existencias en el inventario.'
							raiserror (@mensaje, 11, -1)
						end

						--se actualiza inventario_general_log
						INSERT INTO InventarioGeneralLog(idProducto,cantidad,cantidadDespuesDeOperacion,fechaAlta,idTipoMovInventario)
						select a.idProducto,sum(a.cantidad),b.cantidad-sum(a.cantidad),dbo.FechaActual(),1 
						from #totProductos a
						join InventarioGeneral b on a.idProducto=b.idProducto
						group by a.idProducto,b.cantidad
					

						-- se actualiza inventario detalle
						update	InventarioDetalle
						set		cantidad = a.cantidadFinal,
								fechaActualizacion = dbo.FechaActual()
						from	(
									select	idInventarioDetalle, idProducto, cantidad, idUbicacion, cantidadDescontada, cantidadFinal
									from	#tempExistencias
								)A
						where	InventarioDetalle.idInventarioDetalle = a.idInventarioDetalle

						-- se actualiza el inventario general
						update	InventarioGeneral
						set		InventarioGeneral.cantidad = InventarioGeneral.cantidad - A.cantidad,
								fechaUltimaActualizacion = dbo.FechaActual()
						from	(
									select idProducto, cantidad from #totProductos
								)A
						where InventarioGeneral.idProducto = A.idProducto


						-- se inserta el InventarioDetalleLog
						insert into InventarioDetalleLog (idUbicacion,idProducto,cantidad,cantidadActual,idTipoMovInventario,idUsuario,fechaAlta,idVenta)
						select	idUbicacion, idProducto, cantidadDescontada, cantidadFinal, cast(1 as int) as idTipoMovInventario,
								@idUsuario as idUsuario, dbo.FechaActual() as fechaAlta, @idVenta as idVenta
						from	#tempExistencias
						where	cantidadDescontada > 0

						-- si tiene clientes atendidos de ruta
						if ( @numClientesAtendidos > 0)
							begin 
							
								insert into	
									ClientesAtendidosRuta
										(cantidad,idVenta,idUsuario,idEstacion,fechaAlta)
								values
									(@numClientesAtendidos, @idVenta, @idUsuario, @idEstacion, @fecha)

							end

					  select @cantProductosLiq=sum(a.cantidad) from #totProductos a join Productos b on a.idProducto=b.idProducto and b.idLineaProducto in (19,20)
					    
					--pedidos especiales actualizamos el estatus
					if(@idPedidoEspecial>0) 
					begin

						UPDATE  pedidosInternos set idEstatusPedidoInterno=6,idVenta=@idVenta where idPedidoInterno=@idPedidoEspecial				

						INSERT INTO pedidosInternosLog(idPedidoInterno,idAlmacenOrigen,idAlmacenDestino,idUsuario,fechaAlta,idEstatusPedidoInterno)
						select @idPedidoEspecial,idAlmacenOrigen,0 idAlmacenDestino,@idUsuario,dbo.FechaActual(),6
						from pedidosInternos where idPedidoInterno=@idPedidoEspecial
					
					end 

				end --  1-Normal


				if ( @tipoVenta = 2 )
				begin  --  2-Devolucion 

					select @mensaje= 'Se realizaron las devoluciones correctamente.'
					
					-- universo de devoluciones
					select	p.idProducto, c.cantidad, 
							coalesce(dev.productosDevueltos, 0) as productosDevueltos,
							coalesce(vd.idVentaDetalle, 0) as idVentaDetalle , coalesce(idVenta.idVentaDetalle, 0) as idVentaDetalle_temp
					into	#devoluciones
					from	#cantidades c
							inner join #idProductos p_
								on c.id = p_.id
							inner join Productos p
								on p.idProducto = p_.idProducto
							left join #productosDevueltos dev
								on dev.id = c.id
							left join #idVentaDetalle idVenta
								on idVenta.id = c.id	
							left join VentasDetalle vd 
								on vd.idVentaDetalle = idVenta.idVentaDetalle
					
					--select '#devoluciones',(cantidad - productosDevueltos) as diff, * from #devoluciones

					if not exists ( select 1 from Ventas where idVenta = @idVenta and idStatusVenta = 1 )
					begin
						select @mensaje = 'No existe la venta que quiere modificar.'
						raiserror (@mensaje, 11, -1)
					end

					if exists ( select 1 from #devoluciones where (cantidad - productosDevueltos) < 0 )
					begin
						select @mensaje = 'No puede regresar mas productos de los que se vendieron.'
						raiserror (@mensaje, 11, -1)
					end

					if exists ( select 1 from VentasDetalle where idVenta = @idVenta and montoIva > 0 )
					begin
						select @mensaje = 'No puede hacer una devolucion en una venta facturada.'
						raiserror (@mensaje, 11, -1)
					end

					if	(
							(select coalesce(devoluciones,0) from Ventas where idVenta = @idVenta) >=
							(select cantidad from ModificacionesPermitidasVenta where id = 1)
						)
					begin
						select @mensaje = 'No es posible hacer mas devoluciones a esta venta.'
						raiserror (@mensaje, 11, -1)
					end					
					
					-- actualizar productos regresados a VentasDetalle
					update	VentasDetalle
					set		VentasDetalle.idEstatusProductoVenta = 1, --Devuelto,
							VentasDetalle.productosDevueltos = a.productosDevueltos,
							VentasDetalle.cantidad = a.cantidad - a.productosDevueltos,
							VentasDetalle.monto = ( a.cantidad - a.productosDevueltos ) * VentasDetalle.precioVenta
					from	(
								select	idVentaDetalle, idProducto, cantidad, productosDevueltos
								from	#devoluciones 
							)A
					where	VentasDetalle.idVentaDetalle = a.idVentaDetalle
						and	VentasDetalle.idVenta = @idVenta

						
					-- actualizamos tabla de ventas
					update	Ventas
					set		Ventas.cantidad = a.cantidad,
							Ventas.montoTotal = a.montoTotal,
							Ventas.devoluciones = coalesce(Ventas.devoluciones, 0) + 1,
							Ventas.observaciones = @motivoDevolucion
					from	(
								select	sum(cantidad)  as cantidad, sum(monto) as montoTotal, idVenta
								from	VentasDetalle
								where	idVenta = @idVenta
								group by idVenta
							)A
					where	Ventas.idVenta = a.idVenta


					-- actualizamos InventarioGeneralLog
					insert into InventarioGeneralLog (idProducto,cantidad,cantidadDespuesDeOperacion,fechaAlta,idTipoMovInventario)
					select	d.idProducto, sum(productosDevueltos) as cantidad, 
							( ig.cantidad + sum(productosDevueltos) ) as cantidadDespuesDeOperacion,
							@fecha as fechaAlta, 15 as idTipoMovInventario
					from	#devoluciones d
								inner join InventarioGeneral ig
									on ig.idProducto = d.idProducto
					group by d.idProducto, ig.cantidad

					-- actualizamos InventarioGeneral
					update	InventarioGeneral
					set		InventarioGeneral.cantidad = InventarioGeneral.cantidad + a.totProductosDevueltos
					from	(
								select	idProducto, sum(productosDevueltos) as totProductosDevueltos
								from	#devoluciones
								group by idProducto
							)A
					where	InventarioGeneral.idProducto = a.idProducto



					-- actualizamos InventarioDetalleLog

					--ubicaciones de donde se saco el producto
					select	idl.idProducto, idl.idUbicacion, idl.cantidad, idl.idTipoMovInventario, u.idAlmacen
					into	#tempUbicacionesDevoluciones
					from	InventarioDetalleLog idl
								inner join Ubicacion u
									on u.idUbicacion = idl.idUbicacion
					where	idl.idVenta = @idVenta
						and	idTipoMovInventario = 1 -- las que se vendieron 
					group by idl.idProducto, idl.idUbicacion, idl.cantidad, idl.idTipoMovInventario, u.idAlmacen

					select	t.* , u.idUbicacion as idUbicacionRegresar
					into	#tempUbicacionesDevoluciones_
					from	#tempUbicacionesDevoluciones t
								left join Ubicacion u
									on t.idAlmacen = u.idAlmacen
					where	u.idPasillo = 0
						and	u.idRaq = 0
						and u.idPiso = 0

					--	verificamos si existe el id sin ubicacion
					if exists	(
									select 1 from #tempUbicacionesDevoluciones_ where idUbicacionRegresar is null
								)
					begin
						insert into Ubicacion (idAlmacen, idPasillo, idRaq, idPiso)
						select idAlmacen, 0,0,0 from #tempUbicacionesDevoluciones_
					end

					-- inserta los registros que se regresaron
					insert	into InventarioDetalleLog (idUbicacion, idProducto, cantidad, cantidadActual, idTipoMovInventario, idUsuario, fechaAlta, idVenta)
					select	temp.idUbicacionRegresar, temp.idProducto, devueltos.productosDevueltos, actuales.cantidad + devueltos.productosDevueltos as cantidadActual,
							15 as idTipoMovInventario, @idUsuario as idUsuario, @fecha as fechaAlta, @idVenta as idVenta
					from	#tempUbicacionesDevoluciones_ temp
								join (
										select	idProducto, sum(productosDevueltos) as productosDevueltos 
										from	VentasDetalle 
										where	idVenta = @idVenta 
											and productosDevueltos > 0
										group by idProducto
								
									 )devueltos on devueltos.idProducto = temp.idProducto
								join InventarioDetalle actuales
									on actuales.idProducto = temp.idProducto and actuales.idUbicacion = temp.idUbicacionRegresar


					-- actualizamos InventarioDetalle
					update	InventarioDetalle 
					set		InventarioDetalle.cantidad = a.cantidad,
							InventarioDetalle.fechaActualizacion  = @fecha
					from	(
								select	temp.idProducto, actuales.cantidad + devueltos.productosDevueltos as cantidad, temp.idUbicacionRegresar
								from	#tempUbicacionesDevoluciones_ temp
											join (
													select	idProducto, sum(productosDevueltos) as productosDevueltos 
													from	VentasDetalle 
													where	idVenta = @idVenta 
														and productosDevueltos > 0
													group by idProducto								
												 )devueltos on devueltos.idProducto = temp.idProducto
											join InventarioDetalle actuales
												on actuales.idProducto = temp.idProducto and actuales.idUbicacion = temp.idUbicacionRegresar
							)A
					where	InventarioDetalle.idUbicacion = a.idUbicacionRegresar
						and	InventarioDetalle.idProducto = a.idProducto

					drop table #devoluciones

				end

				
				if ( @tipoVenta = 3 )
				begin  --  3-Agregar Productos a la venta

					select @mensaje= 'Se agregaron los productos a la venta correctamente.'
					
					 --universo de productos agregados
					select	c.id, c.cantidad, p_.idProducto, idVenta.idVentaDetalle,
							cast(0 as money) as costo, 
							cast(0 as money) as precioVenta,
							p.precioIndividual,
							p.precioMenudeo,
							cast(0 as money) as precioRango,
							cast(0 as money) as montoVenta,
							cast(0 as money) as porcentajeDescuentoCliente							
					into	#productosAgregados
					from	#cantidades c
							inner join #idProductos p_
								on c.id = p_.id
							inner join Productos p
								on p.idProducto = p_.idProducto
							left join #idVentaDetalle idVenta
								on idVenta.id = c.id	
							

					if not exists ( select 1 from Ventas where idVenta = @idVenta and idStatusVenta = 1 )
					begin
						select @mensaje = 'No existe la venta que quiere modificar.'
						raiserror (@mensaje, 11, -1)
					end

					if exists ( select 1 from VentasDetalle where idVenta = @idVenta and montoIva > 0 )
					begin
						select @mensaje = 'No puede agregar productos a una venta facturada.'
						raiserror (@mensaje, 11, -1)
					end

					if	(
							(select coalesce(productosAgregados,0) from Ventas where idVenta = @idVenta) >=
							(select cantidad from ModificacionesPermitidasVenta where id = 2)
						)
					begin
						select @mensaje = 'No es posible agregar mas productos a esta venta.'
						raiserror (@mensaje, 11, -1)
					end					
					
					select @totalProductos = sum(cantidad) from #productosAgregados
				
					-- primero precios individual y menudeo
					update	#productosAgregados
					set		costo =	case
										when @totalProductos >= 12 then cantidad * precioMenudeo
										else cantidad * precioIndividual
									end,
							precioVenta =	case
												when @totalProductos >= 12 then precioMenudeo
												else precioIndividual
											end

					-- se actualiza el precio de venta y el precio del rango con que se hizo la venta en caso q exista un precio de rango
					update	#productosAgregados
					set		#productosAgregados.precioVenta = a.precioRango,
							#productosAgregados.precioRango = a.precioRango
					from	(
								select	v.idProducto, v.cantidad, ppp.costo as precioRango, ppp.min, ppp.max
								from	#productosAgregados v
											inner join ProductosPorPrecio ppp
												on ppp.idProducto = v.idProducto
											inner join (select idProducto,max(max) maxCantRango 
																	from ProductosPorPrecio 
																	where
																	activo = cast(1 as bit)
																	group by idProducto) maxRango 
															on ppp.idProducto=maxRango.idProducto
											where	ppp.activo = cast(1 as bit)
												--and	v.cantidad between ppp.min and ppp.max
												and	v.cantidad>=min and v.cantidad<=case when v.cantidad>maxCantRango and max=maxCantRango
												then v.cantidad else max end
							)A
					where	#productosAgregados.idProducto = a.idProducto


					-- si hay descuento
					if ( @descuento > 0.0 )
					begin
						update	#productosAgregados set #productosAgregados.porcentajeDescuentoCliente = @descuento
						update	#productosAgregados set #productosAgregados.precioVenta = #productosAgregados.precioVenta - (#productosAgregados.precioVenta * ( @descuento / 100 ))
					end

					-- actualizamos el precio final
					update	#productosAgregados 
					set		#productosAgregados.costo = precioVenta * cantidad
										
					update	#productosAgregados
					set		montoVenta = costo 

					-- si existe el producto en el inventario general
					if  exists	( 
									select 1 from #productosAgregados v left join InventarioGeneral g on v.idProducto=g.idProducto
									where g.idProducto is null
								)
					begin
						select @mensaje = 'El producto no se encuentra en el inventario.'
						raiserror (@mensaje, 11, -1)
					end

					-- si el producto no tiene un precio asignado en tabla de productos 
					if exists ( select 1 from #productosAgregados where montoVenta <= 0 )
					begin
						select @mensaje = 'El producto no tiene un precio asignado.'
						raiserror (@mensaje, 11, -1)
					end
				
					-- si todo bien
						select @montoTotal = sum(montoVenta) from #productosAgregados


					-- actualizar productos agregados a VentasDetalle
					insert into 
						VentasDetalle (
										idVenta,idProducto,cantidad,contadorProductosPorPrecio,monto,cantidadActualInvGeneral,
										cantidadAnteriorInvGeneral,precioIndividual,precioMenudeo,precioRango,precioVenta,
										montoIva,idEstatusProductoVenta,productosDevueltos
									  )
					select	@idVenta, pa.idProducto, pa.cantidad, 0, (pa.cantidad * p.precioMenudeo) as monto, (ig.cantidad + pa.cantidad) as cantidadActualInvGeneral,
							ig.cantidad as cantidadAnteriorInvGeneral, p.precioIndividual, p.precioMenudeo, 0 as precioRango,  p.precioMenudeo as precioVenta,
							0 as montoIva, 2 as idEstatusProductoVenta, 0 as productosDevueltos
					from	#productosAgregados pa
								join Productos p
									on p.idProducto = pa.idProducto
								join InventarioGeneral ig
									on ig.idProducto = pa.idProducto
					where	pa.idVentaDetalle = 0


					-- actualizamos tabla de ventas
					update	Ventas
					set		Ventas.cantidad = a.cantidad,
							Ventas.montoTotal = a.montoTotal,
							Ventas.productosAgregados = coalesce(Ventas.productosAgregados, 0) + 1							
					from	(
								select	sum(cantidad)  as cantidad, sum(monto) as montoTotal, idVenta
								from	VentasDetalle
								where	idVenta = @idVenta
								group by idVenta
							)A
					where	Ventas.idVenta = a.idVenta

					
					-- actualizamos InventarioGeneralLog
					insert into InventarioGeneralLog (idProducto,cantidad,cantidadDespuesDeOperacion,fechaAlta,idTipoMovInventario)					
					select	pa.idProducto, pa.cantidad, (ig.cantidad + pa.cantidad) as cantidadDespuesDeOperacion, @fecha, 16 as idTipoMovInventario
					from	#productosAgregados pa
								join InventarioGeneral ig
									on ig.idProducto = pa.idProducto
					where	pa.idVentaDetalle = 0					
					

					-- actualizamos InventarioGeneral
					update	InventarioGeneral
					set		InventarioGeneral.cantidad = InventarioGeneral.cantidad + a.totProductosAgregados
					from	(
								select	idProducto, sum(cantidad) as totProductosAgregados
								from	#productosAgregados
								group by idProducto
							)A
					where	InventarioGeneral.idProducto = a.idProducto

					
					-- calculamos las existencias del inventario despues de la venta
					select	idProducto, sum(cantidad) as cantidad 
					into	#totProductosAgregados
					from	#productosAgregados 
					where	idVentaDetalle = 0 -- que sean nuevos
					group by idProducto

					select	idInventarioDetalle, id.idProducto, id.cantidad, fechaAlta, id.idUbicacion, 
							fechaActualizacion, cast(0 as int) as cantidadDescontada, 
							cast(0 as int) as cantidadFinal
					into	#tempExistenciasAgregadas 
					from	Usuarios u
								inner join Almacenes a
									on a.idAlmacen = u.idAlmacen
								inner join Ubicacion ub
									on ub.idAlmacen = a.idAlmacen
								inner join InventarioDetalle id
									on id.idUbicacion = ub.idUbicacion
								inner join #totProductosAgregados p
									on p.idProducto = id.idProducto
					where	u.idUsuario = @idUsuario
						and	id.cantidad > 0

					if not exists ( select 1 from #tempExistenciasAgregadas)
						begin
							select @mensaje = 'No se pudo agregar productos a la venta, no se cuenta con suficientes existencias en el inventario.'
							raiserror (@mensaje, 11, -1)
						end


					-- se calcula de que ubicaciones se van a descontar los productos
					select @ini = min(idProducto), @fin= max(idProducto) from #totProductosAgregados

					while ( @ini <= @fin )
						begin
							declare	@cantidadProductosDevueltos as int = 0
							select	@cantidadProductosDevueltos = cantidad from #totProductosAgregados where idProducto = @ini

							while ( @cantidadProductosDevueltos > 0 )
								begin
									declare @cantidadDestDev as int = 0, @idInventarioDetalleDev as int = 0
									select	@cantidadDestDev = coalesce(max(cantidad), 0) from #tempExistenciasAgregadas where idProducto = @ini and cantidadDescontada = 0
									select	@idInventarioDetalleDev = idInventarioDetalle from #tempExistenciasAgregadas where idProducto = @ini and cantidadDescontada = 0 and cantidad = @cantidadDestDev

									-- si ya no hay ubicaciones con existencias a descontar
									if ( @cantidadDestDev = 0 )
										begin
											update  #tempExistenciasAgregadas set cantidadDescontada = (select cantidad from #totProductosAgregados where idProducto = @ini)
											where	idProducto = @ini
											select @cantidadProductosDevueltos = 0
										end
									else
										begin
											if ( @cantidadDestDev >= @cantidadProductosDevueltos )
												begin 
													update #tempExistenciasAgregadas set cantidadDescontada = @cantidadProductosDevueltos 
													where idProducto = @ini and idInventarioDetalle = @idInventarioDetalleDev
													select @cantidadProductosDevueltos = 0 
												end
											else
												begin
													update	#tempExistenciasAgregadas set cantidadDescontada = @cantidadDestDev
													where	 idProducto = @ini and idInventarioDetalle = @idInventarioDetalleDev
													select @cantidadProductosDevueltos = @cantidadProductosDevueltos - @cantidadDestDev
												end
										end 
								end

							select @ini = min(idProducto) from #totProductosAgregados where idProducto > @ini

						end  -- while ( @ini <= @fin )

						update	#tempExistenciasAgregadas
						set		cantidadFinal = cantidad - cantidadDescontada


						-- si el inventario de los productos vendidos queda negativo se paso de productos = rollback
						if  exists	( select 1 from #tempExistenciasAgregadas where cantidadFinal < 0 )
						begin
							select @mensaje = 'No se pudieron agregar productos a la venta, no se cuenta con suficientes existencias en el inventario.'
							raiserror (@mensaje, 11, -1)
						end

										
						-- se actualiza inventario detalle
						update	InventarioDetalle
						set		cantidad = a.cantidadFinal,
								fechaActualizacion = dbo.FechaActual()
						from	(
									select	idInventarioDetalle, idProducto, cantidad, idUbicacion, cantidadDescontada, cantidadFinal
									from	#tempExistenciasAgregadas
								)A
						where	InventarioDetalle.idInventarioDetalle = a.idInventarioDetalle

					
						-- se inserta el InventarioDetalleLog
						insert into InventarioDetalleLog (idUbicacion,idProducto,cantidad,cantidadActual,idTipoMovInventario,idUsuario,fechaAlta,idVenta)
						select	idUbicacion, idProducto, cantidadDescontada, cantidadFinal, cast(1 as int) as idTipoMovInventario,
								@idUsuario as idUsuario, dbo.FechaActual() as fechaAlta, @idVenta as idVenta
						from	#tempExistenciasAgregadas
						where	cantidadDescontada > 0

		                select @cantProductosLiq=sum(a.cantidad) from #totProductosAgregados a join Productos b on a.idProducto=b.idProducto and b.idLineaProducto in (19,20)
					      

					

				end




				begin -- commit de transaccion
					if @tran_count = 0
						begin -- si la transacción se inició dentro de este ámbito
							commit tran @tran_name
							select @tran_scope = 0
						end -- si la transacción se inició dentro de este ámbito
				end -- commit de transaccion
					
				drop table #Ventas
				drop table #VentasDetalle
				drop table #cantidades
				drop table #idProductos
				
			end -- principal

		end try

		begin catch 
		
			-- captura del error
			select	@status =			-error_state(),
					@error_procedure =	error_procedure(),
					@error_line =		error_line(),
					@mensaje =			error_message()

			-- revertir transacción si es necesario
			if @tran_scope = 1
				rollback tran @tran_name
					
		end catch

		begin -- reporte de estatus

			select	@status status,
					@error_procedure error_procedure,
					@error_line error_line,
					@mensaje mensaje,
					@idVenta as idVenta,
					coalesce(@cantProductosLiq,0) cantProductosLiq

		end -- reporte de estatus

	end  -- principal
