USE [DB_A57E86_lluviadesarrollo]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDA_CONTRASENA]    Script Date: 20/07/2020 05:11:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/14
Objetivo		Valida contraseña encriptada de tabla de usuarios
status			200 = ok
				-1	= error
*/

ALTER proc [dbo].[SP_VALIDA_CONTRASENA]

	@usuario		varchar(200),
	@contrasena		varchar(40),
	@macAdress		varchar(100) = null

as

	begin -- principal
	
		begin try

			begin --declaraciones 

				declare @status					int = 200,
						@mensaje				varchar(255) = 'Usuario validado correctamente.',
						@error_line				varchar(255) = '',
						@error_procedure		varchar(255) = '',
						@idEstacion				int = 1,
						@devoluciones			int = 0,
						@agregarProductos		int = 0
						

			end  --declaraciones 

			begin -- principal

				if not exists ( select contrasena from usuarios where usuario = @usuario and contrasena = @contrasena ) 
				begin
					select @mensaje = 'La contraseña es incorrecta.'
					raiserror (@mensaje, 11, -1)
				end

				if ( @idEstacion is not null )
					begin
						select @idEstacion = idEstacion from Estaciones where macAdress = @macAdress
					end

				-- se agrega la cantidad de veces que puede hacer una devolucion o agregar prodcutos a la venta
				select @devoluciones = cantidad from modificacionesPermitidasVenta where id = 1 --Devoluciones a la Venta
				select @agregarProductos = cantidad from modificacionesPermitidasVenta where id = 2 --Agregar Productos a la Venta

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

			if @status = 200
				begin
					select	@status status,
							@error_procedure error_procedure,
							@error_line error_line,
							@mensaje mensaje

					select	idUsuario,
							u.idRol,
							usuario,
							telefono,
							contrasena,
							idAlmacen,
							idSucursal,
							nombre,
							apellidoPaterno,
							apellidoMaterno,
							@idEstacion as idEstacion,
							@devoluciones as devolucionesPermitidas,
							@agregarProductos as agregarProductosPermitidos,
							cast(1 as bit) as usuarioValido,
							r.descripcion Rol
					from	usuarios u
					join CatRoles r on u.idRol=r.idRol
					where	usuario = @usuario 
						and contrasena = @contrasena

					--Obtenemos los modulos a los que tiene acceso 
					select P.* , M.descripcion from usuarios U join PermisosRolPorModulo P  on U.idRol = P.idRol
					join CatRoles r on u.idRol=r.idRol
					join CatModulos M on P.idModulo = M.idModulo
					where	usuario = @usuario 
						and contrasena = @contrasena
				end
			else
				begin
					select	@status status,
							@error_procedure error_procedure,
							@error_line error_line,
							@mensaje mensaje
				end	

		end -- reporte de estatus

	end  -- principal
