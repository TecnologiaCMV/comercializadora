USE [DB_A57E86_lluviadesarrollo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINA_VENTA]    Script Date: 22/09/2020 11:49:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		elimina la venta seleccionada
status			200 = ok
				-1	= error
*/

ALTER proc [dbo].[SP_ELIMINA_VENTA]

	@idVenta		int,
	@idUsuario		int

as

	begin -- principal
	
		begin try

			begin --declaraciones 

				declare @status					int = 200,
						@mensaje				varchar(255) = 'Venta eliminada correctamente.',
						@error_line				varchar(255) = '',
						@error_procedure		varchar(255) = '',
						@valido					bit = cast(1 as bit)

			end  --declaraciones 

			begin -- principal
				
				if not exists ( select 1 from Ventas where idVenta = @idVenta )
					begin
						select @mensaje = 'No Existe la venta seleccionada.'
						raiserror (@mensaje, 11, -1)
						select @valido = cast(0 as bit)
					end

				if  exists (select 1 from Ventas where idVenta = @idVenta and idStatusVenta=2)
				begin
						select @mensaje = 'La venta ya se encuentra cancelada.'
						raiserror (@mensaje, 11, -1)
						select @valido = cast(0 as bit)
				end

				-- se actualiza el status en tbl de ventas
				update	Ventas 
				set		idStatusVenta = 2
				where	idVenta = @idVenta

				--insertamos en inventario_general_log
				insert into InventarioGeneralLog(idProducto,cantidad,cantidadDespuesDeOperacion,fechaAlta,idTipoMovInventario)
		        select v.idProducto,v.cantidad,i.cantidad+v.cantidad,dbo.FechaActual(),3
				from VentasDetalle v
				inner join InventarioGeneral i on v.idProducto = i.idProducto
					where	v.idVenta = @idVenta


				-- actualizamos el inventario general
				update	InventarioGeneral
				set		cantidad = InventarioGeneral.cantidad + A.cantidadSumada,
						fechaUltimaActualizacion = dbo.FechaActual()
				from	(
							select	v.idProducto, sum(v.cantidad) as cantidadSumada 
							from	VentasDetalle v
										inner join InventarioGeneral i
											on v.idProducto = i.idProducto
							where	v.idVenta = @idVenta
							group by v.idProducto
						) A
				where	InventarioGeneral.idProducto = A.idProducto


				-- revisamos si existen las ubicaciones de sin acomodar por cada idAlmacen que se afecto en la venta
				if exists	(
								select	idl.idUbicacion, u.idAlmacen, sin_.idAlmacen as idAlmacenSin
								from	InventarioDetalleLog idl
										    join Ubicacion u
												on u.idUbicacion = idl.idUbicacion
											left join Ubicacion sin_
												on	sin_.idAlmacen = u.idAlmacen
												and	sin_.idPasillo = 0
												and sin_.idRaq = 0
												and sin_.idPiso = 0
								where	idVenta = @idVenta
									and	sin_.idAlmacen is null	
							)

				begin
	
					insert into Ubicacion (idAlmacen, idPasillo, idRaq, idPiso)
					select	u.idAlmacen, 0 as idPasillo, 0 as idRaq, 0 as idPiso
					from	InventarioDetalleLog idl
							join Ubicacion u
									on u.idUbicacion = idl.idUbicacion
								left join Ubicacion sin_
									on	sin_.idAlmacen = u.idAlmacen
									and	sin_.idPasillo = 0
									and sin_.idRaq = 0
									and sin_.idPiso = 0
					where	idVenta = @idVenta
						and	sin_.idAlmacen is null	
                   group by u.idAlmacen

					insert into InventarioDetalle (idProducto,cantidad,fechaAlta,idUbicacion,fechaActualizacion)
					select	idl.idProducto, 0 as cantidad, dbo.FechaActual() as fechaAlta, sin_.idUbicacion, dbo.FechaActual() as fechaActualizacion 
					from	InventarioDetalleLog idl
								 join Ubicacion u
									on u.idUbicacion = idl.idUbicacion
								 join Ubicacion sin_
									on	sin_.idAlmacen = u.idAlmacen
									and	sin_.idPasillo = 0
									and sin_.idRaq = 0
									and sin_.idPiso = 0
					where	idVenta = @idVenta
					group by idl.idProducto,sin_.idUbicacion					

				end


				-- actualizamos el InventarioDetalle
				update	InventarioDetalle
				set		InventarioDetalle.cantidad = a.cantidad_total
				from	(
				
							select	idl.idProducto, sin_.idUbicacion, id.cantidad + sum(idl.cantidad) as cantidad_total
							from	InventarioDetalleLog idl
									join Ubicacion u
											on u.idUbicacion = idl.idUbicacion
									join Ubicacion sin_
											on	sin_.idAlmacen = u.idAlmacen
											and	sin_.idPasillo = 0
											and sin_.idRaq = 0
											and sin_.idPiso = 0
										inner join InventarioDetalle id
											on	id.idProducto = idl.idProducto
											and	id.idUbicacion = sin_.idUbicacion 
							where	idVenta = @idVenta
							group by idl.idProducto, sin_.idUbicacion,id.cantidad 

						)A
				where	InventarioDetalle.idProducto = a.idProducto
					and	InventarioDetalle.idUbicacion = a.idUbicacion

				
				-- insertamos el InventarioDetalleLog
				insert into InventarioDetalleLog (idUbicacion,idProducto,cantidad,cantidadActual,idTipoMovInventario,idUsuario,fechaAlta,idVenta)
				select	sin_.idUbicacion, idl.idProducto, sum(idl.cantidad), id.cantidad, 3 as idTipoMovInventario, 
						@idUsuario, dbo.FechaActual() as fechaAlta, @idVenta
						--idl.idVenta, idl.idProducto, sin_.idUbicacion, id.cantidad , idl.cantidad, *
				from	InventarioDetalleLog idl
						join Ubicacion u
								on u.idUbicacion = idl.idUbicacion
						join Ubicacion sin_
								on	sin_.idAlmacen = u.idAlmacen
								and	sin_.idPasillo = 0
								and sin_.idRaq = 0
								and sin_.idPiso = 0
						inner join InventarioDetalle id
								on	id.idProducto = idl.idProducto
								and	id.idUbicacion = sin_.idUbicacion 
				where	idVenta = @idVenta
				group by sin_.idUbicacion, idl.idProducto,id.cantidad



			end -- principal

		end try

		begin catch 
		
			-- captura del error
			select	@status =			-error_state(),
					@error_procedure =	error_procedure(),
					@error_line =		error_line(),
					@mensaje =			error_message()
					
		end catch

		begin -- reporte de estatus


			select	@status status,
					@error_procedure error_procedure,
					@error_line error_line,
					@mensaje mensaje

			--if ( @idVenta = cast(1 as bit) )
			--	begin
					
			--	end

				
		end -- reporte de estatus

	end  -- principal
