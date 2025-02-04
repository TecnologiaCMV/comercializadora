USE [DB_A57E86_lluviadesarrollo]
GO
/****** Object:  StoredProcedure [dbo].[SP_APP_OBTENER_PEDIDOS_INTERNOS_X_ALMACEN]    Script Date: 07/09/2020 10:59:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--drop procedure [SP_APP_OBTENER_PEDIDOS_INTERNOS]

ALTER PROCEDURE [dbo].[SP_APP_OBTENER_PEDIDOS_INTERNOS_X_ALMACEN]
@idAlmacenDestino int,
@idEstatusPedido int = null,
@fechaInicio datetime = null,
@fechaFin datetime = null,
@idPedidoInterno int =  null 

/*
1 Pedido Realizado
2 Pedido Enviado ó Atendido
3 Pedido Rechazado
4 Pedido Finalizado
*/
,@idTipoPedidoInterno  int  = 1
AS
BEGIN
		--select * from [dbo].[CatEstatusPedidoInterno]

		select 200 Estatus , 'ok' Mensaje

		SELECT 
		P.IdEstatusPedidoInterno,
		EP.descripcion descripcionEstatus,
		P.idPedidoInterno,
		P.fechaAlta,
		isnull(p.observacion,'') observacion,
		isnull(M4.observaciones,'') observacionRechazaSolicita,
		isnull(MM.observaciones,'') observacionAtendio,
		isnull(M2.observaciones,'') observacionRechazaAtendio,
		isnull(M3.observaciones,'') observacionFinalizado,
		isnull(U.nombre,' ')+' '+isnull(U.apellidoPaterno,'')+' '+isnull(u.apellidoMaterno,'') usuarioSolicito,
		isnull(UU.nombre,' ')+' '+isnull(UU.apellidoPaterno,'')+' '+isnull(UU.apellidoMaterno,'') usuarioAtendio,
		isnull(URechazado.nombre,' ')+' '+isnull(URechazado.apellidoPaterno,'')+' '+isnull(URechazado.apellidoMaterno,'') usuarioRechaza,
		isnull(UAutoriza.nombre,' ')+' '+isnull(UAutoriza.apellidoPaterno,'')+' '+isnull(UAutoriza.apellidoMaterno,'') usuarioAutoriza,
		isnull(URechazaSoclicita.nombre,' ')+' '+isnull(URechazaSoclicita.apellidoPaterno,'')+' '+isnull(URechazaSoclicita.apellidoMaterno,'') usuarioRechazaSoclicita,

		MM.fechaAlta as fechaAtendido,
		M2.fechaAlta as fechaRechazado,
		M3.fechaAlta as fechaAutoriza,
		M4.fechaAlta as fechaRechazaSolicita,
		isnull(PD.cantidadAtendida, 0) cantidadAtendida,
		PD.idProducto , PD.cantidad,Prod.descripcion, 
		P.idAlmacenOrigen,A.idAlmacen, A.Descripcion,
		P.idAlmacenDestino,AB.idAlmacen,AB.Descripcion
		--* 
		FROM PedidosInternos   P join  PedidosInternosDetalle PD
		on P.idPedidoInterno = PD.idPedidoInterno join Productos Prod
		on PD.idProducto = Prod.idProducto JOIN CatEstatusPedidoInterno EP
		ON EP.IdEstatusPedidoInterno =P.IdEstatusPedidoInterno join Almacenes A
		on P.idAlmacenOrigen = A.idAlmacen join Almacenes AB
		on P.idAlmacenDestino = AB.idAlmacen  LEFT JOIN Usuarios U 
		on U.idUsuario = P.idUsuario LEFT JOIN [dbo].[MovimientosDeMercancia] MM
		on MM.idPedidoInterno = P.idPedidoInterno and  MM.idEstatusPedidoInterno =2 LEFT JOIN Usuarios UU 
		on UU.idUsuario = MM.idUsuario  LEFT JOIN [dbo].[MovimientosDeMercancia] M2
		on M2.idPedidoInterno = P.idPedidoInterno and  M2.idEstatusPedidoInterno =3 LEFT JOIN Usuarios URechazado 
		on URechazado.idUsuario = M2.idUsuario  LEFT JOIN [dbo].[MovimientosDeMercancia] M3
		on M3.idPedidoInterno = P.idPedidoInterno and  M3.idEstatusPedidoInterno =4 LEFT JOIN Usuarios UAutoriza 
		on UAutoriza.idUsuario = M3.idUsuario LEFT JOIN [dbo].[MovimientosDeMercancia] M4
		on M4.idPedidoInterno = P.idPedidoInterno and  M4.idEstatusPedidoInterno =5 LEFT JOIN Usuarios URechazaSoclicita 
		on URechazaSoclicita.idUsuario = M4.idUsuario
		
		where
		P.IdEstatusPedidoInterno = coalesce(@idEstatusPedido, P.IdEstatusPedidoInterno)
		and P.idAlmacenDestino = coalesce(@idAlmacenDestino , P.idAlmacenDestino)
		and cast(P.fechaAlta as date) >= coalesce(cast(@fechaInicio as date),cast(P.fechaAlta as date))
		and cast(P.fechaAlta as date) <= coalesce(cast(@fechaFin as date),cast(P.fechaAlta as date))
		and P.idPedidoInterno = coalesce (@idPedidoInterno , P.idPedidoInterno )
		and P.idTipoPedidoInterno = coalesce (@idTipoPedidoInterno , P.idTipoPedidoInterno)
		order by P.fechaAlta asc
END
