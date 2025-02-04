--USE [DB_A57E86_lluviadesarrollo]
GO
/****** Object:  StoredProcedure [dbo].[SP_APP_APROBAR_PEDIDOS_INTERNOS_ESPECIALES]    Script Date: 30/09/2020 11:29:18 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Jessica Almonte Acosta
UsuarioRed		aoaj720209
Fecha			2020/08/28
Objetivo		Obtener los limites maximo y minimos que de inventario por producto y almacen
status			200 = ok
				-1	= error
*/

ALTER proc [dbo].[SP_APP_APROBAR_PEDIDOS_INTERNOS_ESPECIALES]
@productos  xml,
@idPedidoInterno int ,
@idUsuario int,
@idAlmacenOrigen int, -- el usuario que esta logueado en la hand held
@idAlmacenDestino int, -- el usuario que solicito
@observacionGeneral varchar(1000) = null
AS
BEGIN
	BEGIN TRY
	
			
			declare
			@idEstatusPedidoActual int = 0,
			@idEstatusPedidoInterno int = 2 -- Aprobado
			select  @idEstatusPedidoActual = IdEstatusPedidoInterno from PedidosInternos where @idPedidoInterno =idPedidoInterno


			--if exists (select  1  from PedidosInternos where IdEstatusPedidoInterno = @idEstatusPedidoInterno and @idPedidoInterno =idPedidoInterno)
			--begin
			--	select -1 Estatus , 'El estatus del pedido actual es el mismo por favor verifica el estatus' mensaje
			--	return
			--end

			IF OBJECT_ID('tempdb..#ProductosRecibidos') IS NOT NULL
			DROP TABLE #ProductosRecibidos
			create table #ProductosRecibidos
			(	
						indice int identity(1,1),
						idPedidoInterno int,
						idPedidoInternoDetalle		int ,
						idUbicacion int ,
						idProducto			int ,				
						cantidadAtendida	int ,			
						observaciones		varchar(500),
						cantidadSolicitada int , 
			)

			INSERT INTO  #ProductosRecibidos 
						(
						idPedidoInterno
						,idPedidoInternoDetalle
						,idUbicacion
						,idProducto			
						,cantidadAtendida	
						,observaciones	
						,cantidadSolicitada		
						)
			SELECT  
					@idPedidoInterno,
					P.value('idPedidoInternoDetalle[1]', 'INT') AS idPedidoInternoDetalle,
					P.value('idUbicacion[1]', 'INT') AS cantidadSolicitada,
					P.value('idProducto[1]', 'INT') AS idProducto,
					P.value('cantidadAtendida[1]', 'INT') AS cantidadAtendida,
					P.value('observaciones[1]', 'varchar(1000)') AS observaciones,
					P.value('cantidadSolicitada[1]', 'INT') AS cantidadSolicitada
			FROM  @productos.nodes('//ArrayOfProductosPedidoEspecial/ProductosPedidoEspecial') AS x(P)
			
			--select * from #ProductosRecibidos
			declare  	@tran_name varchar(32) = 'PRODUCTO_PEDIDO_ESPECIAL',
						@tran_count int = @@trancount,
						@tran_scope bit = 0
						


			if exists (select PR.idPedidoInternoDetalle , PD.idPedidoInternoDetalle ,  * 
				from #ProductosRecibidos PR   left  join   PedidosInternosDetalle PD 
				on PR.idPedidoInternoDetalle = PD.idPedidoInternoDetalle and PD.idPedidoInterno  =@idPedidoInterno
				where PD.idPedidoInternoDetalle is null)
			begin
				select -1 estatus , 'el pedido contiene productos que no corresponden a lo solicitado' mensaje
				return
			end

			if @tran_count = 0
				begin tran @tran_name
			else
				save tran @tran_name
				
			select @tran_scope = 1

			--BEGIN TRAN 
				--OBTENEMOS LA FECHA MAS QUE NADA LA HORA ACTUAL DE NUESTRA ZONA HORARIA

				BEGIN-- DECLARACIONES

					DECLARE
					@indice int = 1,
					@max int = 0,
					@cantidadAtendida int = 0,
					@idProducto int = 0,
					@cantidadActual int  =0,
					@cantidadTotal int = 0,
					@idTipoMovInventario int = 12,
					@fecha  datetime,
					@idUbicacion int,
					@observacion varchar(1000),
					@idPedidoInternoDetalle int
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
				)select 
					 @idPedidoInterno
					,@idAlmacenOrigen
					,@idAlmacenDestino
					,@idUsuario
					,@idEstatusPedidoInterno
					,@fecha
				--FROM PedidosInternos
				--WHERE idPedidoInterno = @idPedidoInterno
								
				SELECT @max = max(indice) from #ProductosRecibidos
				
				
				WHILE(@indice <= @max)
				BEGIN
					print 'index :::'+cast(@indice as varchar)
					SELECT 
							 @idProducto =idProducto 
							,@cantidadAtendida =cantidadAtendida 
							,@idUbicacion = idUbicacion
							,@observacion  = observaciones
							,@idPedidoInternoDetalle = idPedidoInternoDetalle
					   FROM 
							#ProductosRecibidos 
					   WHERE indice = @indice

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
						coalesce(@cantidadAtendida,0)
						FROM PedidosInternos P join PedidosInternosDetalle PD
						on  P.idPedidoInterno = PD.idPedidoInterno 
						WHERE 
						P.idPedidoInterno = @idPedidoInterno
						AND idPedidoInternoDetalle = @idPedidoInternoDetalle


			
				--INSERTAMOS LA ACTUALIZACION DE LA CANTIDAD QUE SE ATENDIO YA QUE PUEDE SER QUE NO SE ENVIE LA QUE SE SOLICITO
					UPDATE PedidosInternosDetalle 
					SET cantidadAtendida = @cantidadAtendida
					WHERE 
					 idPedidoInterno =@idPedidoInterno
					 AND idPedidoInternoDetalle = @idPedidoInternoDetalle
		
					DECLARE 
					@_IdAlmacenDestino int,
					@cantidadPedidoInterno int ,
					@cantidadActualInventario  int,
					@idTipoMonInventario int = 7, -- Salida de mercancia por pedido interno
					@cantidadDespuesDeOperacion int = 0

					SELECT  @cantidadPedidoInterno= isnull(cantidad,0)  
					FROM PedidosInternosDetalle 
					WHERE idPedidoInterno =@idPedidoInterno AND  idPedidoInternoDetalle = @idPedidoInternoDetalle

					--SI LA CANTIDAD QUE ATENDIMOS ES DIFERENTE QUE LA QUE SE PIDIO SE SETEA A CANTIDAD YA QUE CON ESA VARIABLE
					--SE HACEN LAS OPERACIONES PARA INVENTARIO DETALLE Y DETALLE LOG,
					--SI ES IGUAL  PUES NO AFECTA CON CUAL VARIABLE REALIZAMOS EL CALCULO
					IF (@cantidadAtendida != isnull(@cantidadPedidoInterno,0))
						SET @cantidadPedidoInterno = @cantidadAtendida

					--VALIDAMOS QUE EL ID PRODUCTO EXISTA EN EL INVENTARIO
					IF NOT EXISTS (SELECT 1 FROM InventarioDetalle WHERE idUbicacion = @idUbicacion and idProducto = @idProducto)
					BEGIN
						 RAISERROR('No existe producto cargado en el inventario del alamacen', 15, 217)
					END

					SELECT @cantidadActualInventario = cantidad  
					FROM InventarioDetalle 
					WHERE idUbicacion = @idUbicacion and idProducto = @idProducto
					
					-- VALIDAMOS QUE EL RESULTADO QUE SE OBTIENE NO SEA NULL PARA PODER  HACER LA RESTA
					SET @cantidadActualInventario = isnull(@cantidadActualInventario, 0)
				
					IF (@cantidadActualInventario < @cantidadPedidoInterno)
					BEGIN
						 RAISERROR('No existe suficiente canditad en el inventario para actualizar el pedido', 15, 217)
					END

					SET @cantidadDespuesDeOperacion =  @cantidadActualInventario-@cantidadPedidoInterno
					print 'insertamos en detalle log'
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
											VALUES ( @idUbicacion,
											         @idProducto,
													 @cantidadPedidoInterno ,
													 @cantidadDespuesDeOperacion,
													 @idTipoMonInventario /* Salida pedido */,
													 @idUsuario,
													 dbo.FechaActual(),
													 @idPedidoInterno)

					--ACTUALIZAMOS LA CANTIDAD EN INVENTARIO DETALLE--
					UPDATE InventarioDetalle SET cantidad = @cantidadDespuesDeOperacion
					WHERE idUbicacion = @idUbicacion and idProducto = @idProducto

					SET @indice = @indice +1

				END -- while
				

				--INSERTAMOS LA ACUTALIACION DEL ESTATUS
				UPDATE PedidosInternos 
				SET IdEstatusPedidoInterno = @idEstatusPedidoInterno,
				observacion = case  when @observacionGeneral is null or  @observacionGeneral = '' then observacion
								    when @observacionGeneral is NOT null AND  @observacionGeneral  != '' then @observacion
							   end
				WHERE idPedidoInterno =@idPedidoInterno
				
			--VALIDAMOS SI LA TRANSACCION SE GENERO AQUI , AQUIMISMO SE HACE EL COMMIT	
		    if @tran_count = 0	
			begin -- si la transacción se inició dentro de este ámbito
						
				commit tran @tran_name
				select @tran_scope = 0
						
			end -- si la transacción se inició dentro de este ámbito

			select 200 Estatus , 'OK' Mensaje 
			DROP TABLE #ProductosRecibidos

	END TRY
	BEGIN CATCH
		SELECT -1 Estatus, error_message() Mensaje,error_line() Errorlin,
		cast(@idProducto as varchar) idProducto,
		cast(@idPedidoInternoDetalle as varchar) idPedidoInternoDetalle,
		cast(@cantidadActualInventario as varchar) cantidadActualInventario,
		cast(@cantidadPedidoInterno as varchar) cantidadPedidoInterno,
		cast(@idUbicacion as varchar) idUbicacion
		
		if @tran_scope = 1
			rollback tran @tran_name

	END CATCH
	
END

