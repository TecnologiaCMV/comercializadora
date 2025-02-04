USE [DB_A57E86_lluviadesarrollo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_TICKET]    Script Date: 22/07/2020 09:45:49 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		Consulta los datos del ticket del idVenta
status			200 = ok
				-1	= error
*/

ALTER proc [dbo].[SP_CONSULTA_TICKET]
	@idVenta		int,
	@tipoVenta		int  -- 1-Normal / 2-Devolucion / 3-Agregar Productos a la venta

as

	begin -- principal
	
		begin try

			begin --declaraciones 

				declare @status					int = 200,
						@mensaje				varchar(255) = '',
						@error_line				varchar(255) = '',
						@error_procedure		varchar(255) = '',
						@valido					bit = cast(1 as bit)
						
			end  --declaraciones 


			if not exists ( select 1 from Ventas where idVenta = @idVenta and idStatusVenta = 1 )
			begin
				select	@mensaje = 'No existe la venta seleccionada.',
						@status = -1,
						@valido = cast(0 as bit)
			end	

			if ( @tipoVenta = 2 )
			begin
				if not exists ( select 1 from VentasDetalle where idVenta = @idVenta and productosDevueltos > 0	  )
				begin
					select	@mensaje = 'No existen devoluciones para la venta seleccionada.',
							@status = -1,
							@valido = cast(0 as bit)
				end	
			end

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
			if ( @valido = cast(1 as bit) )
				begin
					
					if ( @tipoVenta = 2 )
						begin

							select	ROW_NUMBER() OVER(ORDER BY v.idVenta DESC) AS contador,	
									v.idVenta,d.idVentaDetalle, d.idProducto, d.productosDevueltos as cantidad, 
									(d.precioVenta * d.productosDevueltos) as monto,
									p.descripcion as descProducto, v.idCliente, 
									case
										when c.nombres is null then 'PÚBLICO EN GENERAL' 
										else c.nombres + ' ' + c.apellidoPaterno + ' ' + c.apellidoMaterno
									end as nombreCliente,
									u.idUsuario, u.nombre + ' ' + u.apellidoPaterno + ' ' + u.apellidoMaterno as nombreUsuario,
									v.fechaAlta, d.precioVenta, d.idVentaDetalle, d.idEstatusProductoVenta, d.productosDevueltos
							from	Ventas v 
										inner join VentasDetalle d
											on v.idVenta = d.idVenta
										left join Clientes c
											on c.idCliente = v.idCliente
										inner join Usuarios u
											on u.idUsuario = v.idUsuario
										inner join Productos p
											on p.idProducto = d.idProducto
							where	v.idVenta = @idVenta
								and d.productosDevueltos > 0

						end

					else
						begin
						
							select	ROW_NUMBER() OVER(ORDER BY v.idVenta DESC) AS contador,	
									v.idVenta, d.idProducto, d.cantidad, d.contadorProductosPorPrecio, d.monto as monto, d.montoIVA,
									coalesce (((d.precioIndividual - d.precioVenta) * d.cantidad ) , 0 )as ahorro , 
									p.descripcion as descProducto, v.idCliente, 
									case
										when c.nombres is null then 'PÚBLICO EN GENERAL' 
										else c.nombres + ' ' + c.apellidoPaterno + ' ' + c.apellidoMaterno
									end as nombreCliente,
									u.idUsuario, u.nombre + ' ' + u.apellidoPaterno + ' ' + u.apellidoMaterno as nombreUsuario,
									d.cantidadActualInvGeneral, d.cantidadAnteriorInvGeneral, v.fechaAlta, d.precioVenta, d.idVentaDetalle,
									d.idEstatusProductoVenta, d.productosDevueltos
							from	Ventas v 
										inner join VentasDetalle d
											on v.idVenta = d.idVenta
										left join Clientes c
											on c.idCliente = v.idCliente
										inner join Usuarios u
											on u.idUsuario = v.idUsuario
										inner join Productos p
											on p.idProducto = d.idProducto
							where	v.idVenta = @idVenta
								and	d.cantidad > 0

						end

				end
				
		end -- reporte de estatus

	end  -- principal
