USE [DB_A57E86_lluviadesarrollo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_DETALLE_PEDIDOS_INTERNOS]    Script Date: 23/09/2020 06:30:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Jessica Almonte Acosta
Fecha			2020/04/27
Objetivo		Consultar el detalle de pedidos internos
*/

ALTER PROCEDURE [dbo].[SP_CONSULTA_DETALLE_PEDIDOS_INTERNOS]
	@idPedidoInterno int
AS
begin -- procedimiento
		
		begin try -- try principal
		
			begin -- inicio

				-- declaraciones
				declare @status int = 200,
						@error_message varchar(255) = '',
						@error_line varchar(255) = '',
						@error_severity varchar(255) = '',
						@error_procedure varchar(255) = '',
						@valido	bit = cast(1 as bit)
						
			end -- inicio
			
		    
			begin

					SELECT 
					PI.idPedidoInterno,pi.fechaAlta,
					pi.idAlmacenOrigen,ao.Descripcion almacenOrigen,
					pi.idAlmacenDestino,ad.Descripcion almacenDestino,
					pi.idUsuario,coalesce(u.nombre,'') + ' ' + coalesce(u.apellidoPaterno,'') + ' ' + coalesce(u.apellidoMaterno,'') nombreCompleto,
					pi.IdEstatusPedidoInterno idStatus,s.descripcion
					INTO #PEDIDOS_INTERNOS_LOG
					FROM PedidosInternosLog pi					
					join CatEstatusPedidoInterno s on pi.IdEstatusPedidoInterno=s.IdEstatusPedidoInterno
					join Almacenes ao on pi.idAlmacenOrigen=ao.idAlmacen
					left join Almacenes ad on pi.idAlmacenDestino=ad.idAlmacen
					join Usuarios u on pi.idUsuario=u.idUsuario					
					where idPedidoInterno=@idPedidoInterno
					

				if not exists (select 1 from #PEDIDOS_INTERNOS_LOG)
				begin
					select	@valido = cast(0 as bit),
							@status = -1,
							@error_message = 'No se encontraron coincidencias.'
				end
				

			end
		   

		end try -- try principal
		
		begin catch -- catch principal
		
			-- captura del error
			select	@status = -error_state(),
					@error_procedure = coalesce(error_procedure(), 'CONSULTA DINÁMICA'),
					@error_line = error_line(),
					@error_message = error_message(),
					@error_severity =
						case error_severity()
							when 11 then 'Error en validación'
							when 12 then 'Error en consulta'
							when 13 then 'Error en actualización'
							else 'Error general'
						end
		
		end catch -- catch principal
		
		begin -- reporte de estatus

			select	@status status,
					@error_procedure error_procedure,
					@error_line error_line,
					@error_severity error_severity,
					@error_message mensaje

				select 
			    idPedidoInterno,fechaAlta,
			    idAlmacenOrigen,idAlmacenOrigen idAlmacen,almacenOrigen Descripcion,
				idAlmacenDestino,idAlmacenOrigen idAlmacen,almacenDestino Descripcion,
				idUsuario,nombreCompleto,
				idStatus,descripcion,
				0 idProducto--,producto descripcion,cantidad
				from #PEDIDOS_INTERNOS_LOG 
			
					
		end -- reporte de estatus
		
	end -- procedimiento
	
