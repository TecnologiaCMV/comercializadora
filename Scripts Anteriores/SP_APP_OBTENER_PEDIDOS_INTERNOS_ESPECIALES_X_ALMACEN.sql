-- se crea procedimiento SP_OBTENER_LIMITES_INVENTARIO
if exists (select * from sysobjects where name like 'SP_APP_OBTENER_PEDIDOS_INTERNOS_ESPECIALES_X_ALMACEN' and xtype = 'p')
	drop proc SP_APP_OBTENER_PEDIDOS_INTERNOS_ESPECIALES_X_ALMACEN
go

/*

Autor			Jessica Almonte Acosta
UsuarioRed		aoaj720209
Fecha			2020/08/28
Objetivo		Obtener los limites maximo y minimos que de inventario por producto y almacen
status			200 = ok
				-1	= error
*/

Create proc [dbo].SP_APP_OBTENER_PEDIDOS_INTERNOS_ESPECIALES_X_ALMACEN
@idAlmacen int = null,
@idPedidoInterno int=null,
@idEstatusPedidoInterno int = null,
@fechaInicio datetime = null,
@fechafin datetime = null
/*
1	Pedido Solicitado
2	Pedido Aprobado
3	Pedido Rechazado
4	Pedido Finalizado
5	Pedido Cancelado
*/
as
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
		
		select 200 Estatus , 'Ok' Mensaje 
			
		SELECT 
		P.idPedidoInterno, ISNULL(P.descripcion,'')descripcionPedido,P.fechaAlta,
		isnull(UO.nombre,'') +' '+ isnull(UO.apellidoPaterno,'')+' '+isnull(UO.apellidoMaterno,'') usuarioSolicito,
		UO.idUsuario idUsuarioSolicito,
		EP.IdEstatusPedidoInterno ,ep.descripcion descripcionEstatus,
		P.idAlmacenOrigen,AO.idAlmacen, AO.Descripcion,
		P.idAlmacenDestino,AD.idAlmacen,AD.Descripcion		
		FROM PedidosInternos P
		JOIN Almacenes AO ON AO.idAlmacen = P.idAlmacenOrigen
		JOIN Almacenes AD ON AD.idAlmacen = P.idAlmacenDestino
		JOIN Usuarios UO ON UO.idUsuario = P.idUsuario
	    JOIN CatEstatusPedidoInterno EP ON EP.IdEstatusPedidoInterno = P.IdEstatusPedidoInterno
		where
		    P.idTipoPedidoInterno = 2
		AND P.idAlmacenDestino = coalesce(@idAlmacen ,P.idAlmacenDestino )
		ANd P.idPedidoInterno = coalesce(@idEstatusPedidoInterno,P.idPedidoInterno)
		AND cast(P.fechaAlta as date) >= coalesce(cast(@fechaInicio as date),cast(P.fechaAlta as date))
		AND cast(P.fechaAlta as date) <= coalesce(cast(@fechaFin as date),cast(P.fechaAlta as date))


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
		
		
	end -- procedimiento
	
