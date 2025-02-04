USE [DB_A57E86_lluviadesarrollo]
GO
/****** Object:  StoredProcedure [dbo].[SP_APP_GENERAR_PEDIDO_INTERNO]    Script Date: 22/09/2020 08:28:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP_APP_GENERAR_PEDIDO_INTERNO]
@idProducto int,
@idUsuario int,
@idAlamacenOrigen int,-- el almacen del usuario que esta logueado en la hand held
@idAlamacenDestino int,
@cantidad int
AS
BEGIN
	
	DECLARE
		@idPedidoInterno int = 0;
	begin try
	--VALIDACIONES
			 
			
			begin tran
				--INSERTAMOS EN LA TABLA DE PEDIDOS INTERNOS
				INSERT INTO [PedidosInternos] 
				(
					idAlmacenOrigen,
					idAlmacenDestino,
					idUsuario,
					IdEstatusPedidoInterno,
					fechaAlta,
					idTipoPedidoInterno
				)
				VALUES
				(
					@idAlamacenOrigen,
					@idAlamacenDestino,
					@idUsuario,
					1, /*1	Pedido Realizado 2	Pedido Enviado ó Atendido 3	Pedido Rechazado 4	Pedido Finalizado */
					dbo.FechaActual(),
					1
				)
				--OBTENEMOS EL ID DE PEDIDO INTERNO GENERADO
				select @idPedidoInterno = max(idPedidoInterno) from [PedidosInternos] where idUsuario = @idUsuario
			

				--insertamos en el log
				INSERT INTO PedidosInternosLog
				(
					 idPedidoInterno
					,idAlmacenOrigen
					,idAlmacenDestino
					,idUsuario
					,IdEstatusPedidoInterno
					,fechaAlta
				)select 
					 @idPedidoInterno
					,@idAlamacenOrigen
					,@idAlamacenDestino
					,@idUsuario
					,1
					,dbo.FechaActual()
				
				


				--INSERTAMOS EL DETALLE DEL PEDIDO INTERNO GENERADO
				INSERT INTO [PedidosInternosDetalle]
				(
				idPedidoInterno,
				idProducto,
				cantidad,
				fechaAlta
				)
				VALUES
				(
				@idPedidoInterno,
				@idProducto,
				@cantidad,
				dbo.FechaActual()
				)

				--INSERTAMOS EL MOVIMIENTO DE LA MERCANCIA 
				INSERT INTO [MovimientosDeMercancia]
				(
					idAlmacenOrigen
					,idAlmacenDestino
					,idProducto
					,cantidad
					,idPedidoInterno
					,idUsuario
					,fechaAlta
					,idEstatusPedidoInterno
					,cantidadAtendida
				)
				VALUES
				(
				@idAlamacenOrigen,
				@idAlamacenDestino,
				@idProducto,
				@cantidad,
				@idPedidoInterno,
				@idUsuario,
				dbo.FechaActual(),
				1,/*1	Pedido Realizado 2	Pedido Enviado ó Atendido 3	Pedido Rechazado 4	Pedido Finalizado */
				@cantidad

				)
			COMMIT TRAN
			SELECT 200 Estatus , 'Pedido registrado exitosamente' Mensaje
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		select 
			-1 Estatus ,
			'Ha ocurrido un error al registrar el pedido ' Mensaje,
			 ERROR_NUMBER() AS ErrorNumber  ,
			 ERROR_MESSAGE() AS ErrorMessage  

	END CATCH

END
