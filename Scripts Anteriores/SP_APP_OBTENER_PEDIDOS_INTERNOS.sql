USE [DB_A57E86_lluviadesarrollo]
GO
/****** Object:  StoredProcedure [dbo].[SP_APP_OBTENER_PEDIDOS_INTERNOS]    Script Date: 07/09/2020 10:54:43 p. m. ******/
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

ALTER PROCEDURE [dbo].[SP_APP_OBTENER_PEDIDOS_INTERNOS]
@idEstatusPedido int = null,
@idAlmacenOrigen int = null,
@idAlmacenDestino int = null,
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
		PD.idProducto , PD.cantidad,Prod.descripcion, 
		P.idAlmacenOrigen, A.Descripcion,
		P.idAlmacenDestino,AB.Descripcion
	
		--* 
		FROM PedidosInternos   P join  PedidosInternosDetalle PD
		on P.idPedidoInterno = PD.idPedidoInterno join Productos Prod
		on PD.idProducto = Prod.idProducto JOIN CatEstatusPedidoInterno EP
		ON EP.IdEstatusPedidoInterno =P.IdEstatusPedidoInterno join Almacenes A
		on P.idAlmacenOrigen = A.idAlmacen join Almacenes AB
		on P.idAlmacenDestino = AB.idAlmacen

		where
		P.IdEstatusPedidoInterno = coalesce(@idEstatusPedido, P.IdEstatusPedidoInterno)
		and P.idAlmacenDestino = coalesce(@idAlmacenDestino , P.idAlmacenDestino)
		and P.idAlmacenOrigen = coalesce(@idAlmacenOrigen , P.idAlmacenOrigen)
		and cast(P.fechaAlta as date) >= coalesce(cast(@fechaInicio as date),cast(P.fechaAlta as date))
		and cast(P.fechaAlta as date) <= coalesce(cast(@fechaFin as date),cast(P.fechaAlta as date))
		and P.idPedidoInterno = coalesce (@idPedidoInterno , P.idPedidoInterno )
		and P.idTipoPedidoInterno =  coalesce (@idTipoPedidoInterno , P.idTipoPedidoInterno)
		order by P.fechaAlta asc
END
