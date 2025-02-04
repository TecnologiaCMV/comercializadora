-- se crea procedimiento SP_OBTENER_LIMITES_INVENTARIO
if exists (select * from sysobjects where name like 'SP_OBTENER_LIMITES_INVENTARIO' and xtype = 'p')
	drop proc SP_OBTENER_LIMITES_INVENTARIO
go

/*

Autor			Jessica Almonte Acosta
UsuarioRed		aoaj720209
Fecha			2020/08/28
Objetivo		Obtener los limites maximo y minimos que de inventario por producto y almacen
status			200 = ok
				-1	= error
*/

Create proc [dbo].[SP_OBTENER_LIMITES_INVENTARIO]

@idProducto int=null,
@idAlmacen int=null,
@idEstatusLimiteInv int = null,
@idLineaProducto int=null 
/*
1	Invietario dentro de sus limites 
2	Cantidad superior por el maximo permitido
3	Cantidad por debajo del minimo permitido
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
			
		    
			begin
			
				select I.idLimiteInventario,i.minimo,i.maximo,p.idProducto,p.descripcion,p.codigoBarras,a.idAlmacen,a.Descripcion descripcionAlmacen, isnull(B.cantidad,0)cantidadInventario  
				,l.idLineaProducto,l.descripcion descripcionLineaProducto
				,case 
					  when isnull(B.cantidad,0) > = i.minimo and isnull(B.cantidad,0) <= i.maximo then 1
					  when isnull(B.cantidad,0) > i.maximo   then 2
					  when isnull(B.cantidad,0) < i.minimo then 3
				end idEstatusLimiteInventario
				into #LimitesInventario
				from LimitesInventario i
				LEFT JOIN(select I.idProducto , U.idAlmacen, sum(I.cantidad) cantidad 
				from InventarioDetalle  I join Ubicacion U on U.idUbicacion   = I .idUbicacion group by I.idProducto , U.idAlmacen) B  on i.idAlmacen = B.idAlmacen and i.idProducto = B.idProducto
				join Productos p on i.idProducto=p.idProducto
				join Almacenes a on i.idAlmacen=a.idAlmacen
				join LineaProducto l on p.idLineaProducto=l.idLineaProducto
				where 
				i.idProducto=coalesce(@idProducto,i.idProducto)
				and i.idAlmacen=coalesce(@idAlmacen,i.idAlmacen)
				and l.idLineaProducto=coalesce(@idLineaProducto,l.idLineaProducto)

				if not exists (select 1 from #LimitesInventario)
				begin
					select	@valido = cast(0 as bit),
							@status = -1,
							@error_message = 'No se encontraron resultados.'
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

			if(@valido=1)
			select A.*, B.idEstatusLimiteInventario as idStatus, B.descripcion 
			from #LimitesInventario A join CatEstatusLimiteInventario B on A.idEstatusLimiteInventario = B.idEstatusLimiteInventario
			where B.idEstatusLimiteInventario = coalesce(@idEstatusLimiteInv, B.idEstatusLimiteInventario)

					
		end -- reporte de estatus
		
	end -- procedimiento
	
