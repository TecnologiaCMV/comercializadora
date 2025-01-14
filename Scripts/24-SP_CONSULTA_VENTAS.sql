use DB_A57E86_comercializadora
go

-- se crea procedimiento SP_CONSULTA_VENTAS
if exists (select * from sysobjects where name like 'SP_CONSULTA_VENTAS' and xtype = 'p' and db_name() = 'DB_A57E86_comercializadora')
	drop proc SP_CONSULTA_VENTAS
go

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		Consulta las ventas hechas a los clientes
status			200 = ok
				-1	= error
				tipoConsulta: 1-para reportes / 2- para modulo de ventas
*/

create proc SP_CONSULTA_VENTAS

	@idProducto				int = null,
	@descProducto			varchar(300) = null,
	@idLineaProducto		int = null,
	@idCliente				int = null,
	@idUsuario				int = null,
	@fechaIni				datetime = null,
	@fechaFin				datetime = null,
	@tipoConsulta			int = null

as

	begin -- principal
	
		begin try

			begin --declaraciones 

				declare @status					int = 200,
						@mensaje				varchar(255) = '',
						@error_line				varchar(255) = '',
						@error_procedure		varchar(255) = '',
						@valido					bit = cast(1 as bit)

				create table
					#Ventas	
						(
							contador					int identity(1,1),
							idVenta						int ,
							idCliente					int,
							nombreCliente				varchar(300),
							cantidad					bigint,
							fechaAlta					datetime,
							idUsuario					int,
							nombreUsuario				varchar(300),
							idProducto					int,
							descripcionProducto			varchar(300),							
							idLineaProducto				int,
							descripcionLineaProducto	varchar(300),
							idFactura					int, 
							idEstatusFactura			int,
							descripcionEstatusFactura	varchar(300),
							fechaTimbrado				datetime
						)			

			end  --declaraciones 

			begin -- principal
				
				-- validaciones
					if (	
							(@idProducto is null) and 
							(@descProducto is null) and 
							(@idCliente is null) and 
							(@idUsuario is null) and 
							(@fechaIni is null) and 
							(@fechaFin is null) 
						)
					begin
						select	@mensaje = 'Debe elejir al menos un criterio para la b�squeda de la Venta.',
								@valido = cast(0 as bit)						
						raiserror (@mensaje, 11, -1)
					end

				-- si son todos
					if (	
							(@idProducto is null) and 
							(@descProducto is null) and 
							(@idLineaProducto is null) and 
							(@idCliente is null) and 
							(@idUsuario is null) and 
							(@fechaIni = '19000101') and
							(@fechaFin = '19000101')
						)
					begin

						insert into #Ventas (idVenta,idCliente,nombreCliente,cantidad,fechaAlta,idUsuario,nombreUsuario,idProducto,descripcionProducto,idLineaProducto,descripcionLineaProducto,idFactura,idEstatusFactura,descripcionEstatusFactura,fechaTimbrado)
						select	top 50 v.idVenta,v.idCliente, cl.nombres + ' ' + cl.apellidoPaterno + ' ' + cl.apellidoMaterno as nombreCliente
								,v.cantidad, v.fechaAlta, v.idUsuario, u.nombre + ' ' + u.apellidoPaterno + ' ' + u.apellidoMaterno as nombreUsuario,
								p.idProducto,p.descripcion, lp.idLineaProducto, lp.descripcion, f.idFactura, f.idEstatusFactura, s.descripcion,f.fechaTimbrado
						from	Ventas v
									inner join Usuarios u
										on u.idUsuario = v.idUsuario
									left join Clientes cl
										on v.idCliente = cl.idCliente
									inner join VentasDetalle vd
										on vd.idVenta = v.idVenta
									inner join Productos p
										on vd.idProducto = p.idProducto	
									inner join LineaProducto lp
										on lp.idLineaProducto = p.idLineaProducto
									left join Facturas f
										on f.idVenta = v.idVenta
									left join FacCatEstatusFactura s
										on s.idEstatusFactura = f.idEstatusFactura
						where	v.idStatusVenta = 1

					end
				-- si es por busqueda
				else 
					begin

						insert into #Ventas (idVenta,idCliente,nombreCliente,cantidad,fechaAlta,idUsuario,nombreUsuario,idProducto,descripcionProducto,idLineaProducto,descripcionLineaProducto,idFactura,idEstatusFactura,descripcionEstatusFactura,fechaTimbrado)
						select	 v.idVenta,v.idCliente, cl.nombres + ' ' + cl.apellidoPaterno + ' ' + cl.apellidoMaterno as nombreCliente
								,v.cantidad, v.fechaAlta, v.idUsuario, u.nombre + ' ' + u.apellidoPaterno + ' ' + u.apellidoMaterno as nombreUsuario,
								p.idProducto,p.descripcion, lp.idLineaProducto, lp.descripcion, f.idFactura, f.idEstatusFactura, s.descripcion,f.fechaTimbrado
						from	Ventas v
									inner join Usuarios u
										on u.idUsuario = v.idUsuario
									left join Clientes cl
										on v.idCliente = cl.idCliente
									inner join VentasDetalle vd
										on vd.idVenta = v.idVenta
									inner join Productos p
										on vd.idProducto = p.idProducto
									inner join LineaProducto lp
										on lp.idLineaProducto = p.idLineaProducto	
									left join Facturas f
										on f.idVenta = v.idVenta
									left join FacCatEstatusFactura s
										on s.idEstatusFactura = f.idEstatusFactura
																		
						where	p.idProducto =	case
													when @idProducto is null then p.idProducto
													when @idProducto = 0 then p.idProducto
													else @idProducto
												end

							and p.descripcion like	case
														when @descProducto is null then p.descripcion
														else '%' + @descProducto + '%'
													end

							and	v.idCliente =	case
													when @idCliente is null then v.idCliente
													when @idCliente = 0 then v.idCliente
													else @idCliente
												end

							and v.idUsuario =	case
													when @idUsuario is null then v.idUsuario
													when @idUsuario = 0 then v.idUsuario
													else @idUsuario
												end

							and lp.idLineaProducto =	case
															when @idLineaProducto is null then lp.idLineaProducto
															when @idLineaProducto = 0 then lp.idLineaProducto
															else @idLineaProducto
														end

							and cast(v.fechaAlta as date) >=	case
																	when @fechaIni is null then cast(v.fechaAlta as date)
																	when @fechaIni = 0 then cast(v.fechaAlta as date)
																	when @fechaIni = '19000101' then cast(v.fechaAlta as date)
																	else cast(@fechaIni as date)
																end

							and cast(v.fechaAlta as date) <=	case
																	when @fechaFin is null then cast(v.fechaAlta as date)
																	when @fechaFin = 0 then cast(v.fechaAlta as date)
																	when @fechaFin = '19000101' then cast(v.fechaAlta as date)
																	else cast(@fechaFin as date)
																end
							and	v.idStatusVenta = 1
						order by v.idVenta desc

					end

				
				if not exists ( select 1 from #Ventas )
					begin
						select	@valido = cast(0 as bit),
								@status = -1,
								@mensaje = 'No se encontraron ventas con esos t�rminos de b�squeda.'
					end

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

		--reporte de estatus
			select	@status status,
					@error_procedure error_procedure,
					@error_line error_line,
					@mensaje mensaje
							

		-- si todo ok
			if ( @valido = 1 )
				begin

					if ( @tipoConsulta = 2 )
						begin
							select	ROW_NUMBER() OVER(ORDER BY idVenta DESC) AS contador,
									idVenta,idCliente,
									case
										when nombreCliente is null then 'P�BLICO EN GENERAL' 
										else nombreCliente
									end as nombreCliente,
									cantidad,fechaAlta,idUsuario,nombreUsuario,idFactura, idEstatusFactura, descripcionEstatusFactura,
									case month(fechaTimbrado)
										when 1 then  '\Facturas\' + CAST( YEAR(fechaTimbrado) as varchar(30) ) + '\ENERO\Factura_' + cast(idVenta as varchar(30)) + '.pdf'
										when 2 then  '\Facturas\' + CAST( YEAR(fechaTimbrado) as varchar(30) ) + '\FEBRERO\Factura_' + cast(idVenta as varchar(30)) + '.pdf'
										when 3 then  '\Facturas\' + CAST( YEAR(fechaTimbrado) as varchar(30) ) + '\MARZO\Factura_' + cast(idVenta as varchar(30)) + '.pdf'
										when 4 then  '\Facturas\' + CAST( YEAR(fechaTimbrado) as varchar(30) ) + '\ABRIL\Factura_' + cast(idVenta as varchar(30)) + '.pdf'
										when 5 then  '\Facturas\' + CAST( YEAR(fechaTimbrado) as varchar(30) ) + '\MAYO\Factura_' + cast(idVenta as varchar(30)) + '.pdf'
										when 6 then  '\Facturas\' + CAST( YEAR(fechaTimbrado) as varchar(30) ) + '\JUNIO\Factura_' + cast(idVenta as varchar(30)) + '.pdf'
										when 7 then  '\Facturas\' + CAST( YEAR(fechaTimbrado) as varchar(30) ) + '\JULIO\Factura_' + cast(idVenta as varchar(30)) + '.pdf'
										when 8 then  '\Facturas\' + CAST( YEAR(fechaTimbrado) as varchar(30) ) + '\AGOSTO\Factura_' + cast(idVenta as varchar(30)) + '.pdf'
										when 9 then  '\Facturas\' + CAST( YEAR(fechaTimbrado) as varchar(30) ) + '\SEPTIEMBRE\Factura_' + cast(idVenta as varchar(30)) + '.pdf'
										when 10 then '\Facturas\' + CAST( YEAR(fechaTimbrado) as varchar(30) ) + '\OCTUBRE\Factura_' + cast(idVenta as varchar(30)) + '.pdf'
										when 11 then '\Facturas\' + CAST( YEAR(fechaTimbrado) as varchar(30) ) + '\NOVIEMBRE\Factura_' + cast(idVenta as varchar(30)) + '.pdf'
										when 12 then '\Facturas\' + CAST( YEAR(fechaTimbrado) as varchar(30) ) + '\DICIEMBRE\Factura_' + cast(idVenta as varchar(30)) + '.pdf'
										else null
									end as rutaFactura
							from	#Ventas 
							group by idVenta,idCliente,nombreCliente,cantidad,fechaAlta,idUsuario,nombreUsuario,idFactura,idEstatusFactura,descripcionEstatusFactura,fechaTimbrado
							order by idVenta desc 
						end
					else
						begin
							select	
									contador,					
									idVenta,						
									idCliente,					
									case
										when nombreCliente is null then 'P�BLICO EN GENERAL' 
										else nombreCliente
									end as nombreCliente,
									cantidad,					
									fechaAlta,					
									idUsuario,					
									nombreUsuario,				
									idProducto,					
									descripcionProducto	,								
									idLineaProducto,				
									descripcionLineaProducto,
									idFactura, 
									idEstatusFactura,
									descripcionEstatusFactura,
									case month(fechaTimbrado)
										when 1 then  '\Facturas\' + CAST( YEAR(fechaTimbrado) as varchar(30) ) + '\ENERO\Factura_' + cast(idVenta as varchar(30)) + '.pdf'
										when 2 then  '\Facturas\' + CAST( YEAR(fechaTimbrado) as varchar(30) ) + '\FEBRERO\Factura_' + cast(idVenta as varchar(30)) + '.pdf'
										when 3 then  '\Facturas\' + CAST( YEAR(fechaTimbrado) as varchar(30) ) + '\MARZO\Factura_' + cast(idVenta as varchar(30)) + '.pdf'
										when 4 then  '\Facturas\' + CAST( YEAR(fechaTimbrado) as varchar(30) ) + '\ABRIL\Factura_' + cast(idVenta as varchar(30)) + '.pdf'
										when 5 then  '\Facturas\' + CAST( YEAR(fechaTimbrado) as varchar(30) ) + '\MAYO\Factura_' + cast(idVenta as varchar(30)) + '.pdf'
										when 6 then  '\Facturas\' + CAST( YEAR(fechaTimbrado) as varchar(30) ) + '\JUNIO\Factura_' + cast(idVenta as varchar(30)) + '.pdf'
										when 7 then  '\Facturas\' + CAST( YEAR(fechaTimbrado) as varchar(30) ) + '\JULIO\Factura_' + cast(idVenta as varchar(30)) + '.pdf'
										when 8 then  '\Facturas\' + CAST( YEAR(fechaTimbrado) as varchar(30) ) + '\AGOSTO\Factura_' + cast(idVenta as varchar(30)) + '.pdf'
										when 9 then  '\Facturas\' + CAST( YEAR(fechaTimbrado) as varchar(30) ) + '\SEPTIEMBRE\Factura_' + cast(idVenta as varchar(30)) + '.pdf'
										when 10 then '\Facturas\' + CAST( YEAR(fechaTimbrado) as varchar(30) ) + '\OCTUBRE\Factura_' + cast(idVenta as varchar(30)) + '.pdf'
										when 11 then '\Facturas\' + CAST( YEAR(fechaTimbrado) as varchar(30) ) + '\NOVIEMBRE\Factura_' + cast(idVenta as varchar(30)) + '.pdf'
										when 12 then '\Facturas\' + CAST( YEAR(fechaTimbrado) as varchar(30) ) + '\DICIEMBRE\Factura_' + cast(idVenta as varchar(30)) + '.pdf'
										else null
									end as rutaFactura,										
									year(fechaAlta) as mes, day(fechaAlta) as dia						
							from	#Ventas 
							order by idVenta desc 
						end
				end
				
		end -- reporte de estatus

	end  -- principal
go

grant exec on SP_CONSULTA_VENTAS to public
go



