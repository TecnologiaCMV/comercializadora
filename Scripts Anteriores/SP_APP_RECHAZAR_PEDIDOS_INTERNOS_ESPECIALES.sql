-- se crea procedimiento SP_OBTENER_LIMITES_INVENTARIO
if exists (select * from sysobjects where name like 'SP_APP_RECHAZAR_PEDIDOS_INTERNOS_ESPECIALES' and xtype = 'p')
	drop proc SP_APP_RECHAZAR_PEDIDOS_INTERNOS_ESPECIALES
go

/*

Autor			Jessica Almonte Acosta
UsuarioRed		aoaj720209
Fecha			2020/08/28
Objetivo		Obtener los limites maximo y minimos que de inventario por producto y almacen
status			200 = ok
				-1	= error
*/

Create proc [dbo].SP_APP_RECHAZAR_PEDIDOS_INTERNOS_ESPECIALES
@idPedidoInterno int ,
@idUsuario int,
@observacionGeneral varchar(1000) = null
AS
BEGIN
	BEGIN TRY
			
			declare
			@idEstatusPedidoActual int = 0,
			@idEstatusPedidoInterno int = 3, -- Rechazado
			@idAlmacenOrigen  int,
			@idAlmacenDestino int 

			SELECT
				 @idEstatusPedidoActual = IdEstatusPedidoInterno
				,@idAlmacenOrigen = idAlmacenOrigen
				,@idAlmacenDestino = idAlmacenDestino
			FROM PedidosInternos 
			WHERE
				@idPedidoInterno =idPedidoInterno


			if exists (select  1  from PedidosInternos where  @idPedidoInterno =idPedidoInterno and IdEstatusPedidoInterno <> 1)
			begin
				select -1 Estatus , 'No se puede rechazar el pedido actual, el pedido ya ha sido aprobado' mensaje
				return
			end

				BEGIN-- DECLARACIONES
					DECLARE
					@fecha  datetime
				END	

				SELECT @fecha  = [dbo].[FechaActual]()

				--insertamos en el log el estado anterior 
				INSERT INTO PedidosInternosLog
				(
					 idPedidoInterno
					,idAlmacenOrigen
					,idAlmacenDestino
					,idUsuario
					,IdEstatusPedidoInterno
					,fechaAlta
				)SELECT 
					 @idPedidoInterno
					,@idAlmacenDestino
					,@idAlmacenOrigen
					,@idUsuario
					,@idEstatusPedidoInterno
					,@fecha
				--FROM PedidosInternos
				--WHERE idPedidoInterno = @idPedidoInterno
								
				--INSERTAMOS LA ACTUALIZACION EN LA TABLA DE MOVIMIENTOS DE MERCANCIA
				INSERT INTO  MovimientosDeMercancia 
				(
				 idAlmacenOrigen
				,idAlmacenDestino
				,idProducto
				,cantidad
				,idPedidoInterno
				,idUsuario
				,fechaAlta
				,idEstatusPedidoInterno
				,observaciones
				,cantidadAtendida
				)
				SELECT 
				@idAlmacenOrigen,
				@idAlmacenDestino,
				PD.idProducto,
				PD.cantidad,
				P.idPedidoInterno,
				@idUsuario,
				@fecha,
				@idEstatusPedidoInterno,
				'Rechazado por el encargado de almacen',
				0
				FROM PedidosInternos P join PedidosInternosDetalle PD
				on  P.idPedidoInterno = PD.idPedidoInterno 
				WHERE 
				P.idPedidoInterno = @idPedidoInterno
				
				

				--INSERTAMOS LA ACUTALIACION DEL ESTATUS
				UPDATE PedidosInternos 
				SET IdEstatusPedidoInterno = @idEstatusPedidoInterno,
				observacion =  @observacionGeneral 								  
				WHERE idPedidoInterno =@idPedidoInterno
				
				--REGRESAMOS  EL VALOR A LA APLICACION
				SELECT 200 Estatus , 'OK' Mensaje 			

	END TRY
	BEGIN CATCH
		SELECT -1 Estatus, error_message() Mensaje,error_line() Errorlin
	END CATCH
	
END