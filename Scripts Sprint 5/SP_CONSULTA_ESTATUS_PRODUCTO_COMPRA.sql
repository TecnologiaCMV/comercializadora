-- se crea procedimiento SP_CONSULTA_ESTATUS_PRODUCTO_COMPRA
if exists (select 1 from sysobjects where name like 'SP_CONSULTA_ESTATUS_PRODUCTO_COMPRA' and xtype = 'p')
	drop proc SP_CONSULTA_ESTATUS_PRODUCTO_COMPRA

GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_ESTATUS_COMPRA]    Script Date: 24/07/2020 0:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Autor
UsuarioRed		aaaa111111
Fecha			yyyymmdd
Objetivo		Objetivo
Proyecto		Consulta catalogo de estatus de producto compra
Ticket			ticket

*/

create proc

	[dbo].[SP_CONSULTA_ESTATUS_PRODUCTO_COMPRA]
	
		-- parámetros
		-- [aquí van los parámetros]
	
as

		begin -- reporte de estatus


			select	idEstatusProductoCompra,descripcion 
			from	CatEstatusProductoCompra			
				
		end -- reporte de estatus

