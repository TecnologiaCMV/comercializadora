USE [comercializadora]
GO
/****** Object:  Table [dbo].[CatAlmacen]    Script Date: 11/02/2020 05:10:57 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CatAlmacen](
	[idAlmacen] [int] NOT NULL,
	[descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_CatAlmacen] PRIMARY KEY CLUSTERED 
(
	[idAlmacen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CatLineaProducto]    Script Date: 11/02/2020 05:10:57 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CatLineaProducto](
	[idLineaProducto] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_CatLineaProducto] PRIMARY KEY CLUSTERED 
(
	[idLineaProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CatPasillo]    Script Date: 11/02/2020 05:10:57 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CatPasillo](
	[idPasillo] [int] NOT NULL,
	[descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_CatPasillo] PRIMARY KEY CLUSTERED 
(
	[idPasillo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CatPiso]    Script Date: 11/02/2020 05:10:57 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CatPiso](
	[idPiso] [int] NOT NULL,
	[descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_CatPiso] PRIMARY KEY CLUSTERED 
(
	[idPiso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CatPuntoVenta]    Script Date: 11/02/2020 05:10:57 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CatPuntoVenta](
	[idPuntoVenta] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_CatPuntoVenta] PRIMARY KEY CLUSTERED 
(
	[idPuntoVenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CatRaq]    Script Date: 11/02/2020 05:10:57 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CatRaq](
	[idRaq] [int] NOT NULL,
	[descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_CatRaq] PRIMARY KEY CLUSTERED 
(
	[idRaq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CatRoles]    Script Date: 11/02/2020 05:10:57 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CatRoles](
	[idRol] [int] NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_CatRoles] PRIMARY KEY CLUSTERED 
(
	[idRol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CatTipoCliente]    Script Date: 11/02/2020 05:10:57 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CatTipoCliente](
	[idTipoCliente] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](50) NULL,
	[descuento] [money] not null
 CONSTRAINT [PK_CatTipoCliente] PRIMARY KEY CLUSTERED 
(
	[idTipoCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CatTipoPrecio]    Script Date: 11/02/2020 05:10:57 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CatTipoPrecio](
	[idTipoPrecio] [int] NOT NULL,
	[descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_CatTipoPrecio] PRIMARY KEY CLUSTERED 
(
	[idTipoPrecio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CatUnidadMedida]    Script Date: 11/02/2020 05:10:57 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CatUnidadMedida](
	[idUnidadMedida] [int] NOT NULL,
	[descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_CatUnidadMedida] PRIMARY KEY CLUSTERED 
(
	[idUnidadMedida] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CatStatusVenta]    Script Date: 11/02/2020 05:10:57 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CatStatusVenta](
	[idStatusVenta] [int] NOT NULL,
	[descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_CatStatusVenta] PRIMARY KEY CLUSTERED 
(
	[idStatusVenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 11/02/2020 05:10:57 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Clientes](
	[idCliente] [int] IDENTITY(1,1) NOT NULL,
	[nombres] [varchar](50) NULL,
	[apellidoPaterno] [varchar](50) NULL,
	[apellidoMaterno] [varchar](50) NULL,
	[telefono] [varchar](50) NULL,
	[correo] [varchar](50) NULL,
	[rfc] [varchar](50) NULL,
	[calle] [varchar](50) NULL,
	[numeroExterior] [varchar](50) NULL,
	[colonia] [varchar](50) NULL,
	[municipio] [varchar](50) NULL,
	[cp] [varchar](50) NULL,
	[estado] [varchar](50) NULL,
	[fechaAlta] [varchar](50) NULL,
	[activo] [varchar](50) NULL,
 CONSTRAINT [PK_Clientes] PRIMARY KEY CLUSTERED 
(
	[idCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Compras]    Script Date: 11/02/2020 05:10:57 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Compras](
	[idCompra] [int] NOT NULL,
	[idProveedor] [int] NOT NULL,
	[cantidad] [float] NULL,
	[fechaAlta] [datetime] NULL,
 CONSTRAINT [PK_Compras] PRIMARY KEY CLUSTERED 
(
	[idCompra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InventarioDetalle]    Script Date: 11/02/2020 05:10:57 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventarioDetalle](
	[idInventarioDetalle] [int] IDENTITY(1,1) NOT NULL,
	[idProducto] [int] NULL,
	[cantidad] [float] NULL,
	[fechaAlta] [datetime] NULL,
	[idUbicacion] [int] NOT NULL,
 CONSTRAINT [PK_InventarioAlmacen] PRIMARY KEY CLUSTERED 
(
	[idInventarioDetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InventarioGeneral]    Script Date: 11/02/2020 05:10:57 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventarioGeneral](
	[contador] [int] NOT NULL,
	[idProducto] [int] NOT NULL,
	[cantidad] [float] NULL,
	[FechaAlta] [datetime] NULL,
 CONSTRAINT [PK_InventarioGeneral] PRIMARY KEY CLUSTERED 
(
	[idProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InventarioPuntoVenta]    Script Date: 11/02/2020 05:10:57 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventarioPuntoVenta](
	[idInventarioPuntoVenta] [int] IDENTITY(1,1) NOT NULL,
	[idPuntoVenta] [int] NOT NULL,
	[idProducto] [int] NOT NULL,
	[cantidad] [float] NOT NULL,
	[fechaAlta] [int] NOT NULL,
 CONSTRAINT [PK_InventarioPuntoVenta] PRIMARY KEY CLUSTERED 
(
	[idInventarioPuntoVenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Productos]    Script Date: 11/02/2020 05:10:57 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Productos](
	[idProducto] [int] NOT NULL,
	[descripcion] [nchar](10) NOT NULL,
	[idUnidadMedida] [int] NOT NULL,
	[idLineaProducto] [int] NOT NULL,
	[cantidadUnidadMedida] [float] NOT NULL,
	[codigoBarras] [varchar](max) NULL,
	[fechaAlta] [nchar](10) NOT NULL,
	[activo] [nchar](10) NOT NULL,
	[claveProdServ]	[float] NOT NULL default '1010101',
	[claveUnidad] nvarchar (510) NOT NULL default '0',
 CONSTRAINT [PK_Productos] PRIMARY KEY CLUSTERED 
(
	[idProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductosPorPrecio]    Script Date: 11/02/2020 05:10:57 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductosPorPrecio](
	[idProducto] [int] IDENTITY(1,1) NOT NULL,
	[min] [decimal](18, 0) NULL,
	[max] [decimal](18, 0) NULL,
	[costo] [decimal](18, 0) NULL,
	[idTipoPrecio] [int] NULL,
 CONSTRAINT [PK_ProductosPorPrecio] PRIMARY KEY CLUSTERED 
(
	[idProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Proveedores]    Script Date: 11/02/2020 05:10:57 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Proveedores](
	[idProveedor] [int] NOT NULL,
	[nombre] [varchar](50) NULL,
	[descripcion] [varchar](50) NULL,
	[telefono] [varchar](10) NULL,
	[direccion] [varchar](250) NULL,
 CONSTRAINT [PK_Proveedores] PRIMARY KEY CLUSTERED 
(
	[idProveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Ubicacion]    Script Date: 11/02/2020 05:10:57 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ubicacion](
	[idUbicacion] [int] IDENTITY(1,1) NOT NULL,
	[idAlmacen] [int] NULL,
	[idPasillo] [int] NULL,
	[idRaq] [int] NULL,
	[idPiso] [int] NULL,
 CONSTRAINT [PK_Ubicacion] PRIMARY KEY CLUSTERED 
(
	[idUbicacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 11/02/2020 05:10:57 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuarios](
	[idUsuario] [int] NOT NULL,
	[idRol] [int] NOT NULL,
	[idPuntoVenta] [int] NOT NULL,
	[nombre] [varchar](50) NULL,
	[telefono] [varchar](10) NULL,
	[contrasena] [varchar](50) NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Ventas]    Script Date: 11/02/2020 05:10:57 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ventas](
	[idVenta] [int] IDENTITY(1,1) NOT NULL,
	[idCliente] [int] NOT NULL,
	[cantidad] [float] NULL,
	[fechaAlta] [datetime] NULL,
	[montoTotal] [decimal](18, 0) NULL,
	[idUsuario] [int] NOT NULL,	
	[idStatusVenta] [int] NOT NULL,
 CONSTRAINT [PK_Ventas] PRIMARY KEY CLUSTERED 
(
	[idVenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VentasDetalle]    Script Date: 11/02/2020 05:10:57 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VentasDetalle](
	[idVentaDetalle] [int] IDENTITY(1,1) NOT NULL,
	[idVenta] [int] NOT NULL,
	[idProducto] [int] NOT NULL,
	--[idPuntoVenta] [int] NOT NULL,
	--[idUsuario] [int] NOT NULL,
	[cantidad] [float] NULL,
	[monto] [decimal](18, 0) NULL,
	[cantidadActualInvGeneral] [float] NULL,
	[cantidadAnteriorInvGeneral] [float] NULL,
 CONSTRAINT [PK_VentasDetalle] PRIMARY KEY CLUSTERED 
(
	[idVentaDetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Compras]  WITH CHECK ADD  CONSTRAINT [FK_Compras_Compras] FOREIGN KEY([idProveedor])
REFERENCES [dbo].[Proveedores] ([idProveedor])
GO
ALTER TABLE [dbo].[Compras] CHECK CONSTRAINT [FK_Compras_Compras]
GO
ALTER TABLE [dbo].[InventarioDetalle]  WITH CHECK ADD  CONSTRAINT [FK_InventarioDetalle_Ubicacion] FOREIGN KEY([idProducto])
REFERENCES [dbo].[Productos] ([idProducto])
GO
ALTER TABLE [dbo].[InventarioDetalle] CHECK CONSTRAINT [FK_InventarioDetalle_Ubicacion]
GO
ALTER TABLE [dbo].[InventarioGeneral]  WITH CHECK ADD  CONSTRAINT [FK_InventarioGeneral_InventarioGeneral] FOREIGN KEY([idProducto])
REFERENCES [dbo].[Productos] ([idProducto])
GO
ALTER TABLE [dbo].[InventarioGeneral] CHECK CONSTRAINT [FK_InventarioGeneral_InventarioGeneral]
GO
ALTER TABLE [dbo].[InventarioPuntoVenta]  WITH CHECK ADD  CONSTRAINT [FK_InventarioPuntoVenta_InventarioPuntoVenta] FOREIGN KEY([idPuntoVenta])
REFERENCES [dbo].[CatPuntoVenta] ([idPuntoVenta])
GO
ALTER TABLE [dbo].[InventarioPuntoVenta] CHECK CONSTRAINT [FK_InventarioPuntoVenta_InventarioPuntoVenta]
GO
ALTER TABLE [dbo].[InventarioPuntoVenta]  WITH CHECK ADD  CONSTRAINT [FK_InventarioPuntoVenta_Productos] FOREIGN KEY([idProducto])
REFERENCES [dbo].[Productos] ([idProducto])
GO
ALTER TABLE [dbo].[InventarioPuntoVenta] CHECK CONSTRAINT [FK_InventarioPuntoVenta_Productos]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [FK_Productos_CatLineaProducto] FOREIGN KEY([idLineaProducto])
REFERENCES [dbo].[CatLineaProducto] ([idLineaProducto])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [FK_Productos_CatLineaProducto]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [FK_Productos_Productos] FOREIGN KEY([idUnidadMedida])
REFERENCES [dbo].[CatUnidadMedida] ([idUnidadMedida])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [FK_Productos_Productos]
GO
ALTER TABLE [dbo].[ProductosPorPrecio]  WITH CHECK ADD  CONSTRAINT [FK_ProductosPorPrecio_CatTipoPrecio] FOREIGN KEY([idTipoPrecio])
REFERENCES [dbo].[CatTipoPrecio] ([idTipoPrecio])
GO
ALTER TABLE [dbo].[ProductosPorPrecio] CHECK CONSTRAINT [FK_ProductosPorPrecio_CatTipoPrecio]
GO
ALTER TABLE [dbo].[Ubicacion]  WITH CHECK ADD  CONSTRAINT [FK_Ubicacion_CatPiso] FOREIGN KEY([idPiso])
REFERENCES [dbo].[CatPiso] ([idPiso])
GO
ALTER TABLE [dbo].[Ubicacion] CHECK CONSTRAINT [FK_Ubicacion_CatPiso]
GO
ALTER TABLE [dbo].[Ubicacion]  WITH CHECK ADD  CONSTRAINT [FK_Ubicacion_CatRaq] FOREIGN KEY([idRaq])
REFERENCES [dbo].[CatRaq] ([idRaq])
GO
ALTER TABLE [dbo].[Ubicacion] CHECK CONSTRAINT [FK_Ubicacion_CatRaq]
GO
ALTER TABLE [dbo].[Ubicacion]  WITH CHECK ADD  CONSTRAINT [FK_Ubicacion_Ubicacion] FOREIGN KEY([idAlmacen])
REFERENCES [dbo].[CatAlmacen] ([idAlmacen])
GO
ALTER TABLE [dbo].[Ubicacion] CHECK CONSTRAINT [FK_Ubicacion_Ubicacion]
GO
ALTER TABLE [dbo].[Ubicacion]  WITH CHECK ADD  CONSTRAINT [FK_Ubicacion_Ubicacion1] FOREIGN KEY([idPasillo])
REFERENCES [dbo].[CatPasillo] ([idPasillo])
GO
ALTER TABLE [dbo].[Ubicacion] CHECK CONSTRAINT [FK_Ubicacion_Ubicacion1]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [FK_Usuarios_CatRoles] FOREIGN KEY([idPuntoVenta])
REFERENCES [dbo].[CatPuntoVenta] ([idPuntoVenta])
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [FK_Usuarios_CatRoles]
GO
ALTER TABLE [dbo].[Ventas]  WITH CHECK ADD  CONSTRAINT [FK_Ventas_Clientes] FOREIGN KEY([idCliente])
REFERENCES [dbo].[Clientes] ([idCliente])
GO
ALTER TABLE [dbo].[Ventas] CHECK CONSTRAINT [FK_Ventas_Clientes]
GO
--ALTER TABLE [dbo].[VentasDetalle]  WITH CHECK ADD  CONSTRAINT [FK_VentasDetalle_CatPuntoVenta] FOREIGN KEY([idPuntoVenta])
--REFERENCES [dbo].[CatPuntoVenta] ([idPuntoVenta])
--GO
--ALTER TABLE [dbo].[VentasDetalle] CHECK CONSTRAINT [FK_VentasDetalle_CatPuntoVenta]
--GO
ALTER TABLE [dbo].[VentasDetalle]  WITH CHECK ADD  CONSTRAINT [FK_VentasDetalle_Productos] FOREIGN KEY([idProducto])
REFERENCES [dbo].[Productos] ([idProducto])
GO
ALTER TABLE [dbo].[VentasDetalle] CHECK CONSTRAINT [FK_VentasDetalle_Productos]
GO
ALTER TABLE [dbo].[VentasDetalle]  WITH CHECK ADD  CONSTRAINT [FK_VentasDetalle_Ventas] FOREIGN KEY([idVenta])
REFERENCES [dbo].[Ventas] ([idVenta])
GO
ALTER TABLE [dbo].[VentasDetalle] CHECK CONSTRAINT [FK_VentasDetalle_Ventas]
GO
ALTER TABLE [dbo].[Ventas]  WITH CHECK ADD  CONSTRAINT [FK_ESTATUS_VENTA] FOREIGN KEY([idStatusVenta])
REFERENCES [dbo].[CatStatusVenta] ([idStatusVenta])
GO