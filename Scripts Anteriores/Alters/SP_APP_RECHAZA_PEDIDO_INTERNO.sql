USE [DB_A57E86_lluviadesarrollo]
GO
/****** Object:  StoredProcedure [dbo].[SP_APP_RECHAZA_PEDIDO_INTERNO]    Script Date: 22/09/2020 09:09:03 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--drop procedure SP_APP_ACEPTA_PEDIDO_INTERNO
ALTER PROCEDURE [dbo].[SP_APP_RECHAZA_PEDIDO_INTERNO]
@idPedidoInterno int ,
@idUsuario int,
@idAlmacenOrigen int,-- el almacen del usuario que esta logueado en la hand held
@idAlmacenDestino int,
@observacion varchar(max) = null
AS
BEGIN
	BEGIN TRY
	        
			declare @idEstatusPedidoInterno int=5 --pedido rechazado
		
	
			if not exists (select 1 from PedidosInternos where 
			(idAlmacenDestino = @idAlmacenDestino or idAlmacenDestino =  @idAlmacenOrigen) and
			(idAlmacenOrigen = @idAlmacenOrigen  or idAlmacenOrigen = @idAlmacenDestino ) and
			idPedidoInterno = @idPedidoInterno)
			begin
				select -1 Estatus , 'El pedido no corresponde al almacen solicitado' mensaje
				return
			end
			declare
			@idEstatusPedidoActual int = 0
			select  @idEstatusPedidoActual = IdEstatusPedidoInterno from PedidosInternos where @idPedidoInterno =idPedidoInterno

			if (@idEstatusPedidoActual not in (2))
			begin
				select -1 Estatus , 'No se puede rechazar el pedido sin ser atendido' mensaje
				return
			end

			if exists (select  1  from PedidosInternos where IdEstatusPedidoInterno = @idEstatusPedidoInterno and @idPedidoInterno =idPedidoInterno)
			begin
				select -1 Estatus , 'El estatus del pedido actual es el mismo por favor verifica el estatus' mensaje
				return
			end
			

			if EXISTS (select  1  from PedidosInternosLog where IdEstatusPedidoInterno  = @idEstatusPedidoInterno  and  idPedidoInterno =  @idPedidoInterno )

			BEGIN
				select -1 Estatus , 'No es posible rechazar el pedido, este pedido ya fue rechazado' mensaje
				return
			END
			
			BEGIN TRAN 
				--OBTENEMOS LA FECHA MAS QUE NADA LA HORA ACTUAL DE NUESTRA ZONA HORARIA

				declare	@fecha  datetime,@cantidadRechazada int
				select @fecha  = [dbo].[FechaActual]()

				--OBTENEMOS LA CANTIDAD POR LA CUAL SE VA A RECHAZAR
				select @cantidadRechazada=cantidadAtendida from PedidosInternosDetalle where idPedidoInterno=@idPedidoInterno
				

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
					@idPedidoInterno,
					@idUsuario,
					@fecha,
					@idEstatusPedidoInterno,
					coalesce(@observacion,''),
					@cantidadRechazada
					FROM PedidosInternos P join PedidosInternosDetalle PD
					on  P.idPedidoInterno = PD.idPedidoInterno WHERE P.idPedidoInterno = @idPedidoInterno
			
				--insertamos en el log los cambios del pedido interno
				insert into PedidosInternosLog
				(
					idPedidoInterno
					,idAlmacenOrigen
					,idAlmacenDestino
					,idUsuario
					,IdEstatusPedidoInterno
					,fechaAlta
				)select 
					  @idPedidoInterno
					 ,@idAlmacenOrigen
					 ,@idAlmacenDestino
					 ,@idUsuario
					 ,@idEstatusPedidoInterno
					 ,@fecha
				--from PedidosInternos
				--where idPedidoInterno = @idPedidoInterno

				--INSERTAMOS LA ACUTALIACION DEL ESTATUS
				UPDATE PedidosInternos 
				SET IdEstatusPedidoInterno = @idEstatusPedidoInterno,
				observacion = case  when @observacion is null or  @observacion = '' then observacion
								    when @observacion is NOT null AND  @observacion  != '' then @observacion
							   end
				WHERE idPedidoInterno =@idPedidoInterno

				--INSERTAMOS LA ACTuALIAzaCION DE LA CANTIDAD QUE SE ATENDIO YA QUE PUEDE SER QUE NO SE ENVIE LA QUE SE SOLICITO
				update PedidosInternosDetalle set cantidadRechazada = @cantidadRechazada
				where idPedidoInterno =@idPedidoInterno
		
				declare 
				@_IdAlmacenDestino int,
				@idProducto int ,
				@cantidadPedidoInterno int ,
				@cantidadActualInventario  int,
				@idTipoMovInventario int = 10, -- Carga de mercancia por pedido interno rechazado
				@cantidadDespuesDeOperacion int = 0,
				@idUbicacion int

				--INCREMENTAMOS LA MERCANCIA EN EL INVENTARIO DEL ALAMACEN
					
				select  @idProducto = idProducto ,  @cantidadPedidoInterno= isnull(cantidad,0)  
				from PedidosInternosDetalle where idPedidoInterno =@idPedidoInterno

					--SI LA CANTIDAD QUE ATENDIMOS ES DIFERENTE QUE LA QUE SE PIDIO SE SETEA A CANTIDAD YA QUE CON ESA VARIABLE
					--SE HACEN LAS OPERACIONES PARA INVENTARIO DETALLE Y DETALLE LOG,
					--SI ES IGUAL  PUES NO AFECTA CON CUAL VARIABLE REALIZAMOS EL CALCULO
					if (@cantidadRechazada != isnull(@cantidadPedidoInterno,0))
						SET @cantidadPedidoInterno = @cantidadRechazada

					select @idUbicacion= idUbicacion FROM Ubicacion WHERE idAlmacen = @idAlmacenDestino and idPasillo=0 and idRaq=0 and idPiso=0

					--VALIDAMOS QUE EXISTA LA UBICACION DE SIN ACOMODAR Y EN CASO DE QUE NO EXISTE LA INSERTAMOS
					IF (coalesce(@idUbicacion,0)=0)
					BEGIN
						 INSERT INTO Ubicacion(idAlmacen,idPasillo,idRaq,idPiso)
						 select @idAlmacenDestino,0,0,0

						 select @idUbicacion=max(idUbicacion) from Ubicacion where idAlmacen=@idAlmacenDestino				

					END					

					SELECT @cantidadActualInventario = cantidad  FROM InventarioDetalle 
					WHERE idUbicacion = @idUbicacion and idProducto = @idProducto
					
					-- VALIDAMOS QUE EL RESULTADO QUE SE OBTIENE NO SEA NULL 
					SET @cantidadActualInventario = isnull(@cantidadActualInventario, 0)					
	

					SET @cantidadDespuesDeOperacion =  @cantidadActualInventario+@cantidadPedidoInterno
					--ACTUALIZAMOS LA CANTIDAD EN INVENTARIO DETALLE LOG
					INSERT INTO InventarioDetalleLog (  idUbicacion,
														idProducto,
														cantidad,
														cantidadActual,
														idTipoMovInventario,
														idUsuario,
														fechaAlta,
														idPedidoInterno
														)
					VALUES ( @idUbicacion,@idProducto,@cantidadPedidoInterno ,@cantidadDespuesDeOperacion,@idTipoMovInventario,@idUsuario,dbo.FechaActual(),@idPedidoInterno)

					--VALIDACION SI NO EXISTE INVENTARIO DETALLE CON ESE UBICACION LA INSERTAMOS
					IF NOT EXISTS(select 1 from InventarioDetalle where idUbicacion=@idUbicacion and idProducto=@idProducto)
					--INSERTAMOS LA CANTIDAD EN INVENTARIO DETALLE--
					INSERT INTO  InventarioDetalle(idProducto,cantidad,fechaAlta,idUbicacion)
					SELECT @idProducto, @cantidadDespuesDeOperacion,@fecha,@idUbicacion
					ELSE
					--ACTUALIZAMOS LA CANTIDAD EN INVENTARIO DETALLE--
					update InventarioDetalle set cantidad = @cantidadDespuesDeOperacion,fechaActualizacion=@fecha
					where idUbicacion = @idUbicacion and idProducto = @idProducto				

			COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN 
		SELECT -1 Estatus ,ERROR_MESSAGE() Mensaje, ERROR_LINE() LineaError 
	END CATCH
		
	     select 200 Estatus , 'Registro actualizado exitosamente' Mensaje
END
