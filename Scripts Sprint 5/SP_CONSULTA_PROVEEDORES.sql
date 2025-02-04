USE [DB_A57E86_lluviadesarrollo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_PROVEEDORES]    Script Date: 21/07/2020 23:52:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		Consulta los diferentes proveedores del sistema
status			200 = ok
				-1	= error
*/

ALTER proc [dbo].[SP_CONSULTA_PROVEEDORES]

	@idProveedor		int,
	@fechaIni			datetime=null,
	@fechaaFin			datetime=null

as

	begin -- principal
	
		begin try

			begin --declaraciones 

				declare @status					int = 200,
						@mensaje				varchar(255) = '',
						@error_line				varchar(255) = '',
						@error_procedure		varchar(255) = '',
						@valido					bit = cast(0 as bit)

			end  --declaraciones 

			begin -- principal
				
				if not exists ( select 1 from Proveedores where activo=1 )
					begin
						select @mensaje = 'No existen proveedores registrados.'
						raiserror (@mensaje, 11, -1)
					end
				else
					begin
						select @valido = cast(1 as bit)
					end

			end -- principal

		end try

		begin catch 
		
			-- captura del error
			select	@status =			-error_state(),
					@error_procedure =	error_procedure(),
					@error_line =		error_line(),
					@mensaje =			error_message()
					
		end catch

		begin -- reporte de estatus

			if ( @valido = cast(1 as bit) )
				begin
						
					select	distinct 
							@status status,
							@error_procedure error_procedure,
							@error_line error_line,
							@mensaje mensaje,
							ROW_NUMBER() OVER(ORDER BY p.idProveedor DESC) AS contador,
							p.idProveedor,
							p.nombre,
							p.descripcion,
							p.telefono,
							p.direccion,
							p.activo,
							coalesce(pi.totalPedidosIncompletos,0) totalPedidosIncompletos,
							coalesce(pedidos.totalPedidosTotales,0) totalPedidosTotales,
							coalesce(pedidosCorrectos.totalPedidosCompletos,0) totalPedidosCompletos,
							coalesce(pedidosCantMayor.totalPedidosMayorSolicitado,0) totalPedidosMayorSolicitado,
							case when coalesce(pedidos.totalPedidosTotales,0)=0 then cast(0 as float) else (1-ROUND(cast((coalesce(pi.totalPedidosIncompletos,0)/coalesce(pedidos.totalPedidosTotales,0)) as float),2))*100 end PorcAtendido
					from	Proveedores p
					left join (select count(1) totalPedidosIncompletos,idProveedor from Compras c
						where activo=1  and c.idStatusCompra in(3,5) and  cast(c.fechaAlta as date)>=cast(coalesce(@fechaIni,c.fechaAlta) as date) and cast(c.fechaAlta as date)<=cast(coalesce(@fechaaFin,c.fechaAlta) as date) and exists(select 1 from ComprasDetalle where idCompra=c.idCompra and idEstatusProductoCompra in(3,4,5)) group by idProveedor) pi on p.idProveedor=pi.idProveedor
					left join (select count(1) totalPedidosCompletos,idProveedor from Compras c
						where activo=1  and c.idStatusCompra in(3,5) and  cast(c.fechaAlta as date)>=cast(coalesce(@fechaIni,c.fechaAlta) as date) and cast(c.fechaAlta as date)<=cast(coalesce(@fechaaFin,c.fechaAlta) as date) and exists(select 1 from ComprasDetalle where idCompra=c.idCompra and idEstatusProductoCompra in(1)) group by idProveedor) pedidosCorrectos on pedidosCorrectos.idProveedor=p.idProveedor
					left join (select count(1) totalPedidosMayorSolicitado,idProveedor from Compras c
						where activo=1  and c.idStatusCompra in(3,5) and  cast(c.fechaAlta as date)>=cast(coalesce(@fechaIni,c.fechaAlta) as date) and cast(c.fechaAlta as date)<=cast(coalesce(@fechaaFin,c.fechaAlta) as date) and exists(select 1 from ComprasDetalle where idCompra=c.idCompra and idEstatusProductoCompra in(2)) group by idProveedor) pedidosCantMayor on pedidosCantMayor.idProveedor=p.idProveedor
					left join (select count(1) totalPedidosTotales,idProveedor from Compras c
						where activo=1 and c.idStatusCompra in(3,5) and  cast(c.fechaAlta as date)>=cast(coalesce(@fechaIni,c.fechaAlta) as date) and cast(c.fechaAlta as date)<=cast(coalesce(@fechaaFin,c.fechaAlta) as date) group by idProveedor) pedidos on p.idProveedor=pedidos.idProveedor
					where	p.idProveedor =	case
												when @idProveedor > 0 then @idProveedor
												else p.idProveedor
											end
						and	p.activo = cast(1 as bit)
					order by p.idProveedor desc
						
				end
			else
				begin

					select	-1 status,
							@error_procedure error_procedure,
							@error_line error_line,
							@mensaje as  mensaje
							
				end


		end -- reporte de estatus

	end  -- principal
