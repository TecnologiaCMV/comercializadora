-- se crea procedimiento SP_CONSULTA_INVENTARIO_FISICO
if exists (select 1 from sysobjects where name like 'SP_CONSULTA_INVENTARIO_FISICO' and xtype = 'p' )
	drop proc SP_CONSULTA_INVENTARIO_FISICO

GO
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Jessica Almonte Acosta
UsuarioRed		aoaj720209
Fecha			2020/07/28
Objetivo		Consulta el inventario fisico
status			200 = ok
				-1	= error
*/

Create proc [dbo].[SP_CONSULTA_INVENTARIO_FISICO]

@idSucursal int=null

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

				if not exists (select 1 from InventarioFisico where idSucursal=coalesce(@idSucursal,idSucursal))
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
			select idInventarioFisico,f.Nombre,Observaciones,f.Activo,FechaInicio,FechaFin,FechaAlta,
			s.idSucursal,descripcion,
			u.idUsuario,coalesce(u.nombre,'') + ' ' + coalesce(u.apellidoPaterno,'') + ' ' + coalesce(u.apellidoMaterno,'')  nombreCompleto
			from InventarioFisico f
			join Usuarios u on f.idUsuario=u.idUsuario
			join CatSucursales s on f.idSucursal=s.idSucursal
			where  f.idSucursal=coalesce(@idSucursal,f.idSucursal)
			order by idInventarioFisico desc
			
			

					
		end -- reporte de estatus
		
	end -- procedimiento
	
