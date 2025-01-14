USE [DB_A57E86_lluviadesarrollo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_PEDIDOS_INTERNOS]    Script Date: 14/09/2020 11:52:06 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Jessica Almonte Acosta
Fecha			2020/04/27
Objetivo		Consultar los pedidos internos
*/

ALTER procedure [dbo].[SP_CONSULTA_PEDIDOS_INTERNOS]

@IdEstatusPedidoInterno int=NULL,
@idAlmancenOrigen int=NULL,
@idAlmacenDestino int=NULL,
@idUsuario int=NULL,
@idProducto int=NULL,
@fechaIni date=NULL,
@fechaFin date=NULL,
@idPedidoInterno int=NULL,
@idTipoPedidoInterno int = null



AS BEGIN

		begin try -- try principal
		
			begin -- inicio

				-- declaraciones
				declare @status int = 200,
						@error_message varchar(255) = '',
						@error_line varchar(255) = '',
						@error_severity varchar(255) = '',
						@error_procedure varchar(255) = '',
						@valido	bit = cast(1 as bit),
						@top bigint=0x7fffffffffffffff--valor màximo
						
			end -- inicio
			
		    
			begin
				
				--select @idTipoPedidoInterno = coalesce(@idTipoPedidoInterno, 1)
				--print @idTipoPedidoInterno

				if(	@IdEstatusPedidoInterno is null and
					@idAlmancenOrigen is null and
					@idAlmancenOrigen is null and
					@idUsuario is null and
					@idProducto is null and
					@fechaIni is null and
					@fechaFin is null and
					@idPedidoInterno is null and
					@idTipoPedidoInterno is null 
					)
					
					begin
						select @top=50
					end


					SELECT top (@top) 
					PI.idPedidoInterno,pi.fechaAlta,
					pi.idAlmacenOrigen,ao.Descripcion almacenOrigen,
					pi.idAlmacenDestino,ad.Descripcion almacenDestino,
					pi.idUsuario,coalesce(u.nombre,'') + ' ' + coalesce(u.apellidoPaterno,'') + ' ' + coalesce(u.apellidoMaterno,'') nombreCompleto,
					pi.IdEstatusPedidoInterno idStatus,s.descripcion,
					pid.idProducto,p.descripcion producto,pid.cantidad
					INTO #PEDIDOS_INTERNOS
					FROM PedidosInternos pi
					join PedidosInternosDetalle pid on pi.idPedidoInterno=pid.idPedidoInterno
					join CatEstatusPedidoInterno s on pi.IdEstatusPedidoInterno=s.IdEstatusPedidoInterno
					join Almacenes ao on pi.idAlmacenOrigen=ao.idAlmacen
					join Almacenes ad on pi.idAlmacenDestino=ad.idAlmacen
					join Usuarios u on pi.idUsuario=u.idUsuario
					join Productos p on pid.idProducto=p.idProducto
					where
					pi.idPedidoInterno=coalesce(@idPedidoInterno,pi.idPedidoInterno) and
					pi.IdEstatusPedidoInterno=coalesce(@IdEstatusPedidoInterno,pi.idestatuspedidointerno)
					and pi.idAlmacenOrigen=coalesce(@idAlmancenOrigen,pi.idAlmacenOrigen)
					and pi.idAlmacenDestino=coalesce(@idAlmacenDestino,pi.idAlmacenDestino)
					and pi.idUsuario=coalesce(@idUsuario,pi.idUsuario)
					and pid.idProducto=coalesce(@idProducto,pid.idProducto)
					and cast(pi.fechaAlta as date) >=coalesce(cast(@fechaIni as date),cast(pi.fechaAlta as date))
					and cast(pi.fechaAlta as date) <=coalesce(cast(@fechaFin as date),cast(pi.fechaAlta as date))
					and idTipoPedidoInterno = coalesce(@idTipoPedidoInterno, 1)
					order by fechaAlta desc

				if not exists (select 1 from #PEDIDOS_INTERNOS)
				begin
					select	@valido = cast(0 as bit),
							@status = -1,
							@error_message = 'No se encontraron pedidos internos con esos términos de búsqueda.'
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
				idProducto,producto descripcion,cantidad
				from #PEDIDOS_INTERNOS 
				
			
					
		end -- reporte de estatus
		

END