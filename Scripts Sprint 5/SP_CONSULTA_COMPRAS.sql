use DB_A57E86_lluviadesarrollo
go

-- se crea procedimiento SP_CONSULTA_COMPLEMENTOS_VENTA
if exists (select * from sysobjects where name like 'SP_CONSULTA_COMPRAS' and xtype = 'p' and db_name() = 'DB_A57E86_lluviadesarrollo')
	drop proc SP_CONSULTA_COMPRAS
go

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/07/23
Objetivo		Consulta productos agregados/devueltos de una venta
status			200 = ok
				-1	= error
*/

create proc SP_CONSULTA_COMPRAS

	@idCompra int=null,
	@idProveedor int=null,
	@idStatusCompra int=null,
	@idUsuario int=null,
	@idAlmacen int=null,
	@fechaInicio datetime=null,
	@fechaFin datetime=null,
	@idProducto int=null,
	@descripcionProducto varchar(100)=null,
	@idLineaProducto int = null,
	@detalleCompra bit=0,
	@idEstatusProducto int=null



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
						@valido	bit = cast(1 as bit),
						@top bigint=0x7fffffffffffffff--valor màximo
						
			end -- inicio
			
		    
			begin
				

				if(	@idCompra is null and
					@idProveedor is null and
					@idStatusCompra is null and
					@idUsuario is null and
					@idAlmacen is null and
					@fechaInicio is null and
					@fechaFin is null and
					@idProducto is null and
					@descripcionProducto is null and
					@idLineaProducto is null and @idEstatusProducto=null) 
					begin
						select @top=50
					end


				SELECT --top (@top)
				c.idCompra,c.fechaAlta,c.observaciones,p.idProveedor,p.nombre,
				s.idStatusCompra idStatus,s.descripcion,
				u.idUsuario,u.nombre + ' ' + coalesce(u.apellidoPaterno,'') + ' ' + coalesce(u.apellidoMaterno,'') nombreCompleto,
				a.idAlmacen,a.Descripcion Almacen 
				INTO #COMPRAS
				FROM COMPRAS c
				join Proveedores p on c.idProveedor=p.idProveedor
				join CatStatusCompra s on c.idStatusCompra=s.idStatusCompra
				join Usuarios u on c.idUsuario=u.idUsuario
				join Almacenes a on u.idAlmacen=a.idAlmacen
				where c.idCompra=coalesce(@idCompra,c.idCompra)
				and p.idProveedor=coalesce(@idProveedor,p.idProveedor)
				and u.idUsuario=coalesce(@idUsuario,u.idUsuario)
				and s.idStatusCompra=coalesce(@idStatusCompra,s.idStatusCompra)
				and cast(c.fechaAlta as date) >=coalesce(cast(@fechaInicio as date),cast(c.fechaAlta as date))
				and cast(c.fechaAlta as date) <=coalesce(cast(@fechaFin as date),cast(c.fechaAlta as date))
				and c.activo=1				

				select d.*,p.descripcion,p.codigoBarras,l.descripcion DescripcionLinea,
					estatus.descripcion estatusProducto,
				    coalesce(u.nombre,'') + ' ' + coalesce(u.apellidoPaterno,'') + ' ' + coalesce(u.apellidoMaterno,'') usuarioRecibio			
				    into #COMPRASDETALLE 
					from #COMPRAS C
					join ComprasDetalle d on C.idCompra=d.idCompra
					join Productos p on d.idProducto=p.idProducto
					join LineaProducto l on p.idLineaProducto=l.idLineaProducto
					left join CatEstatusProductoCompra estatus on d.idEstatusProductoCompra=estatus.idEstatusProductoCompra
					left join usuarios u on d.idUsuarioRecibio=u.idUsuario
					where d.idProducto=coalesce(@idProducto,d.idProducto)
					and p.idLineaProducto=coalesce(@idLineaProducto,p.idLineaProducto)
					and p.descripcion like	case when @descripcionProducto is null then p.descripcion
												 else '%' + @descripcionProducto + '%'
													end
					and coalesce(d.idEstatusProductoCompra,0)=coalesce(@idEstatusProducto,coalesce(d.idEstatusProductoCompra,0))
					
					

				if not exists (select 1 from #COMPRAS)
				begin
					select	@valido = cast(0 as bit),
							@status = -1,
							@error_message = 'No se encontraron compras con esos términos de búsqueda.'
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

			if(@detalleCompra=1)
			select top (@top) cd.*,c.*,d.idProducto,d.descripcion,d.cantidad,d.precio,(precio * cast(cantidad as float)) total,d.codigoBarras,d.DescripcionLinea,
			    d.observaciones,d.usuarioRecibio,d.cantidadRecibida,d.cantidadDevuelta,
			    coalesce(d.idEstatusProductoCompra,0) idEstatusProducto,d.estatusProducto
				from #COMPRAS c
				join #COMPRASDETALLE d on c.idCompra=d.idCompra	
				join (select idCompra,SUM((precio * cast(cantidad as float))) montoTotal,SUM(cantidad) totalCantProductos, 
				sum(coalesce(cantidadRecibida,0)) totalCantProductosRecibidos,SUM((precio * cast(coalesce(cantidadRecibida,0) as float))) montoTotalRecibido
				from #COMPRASDETALLE
				group by idCompra) cd on c.idCompra=cd.idCompra
				order by c.fechaAlta desc
			else
				select top (@top) cd.montoTotal,cd.totalCantProductos,cd.totalCantProductosRecibidos,cd.totalCantProductosDevueltos,cd.montoTotalRecibido,
				case 
				when exists(select 1 from ComprasDetalle where idCompra=c.idCompra and idEstatusProductoCompra in(3,4,5)) then 2 --compra incorrecta
				when exists(select 1 from ComprasDetalle where idCompra=c.idCompra and coalesce(idEstatusProductoCompra,0)=0) then 0 --compra pendiente
				else 1 end estadoCompra --compra correcta
				,c.* ,0 idProducto,0 idEstatusProducto				    
				from #COMPRAS c
				join (select idCompra,SUM((precio * cast(cantidad as float))) montoTotal,SUM(cantidad) totalCantProductos, 
				sum(coalesce(cantidadRecibida,0)) totalCantProductosRecibidos,SUM((precio * cast(coalesce(cantidadRecibida,0) as float))) montoTotalRecibido,
				sum(coalesce(cantidadDevuelta,0)) totalCantProductosDevueltos from #COMPRASDETALLE
				group by idCompra) cd on c.idCompra=cd.idCompra
				order by c.fechaAlta desc
			

					
		end -- reporte de estatus
		
	end -- procedimiento
	
