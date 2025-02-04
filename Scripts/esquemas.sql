USE [master]
GO
/****** Object:  Database [DB_A552FA_comercializadora]    Script Date: 11/04/2020 14:20:52 ******/
CREATE DATABASE [DB_A552FA_comercializadora]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DB_A552FA_comercializadora_Data', FILENAME = N'H:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\DB_A552FA_comercializadora_DATA.mdf' , SIZE = 12032KB , MAXSIZE = 1024000KB , FILEGROWTH = 10%)
 LOG ON 
( NAME = N'DB_A552FA_comercializadora_Log', FILENAME = N'H:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\DB_A552FA_comercializadora_Log.LDF' , SIZE = 3072KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [DB_A552FA_comercializadora] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DB_A552FA_comercializadora].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DB_A552FA_comercializadora] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DB_A552FA_comercializadora] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DB_A552FA_comercializadora] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DB_A552FA_comercializadora] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DB_A552FA_comercializadora] SET ARITHABORT OFF 
GO
ALTER DATABASE [DB_A552FA_comercializadora] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DB_A552FA_comercializadora] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DB_A552FA_comercializadora] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DB_A552FA_comercializadora] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DB_A552FA_comercializadora] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DB_A552FA_comercializadora] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DB_A552FA_comercializadora] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DB_A552FA_comercializadora] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DB_A552FA_comercializadora] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DB_A552FA_comercializadora] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DB_A552FA_comercializadora] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DB_A552FA_comercializadora] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DB_A552FA_comercializadora] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DB_A552FA_comercializadora] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DB_A552FA_comercializadora] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DB_A552FA_comercializadora] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DB_A552FA_comercializadora] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DB_A552FA_comercializadora] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DB_A552FA_comercializadora] SET  MULTI_USER 
GO
ALTER DATABASE [DB_A552FA_comercializadora] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DB_A552FA_comercializadora] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DB_A552FA_comercializadora] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DB_A552FA_comercializadora] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [DB_A552FA_comercializadora] SET DELAYED_DURABILITY = DISABLED 
GO
USE [DB_A552FA_comercializadora]
GO
/****** Object:  Table [dbo].[Almacenes]    Script Date: 11/04/2020 14:20:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Almacenes](
	[idAlmacen] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NULL,
	[idTipoAlmacen] [int] NULL,
	[idSucursal] [int] NULL,
 CONSTRAINT [PK_Almacenes] PRIMARY KEY CLUSTERED 
(
	[idAlmacen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CatEstatusInventario]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CatEstatusInventario](
	[idEstatusAlmacen] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_CatEstatusAlmacen] PRIMARY KEY CLUSTERED 
(
	[idEstatusAlmacen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CatPasillo]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CatPasillo](
	[idPasillo] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_CatPasillo] PRIMARY KEY CLUSTERED 
(
	[idPasillo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CatPiso]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CatPiso](
	[idPiso] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_CatPiso] PRIMARY KEY CLUSTERED 
(
	[idPiso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CatRaq]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CatRaq](
	[idRaq] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_CatRaq] PRIMARY KEY CLUSTERED 
(
	[idRaq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CatRoles]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CatRoles](
	[idRol] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
	[activo] [bit] NOT NULL CONSTRAINT [DF_CatRoles_activo]  DEFAULT ((1)),
 CONSTRAINT [PK_CatRoles] PRIMARY KEY CLUSTERED 
(
	[idRol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CatStatusVenta]    Script Date: 11/04/2020 14:20:55 ******/
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
/****** Object:  Table [dbo].[CatSucursales]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CatSucursales](
	[idSucursal] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_CatSucursales] PRIMARY KEY CLUSTERED 
(
	[idSucursal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CatTipoAlmacen]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CatTipoAlmacen](
	[idTipoAlmacen] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_CatAlmacen] PRIMARY KEY CLUSTERED 
(
	[idTipoAlmacen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CatTipoCliente]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CatTipoCliente](
	[idTipoCliente] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](50) NULL,
	[descuento] [money] NOT NULL,
	[activo] [bit] NOT NULL,
 CONSTRAINT [PK_CatTipoCliente] PRIMARY KEY CLUSTERED 
(
	[idTipoCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CatTipoPrecio]    Script Date: 11/04/2020 14:20:55 ******/
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
/****** Object:  Table [dbo].[CatTipoTransferenciaMercancia]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CatTipoTransferenciaMercancia](
	[idTipoTransferenciaMercancia] [int] NOT NULL,
	[descripcion] [varchar](100) NULL,
 CONSTRAINT [PK_CatTipoTransferenciaMercancia] PRIMARY KEY CLUSTERED 
(
	[idTipoTransferenciaMercancia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CatUnidadMedida]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CatUnidadMedida](
	[idUnidadMedida] [int] NOT NULL,
	[descripcion] [varchar](50) NULL,
	[claveUnidadSAT] [varchar](50) NULL,
	[unidadSAT] [varchar](50) NULL,
	[descripcionSAT] [varchar](50) NULL,
 CONSTRAINT [PK_CatUnidadMedida] PRIMARY KEY CLUSTERED 
(
	[idUnidadMedida] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 11/04/2020 14:20:55 ******/
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
	[fechaAlta] [datetime] NULL,
	[activo] [bit] NULL,
	[idTipoCliente] [int] NOT NULL,
 CONSTRAINT [PK_Clientes] PRIMARY KEY CLUSTERED 
(
	[idCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Compras]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Compras](
	[idCompra] [int] IDENTITY(1,1) NOT NULL,
	[idProveedor] [int] NOT NULL,
	[cantidad] [float] NULL,
	[fechaAlta] [datetime] NULL,
	[idUsuario] [int] NULL,
	[idProducto] [int] NULL,
 CONSTRAINT [PK_Compras] PRIMARY KEY CLUSTERED 
(
	[idCompra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FactCatClaveProdServicio]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactCatClaveProdServicio](
	[id] [int] NOT NULL,
	[claveProdServ] [float] NULL,
	[descripcion] [nvarchar](255) NULL,
	[Incluir _IVA_trasladado] [nvarchar](255) NULL,
 CONSTRAINT [PK_FactCatClaveProdServicio] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FactCatClaveUnidad]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactCatClaveUnidad](
	[id] [int] NOT NULL,
	[claveUnidad] [nvarchar](255) NULL,
	[nombre] [nvarchar](255) NULL,
	[descripcion] [nvarchar](255) NULL,
	[nota] [nvarchar](255) NULL,
	[simbolo] [nvarchar](255) NULL,
 CONSTRAINT [PK_FactCatClaveUnidad] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FactCatFormaPago]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FactCatFormaPago](
	[id] [int] NOT NULL,
	[formaPago] [varchar](50) NULL,
	[descripcion] [nvarchar](255) NULL,
 CONSTRAINT [PK_FactCatFormaPago] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FactCatMetodoPago]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FactCatMetodoPago](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[metodoPago] [varchar](250) NULL,
	[descripcion] [varchar](250) NULL,
 CONSTRAINT [PK_FactCatMetodoPago] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FactCatUsoCFDI]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactCatUsoCFDI](
	[id] [float] NULL,
	[usoCFDI] [nvarchar](255) NULL,
	[descripcion] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FactConfiguracionComprobante]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FactConfiguracionComprobante](
	[contador] [int] IDENTITY(1,1) NOT NULL,
	[Version] [varchar](3) NULL,
	[Moneda] [varchar](3) NULL,
	[TipoDeComprobante] [varchar](1) NULL,
	[MetodoPago] [varchar](3) NULL,
	[LugarExpedicion] [varchar](6) NULL,
	[RegimenFiscal] [varchar](3) NULL,
	[Rfc] [varchar](16) NULL,
	[Nombre] [varchar](500) NULL,
 CONSTRAINT [PK_FactConfiguracionComprobante] PRIMARY KEY CLUSTERED 
(
	[contador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Facturas]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Facturas](
	[idFactura] [bigint] IDENTITY(1,1) NOT NULL,
	[idVenta] [bigint] NULL,
	[fechaTimbrado] [datetime] NULL,
	[fecha] [datetime] NULL,
	[UUID] [varchar](max) NOT NULL,
	[idEstatusFactura] [nchar](10) NULL,
 CONSTRAINT [PK_Facturas] PRIMARY KEY CLUSTERED 
(
	[idFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[InventarioDetalle]    Script Date: 11/04/2020 14:20:55 ******/
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
/****** Object:  Table [dbo].[InventarioGeneral]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventarioGeneral](
	[contador] [int] NOT NULL,
	[idProducto] [int] NOT NULL,
	[cantidad] [float] NOT NULL,
	[fechaUltimaActualizacion] [datetime] NULL,
 CONSTRAINT [PK_InventarioGeneral] PRIMARY KEY CLUSTERED 
(
	[contador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LineaProducto]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LineaProducto](
	[idLineaProducto] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
	[activo] [bit] NULL,
 CONSTRAINT [PK_CatLineaProducto] PRIMARY KEY CLUSTERED 
(
	[idLineaProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Productos](
	[idProducto] [int] NOT NULL,
	[descripcion] [varchar](100) NULL,
	[idUnidadMedida] [int] NOT NULL,
	[idLineaProducto] [int] NOT NULL,
	[cantidadUnidadMedida] [float] NOT NULL,
	[codigoBarras] [varchar](max) NULL,
	[fechaAlta] [datetime] NULL,
	[activo] [bit] NULL,
	[articulo] [varchar](100) NULL,
	[claveProdServ] [float] NOT NULL DEFAULT ('1010101'),
 CONSTRAINT [PK_Productos] PRIMARY KEY CLUSTERED 
(
	[idProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[productos_excel]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[productos_excel](
	[idProducto] [int] NOT NULL,
	[descripcion] [varchar](100) NULL,
	[idUnidadMedida] [int] NOT NULL,
	[idLineaProducto] [int] NOT NULL,
	[cantidadUnidadMedida] [float] NOT NULL,
	[codigoBarras] [varchar](max) NULL,
	[fechaAlta] [datetime] NULL,
	[activo] [bit] NULL,
	[articulo] [varchar](100) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductosPorPrecio]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductosPorPrecio](
	[contador] [int] IDENTITY(1,1) NOT NULL,
	[idProducto] [int] NOT NULL,
	[min] [decimal](18, 0) NULL,
	[max] [decimal](18, 0) NULL,
	[costo] [decimal](18, 0) NULL,
	[activo] [bit] NOT NULL,
	[idTipoPrecio] [int] NULL,
 CONSTRAINT [PK_ProductosPorPrecio] PRIMARY KEY CLUSTERED 
(
	[contador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Proveedores]    Script Date: 11/04/2020 14:20:55 ******/
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
	[activo] [bit] NULL,
 CONSTRAINT [PK_Proveedores] PRIMARY KEY CLUSTERED 
(
	[idProveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TransferenciaMercancia]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransferenciaMercancia](
	[idTransferenciaMercancia] [int] NOT NULL,
	[idUsuario] [int] NOT NULL,
	[idUbicacionOrigen] [int] NOT NULL,
	[idUbicacionDestino] [int] NOT NULL,
	[idProducto] [int] NOT NULL,
	[cantidad] [float] NOT NULL,
	[fechaAlta] [datetime] NOT NULL,
	[idTipoTransferenciaMercancia] [int] NOT NULL,
 CONSTRAINT [PK_TransferenciaMercancia] PRIMARY KEY CLUSTERED 
(
	[idTransferenciaMercancia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Ubicacion]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ubicacion](
	[idUbicacion] [int] IDENTITY(1,1) NOT NULL,
	[idAlmacen] [int] NOT NULL,
	[idPasillo] [int] NOT NULL,
	[idRaq] [int] NOT NULL,
	[idPiso] [int] NOT NULL,
 CONSTRAINT [PK_Ubicacion] PRIMARY KEY CLUSTERED 
(
	[idUbicacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuarios](
	[idUsuario] [int] NOT NULL,
	[idRol] [int] NOT NULL,
	[usuario] [varchar](50) NULL,
	[telefono] [varchar](10) NULL,
	[contrasena] [varchar](50) NULL,
	[idAlmacen] [int] NOT NULL,
	[idSucursal] [int] NULL,
	[nombre] [varchar](50) NULL,
	[apellidoPaterno] [varchar](50) NULL,
	[apellidoMaterno] [varchar](50) NULL,
	[fecha_alta] [datetime] NULL,
	[activo] [bit] NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Ventas]    Script Date: 11/04/2020 14:20:55 ******/
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
	[idFactFormaPago] [int] NULL,
 CONSTRAINT [PK_Ventas] PRIMARY KEY CLUSTERED 
(
	[idVenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VentasDetalle]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VentasDetalle](
	[idVentaDetalle] [int] IDENTITY(1,1) NOT NULL,
	[idVenta] [int] NOT NULL,
	[idProducto] [int] NOT NULL,
	[cantidad] [float] NULL,
	[contadorProductosPorPrecio] [int] NOT NULL,
	[monto] [decimal](18, 0) NULL,
	[cantidadActualInvGeneral] [float] NULL,
	[cantidadAnteriorInvGeneral] [float] NULL,
 CONSTRAINT [PK_VentasDetalle] PRIMARY KEY CLUSTERED 
(
	[idVentaDetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Almacenes]  WITH CHECK ADD  CONSTRAINT [FK_Almacenes_CatSucursales] FOREIGN KEY([idSucursal])
REFERENCES [dbo].[CatSucursales] ([idSucursal])
GO
ALTER TABLE [dbo].[Almacenes] CHECK CONSTRAINT [FK_Almacenes_CatSucursales]
GO
ALTER TABLE [dbo].[Almacenes]  WITH CHECK ADD  CONSTRAINT [FK_Almacenes_CatTipoAlmacen] FOREIGN KEY([idTipoAlmacen])
REFERENCES [dbo].[CatTipoAlmacen] ([idTipoAlmacen])
GO
ALTER TABLE [dbo].[Almacenes] CHECK CONSTRAINT [FK_Almacenes_CatTipoAlmacen]
GO
ALTER TABLE [dbo].[Compras]  WITH CHECK ADD  CONSTRAINT [FK__Compras__idProdu__2022C2A6] FOREIGN KEY([idProducto])
REFERENCES [dbo].[Productos] ([idProducto])
GO
ALTER TABLE [dbo].[Compras] CHECK CONSTRAINT [FK__Compras__idProdu__2022C2A6]
GO
ALTER TABLE [dbo].[Compras]  WITH CHECK ADD  CONSTRAINT [FK_Compras_Compras] FOREIGN KEY([idProveedor])
REFERENCES [dbo].[Proveedores] ([idProveedor])
GO
ALTER TABLE [dbo].[Compras] CHECK CONSTRAINT [FK_Compras_Compras]
GO
ALTER TABLE [dbo].[Compras]  WITH CHECK ADD  CONSTRAINT [FK_Compras_Usuarios] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[Compras] CHECK CONSTRAINT [FK_Compras_Usuarios]
GO
ALTER TABLE [dbo].[InventarioDetalle]  WITH CHECK ADD  CONSTRAINT [FK_InventarioDetalle_Ubicacion] FOREIGN KEY([idProducto])
REFERENCES [dbo].[Productos] ([idProducto])
GO
ALTER TABLE [dbo].[InventarioDetalle] CHECK CONSTRAINT [FK_InventarioDetalle_Ubicacion]
GO
ALTER TABLE [dbo].[InventarioDetalle]  WITH CHECK ADD  CONSTRAINT [FK_InventarioDetalle_Ubicacion1] FOREIGN KEY([idUbicacion])
REFERENCES [dbo].[Ubicacion] ([idUbicacion])
GO
ALTER TABLE [dbo].[InventarioDetalle] CHECK CONSTRAINT [FK_InventarioDetalle_Ubicacion1]
GO
ALTER TABLE [dbo].[InventarioGeneral]  WITH CHECK ADD  CONSTRAINT [FK_InventarioGeneral_InventarioGeneral] FOREIGN KEY([idProducto])
REFERENCES [dbo].[Productos] ([idProducto])
GO
ALTER TABLE [dbo].[InventarioGeneral] CHECK CONSTRAINT [FK_InventarioGeneral_InventarioGeneral]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [FK_Productos_CatLineaProducto] FOREIGN KEY([idLineaProducto])
REFERENCES [dbo].[LineaProducto] ([idLineaProducto])
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
ALTER TABLE [dbo].[ProductosPorPrecio]  WITH CHECK ADD  CONSTRAINT [FK_ProductosPorPrecio_Productos] FOREIGN KEY([idProducto])
REFERENCES [dbo].[Productos] ([idProducto])
GO
ALTER TABLE [dbo].[ProductosPorPrecio] CHECK CONSTRAINT [FK_ProductosPorPrecio_Productos]
GO
ALTER TABLE [dbo].[TransferenciaMercancia]  WITH CHECK ADD  CONSTRAINT [FK_TransferenciaMercancia_CatTipoTransferenciaMercancia] FOREIGN KEY([idTipoTransferenciaMercancia])
REFERENCES [dbo].[CatTipoTransferenciaMercancia] ([idTipoTransferenciaMercancia])
GO
ALTER TABLE [dbo].[TransferenciaMercancia] CHECK CONSTRAINT [FK_TransferenciaMercancia_CatTipoTransferenciaMercancia]
GO
ALTER TABLE [dbo].[TransferenciaMercancia]  WITH CHECK ADD  CONSTRAINT [FK_TransferenciaMercancia_Productos] FOREIGN KEY([idProducto])
REFERENCES [dbo].[Productos] ([idProducto])
GO
ALTER TABLE [dbo].[TransferenciaMercancia] CHECK CONSTRAINT [FK_TransferenciaMercancia_Productos]
GO
ALTER TABLE [dbo].[TransferenciaMercancia]  WITH CHECK ADD  CONSTRAINT [FK_TransferenciaMercancia_Usuarios] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[TransferenciaMercancia] CHECK CONSTRAINT [FK_TransferenciaMercancia_Usuarios]
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
REFERENCES [dbo].[Almacenes] ([idAlmacen])
GO
ALTER TABLE [dbo].[Ubicacion] CHECK CONSTRAINT [FK_Ubicacion_Ubicacion]
GO
ALTER TABLE [dbo].[Ubicacion]  WITH CHECK ADD  CONSTRAINT [FK_Ubicacion_Ubicacion1] FOREIGN KEY([idPasillo])
REFERENCES [dbo].[CatPasillo] ([idPasillo])
GO
ALTER TABLE [dbo].[Ubicacion] CHECK CONSTRAINT [FK_Ubicacion_Ubicacion1]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [FK_Usuarios_CatRoles] FOREIGN KEY([idRol])
REFERENCES [dbo].[CatRoles] ([idRol])
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [FK_Usuarios_CatRoles]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [FK_Usuarios_Usuarios] FOREIGN KEY([idAlmacen])
REFERENCES [dbo].[Almacenes] ([idAlmacen])
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [FK_Usuarios_Usuarios]
GO
ALTER TABLE [dbo].[Ventas]  WITH CHECK ADD  CONSTRAINT [FK_ESTATUS_VENTA] FOREIGN KEY([idStatusVenta])
REFERENCES [dbo].[CatStatusVenta] ([idStatusVenta])
GO
ALTER TABLE [dbo].[Ventas] CHECK CONSTRAINT [FK_ESTATUS_VENTA]
GO
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
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_STATUS_CLIENTES]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		Actualiza el estatus los clientes del sistema
status			200 = ok
				-1	= error
*/

CREATE proc [dbo].[SP_ACTUALIZA_STATUS_CLIENTES]

	@idCliente		int,
	@activo			bit

as

	begin -- principal
	
		begin try

			begin --declaraciones 

				declare @status					int = 200,
						@mensaje				varchar(255) = 'Cliente modificado correctamente.',
						@error_line				varchar(255) = '',
						@error_procedure		varchar(255) = '',
						@valido					bit = cast(0 as bit)

			end  --declaraciones 

			begin -- principal
				
				if not exists ( select 1 from Clientes where idCliente = @idCliente )
					begin
						select @mensaje = 'No existe el Cliente solicitado.'
						raiserror (@mensaje, 11, -1)
					end
				else
					begin
						
						update	Clientes
						set		activo = @activo
						where	idCliente = @idCliente

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

GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_STATUS_LINEAS_PRODUCTO]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		Actualiza el estatus de las lineas de producto
status			200 = ok
				-1	= error
*/

create proc [dbo].[SP_ACTUALIZA_STATUS_LINEAS_PRODUCTO]

	@idLineaProducto	int,
	@activo				bit

as

	begin -- principal
	
		begin try

			begin --declaraciones 

				declare @status					int = 200,
						@mensaje				varchar(255) = 'Linea de Producto modificada correctamente.',
						@error_line				varchar(255) = '',
						@error_procedure		varchar(255) = '',
						@valido					bit = cast(0 as bit)

			end  --declaraciones 

			begin -- principal
				
				if not exists ( select 1 from LineaProducto where idLineaProducto = @idLineaProducto )
					begin
						select @mensaje = 'No existe la Linea de Producto solicitada.'
						raiserror (@mensaje, 11, -1)
					end
				else
					begin
						
						update	LineaProducto
						set		activo = @activo
						where	idLineaProducto = @idLineaProducto

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


			select	@status status,
					@error_procedure error_procedure,
					@error_line error_line,
					@mensaje mensaje

				
		end -- reporte de estatus

	end  -- principal

GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_STATUS_PRODUCTOS]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		Actualiza el estatus los productos del sistema
status			200 = ok
				-1	= error
*/

create proc [dbo].[SP_ACTUALIZA_STATUS_PRODUCTOS]

	@idProducto		int,
	@activo			bit

as

	begin -- principal
	
		begin try

			begin --declaraciones 

				declare @status					int = 200,
						@mensaje				varchar(255) = 'Producto modificado correctamente.',
						@error_line				varchar(255) = '',
						@error_procedure		varchar(255) = '',
						@valido					bit = cast(0 as bit)

			end  --declaraciones 

			begin -- principal
				
				if not exists ( select 1 from Productos where idProducto = @idProducto )
					begin
						select @mensaje = 'No existe el Producto solicitado.'
						raiserror (@mensaje, 11, -1)
					end
				else
					begin
						
						update	Productos
						set		activo = @activo
						where	idProducto = @idProducto

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


			select	@status status,
					@error_procedure error_procedure,
					@error_line error_line,
					@mensaje mensaje

				
		end -- reporte de estatus

	end  -- principal

GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_STATUS_PROVEEDOR]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		Actualiza el estatus del proveedor
status			200 = ok
				-1	= error
*/

create proc [dbo].[SP_ACTUALIZA_STATUS_PROVEEDOR]

	@idProveedor	int,
	@activo			bit

as

	begin -- principal
	
		begin try

			begin --declaraciones 

				declare @status					int = 200,
						@mensaje				varchar(255) = 'Proveedor modificado correctamente.',
						@error_line				varchar(255) = '',
						@error_procedure		varchar(255) = '',
						@valido					bit = cast(0 as bit)

			end  --declaraciones 

			begin -- principal
				
				if not exists ( select 1 from Proveedores where idProveedor = @idProveedor )
					begin
						select @mensaje = 'No existe el Proveedor solicitado.'
						raiserror (@mensaje, 11, -1)
					end
				else
					begin
						
						update	Proveedores
						set		activo = @activo
						where	idProveedor = @idProveedor

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


			select	@status status,
					@error_procedure error_procedure,
					@error_line error_line,
					@mensaje mensaje

				
		end -- reporte de estatus

	end  -- principal

GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_STATUS_TIPOS_CLIENTES]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		Actualiza el estatus los tipos de clientes del sistema
status			200 = ok
				-1	= error
*/

create proc [dbo].[SP_ACTUALIZA_STATUS_TIPOS_CLIENTES]

	@idTipoCliente		int,
	@activo				bit

as

	begin -- principal
	
		begin try

			begin --declaraciones 

				declare @status					int = 200,
						@mensaje				varchar(255) = 'Tipo de Cliente modificado correctamente.',
						@error_line				varchar(255) = '',
						@error_procedure		varchar(255) = '',
						@valido					bit = cast(0 as bit)

			end  --declaraciones 

			begin -- principal
				
				if not exists ( select 1 from CatTipoCliente where idTipoCliente = @idTipoCliente )
					begin
						select @mensaje = 'No Existe el Tipo de Cliente Solicitado.'
						raiserror (@mensaje, 11, -1)
					end
				else
					begin
						
						update	CatTipoCliente
						set		activo = @activo
						where	idTipoCliente = @idTipoCliente

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


			select	@status status,
					@error_procedure error_procedure,
					@error_line error_line,
					@mensaje mensaje

				
		end -- reporte de estatus

	end  -- principal

GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_STATUS_USUARIO]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		Consulta los diferentes sucursales del sistema
status			200 = ok
				-1	= error
*/

create proc [dbo].[SP_ACTUALIZA_STATUS_USUARIO]

	@idUsuario		int,
	@activo			bit

as

	begin -- principal
	
		begin try

			begin --declaraciones 

				declare @status					int = 200,
						@mensaje				varchar(255) = 'Usuario modificado correctamente.',
						@error_line				varchar(255) = '',
						@error_procedure		varchar(255) = '',
						@valido					bit = cast(0 as bit)

			end  --declaraciones 

			begin -- principal
				
				if not exists ( select 1 from usuarios where idUsuario = @idUsuario )
					begin
						select @mensaje = 'No existen el usuario solicitado.'
						raiserror (@mensaje, 11, -1)
					end
				else
					begin
						
						update	usuarios
						set		activo = @activo
						where	idUsuario = @idUsuario

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


			select	@status status,
					@error_procedure error_procedure,
					@error_line error_line,
					@mensaje mensaje

				
		end -- reporte de estatus

	end  -- principal

GO
/****** Object:  StoredProcedure [dbo].[SP_AGREGAR_PRODUCTO_INVENTARIO]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_AGREGAR_PRODUCTO_INVENTARIO]
@idProducto int,
@idProveedor int,
@cantidad int,
@idUsuario int

AS
BEGIN
	
	BEGIN TRY

		BEGIN TRAN
		   BEGIN
			insert into compras (idProveedor,cantidad,fechaAlta,idUsuario,idProducto)
			values (@idProveedor , @cantidad,getdate(),@idUsuario,@idProducto)
		
			if exists (select 1 from InventarioGeneral where idProducto = @idProducto)
			begin
					update InventarioGeneral set cantidad = cantidad + @cantidad, fechaUltimaActualizacion = getdate()
					where idProducto = @idProducto
			end
			else
			begin 
					 insert into InventarioGeneral (idProducto,cantidad,fechaUltimaActualizacion)
					 values(@idProducto ,@cantidad , getdate() )
			end
		  END
		COMMIT TRAN
		SELECT 200 Estatus , 'Producto agregado correctamente al inventario' Mensaje

		
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		select 
			-1 Estatus ,
			'Ha ocurrido un error al agregar el producto al inventario general' Mensaje,
			 ERROR_NUMBER() AS ErrorNumber  ,
			 ERROR_MESSAGE() AS ErrorMessage  
	END CATCH

END

GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_ALMACENES]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		Consulta los diferentes almacenes del sistema
status			200 = ok
				-1	= error
*/

create proc [dbo].[SP_CONSULTA_ALMACENES]

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
				
				if not exists ( select 1 from almacenes )
					begin
						select @mensaje = 'No existen almacenes registrados.'
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
						
					select	@status status,
							@error_procedure error_procedure,
							@error_line error_line,
							@mensaje mensaje,
							*
					from	Almacenes
					
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

GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_CLAVES_PRODUCTOS]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		Consulta los diferentes claves de productos 
status			200 = ok
				-1	= error
*/

create proc [dbo].[SP_CONSULTA_CLAVES_PRODUCTOS]

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
				
				if not exists ( select 1 from FactCatClaveProdServicio )
					begin
						select @mensaje = 'No existen claves de prouctos registradas.'
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
						
					select	distinct top 20
							@status status,
							@error_procedure error_procedure,
							@error_line error_line,
							@mensaje mensaje,
					
							claveProdServ,
							descripcion
					from	FactCatClaveProdServicio 

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

GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_CLAVES_UNIDAD]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		Consulta los diferentes claves de unidad para los productos
status			200 = ok
				-1	= error
*/

create proc [dbo].[SP_CONSULTA_CLAVES_UNIDAD]

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
				
				if not exists ( select 1 from FactCatClaveUnidad )
					begin
						select @mensaje = 'No existen claves registradas.'
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
						
					select	distinct top 20
							@status status,
							@error_procedure error_procedure,
							@error_line error_line,
							@mensaje mensaje,
					
							claveUnidad,
							nombre
					from	FactCatClaveUnidad 
					--where	descripcion is not null 
					--	and descripcion <> ''

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

GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_CLIENTES]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		Consulta los diferentes clientes del sistema
status			200 = ok
				-1	= error
*/

create proc [dbo].[SP_CONSULTA_CLIENTES]

	@idCliente				int

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
				
				if not exists ( select 1 from clientes )
					begin
						select @mensaje = 'No existen clientes registrados.'
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
							@mensaje mensaje
					select 
							ROW_NUMBER() OVER(ORDER BY idCliente DESC) AS contador,
							c.idCliente,
							c.nombres,
							c.apellidoPaterno,
							case
								when ( (c.activo = cast(0 as bit)) or (c.activo is null) ) then c.apellidoMaterno + ' (BAJA)'
								else c.apellidoMaterno
							end as apellidoMaterno,
							c.telefono,
							c.correo,
							case
								when c.rfc is null then '[no tiene]'
								else c.rfc
							end as rfc,
							c.calle,
							c.numeroExterior,
							c.colonia,
							c.municipio,
							c.cp,
							c.estado,
							c.fechaAlta,
							c.activo,
							c.idTipoCliente,
							t.descripcion, 
							cast(t.descuento as decimal(18,2)) as descuento
					from	Clientes c
							inner join CatTipoCliente t
								on c.idTipoCliente = t.idTipoCliente
					where	c.idCliente	 =	case
												when @idCliente > 0 then @idCliente
												else c.idCliente
											end
						--and	c.activo = cast(1 as bit)
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

GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_COMPRAS]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		Consulta las compras hechas a los proveedores
status			200 = ok
				-1	= error
*/

create proc [dbo].[SP_CONSULTA_COMPRAS]

	@idProducto				int = null,
	@descProducto			varchar(300) = null,
	@idProveedor			int = null,
	@idLineaProducto		int = null,
	@idUsuario				int = null,
	@fechaIni				datetime = null,
	@fechaFin				datetime = null

as

	begin -- principal
	
		begin try

			begin --declaraciones 

				declare @status					int = 200,
						@mensaje				varchar(255) = '',
						@error_line				varchar(255) = '',
						@error_procedure		varchar(255) = '',
						@valido					bit = cast(1 as bit)

				create table 
					#Compras
						(
							contador					int identity(1,1),
							idCompra					int,
							idProducto					int,
							descripcionProducto			varchar(300),
							idProveedor					int,
							descripcionProveedor		varchar(300),
							idUsuario					int,
							nombreUsuario				varchar(300),
							fechaAlta					datetime,
							cantidad					int,
							idLineaProducto				int,
							descripcionLineaProducto	varchar(300)
						)
						
			end  --declaraciones 

			begin -- principal
				
				-- validaciones
					if (	(@idProducto is null) and 
							(@idProveedor is null) and
							(@idUsuario is null) and
							(@fechaIni is null) and
							(@fechaFin is null)
						)
					begin
						select	@mensaje = 'Debe elejir al menos un criterio para la búsqueda de la Compra.',
								@valido = cast(0 as bit)						
						raiserror (@mensaje, 11, -1)
					end

				-- si son todos
					if (	(@idProducto = 0) and 
							(@idProveedor = 0) and
							(@idLineaProducto = 0) and
							(@idUsuario = 0) and
							(@fechaIni = '19000101') and
							(@fechaFin = '19000101')
						)
					begin

						insert into #Compras (idCompra,idProducto,descripcionProducto,idProveedor,descripcionProveedor,idUsuario,nombreUsuario,fechaAlta,cantidad,idLineaProducto,descripcionLineaProducto)
						select	top 50 idCompra,c.idProducto, p.descripcion as descripcionProducto, c.idProveedor, pro.nombre as descripcionProveedor, c.idUsuario, u.nombre + ' ' + u.apellidoPaterno + ' ' + u.apellidoMaterno as nombreUsuario, c.fechaAlta, c.cantidad,lp.idLineaProducto,lp.descripcion
						from	Compras c
									inner join Productos p
										on p.idProducto = c.idProducto
									inner join Usuarios u
										on u.idUsuario = c.idUsuario
									inner join Proveedores pro
										on pro.idProveedor = c.idProveedor					
									inner join LineaProducto lp
										on lp.idLineaProducto = p.idLineaProducto											

						order by idCompra desc

					end
				-- si es por busqueda
				else 
					begin

						insert into #Compras (idCompra,idProducto,descripcionProducto,idProveedor,descripcionProveedor,idUsuario,nombreUsuario,fechaAlta,cantidad,idLineaProducto,descripcionLineaProducto)
						select	idCompra,c.idProducto, p.descripcion as descripcionProducto, c.idProveedor, pro.nombre as descripcionProveedor, c.idUsuario, u.nombre + ' ' + u.apellidoPaterno + ' ' + u.apellidoMaterno as nombreUsuario, c.fechaAlta, c.cantidad,lp.idLineaProducto,lp.descripcion
						from	Compras c
									inner join Productos p
										on p.idProducto = c.idProducto
									inner join Usuarios u
										on u.idUsuario = c.idUsuario
									inner join Proveedores pro
										on pro.idProveedor = c.idProveedor
									inner join LineaProducto lp
										on lp.idLineaProducto = p.idLineaProducto											

						where	c.idProducto =	case
													when @idProducto is null then c.idProducto
													when @idProducto = 0 then c.idProducto
													else @idProducto
												end

							and p.descripcion like	case
														when @descProducto is null then p.descripcion
														else '%' + @descProducto + '%'
													end

							and c.idProveedor =	case
														when @idProveedor is null then c.idProveedor
														when @idProveedor = 0 then c.idProveedor
														else @idProveedor
													end

							and c.idUsuario =	case
														when @idUsuario is null then c.idUsuario
														when @idUsuario = 0 then c.idUsuario
														else @idUsuario
													end

							and lp.idLineaProducto =	case
															when @idLineaProducto is null then lp.idLineaProducto
															when @idLineaProducto = 0 then lp.idLineaProducto
															else @idLineaProducto
														end

							and cast(c.fechaAlta as date) >=	case
																	when @fechaIni is null then cast(c.fechaAlta as date)
																	when @fechaIni = 0 then cast(c.fechaAlta as date)
																	when @fechaIni = '19000101' then cast(c.fechaAlta as date)
																	else cast(@fechaIni as date)
																end

							and cast(c.fechaAlta as date) <=	case
																	when @fechaFin is null then cast(c.fechaAlta as date)
																	when @fechaFin = 0 then cast(c.fechaAlta as date)
																	when @fechaFin = '19000101' then cast(c.fechaAlta as date)
																	else cast(@fechaFin as date)
																end

					end

				
				if not exists ( select 1 from #Compras )
					begin
						select	@valido = cast(0 as bit),
								@status = -1,
								@mensaje = 'No se encontraron productos con esos términos de búsqueda.'
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

		--reporte de estatus
			select	@status status,
					@error_procedure error_procedure,
					@error_line error_line,
					@mensaje mensaje
							

		-- si todo ok
			if ( @valido = 1 )
				begin
					select	* from	#Compras order by idCompra desc 
				end
				
		end -- reporte de estatus

	end  -- principal

GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_FORMA_PAGO]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		Consulta los diferentes claves de productos 
status			200 = ok
				-1	= error
*/

create proc [dbo].[SP_CONSULTA_FORMA_PAGO]

as

	begin -- principal
	
		begin try

			begin --declaraciones 

				declare @status					int = 200,
						@mensaje				varchar(255) = '',
						@error_line				varchar(255) = '',
						@error_procedure		varchar(255) = '',
						@valido					bit = cast(1 as bit)

			end  --declaraciones 

			begin -- principal
				
				if not exists ( select 1 from FactCatFormaPago )
					begin
						select	@mensaje = 'No existen claves de formas de pago registradas.',
								@valido = cast(0 as bit)
						raiserror (@mensaje, 11, -1)
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

			select	@status status,
					@error_procedure error_procedure,
					@error_line error_line,
					@mensaje as  mensaje


			if ( @valido = cast(1 as bit) )
				begin
						
					select	distinct 
							id,
							formaPago,
							descripcion
					from	FactCatFormaPago 

				end
								
		end -- reporte de estatus

	end  -- principal

GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_LINEAS_PRODUCTO]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		Consulta los diferentes lineas del producto del sistema
status			200 = ok
				-1	= error
*/

create proc [dbo].[SP_CONSULTA_LINEAS_PRODUCTO]

	@idLineaProducto		int

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
				
				if not exists ( select 1 from LineaProducto )
					begin
						select @mensaje = 'No existen Lineas de Productos registradas.'
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
							ROW_NUMBER() OVER(ORDER BY idLineaProducto DESC) as contador,
							l.idLineaProducto,
							l.descripcion,
							l.activo
					from	LineaProducto l
					where	l.idLineaProducto =	case
													when @idLineaProducto > 0 then @idLineaProducto
													else l.idLineaProducto
												end
						and	l.activo = cast(1 as bit)
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

GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_PRECIO_X_VOLUMEN]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		Consulta los diferentes clientes del sistema
status			200 = ok
				-1	= error
*/

create proc [dbo].[SP_CONSULTA_PRECIO_X_VOLUMEN]
	@idProducto		int,
	@cantidad		int 
as

	begin -- principal
	
		begin try

			begin --declaraciones 

				declare @status					int = 200,
						@mensaje				varchar(255) = '',
						@error_line				varchar(255) = '',
						@error_procedure		varchar(255) = '',
						@valido					bit = cast(1 as bit)
						
			end  --declaraciones 


			if not exists ( 
							select	1 
							from	ProductosPorPrecio
							where	idProducto = @idProducto
								and @cantidad between min and max
								and activo = cast(1 as bit)
						  )
			begin
				select	@mensaje = 'No existen rangos activos de precio para el producto seleccionado',
						@status = -1,
						@valido = cast(0 as bit)
			end	

		end try

		begin catch 
		
			-- captura del error
			select	@status =			-error_state(),
					@error_procedure =	error_procedure(),
					@error_line =		error_line(),
					@mensaje =			error_message()
					
		end catch

		begin -- reporte de estatus

		--reporte de estatus
			select	@status status,
					@error_procedure error_procedure,
					@error_line error_line,
					@mensaje mensaje
							

		-- si todo ok
			if ( @valido = cast(1as bit) )
				begin
					select	contador,
							idProducto,
							min,
							max,
							costo,
							activo,
							idTipoPrecio 
					from	ProductosPorPrecio
					where	idProducto = @idProducto
						and @cantidad between min and max
						and activo = cast(1 as bit)
				end

				
		end -- reporte de estatus

	end  -- principal

GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_PRODUCTOS]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		Consulta los diferentes clientes del sistema
status			200 = ok
				-1	= error
*/

create proc [dbo].[SP_CONSULTA_PRODUCTOS]

	@idProducto				int = null,
	@descripcion			varchar(255) = null,
	@idUnidadMedida			int = null,
	@idLineaProducto		int = null,
	@activo					bit = null,
	@articulo				varchar(255) = null,
	@claveProdServ			float = null,
	@fechaIni				datetime = null,
	@fechaFin				datetime = null

as

	begin -- principal
	
		begin try

			begin --declaraciones 

				declare @status					int = 200,
						@mensaje				varchar(255) = '',
						@error_line				varchar(255) = '',
						@error_procedure		varchar(255) = '',
						@valido					bit = cast(1 as bit)

				create table
					#Productos
						(
							contador				int identity (1,1),
							idProducto				int,
							descripcion				varchar(100),
							idUnidadMedida			int,
							idLineaProducto			int,
							cantidadUnidadMedida	float,
							codigoBarras			nvarchar(4000),
							fechaAlta				datetime,
							activo					bit,
							articulo				varchar(100),
							claveProdServ			float,
							precio					money
						)
						
			end  --declaraciones 

			begin -- principal
				
				-- validaciones
					if (@idProducto is null and @descripcion is null and @idUnidadMedida is null and 
						@idLineaProducto is null and @activo is null and @articulo is null and 
						@claveProdServ is null 						
						)
					begin
						select	@mensaje = 'Debe elejir al menos un criterio para la búsqueda del Producto.',
								@valido = cast(0 as bit)						
						raiserror (@mensaje, 11, -1)
					end

				-- si son todos
				if	( 
						( @idProducto = 0 ) and 
						( @descripcion is null ) and 
						( @idUnidadMedida = 0 ) and 
						( @idLineaProducto = 0 ) and 
						( @activo = 0 ) and 
						( @articulo is null ) and					
						( @fechaIni = '19000101' ) and					
						( @fechaFin = '19000101' ) and 
						( @claveProdServ is null)  
					)
					begin

						insert into #Productos (idProducto,descripcion,idUnidadMedida,idLineaProducto,cantidadUnidadMedida,codigoBarras,fechaAlta,activo,articulo,claveProdServ,precio)
						select	top 50 idProducto,descripcion,idUnidadMedida,idLineaProducto,cantidadUnidadMedida,codigoBarras,fechaAlta,activo,articulo,claveProdServ, 0 as precio
						from	Productos
						where	activo = cast(1 as bit)
						order by idProducto desc						

					end
				-- si es por busqueda
				else 
					begin
					
						insert into #Productos (idProducto,descripcion,idUnidadMedida,idLineaProducto,cantidadUnidadMedida,codigoBarras,fechaAlta,activo,articulo,claveProdServ,precio)
						select	idProducto,descripcion,idUnidadMedida,idLineaProducto,cantidadUnidadMedida,codigoBarras,fechaAlta,activo,articulo,claveProdServ, 0 as precio
						from	Productos
						where	idProducto =	case
													when @idProducto is null then idProducto
													when @idProducto = 0 then idProducto
													else @idProducto
												end

							and descripcion like	case
														when @descripcion is null then descripcion
														else '%' + @descripcion + '%'
													end

							and idLineaProducto =	case
														when @idLineaProducto is null then idLineaProducto
														when @idLineaProducto = 0 then idLineaProducto
														else @idLineaProducto
													end

							and articulo like	case
													when @articulo is null then articulo
													else '%' + @articulo + '%' 
												end

							and cast(fechaAlta as date) >=	case
																	when @fechaIni is null then cast(fechaAlta as date)
																	when @fechaIni = 0 then cast(fechaAlta as date)
																	when @fechaIni = '19000101' then cast(fechaAlta as date)
																	else cast(@fechaIni as date)
																end

							and cast(fechaAlta as date) <=	case
																	when @fechaFin is null then cast(fechaAlta as date)
																	when @fechaFin = 0 then cast(fechaAlta as date)
																	when @fechaFin = '19000101' then cast(fechaAlta as date)
																	else cast(@fechaFin as date)
																end

							and claveProdServ		=	case
															when @claveProdServ is null then claveProdServ
															when @claveProdServ = 0 then claveProdServ
															else @claveProdServ
														end

							and activo = cast(1 as bit)

					end

				
				if not exists ( select 1 from #Productos )
					begin
						select	@valido = cast(0 as bit),
								@status = -1,
								@mensaje = 'No se encontraron productos con esos términos de búsqueda.'
					end

				-- se actualizan los precios minimos por cada producto
					update	#Productos
					set		precio = a.costo
					from	(
								select	contador, idProducto, min, max, costo, activo
								from	ProductosPorPrecio 
								where	contador in ( 
														select min(contador) as min_contador 
														from  ProductosPorPrecio 
														where activo = 1 
														group by idProducto 
													)
							)A
					where #Productos.idProducto = a.idProducto



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

		--reporte de estatus
			select	@status status,
					@error_procedure error_procedure,
					@error_line error_line,
					@mensaje mensaje
							

		-- si todo ok
			if ( @valido = 1 )
				begin
				
					select	p.*, l.descripcion as DescripcionLinea, u.descripcion as DescripcionUnidadMedida, g.cantidad
					from	#Productos p
								inner join LineaProducto l 
									on p.idLineaProducto = l.idLineaProducto
								inner join CatUnidadMedida u
									on p.idUnidadMedida = u.idUnidadMedida
								left join InventarioGeneral g
									on g.idProducto = p.idProducto
					order by idProducto desc 

				end
				
		end -- reporte de estatus

	end  -- principal

GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_PRODUCTOS_POR_CODIGO_BARRAS]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_CONSULTA_PRODUCTOS_POR_CODIGO_BARRAS]
@codigo varchar (500)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM Productos WHERE codigoBarras = @codigo)
	begin
		select 200 estatus , 'se encontro un coincidencia' mensaje
		select * from Productos where codigoBarras  = @codigo
	end
	else
	begin
		select -1 estatus , 'no existe un producto registrado con eso codigo de barras' mensaje
	end
END

GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_PROVEEDORES]    Script Date: 11/04/2020 14:20:55 ******/
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

create proc [dbo].[SP_CONSULTA_PROVEEDORES]

	@idProveedor		int

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
				
				if not exists ( select 1 from Proveedores )
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
							ROW_NUMBER() OVER(ORDER BY idProveedor DESC) AS contador,
							p.idProveedor,
							p.nombre,
							p.descripcion,
							p.telefono,
							p.direccion,
							p.activo
					from	Proveedores p
					where	p.idProveedor =	case
												when @idProveedor > 0 then @idProveedor
												else p.idProveedor
											end
						and	p.activo = cast(1 as bit)
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

GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_ROLES]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		Consulta los diferentes usuarios del sistema
status			200 = ok
				-1	= error
*/

create proc [dbo].[SP_CONSULTA_ROLES]

	@idRol	int

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
				
				if exists ( select 1 from Usuarios )
					begin
						
						if ( @idRol = 1 )
							begin
								select @valido = cast(1 as bit)
							end

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
						
					select	@status status,
							@error_procedure error_procedure,
							@error_line error_line,
							@mensaje mensaje,
							*
					from	catRoles
					where	activo = cast(1 as bit)
						and	idRol <> 1

				end
			else
				begin

					select	-1 status,
							@error_procedure error_procedure,
							@error_line error_line,
							'No existen roles en la base.' as  mensaje
							
				end

				
		end -- reporte de estatus

	end  -- principal

GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_SUCURSALES]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		Consulta los diferentes sucursales del sistema
status			200 = ok
				-1	= error
*/

create proc [dbo].[SP_CONSULTA_SUCURSALES]

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
				
				if not exists ( select 1 from CatSucursales )
					begin
						select @mensaje = 'No existen sucursales registradas.'
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
						
					select	@status status,
							@error_procedure error_procedure,
							@error_line error_line,
							@mensaje mensaje,
							*
					from	CatSucursales
					
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

GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_TICKET]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		Consulta los datos del ticket del idVenta
status			200 = ok
				-1	= error
*/

create proc [dbo].[SP_CONSULTA_TICKET]
	@idVenta		int
as

	begin -- principal
	
		begin try

			begin --declaraciones 

				declare @status					int = 200,
						@mensaje				varchar(255) = '',
						@error_line				varchar(255) = '',
						@error_procedure		varchar(255) = '',
						@valido					bit = cast(1 as bit)
						
			end  --declaraciones 


			if not exists ( 
							select 1 from Ventas where idVenta = @idVenta and idStatusVenta = 1
						  )
			begin
				select	@mensaje = 'No existe la venta seleccionada.',
						@status = -1,
						@valido = cast(0 as bit)
			end	

		end try

		begin catch 
		
			-- captura del error
			select	@status =			-error_state(),
					@error_procedure =	error_procedure(),
					@error_line =		error_line(),
					@mensaje =			error_message()
					
		end catch

		begin -- reporte de estatus

		--reporte de estatus
			select	@status status,
					@error_procedure error_procedure,
					@error_line error_line,
					@mensaje mensaje
							

		-- si todo ok
			if ( @valido = cast(1 as bit) )
				begin
					
					select	v.idVenta, d.idProducto, d.cantidad, d.contadorProductosPorPrecio, d.monto as monto,
							p.descripcion as descProducto, 
							v.idCliente, 
							case
								when c.nombres is null then 'PÚBLICO EN GENERAL' 
								else c.nombres + ' ' + c.apellidoPaterno + ' ' + c.apellidoMaterno
							end as nombreCliente,
							u.idUsuario, u.nombre + ' ' + u.apellidoPaterno + ' ' + u.apellidoMaterno as nombreUsuario,
							d.cantidadActualInvGeneral, d.cantidadAnteriorInvGeneral, v.fechaAlta							 
					from	Ventas v 
								inner join VentasDetalle d
									on v.idVenta = d.idVenta
								left join Clientes c
									on c.idCliente = v.idCliente
								inner join Usuarios u
									on u.idUsuario = v.idUsuario
								inner join Productos p
									on p.idProducto = d.idProducto
								inner join ProductosPorPrecio pp
									on pp.contador = contadorProductosPorPrecio
					where	v.idVenta = @idVenta
						and d.cantidad between pp.min and pp.max
							--and pp.activo = cast(1 as bit)

				end

				
		end -- reporte de estatus

	end  -- principal

GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_TIPO_CLIENTES]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[SP_CONSULTA_TIPO_CLIENTES]
AS
BEGIN
		SELECT * FROM CatTipoCliente
END

GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_TIPOS_CLIENTES]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		Consulta los diferentes clientes del sistema
status			200 = ok
				-1	= error
*/

create proc [dbo].[SP_CONSULTA_TIPOS_CLIENTES]
	@idTipoCliente		int 
as

	begin -- principal
	
		begin try

			begin --declaraciones 

				declare @status					int = 200,
						@mensaje				varchar(255) = '',
						@error_line				varchar(255) = '',
						@error_procedure		varchar(255) = '',
						@valido					bit = cast(1 as bit)

				
						
			end  --declaraciones 

			

		end try

		begin catch 
		
			-- captura del error
			select	@status =			-error_state(),
					@error_procedure =	error_procedure(),
					@error_line =		error_line(),
					@mensaje =			error_message()
					
		end catch

		begin -- reporte de estatus

		--reporte de estatus
			select	@status status,
					@error_procedure error_procedure,
					@error_line error_line,
					@mensaje mensaje
							

		-- si todo ok
			select	ROW_NUMBER() OVER(ORDER BY idTipoCliente DESC) AS contador,
					idTipoCliente,
					descripcion,
					descuento,
					activo
			from	CatTipoCliente
			where	idTipoCliente = case
										when @idTipoCliente = 0 then idTipoCliente
										else @idTipoCliente
									end	
				and activo = cast(1 as bit)
				
		end -- reporte de estatus

	end  -- principal

GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_TIPOS_DE_PRECIOS]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/03/27
Objetivo		Consulta los diferentes rangos de precio del idProducto
status			200 = ok
				-1	= error
*/

create proc [dbo].[SP_CONSULTA_TIPOS_DE_PRECIOS]
	@idProducto			int 
as

	begin -- principal
	
		begin try

			begin --declaraciones 

				declare @status					int = 200,
						@mensaje				varchar(255) = '',
						@error_line				varchar(255) = '',
						@error_procedure		varchar(255) = '',
						@existeProducto			bit = cast(1 as bit)

			end  --declaraciones 


			begin  --validaciones

				if not exists ( select 1 from ProductosPorPrecio where idProducto = @idProducto )
					begin
						select	@existeProducto = cast(0 as bit),
								@mensaje = 'No existen rangos de precio para el producto seleccionado',
								@status = -1
					end	

			end  --validaciones

			

		end try

		begin catch 
		
			-- captura del error
			select	@status =			-error_state(),
					@error_procedure =	error_procedure(),
					@error_line =		error_line(),
					@mensaje =			error_message()
					
		end catch

		begin -- reporte de estatus

		--reporte de estatus
			select	@status status,
					@error_procedure error_procedure,
					@error_line error_line,
					@mensaje mensaje
							

		-- si todo ok
			select	contador,
					idProducto,
					min,
					max,
					costo 
			from	ProductosPorPrecio
			where	idProducto = @idProducto
			and		activo = cast(1 as bit)
				
		end -- reporte de estatus

	end  -- principal

GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_UNIDADES_MEDIDA]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		Consulta los diferentes unidades de medidas del sistema
status			200 = ok
				-1	= error
*/

create proc [dbo].[SP_CONSULTA_UNIDADES_MEDIDA]

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
				
				if not exists ( select 1 from CatUnidadMedida )
					begin
						select @mensaje = 'No existen unidades de medida registradas.'
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
					
							idUnidadMedida,
							descripcion
					from	CatUnidadMedida 

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

GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_USUARIOS]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		Consulta los diferentes usuarios del sistema
status			200 = ok
				-1	= error
*/

create proc [dbo].[SP_CONSULTA_USUARIOS]

	@idUsuario		int

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
				
				if not exists ( select 1 from Usuarios )
					begin
						select @mensaje = 'No existen usuarios registrados.'
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
							ROW_NUMBER() OVER(ORDER BY idUsuario DESC) as contador,
							u.idUsuario,
							u.idRol,
							u.usuario,
							u.telefono,
							u.contrasena,
							u.idAlmacen,
							u.idSucursal,
							u.nombre,
							u.apellidoPaterno,
							--u.apellidoMaterno,
							case 
								when u.activo = cast(0 as bit) then u.apellidoMaterno + ' (BAJA)'
								else u.apellidoMaterno
							end as apellidoMaterno,
							u.fecha_alta,
							u.activo,
							r.descripcion as descripcionRol,
							s.descripcion as descripcionSucursal,
							a.descripcion as descripcionAlmacen
					from	Usuarios u
								left join catRoles r
									on r.idRol = u.idRol
								left join CatSucursales s
									on s.idSucursal = u.idSucursal
								left join Almacenes a
									on a.idAlmacen = u.idAlmacen
					where	u.idUsuario =	case
												when @idUsuario > 0 then @idUsuario
												else u.idUsuario
											end
						--and	u.activo = cast(1 as bit)
						and r.idRol <> 1 -- administrador

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

GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_VENTAS]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		Consulta las ventas hechas a los clientes
status			200 = ok
				-1	= error
				tipoConsulta: 1-para reportes / 2- para modulo de ventas
*/

create proc [dbo].[SP_CONSULTA_VENTAS]

	@idProducto				int = null,
	@descProducto			varchar(300) = null,
	@idLineaProducto		int = null,
	@idCliente				int = null,
	@idUsuario				int = null,
	@fechaIni				datetime = null,
	@fechaFin				datetime = null,
	@tipoConsulta			int = null

as

	begin -- principal
	
		begin try

			begin --declaraciones 

				declare @status					int = 200,
						@mensaje				varchar(255) = '',
						@error_line				varchar(255) = '',
						@error_procedure		varchar(255) = '',
						@valido					bit = cast(1 as bit)

				create table
					#Ventas	
						(
							contador					int identity(1,1),
							idVenta						int ,
							idCliente					int,
							nombreCliente				varchar(300),
							cantidad					bigint,
							fechaAlta					datetime,
							idUsuario					int,
							nombreUsuario				varchar(300),
							idProducto					int,
							descripcionProducto			varchar(300),							
							idLineaProducto				int,
							descripcionLineaProducto	varchar(300)
						)			

			end  --declaraciones 

			begin -- principal
				
				-- validaciones
					if (	
							(@idProducto is null) and 
							(@descProducto is null) and 
							(@idCliente is null) and 
							(@idUsuario is null) and 
							(@fechaIni is null) and 
							(@fechaFin is null) 
						)
					begin
						select	@mensaje = 'Debe elejir al menos un criterio para la búsqueda de la Venta.',
								@valido = cast(0 as bit)						
						raiserror (@mensaje, 11, -1)
					end

				-- si son todos
					if (	
							(@idProducto is null) and 
							(@descProducto is null) and 
							(@idLineaProducto is null) and 
							(@idCliente is null) and 
							(@idUsuario is null) and 
							(@fechaIni = '19000101') and
							(@fechaFin = '19000101')
						)
					begin

						insert into #Ventas (idVenta,idCliente,nombreCliente,cantidad,fechaAlta,idUsuario,nombreUsuario,idProducto,descripcionProducto,idLineaProducto,descripcionLineaProducto)
						select	top 50 v.idVenta,v.idCliente, cl.nombres + ' ' + cl.apellidoPaterno + ' ' + cl.apellidoMaterno as nombreCliente
								,v.cantidad, v.fechaAlta, v.idUsuario, u.nombre + ' ' + u.apellidoPaterno + ' ' + u.apellidoMaterno as nombreUsuario,
								p.idProducto,p.descripcion, lp.idLineaProducto, lp.descripcion
						from	Ventas v
									inner join Usuarios u
										on u.idUsuario = v.idUsuario
									left join Clientes cl
										on v.idCliente = cl.idCliente
									inner join VentasDetalle vd
										on vd.idVenta = v.idVenta
									inner join Productos p
										on vd.idProducto = p.idProducto	
									inner join LineaProducto lp
										on lp.idLineaProducto = p.idLineaProducto
						where	v.idStatusVenta = 1

					end
				-- si es por busqueda
				else 
					begin

						insert into #Ventas (idVenta,idCliente,nombreCliente,cantidad,fechaAlta,idUsuario,nombreUsuario,idProducto,descripcionProducto,idLineaProducto,descripcionLineaProducto)
						select	 v.idVenta,v.idCliente, cl.nombres + ' ' + cl.apellidoPaterno + ' ' + cl.apellidoMaterno as nombreCliente
								,v.cantidad, v.fechaAlta, v.idUsuario, u.nombre + ' ' + u.apellidoPaterno + ' ' + u.apellidoMaterno as nombreUsuario,
								p.idProducto,p.descripcion, lp.idLineaProducto, lp.descripcion
						from	Ventas v
									inner join Usuarios u
										on u.idUsuario = v.idUsuario
									left join Clientes cl
										on v.idCliente = cl.idCliente
									inner join VentasDetalle vd
										on vd.idVenta = v.idVenta
									inner join Productos p
										on vd.idProducto = p.idProducto
									inner join LineaProducto lp
										on lp.idLineaProducto = p.idLineaProducto											
																		
						where	p.idProducto =	case
													when @idProducto is null then p.idProducto
													when @idProducto = 0 then p.idProducto
													else @idProducto
												end

							and p.descripcion like	case
														when @descProducto is null then p.descripcion
														else '%' + @descProducto + '%'
													end

							and	v.idCliente =	case
													when @idCliente is null then v.idCliente
													when @idCliente = 0 then v.idCliente
													else @idCliente
												end

							and v.idUsuario =	case
													when @idUsuario is null then v.idUsuario
													when @idUsuario = 0 then v.idUsuario
													else @idUsuario
												end

							and lp.idLineaProducto =	case
															when @idLineaProducto is null then lp.idLineaProducto
															when @idLineaProducto = 0 then lp.idLineaProducto
															else @idLineaProducto
														end

							and cast(v.fechaAlta as date) >=	case
																	when @fechaIni is null then cast(v.fechaAlta as date)
																	when @fechaIni = 0 then cast(v.fechaAlta as date)
																	when @fechaIni = '19000101' then cast(v.fechaAlta as date)
																	else cast(@fechaIni as date)
																end

							and cast(v.fechaAlta as date) <=	case
																	when @fechaFin is null then cast(v.fechaAlta as date)
																	when @fechaFin = 0 then cast(v.fechaAlta as date)
																	when @fechaFin = '19000101' then cast(v.fechaAlta as date)
																	else cast(@fechaFin as date)
																end
							and	v.idStatusVenta = 1
						order by v.idVenta desc

					end

				
				if not exists ( select 1 from #Ventas )
					begin
						select	@valido = cast(0 as bit),
								@status = -1,
								@mensaje = 'No se encontraron ventas con esos términos de búsqueda.'
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

		--reporte de estatus
			select	@status status,
					@error_procedure error_procedure,
					@error_line error_line,
					@mensaje mensaje
							

		-- si todo ok
			if ( @valido = 1 )
				begin

					if ( @tipoConsulta = 2 )
						begin
							select	ROW_NUMBER() OVER(ORDER BY idVenta DESC) AS contador,
									idVenta,idCliente,
									case
										when nombreCliente is null then 'PÚBLICO EN GENERAL' 
										else nombreCliente
									end as nombreCliente,
									cantidad,fechaAlta,idUsuario,nombreUsuario 
							from	#Ventas 
							group by idVenta,idCliente,nombreCliente,cantidad,fechaAlta,idUsuario,nombreUsuario
							order by idVenta desc 
						end
					else
						begin
							select	
									contador,					
									idVenta,						
									idCliente,					
									case
										when nombreCliente is null then 'PÚBLICO EN GENERAL' 
										else nombreCliente
									end as nombreCliente,
									cantidad,					
									fechaAlta,					
									idUsuario,					
									nombreUsuario,				
									idProducto,					
									descripcionProducto	,								
									idLineaProducto,				
									descripcionLineaProducto								
							from	#Ventas 
							order by idVenta desc 
						end
				end
				
		end -- reporte de estatus

	end  -- principal

GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINA_VENTA]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		elimina la venta seleccionada
status			200 = ok
				-1	= error
*/

create proc [dbo].[SP_ELIMINA_VENTA]

	@idVenta		int

as

	begin -- principal
	
		begin try

			begin --declaraciones 

				declare @status					int = 200,
						@mensaje				varchar(255) = 'Venta eliminada correctamente.',
						@error_line				varchar(255) = '',
						@error_procedure		varchar(255) = '',
						@valido					bit = cast(1 as bit)

			end  --declaraciones 

			begin -- principal
				
				if not exists ( select 1 from Ventas where idVenta = @idVenta )
					begin
						select @mensaje = 'No Existe la venta seleccionada.'
						raiserror (@mensaje, 11, -1)
						select @valido = cast(0 as bit)
					end

				-- se regresa el inventario general

				update	Ventas 
				set		idStatusVenta = 2
				where	idVenta = @idVenta
				
				update	InventarioGeneral
				set		cantidad = a.cantidadSumada,
						fechaUltimaActualizacion = getdate()
				from	(

							select	v.idVenta, v.idProducto, i.cantidad + v.cantidad as cantidadSumada 
							from	VentasDetalle v
										inner join InventarioGeneral i
											on v.idProducto = i.idProducto
							where	v.idVenta = @idVenta
						) A
				where	InventarioGeneral.idProducto = A.idProducto

				-- se actualiza el status

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


			select	@status status,
					@error_procedure error_procedure,
					@error_line error_line,
					@mensaje mensaje

			--if ( @idVenta = cast(1 as bit) )
			--	begin
					
			--	end

				
		end -- reporte de estatus

	end  -- principal

GO
/****** Object:  StoredProcedure [dbo].[SP_FACTURACION_OBTENER_CONFIGURACION_COMPROBANTE]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FACTURACION_OBTENER_CONFIGURACION_COMPROBANTE]

AS
BEGIN
	select 200 Estatus
	SELECT * FROM FactConfiguracionComprobante
END

GO
/****** Object:  StoredProcedure [dbo].[SP_FACTURACION_OBTENER_DETALLE_VENTA]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FACTURACION_OBTENER_DETALLE_VENTA]
@idVenta bigint
AS
BEGIN
declare 
@estatus int,
@mensaje varchar (200)
	
	if exists (	SELECT 1 FROM Ventas  V join Clientes C on V.idCliente = C.idCliente where (C.nombres is null or c.nombres ='') or (c.rfc is null or c.rfc=''))
	begin
		select -1 Estatus, 'Por favor actualiza los datos del clientes es necesario Nombre y Rfc' as mensaje
		return
	end
	
	SELECT 200 Estatus, 'OK' Mensaje
	
	SELECT
	isnull(C.nombres,'')+' '+isnull(c.apellidoPaterno,'')+' '+isnull(c.apellidoMaterno,'') Nombre,
	C.rfc as Rfc,
	UCFDI.usoCFDI as UsoCFDI,
	 FP.formaPago as FormaPago
	FROM Ventas  V 
	join Clientes C on V.idCliente = C.idCliente
	join FactCatUsoCFDI UCFDI on UCFDI.id = 3
	join FactCatFormaPago FP on FP.id = V.idFactFormaPago
	where V.idVenta = @idVenta


	SELECT
	 P.claveProdServ ClaveProdserv,
	 UM.claveUnidadSAT ClaveUnidad ,
	 VD.cantidad Cantidad,
	 UM.unidadSat Unidad,
	 P.articulo NoIdentificacion,
	 P.descripcion Descripcion,
	 VD.monto ValorUnitario,
	
	 cast ((VD.monto * VD.cantidad) as decimal (16,2)) Importe,
	 --LOS CAMPOS DE ARRIBA SON NECESARIOS PARA EL  NODO DEL CONCEPTO
	 cast ((VD.monto * VD.cantidad) as decimal (16,2)) Base,
	 '002'  Impuesto,
	 'Tasa' TipoFactor,
	 0.16 TasaOCuota,
	 cast (((VD.monto * VD.cantidad)*0.16) as decimal (16,2)) ImporteT 
	 --LOS CAMPOS DE ARRIBA SON NECESARIOS PARA EL NODO TRASLADO QUE EXISTE
	 --DENTRO DEL NODO DE CONCEPTOS ACTUALMENT NO SETEAN EN CODIGO C#
	from dbo.[VentasDetalle] as VD  join Productos P 
	on P.idProducto =  VD.idProducto join CatUnidadMedida UM 
	on UM.idUnidadMedida = P.idUnidadMedida 
	where VD.idVenta = @idVenta




END

GO
/****** Object:  StoredProcedure [dbo].[SP_INSERTA_ACTUALIZA_CLIENTES]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		inserta y actualiza las diferentes lineas de producto del sistema
status			200 = ok
				-1	= error
*/

CREATE proc [dbo].[SP_INSERTA_ACTUALIZA_CLIENTES]

	@idCliente				int,
	@nombres				varchar(50),
	@apellidoPaterno		varchar(50),
	@apellidoMaterno		varchar(50),
	@telefono				varchar(50),
	@correo					varchar(50) =null,
	@rfc					varchar(50) =null,
	@calle					varchar(50) =null,
	@numeroExterior			varchar(50) =null,
	@colonia				varchar(50) =null,
	@municipio				varchar(50) =null,
	@cp						varchar(50) =null,
	@estado					varchar(50) =null,
	--@fechaAlta				varchar(50),
	--@activo					varchar(50),
	@idTipoCliente			int = 1

as

	begin -- principal
	
		begin try

			begin --declaraciones 

				declare @status					int = 200,
						@mensaje				varchar(255) = 'Cliente sin modificaciones',
						@error_line				varchar(255) = '',
						@error_procedure		varchar(255) = '',
						@existeCliente			bit = cast(0 as bit)

			end  --declaraciones 

			begin -- principal
				
				if (@idCliente > 0 )
				begin
					declare
					@numeroAux  int ,
					@telefonoAux varchar(50),
					@correoAux varchar(50),
					@nombresAux varchar(50),
					@apellidoPaternoAux varchar(50),
					@apellidoMaternoAux varchar(50)
					
					--Select * from Clientes where idCliente = @idCliente
				end

				if (@idCliente  = 0)
				begin
					if exists ( select 1 from clientes where nombres like @nombres and apellidoPaterno like @apellidoPaterno and apellidoMaterno like @apellidoMaterno )
					begin
							select   @status=-1, @existeCliente = cast(1 as bit) , @mensaje= 'Ya existe un cliente con este nombre, por favor actualize la información del cliente '
					end

					if exists ( select 1 from clientes where correo = @correo )
					begin
						select @status=-1, @existeCliente = cast(1 as bit) , @mensaje= 'Ya existe un cliente con este correo, por favor actualize la información del cliente'
					end

					if exists ( select 1 from clientes where telefono =@telefono )
					begin
						select @status=-1, @existeCliente = cast(1 as bit) , @mensaje= 'Ya existe un cliente con este telefono, por favor actualize la información del cliente'
					end
				end
				-- si es modificacion
				if	( (@idCliente > 0) )
					begin
						
						if not exists ( select 1 from Clientes where idCliente = @idCliente ) 
						begin
							select @mensaje = 'El Cliente no existe.'
							raiserror (@mensaje, 11, -1)
						end

						
							
						update	Clientes 
						set		nombres = @nombres,
								apellidoPaterno = @apellidoPaterno,
								apellidoMaterno = @apellidoMaterno,
								telefono = @telefono,
								correo = @correo,
								rfc = @rfc,
								calle = @calle,
								numeroExterior = @numeroExterior,
								colonia = @colonia,
								municipio = @municipio,
								cp = @cp,
								estado = @estado,
								--fechaAlta = @fechaAlta,
								activo = 1,
								idTipoCliente = @idTipoCliente
						where	idCliente = @idCliente
						
						select	@mensaje = 'Cliente modificado correctamente.'
					end
				-- si es nuevo
				else
					begin
						if ( @existeCliente = cast(0 as bit) )
							begin

								--select @idCliente = coalesce( max(idLineaProducto) + 1, 1) from clientes
								insert into Clientes (nombres,apellidoPaterno,apellidoMaterno,telefono,correo,rfc,calle,numeroExterior,colonia,municipio,cp,estado,fechaAlta,activo,idTipoCliente) 
								values (@nombres,@apellidoPaterno,@apellidoMaterno,@telefono,@correo,@rfc,@calle,@numeroExterior,@colonia,@municipio,@cp,@estado,getdate(),1,@idTipoCliente) 
								select @mensaje = 'Cliente agregado correctamente.'
							end
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

GO
/****** Object:  StoredProcedure [dbo].[SP_INSERTA_ACTUALIZA_LINEAS_PRODUCTO]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		inserta y actualiza las diferentes lineas de producto del sistema
status			200 = ok
				-1	= error
*/

create proc [dbo].[SP_INSERTA_ACTUALIZA_LINEAS_PRODUCTO]

	@idLineaProducto	int,
	@descripcion		varchar(255),
	@activo				bit

as

	begin -- principal
	
		begin try

			begin --declaraciones 

				declare @status					int = 200,
						@mensaje				varchar(255) = 'Linea de Producto sin modificaciones',
						@error_line				varchar(255) = '',
						@error_procedure		varchar(255) = '',
						@existeLinea			bit = cast(0 as bit)

			end  --declaraciones 

			begin -- principal
				
				if exists ( select 1 from LineaProducto where descripcion like @descripcion )
					begin
						select @existeLinea = cast(1 as bit)
					end
					
				-- si es modificacion
				if	( (@idLineaProducto > 0) )
					begin
						
						if not exists ( select 1 from LineaProducto where idLineaProducto = @idLineaProducto ) 
						begin
							select @mensaje = 'La Linea de Producto no existe.'
							raiserror (@mensaje, 11, -1)
						end

						if ( (@existeLinea = cast(1 as bit)) and ( (@activo is null) or (@activo = 0) ) )
							begin
								select	@activo = activo
								from	LineaProducto
								where	idLineaProducto = @idLineaProducto
							end
							
						update	LineaProducto 
						set		descripcion = @descripcion,
								activo = @activo 
						where	idLineaProducto = @idLineaProducto

						select @mensaje = 'Linea de Producto modificada correctamente.'
					end
				-- si es nuevo
				else
					begin
						if ( @existeLinea = cast(0 as bit) )
							begin
								select @activo = cast(1 as bit)
								insert into LineaProducto (descripcion,activo) 
								values (@descripcion,@activo) 
								select @mensaje = 'Linea de Prouducto agregada correctamente.'
							end
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

			select	@status status,
					@error_procedure error_procedure,
					@error_line error_line,
					@mensaje mensaje
				
		end -- reporte de estatus

	end  -- principal

GO
/****** Object:  StoredProcedure [dbo].[SP_INSERTA_ACTUALIZA_PRODUCTOS]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		inserta y actualiza los diferentes productos del sistema
status			200 = ok
				-1	= error
*/

create proc [dbo].[SP_INSERTA_ACTUALIZA_PRODUCTOS]

	@idProducto				int,
	@descripcion			varchar(255),
	@idUnidadMedida			int,
	@idLineaProducto		int,
	@cantidadUnidadMedida	float,
	@codigoBarras			nvarchar(4000),
	--@fechaAlta				datetime = null,
	@activo					bit,
	@articulo				varchar(255),
	@claveProdServ			float,
	@claveUnidad			nvarchar(4000)

as

	begin -- principal
	
		begin try

			begin --declaraciones 

				declare @status					int = 200,
						@mensaje				varchar(255) = 'Producto sin modificaciones',
						@error_line				varchar(255) = '',
						@error_procedure		varchar(255) = '',
						@existeProducto			bit = cast(0 as bit)

			end  --declaraciones 

			begin -- principal
				
				if exists ( select 1 from Productos where idProducto = @idProducto )
					begin
						select @existeProducto = cast(1 as bit)
					end
					
				-- si es modificacion
				if	( (@idProducto > 0) )
					begin
						
						if not exists ( select 1 from Productos where idProducto = @idProducto ) 
						begin
							select @mensaje = 'El Producto no existe.'
							raiserror (@mensaje, 11, -1)
						end

						if ( @existeProducto = cast(1 as bit)) 
							begin
							
								update	Productos 
								set		descripcion = @descripcion,
										idUnidadMedida = @idUnidadMedida ,
										idLineaProducto = @idLineaProducto,
										cantidadUnidadMedida = @cantidadUnidadMedida,
										codigoBarras = @codigoBarras,
										--fechaAlta = @fechaAlta,
										activo = @activo,
										articulo = @articulo,
										claveProdServ = @claveProdServ,
										claveUnidad = @claveUnidad
								where	idProducto = @idProducto
						
								select	@mensaje = 'Cliente modificado correctamente.'
							
							end

					end
				-- si es nuevo
				else
					begin
						if ( @existeProducto = cast(0 as bit) )
							begin
								select @activo = cast(1 as bit)
								select @idProducto = coalesce( max(idProducto) + 1, 1) from Productos
								insert into productos (idProducto,descripcion,idUnidadMedida,idLineaProducto,cantidadUnidadMedida,codigoBarras,fechaAlta,activo,articulo,claveProdServ,claveUnidad)
								values (@idProducto,@descripcion,@idUnidadMedida,@idLineaProducto,@cantidadUnidadMedida,@codigoBarras,getdate(),@activo,@articulo,@claveProdServ,@claveUnidad)

								select @mensaje = 'Producto agregado correctamente.'
							end
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

			select	@status status,
					@error_procedure error_procedure,
					@error_line error_line,
					@mensaje mensaje
				
		end -- reporte de estatus

	end  -- principal

GO
/****** Object:  StoredProcedure [dbo].[SP_INSERTA_ACTUALIZA_PROVEEDORES]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		inserta y actualiza los diferentes proveedores del sistema
status			200 = ok
				-1	= error
*/

CREATE proc [dbo].[SP_INSERTA_ACTUALIZA_PROVEEDORES]

	@idProveedor	int,
	@nombre			varchar(255),
	@descripcion	varchar(255) = null, -- SE AGREGAN LOS NULL POR QUE DESDE LA APP SE PUEDE REGISTRAR UN PROVEEDOR
	@telefono		varchar(10)  = null, -- SE AGREGAN LOS NULL POR QUE DESDE LA APP SE PUEDE REGISTRAR UN PROVEEDOR
	@direccion		varchar(255) = null, -- SE AGREGAN LOS NULL POR QUE DESDE LA APP SE PUEDE REGISTRAR UN PROVEEDOR
	@activo			bit = 1

as

	begin -- principal
	
		begin try

			begin --declaraciones 

				declare @status					int = 200,
						@mensaje				varchar(255) = 'Proveedor sin modificaciones',
						@error_line				varchar(255) = '',
						@error_procedure		varchar(255) = '',
						@existeProveedor			bit = cast(0 as bit)

			end  --declaraciones 

			begin -- principal
				
				if exists ( select 1 from Proveedores where nombre like @nombre )
					begin
						select @existeProveedor = cast(1 as bit)
					end
					
				-- si es modificacion
				if	( (@idProveedor > 0) )
					begin
						
						if not exists ( select 1 from Proveedores where idProveedor = @idProveedor ) 
						begin
							select @mensaje = 'El Proveedor no existe.'
							raiserror (@mensaje, 11, -1)
						end

						if ( (@existeProveedor = cast(1 as bit)) and ( (@activo is null) or (@activo = 0) ) )
							begin
								select	@activo = activo
								from	Proveedores
								where	idProveedor = @idProveedor
							end
							
						update	Proveedores 
						set		nombre = @nombre,
								descripcion = @descripcion,
								telefono = @telefono,
								direccion = @direccion,
								activo = @activo 
						where	idProveedor = @idProveedor

						select @mensaje = 'Proveedor modificado correctamente.'
					end
				-- si es nuevo
				else
					begin
						if ( @existeProveedor = cast(0 as bit) )
							begin
								select @activo = cast(1 as bit)

								select @idProveedor = coalesce(max(idProveedor) + 1, 1) from Proveedores 
								insert into Proveedores (idProveedor,nombre,descripcion,telefono,direccion,activo) 
								values (@idProveedor,@nombre,@descripcion,@telefono,@direccion,@activo)
								select @mensaje = 'Proveedor agregado correctamente.'
							end
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

			select	@status status,
					@error_procedure error_procedure,
					@error_line error_line,
					@mensaje mensaje
				
		end -- reporte de estatus

	end  -- principal

GO
/****** Object:  StoredProcedure [dbo].[SP_INSERTA_ACTUALIZA_RANGOS_PRECIOS]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		inserta y actualiza los diferentes rangos de precios del sistema
status			200 = ok
				-1	= error
*/

create proc [dbo].[SP_INSERTA_ACTUALIZA_RANGOS_PRECIOS]

  @xml AS XML

as

	begin -- principal
	
		begin try

			begin --declaraciones 

				declare @status					int = 200,
						@mensaje				varchar(255) = 'Rango de precios actualizado correctamente',
						@error_line				varchar(255) = '',
						@error_procedure		varchar(255) = '',
						@idProducto				int = 0

						create table
							#contadores
								(
									id			int identity(1,1),
									contador	int
								)

						create table
							#mins
								(
									id			int identity(1,1),
									min_		int
								)

						create table
							#maxs
								(
									id			int identity(1,1),
									max_		int
								)

						create table
							#precios
								(
									id			int identity(1,1),
									costo		money
								)

			end  --declaraciones 

			begin -- principal

				insert into #contadores (contador)
				SELECT Precio.contador.value('.','NVARCHAR(200)') AS contadores FROM @xml.nodes('//contador') as Precio(contador) 

				insert into #mins (min_)
				SELECT Precio.min.value('.','NVARCHAR(200)') AS mins FROM @xml.nodes('//min') as Precio(min)

				insert into #maxs (max_)
				SELECT Precio.max.value('.','NVARCHAR(200)') AS mins FROM @xml.nodes('//max') as Precio(max)

				insert into #precios (costo)
				SELECT Precio.costo.value('.','NVARCHAR(200)') AS costos FROM @xml.nodes('//costo') as Precio(costo)

				select  @idProducto = ( SELECT top 1  Precio.idProducto.value('.','NVARCHAR(200)') AS idProducto FROM @xml.nodes('//idProducto') as Precio(idProducto))


				if exists ( select 1 from ProductosPorPrecio where idProducto = @idProducto )
					begin
						update	ProductosPorPrecio 
						set		activo = cast(0 as bit)
						where	idProducto = @idProducto
					end

				insert into ProductosPorPrecio (idProducto,min,max,costo, activo)
				select	@idProducto as idProducto, m.min_, x.max_, p.costo, cast(1 as bit)
				from	#contadores c
							inner join #mins m
								on m.id = c.id
							inner join #maxs x
								on x.id = c.id			
							inner join #precios p
								on p.id = c.id

				drop table #contadores
				drop table #mins
				drop table #maxs
				drop table #precios


				
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

			select	@status status,
					@error_procedure error_procedure,
					@error_line error_line,
					@mensaje mensaje

		end -- reporte de estatus

	end  -- principal

GO
/****** Object:  StoredProcedure [dbo].[SP_INSERTA_ACTUALIZA_ROLES]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		inserta y actualiza los diferentes roles disponibles
status			200 = ok
				-1	= error
*/

create proc [dbo].[SP_INSERTA_ACTUALIZA_ROLES]

	@descripcion	varchar(50),
	@activo			bit = null,
	@idRol			int = null

as

	begin -- principal
	
		begin try

			begin --declaraciones 

				declare @status					int = 200,
						@mensaje				varchar(255) = 'Rol sin modificaciones',
						@error_line				varchar(255) = '',
						@error_procedure		varchar(255) = '',
						@existeDescripcion		bit = cast(0 as bit)

			end  --declaraciones 

			begin -- principal
				
				if exists ( select 1 from CatRoles where descripcion like @descripcion /*and activo = cast(1 as bit)*/ )
					begin
						select @existeDescripcion = cast(1 as bit)
					end
					
				-- si es modificacion
				if	( @idRol is not null )
					begin
						
						if not exists ( select 1 from CatRoles where idRol = @idRol ) 
						begin
							select @mensaje = 'El rol no existe.'
							raiserror (@mensaje, 11, -1)
						end

						if ( (@existeDescripcion = cast(1 as bit)) and ( @activo is null ) )
							begin
								select @activo=activo from CatRoles where descripcion like @descripcion
							end
							
						update	CatRoles 
						set		descripcion = @descripcion, 
								activo = @activo 
						where	idRol = @idRol

						select @mensaje = 'Rol modificado correctamente.'
					end
				-- si es nuevo
				else
					begin
						if ( @existeDescripcion = cast(0 as bit) )
							begin
								select @activo = cast(1 as bit)
								insert into CatRoles (descripcion,activo) values (@descripcion, @activo)
								select @mensaje = 'Rol agregado correctamente.'
							end
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

			select	@status status,
					@error_procedure error_procedure,
					@error_line error_line,
					@mensaje mensaje
				
		end -- reporte de estatus

	end  -- principal

GO
/****** Object:  StoredProcedure [dbo].[SP_INSERTA_ACTUALIZA_TIPOS_CLIENTES]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		inserta y actualiza los diferentes tipos de clientes del sistema
status			200 = ok
				-1	= error
*/

create proc [dbo].[SP_INSERTA_ACTUALIZA_TIPOS_CLIENTES]

  @idTipoCliente		int,
  @descripcion			varchar(50),
  @descuento			money,
  @activo				bit

as

	begin -- principal
	
		begin try

			begin --declaraciones 

				declare @status					int = 200,
						@mensaje				varchar(255) = 'Tipo de Cliente sin modificaciones',
						@error_line				varchar(255) = '',
						@error_procedure		varchar(255) = '',
						@existeTipoCliente		bit = cast(0 as bit)

			end  --declaraciones 

			begin -- principal
				
				if exists ( select 1 from CatTipoCliente where idTipoCliente = @idTipoCliente )
					begin
						select @existeTipoCliente = cast(1 as bit)
					end
					
				-- si es modificacion
				if	( (@idTipoCliente > 0) )
					begin
						
						if not exists ( select 1 from CatTipoCliente where idTipoCliente = @idTipoCliente ) 
						begin
							select @mensaje = 'El Tipo de Cliente no existe.'
							raiserror (@mensaje, 11, -1)
						end

						if ( @existeTipoCliente = cast(1 as bit)) 
							begin
							
								update	CatTipoCliente 
								set		descripcion = @descripcion,
										descuento = @descuento,
										activo = @activo
								where	idTipoCliente = @idTipoCliente
						
								select	@mensaje = 'Tipo de Cliente Modificado Correctamente.'
							
							end

					end
				-- si es nuevo
				else
					begin
						if ( @existeTipoCliente = cast(0 as bit) )
							begin
								select @activo = cast(1 as bit)
								
								insert into CatTipoCliente (descripcion,descuento,activo)
								values (@descripcion,@descuento,@activo)

								select @mensaje = 'Tipo de Cliente Agregado Correctamente.'
							end
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

			select	@status status,
					@error_procedure error_procedure,
					@error_line error_line,
					@mensaje mensaje
				
		end -- reporte de estatus

	end  -- principal

GO
/****** Object:  StoredProcedure [dbo].[SP_INSERTA_ACTUALIZA_USUARIOS]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		inserta y actualiza los diferentes usuarios del sistema
status			200 = ok
				-1	= error
*/

create proc [dbo].[SP_INSERTA_ACTUALIZA_USUARIOS]

	@idUsuario				int = null,
	@idRol					int,
	@usuario				varchar(50),
	@telefono				varchar(10),
	@contrasena				varchar(50),
	@idAlmacen				int,
	@idSucursal				int,
	@nombre					varchar(50),
	@apellidoPaterno		varchar(50),
	@apellidoMaterno		varchar(50),
	@fecha_alta				datetime,
	@activo					bit = null

as

	begin -- principal
	
		begin try

			begin --declaraciones 

				declare @status					int = 200,
						@mensaje				varchar(255) = 'Usuario sin modificaciones',
						@error_line				varchar(255) = '',
						@error_procedure		varchar(255) = '',
						@existeUsuario			bit = cast(0 as bit)

			end  --declaraciones 

			begin -- principal
				
				if exists ( select 1 from usuarios where nombre like @nombre and apellidoPaterno like @apellidoPaterno and apellidoMaterno like @apellidoMaterno )
					begin
						select @existeUsuario = cast(1 as bit)
					end
					
				-- si es modificacion
				if	( (@idUsuario is not null) and (@idUsuario > 0) )
					begin
						
						if not exists ( select 1 from usuarios where idUsuario = @idUsuario ) 
						begin
							select @mensaje = 'El usuario no existe.'
							raiserror (@mensaje, 11, -1)
						end

						if ( (@existeUsuario = cast(1 as bit)) and ( (@activo is null) or (@activo = 0) ) )
							begin
								select	@activo=activo,
										@contrasena = contrasena 
								from	usuarios 
								where	nombre like @nombre 
									and apellidoPaterno like @apellidoPaterno 
									and apellidoMaterno like @apellidoMaterno
							end
							
						update	usuarios 
						set		idRol = @idRol,
								usuario = @usuario,
								telefono = @telefono,
								contrasena = @contrasena,
								idAlmacen = @idAlmacen,
								idSucursal = @idSucursal,
								nombre = @nombre,
								apellidoPaterno = @apellidoPaterno,
								apellidoMaterno = @apellidoMaterno,
								fecha_alta = @fecha_alta,
								activo = @activo 
						where	idUsuario = @idUsuario

						select @mensaje = 'Usuario modificado correctamente.'
					end
				-- si es nuevo
				else
					begin
						if ( @existeUsuario = cast(0 as bit) )
							begin
								select @activo = cast(1 as bit)
								select @idUsuario = max(idUsuario) + 1 from usuarios 
								insert into usuarios (idUsuario,idRol,usuario,telefono,contrasena,idAlmacen,idSucursal,nombre,apellidoPaterno,apellidoMaterno,fecha_alta,activo) 
								values (@idUsuario,@idRol,@usuario,@telefono,@contrasena,@idAlmacen,@idSucursal,@nombre,@apellidoPaterno,@apellidoMaterno,@fecha_alta,@activo)
								select @mensaje = 'Usuario agregado correctamente.'
							end
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

			select	@status status,
					@error_procedure error_procedure,
					@error_line error_line,
					@mensaje mensaje
				
		end -- reporte de estatus

	end  -- principal

GO
/****** Object:  StoredProcedure [dbo].[SP_OBTIENE_CODIGO_ARTICULO]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		obtiene el codigo de artucilo sugerido en el alta de un producto
status			200 = ok
				-1	= error
*/

create proc [dbo].[SP_OBTIENE_CODIGO_ARTICULO]

	@descripcion		varchar(255),
	@idLineaProducto	int

as

	begin -- principal
	
		begin try

			begin --declaraciones 

				declare @status					int = 200,
						@mensaje				varchar(255) = '',
						@error_line				varchar(255) = '',
						@error_procedure		varchar(255) = '',
						@prefijo				varchar(10) = '',
						@desc					varchar(10) = '',
						@totPalabras			int = 0,
						@valido					bit = cast(0 as bit)

			end  --declaraciones 

			begin -- principal
				
				--if not exists ( select 1 from CatUnidadMedida )
				--	begin
				--		select @mensaje = 'No existen unidades de medida registradas.'
				--		raiserror (@mensaje, 11, -1)
				--	end
				--else
				--	begin
				--		select @valido = cast(1 as bit)
				--	end

				select @prefijo = substring( (ltrim(rtrim(replace(descripcion, 'Linea', '')))), 1,2) + '-' from LineaProducto where idLineaProducto = @idLineaProducto 
				
				---- total de palabras
					create table #palabras (id int identity(1,1), letra varchar(50))

					DECLARE @xml xml, @str varchar(100), @delimiter varchar(10)
					SET @str = @descripcion
					SET @delimiter = ' '
					SET @xml = cast(('<X>'+replace(@str, @delimiter, '</X><X>')+'</X>') as xml)

					insert into #palabras (letra)
					SELECT C.value('.', 'varchar(10)') as value FROM @xml.nodes('X') as X(C)

					--select * from #palabras
					--drop table #palabras
					
					select @totPalabras = count(1) from #palabras

				if ( @totPalabras = 1 )
					begin
						select @desc = @prefijo +
							(select substring(letra, 1,3) from #palabras where id = 1)
					end
				
				if ( @totPalabras = 2 )
					begin
						select @desc = @prefijo +
							(select substring(letra, 1,1) from #palabras where id = 1)+
							(select substring(letra, 1,2) from #palabras where id = 2)
					end

				if ( @totPalabras >= 3 )
					begin
						select @desc = @prefijo +
							(select substring(letra, 1,1) from #palabras where id = 1)+
							(select substring(letra, 1,1) from #palabras where id = 2)+
							(select substring(letra, 1,1) from #palabras where id = 3)
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

			select	@status status,
					@error_procedure error_procedure,
					@error_line error_line,
					@mensaje as  mensaje

			select	UPPER(@desc) as articulo

			
							
		end -- reporte de estatus

	end  -- principal

GO
/****** Object:  StoredProcedure [dbo].[SP_REALIZA_VENTA]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

Autor			Ernesto Aguilar
UsuarioRed		auhl373453
Fecha			2020/02/17
Objetivo		guarda la venta en el sistema
status			200 = ok
				-1	= error
*/

create proc [dbo].[SP_REALIZA_VENTA]

  @xml AS XML

as

	begin -- principal
	
		begin try

			begin --declaraciones 

				declare @status					int = 200,
						@mensaje				varchar(255) = 'Se registro la venta correctamente.',
						@error_line				varchar(255) = '',
						@error_procedure		varchar(255) = '',
						@tran_name				varchar(32) = 'REALIZA_VTA',
						@tran_count				int = @@trancount,
						@tran_scope				bit = 0,
						@idCliente				int = 0,
						@idFactFormaPago		varchar(50) = '',
						@idUsuario				int = 0,
						@totalProductos			int = 0,
						@montoTotal				money = 0,
						@idVenta				int = 0,
						@descuento				money = 0.0

				create table
					#Ventas
						(	
							contador			int identity(1,1),
							idCliente			int,
							cantidad			float,
							fechaAlta			datetime,
							montoTotal			money,
							idUsuario			int,
							idStatusVenta		int,
							idFactFormaPago		int
						)

				create table
					#VentasDetalle
						(
							idVentaDetalle					int,
							idVenta							int,
							idProducto						int,
							cantidad						float,
							contadorProductosPorPrecio		int,
							monto							money,
							cantidadActualInvGeneral		float,
							cantidadAnteriorInvGeneral		float						
						)

				create table 
					#cantidades 
						(  
							id			int identity(1,1),
							cantidad	int
						)

				create table 
					#idProductos 
						(  
							id			int identity(1,1),
							idProducto	int
						)
						

			end  --declaraciones 

			begin -- principal

				begin -- inicio transaccion
					if @tran_count = 0
						begin tran @tran_name
					else
						save tran @tran_name
					select @tran_scope = 1
				end -- inicio transaccion


				select  @idCliente =		( SELECT top 1  Ventas.idCliente.value('.','NVARCHAR(200)') AS idCliente FROM @xml.nodes('//idCliente') as Ventas(idCliente))
				select  @idFactFormaPago =	( SELECT top 1  Ventas.formaPago.value('.','NVARCHAR(200)') AS formaPago FROM @xml.nodes('//formaPago') as Ventas(formaPago))
				select  @idUsuario =		( SELECT top 1  Ventas.idUsuario.value('.','NVARCHAR(200)') AS idUsuario FROM @xml.nodes('//idUsuario') as Ventas(idUsuario))
				select  @idVenta =			( SELECT top 1  Ventas.idVenta.value('.','NVARCHAR(200)') AS idVenta FROM @xml.nodes('//idVenta') as Ventas(idVenta))
				

				insert into #cantidades (cantidad)
				SELECT Ventas.cantidad.value('.','NVARCHAR(200)') AS cantidad FROM @xml.nodes('//cantidad') as Ventas(cantidad) 

				insert into #idProductos (idProducto)
				SELECT Ventas.idProducto.value('.','NVARCHAR(200)') AS idProducto FROM @xml.nodes('//idProducto') as Ventas(idProducto)

				
				-- universo de venta de productos
				select	p.idProducto, c.cantidad, pre.contador, pre.costo,
						pre.costo * c.cantidad as precioPorProducto
				into	#vta
				from	#cantidades c
						inner join #idproductos p
							on c.id=p.id
						inner join ProductosPorPrecio pre
							on pre.idProducto = p.idProducto
				where	c.cantidad between pre.min and pre.max 
					and	pre.activo = cast(1 as bit)
					

				-- si existe el producto en el inventario general
				if not exists	( 
									select 1 from InventarioGeneral where idProducto not in ( select distinct idProducto from #vta )
								)
				begin
					select @mensaje = 'El producto no se encuentra en el inventario.'
					raiserror (@mensaje, 11, -1)
				end
				
				---- validamos q tenga el suficiente inventario
				--if  exists	( 
				--				select	i.cantidad - v.cantidad as cantidadActualInvGeneral,
				--						i.cantidad as cantidadAnteriorInvGeneral
				--				from	#vta v
				--						inner join InventarioGeneral i
				--							on v.idProducto = i.idProducto
				--				where	( ( i.cantidad - v.cantidad ) < 0 )
				--			)
				--begin
				--	select @mensaje = 'No se cuenta con suficientes existencias en el inventario.'
				--	raiserror (@mensaje, 11, -1)
				--end

				-- validamos si el cliente tiene descuento por aplicar
				select	@descuento = t.descuento
				from	clientes c
						inner join CatTipoCliente t
							on c.idTipoCliente = t.idTipoCliente
				where	c.idCliente = @idCliente

				-- si hay descuento
				if ( @descuento > 0.0 )
				begin
					update	#vta set #vta.precioPorProducto = #vta.precioPorProducto - (#vta.precioPorProducto * ( @descuento / 100 ))
				end
				
				-- si todo bien
				select @montoTotal = sum(precioPorProducto) from #vta
				select @totalProductos = sum(cantidad) from #vta


				-- inserta en tablas fisicas
				if ( @idVenta > 0 ) -- si es edicion
					begin

						--select	'InventarioGeneral',
						--		i.cantidad + A.tot_productos
						--		,* 
						
						update	InventarioGeneral 
						set		cantidad = i.cantidad + A.tot_productos
						from	InventarioGeneral i
									inner join	(
													select	idProducto as idProducto, sum(cantidad) as tot_productos 
													from	VentasDetalle 
													where	idVenta = @idVenta
													group by idProducto
												)A 
										on A.idProducto = i.idProducto


						delete from VentasDetalle where idVenta = @idVenta

						-- se restituye las existencias en el inventario


						-- se actualiza el la venta con los nuevos datos
						update	Ventas
						set		idCliente = @idCliente,
								cantidad  = @totalProductos,
								fechaAlta = getdate(),
								montoTotal = @montoTotal,
								idUsuario = @idUsuario,
								idStatusVenta = 1,
								idFactFormaPago = @idFactFormaPago
						where	idVenta = @idVenta

					end
				else -- si es nueva
					begin
						
						insert into Ventas (idCliente,cantidad,fechaAlta,montoTotal,idUsuario,idStatusVenta,idFactFormaPago)
						select	@idCliente as idCliente, @totalProductos as cantidad , GETDATE() as fechaAlta, 
								@montoTotal as montoTotal, @idUsuario as idUsuario, 1 as idStatusVenta,
								@idFactFormaPago as idFactFormaPago

						select @idVenta = max(idVenta)  from Ventas

					end


				insert into VentasDetalle (idVenta,idProducto,cantidad,contadorProductosPorPrecio,monto,cantidadActualInvGeneral,cantidadAnteriorInvGeneral)
				select	@idVenta as idVenta, v.idProducto, v.cantidad, v.contador, v.precioPorProducto, i.cantidad - v.cantidad as cantidadActualInvGeneral,
						i.cantidad as cantidadAnteriorInvGeneral
				from	#vta v
						inner join InventarioGeneral i
							on v.idProducto = i.idProducto

				-- actualizar el inventario general	
				update	InventarioGeneral
				set		cantidad = cantidad - a.productosComprados,
						fechaUltimaActualizacion = getdate()
				from	(
							select	idProducto, sum(cantidad) as productosComprados
							from	VentasDetalle 
							where	idVenta = @idVenta
							group by idProducto 
							--select	idProducto, cantidadActualInvGeneral 
							--from	VentasDetalle 
							--where	idVenta = @idVenta
						)A
				where	InventarioGeneral.idProducto = A.idProducto

				-- si el inventario de los productos vendidos queda negativo se paso de productos = rollback
				if  exists	( 
								select	1 
								from	InventarioGeneral
								where	idProducto in (select idProducto from #vta)
									and	cantidad < 0
							)
				begin
					select @mensaje = 'No se cuenta con suficientes existencias en el inventario.'
					raiserror (@mensaje, 11, -1)
				end



				begin -- commit de transaccion
					if @tran_count = 0
						begin -- si la transacción se inició dentro de este ámbito
							commit tran @tran_name
							select @tran_scope = 0
						end -- si la transacción se inició dentro de este ámbito
				end -- commit de transaccion
					
				drop table #Ventas
				drop table #VentasDetalle
				drop table #cantidades
				drop table #idProductos
				
			end -- principal

		end try

		begin catch 
		
			-- captura del error
			select	@status =			-error_state(),
					@error_procedure =	error_procedure(),
					@error_line =		error_line(),
					@mensaje =			error_message()

			-- revertir transacción si es necesario
			if @tran_scope = 1
				rollback tran @tran_name
					
		end catch

		begin -- reporte de estatus

			select	@status status,
					@error_procedure error_procedure,
					@error_line error_line,
					@mensaje mensaje,
					@idVenta as idVenta

		end -- reporte de estatus

	end  -- principal

GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDA_CONTRASENA]    Script Date: 11/04/2020 14:20:55 ******/
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

create proc [dbo].[SP_VALIDA_CONTRASENA]

	@usuario	varchar(200),
	@contrasena	varchar(40)

as

	begin -- principal
	
		begin try

			begin --declaraciones 

				declare @status					int = 200,
						@mensaje				varchar(255) = 'Usuario validado correctamente.',
						@error_line				varchar(255) = '',
						@error_procedure		varchar(255) = ''

			end  --declaraciones 

			begin -- principal

				if not exists ( select contrasena from usuarios where usuario = @usuario and contrasena = @contrasena ) 
				begin
					select @mensaje = 'La contraseña es incorrecta.'
					raiserror (@mensaje, 11, -1)
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

			if @status = 200
				begin
					select	@status status,
							@error_procedure error_procedure,
							@error_line error_line,
							@mensaje mensaje

					select	idUsuario,
							idRol,
							usuario,
							telefono,
							contrasena,
							idAlmacen,
							idSucursal,
							nombre,
							apellidoPaterno,
							apellidoMaterno,
							cast(1 as bit) as usuarioValido
					from	usuarios 
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

GO
/****** Object:  StoredProcedure [dbo].[spXmlSampleSimple]    Script Date: 11/04/2020 14:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spXmlSampleSimple](@Order XML)
AS

-- Retrive single values
DECLARE @OrderID INT;
DECLARE @ManagerID INT;
SET @OrderID = @Order.value('/Order[1]/OrderID[1]', 'INT');
SET @ManagerID = @Order.value('/Order[1]/Manager[1]/ManagerID[1]', 'INT');
SELECT @OrderID AS OrderID, @ManagerID AS ManagerID;

-- Arrays
SELECT Phones.Phone.value('.','NVARCHAR(20)') AS CustomerPhones FROM @Order.nodes('//Phone') as Phones(Phone);

-- Arrays into table
DECLARE @Phones TABLE (Phones NVARCHAR(20))
INSERT INTO @Phones(Phones) SELECT Phones.Phone.value('.','NVARCHAR(20)') FROM @Order.nodes('//Phone') as Phones(Phone);
SELECT * FROM @Phones;

-- Aggregations
DECLARE @ItemsCount INT;
SET @ItemsCount = @Order.value('count(/Order/Items/Item)', 'INT');
SELECT @ItemsCount AS ItemsCount;

GO
USE [master]
GO
ALTER DATABASE [DB_A552FA_comercializadora] SET  READ_WRITE 
GO
