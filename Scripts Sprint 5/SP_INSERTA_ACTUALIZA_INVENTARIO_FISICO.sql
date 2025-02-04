
-- se crea procedimiento SP_INSERTA_ACTUALIZA_INVENTARIO_FISICO
if exists (select 1 from sysobjects where name like 'SP_INSERTA_ACTUALIZA_INVENTARIO_FISICO' and xtype = 'p' )
	drop proc SP_INSERTA_ACTUALIZA_INVENTARIO_FISICO

GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Jessica Almonte Acosta
UsuarioRed		aoaj720209
Fecha			2020/07/28
Objetivo		inserta y actualiza el inventario fisico
status			200 = ok
				-1	= error
*/

create proc [dbo].[SP_INSERTA_ACTUALIZA_INVENTARIO_FISICO]

	@idInventarioFisico	int=null,
	@nombre	varchar(300),
	@idUsuario	int,
	@activo bit

as

	begin -- principal
	
		begin try

			begin --declaraciones 

				declare @status					int = 200,
						@mensaje				varchar(255) = 'Inventario fisico actualizado correctamente.',
						@error_line				varchar(255) = '',
						@error_procedure		varchar(255) = '',					
						@idSucursal				int,
						@idTipoActualizacion    int--actualizacion nombre, actualizacion activo

			end  --declaraciones 

			begin -- principal
				
				if exists (select 1 from InventarioFisico where nombre=@nombre and coalesce(idInventarioFisico,0)<>coalesce(@idInventarioFisico,0))
					begin
					
						select -1 Estatus , 'Ya existe un inventario fisico con ese nombre' Mensaje
						return 
					end

				if  (coalesce(@idInventarioFisico,0)>0) and not exists (select 1 from InventarioFisico where idInventarioFisico=@idInventarioFisico)
					begin						
						select -1 Estatus , 'El inventario fisico que desea actualizar no existe' Mensaje
						return 
					end

				if(coalesce(@idInventarioFisico,0)>0)
					select @idSucursal=idSucursal from InventarioFisico where idInventarioFisico=@idInventarioFisico
				else
					select @idSucursal = idSucursal from usuarios where idUsuario=@idUsuario

			
				if exists (select 1 from InventarioFisico where idSucursal=@idSucursal and activo=1 and @activo=1 and coalesce(idInventarioFisico,0)<>coalesce(@idInventarioFisico,0))
				begin					
						select -1 Estatus , 'Ya existe un inventario fisico activo' Mensaje
						return 
				end

				if(coalesce(@idInventarioFisico,0)>0 and coalesce(@nombre,'')<>'')
				begin
				 select @idTipoActualizacion=1
				 select @mensaje='El nombre se ha actualizado de manera correcta'
				end

				else if(coalesce(@idInventarioFisico,0)>0 and exists(select 1 from InventarioFisico where idInventarioFisico=@idInventarioFisico and coalesce(activo,0)<>@activo))
				begin
				 select @idTipoActualizacion=2
				 select @mensaje= case when @activo=1 then 'Se ha activado de manera correcta el inventario fisico' else 'Se ha desactivado de manera correcta el inventario fisico' end
				end
					
				-- si es modificacion
				if	(coalesce(@idInventarioFisico,0) > 0 )
					begin					
						
						update	InventarioFisico						
						set		nombre = case when @idTipoActualizacion=1 then @nombre else nombre end,								
								activo = case when @idTipoActualizacion=2 then @activo else activo end  ,
								fechaInicio=case when @activo=1 and @idTipoActualizacion=2 then dbo.FechaActual() else fechaInicio end,
								fechaFin=case when @activo=0 and @idTipoActualizacion=2 then dbo.FechaActual() else fechaFin end
						where	idInventarioFisico = @idInventarioFisico

						--select @mensaje = 'Inventario fisico modificado correctamente.'
					end
				-- si es nuevo
				else
					begin						
					
						
						insert into InventarioFisico (nombre,idUsuario,idSucursal,fechaInicio,activo) 
						values (@nombre,@idUsuario,@idSucursal,case when @activo=1 then dbo.FechaActual() else null end,@activo)
						
						select @mensaje = 'Inventario fisico agregado correctamente.'
							
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

			select	@status Estatus,
					@error_procedure error_procedure,
					@error_line error_line,
					@mensaje Mensaje
				
		end -- reporte de estatus

	end  -- principal
