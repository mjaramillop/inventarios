USE [master]
GO
/****** Object:  Database [inventarios]    Script Date: 02/05/2024 21:42:38 ******/
CREATE DATABASE [inventarios]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'inventarios', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\inventarios.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'inventarios_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\inventarios_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [inventarios] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [inventarios].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [inventarios] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [inventarios] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [inventarios] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [inventarios] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [inventarios] SET ARITHABORT OFF 
GO
ALTER DATABASE [inventarios] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [inventarios] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [inventarios] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [inventarios] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [inventarios] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [inventarios] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [inventarios] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [inventarios] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [inventarios] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [inventarios] SET  DISABLE_BROKER 
GO
ALTER DATABASE [inventarios] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [inventarios] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [inventarios] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [inventarios] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [inventarios] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [inventarios] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [inventarios] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [inventarios] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [inventarios] SET  MULTI_USER 
GO
ALTER DATABASE [inventarios] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [inventarios] SET DB_CHAINING OFF 
GO
ALTER DATABASE [inventarios] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [inventarios] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [inventarios] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [inventarios] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [inventarios] SET QUERY_STORE = OFF
GO
USE [inventarios]
GO
/****** Object:  UserDefinedFunction [dbo].[TRAE_ABREVIATURA_TIPO_DE_DOCUMENTO]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================

CREATE  FUNCTION [dbo].[TRAE_ABREVIATURA_TIPO_DE_DOCUMENTO] 
(
	@ID INT 
)
RETURNS VARCHAR(200)
AS
BEGIN
	


	DECLARE @NOMBRE VARCHAR(200);

	SELECT @NOMBRE= ABREVIATURA FROM TABLA_TIPOS_DE_DOCUMENTO WHERE ID = @ID

	RETURN @NOMBRE

END
GO
/****** Object:  UserDefinedFunction [dbo].[TRAE_CODIGO_NOMBRE_ATRIBUTO_DE_UN_TIPO_DE_DOCUMENTO]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================

CREATE  FUNCTION [dbo].[TRAE_CODIGO_NOMBRE_ATRIBUTO_DE_UN_TIPO_DE_DOCUMENTO] 
(
	@NOMBRE VARCHAR(300) 
)
RETURNS VARCHAR(500)
AS
BEGIN
	
	SET @NOMBRE = UPPER(RTRIM(LTRIM(@NOMBRE)))
	DECLARE @CODIGO VARCHAR(500);

	SELECT @CODIGO=ID FROM TABLA_TIPOS_DE_DOCUMENTO_ATRIBUTOS  WHERE UPPEr(NOMBRE) =upper(@NOMBRE)

	RETURN @CODIGO

END
GO
/****** Object:  UserDefinedFunction [dbo].[TRAE_FECHA_FORMATO_DDMMMAAAA]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE function [dbo].[TRAE_FECHA_FORMATO_DDMMMAAAA] (@fecha datetime)
RETURNS varchar(max) AS 
Begin



	RETURN  CONVERT(VARCHAR(12), @fecha, 106) 
End
GO
/****** Object:  UserDefinedFunction [dbo].[TRAE_FECHA_FORMATO_DMA]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE function [dbo].[TRAE_FECHA_FORMATO_DMA] (@fecha datetime)
RETURNS varchar(max) AS 
Begin


	return CONVERT(VARCHAR(15) , @fecha,103)
End
GO
/****** Object:  UserDefinedFunction [dbo].[TRAE_NIT_DE_LA_TRANSACCION]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================

CREATE  FUNCTION [dbo].[TRAE_NIT_DE_LA_TRANSACCION] 

(
	@TIPODEDOCUMENTO INT ,
	@DESPACHA INT,
	@RECIBE INT
)
RETURNS VARCHAR(300)
AS
BEGIN
	
DECLARE @VALOR VARCHAR(20)
DECLARE @NOMBREATRIBUTO VARCHAR(100) ='eldocumentoseimprimeanombrededespachaorecibe'
DECLARE @IDATRIBUTO INT
SELECT  @IDATRIBUTO=  ID FROM TABLA_TIPOS_DE_DOCUMENTO_ATRIBUTOS WHERE LOWER(NOMBRE)=@NOMBREATRIBUTO 


SELECT @VALOR=VALOR FROM TABLA_TIPOS_DE_DOCUMENTO_ATRIBUTOS_ASIGNADOS  WHERE 
TIPO_DE_DOCUMENTO = @TIPODEDOCUMENTO AND ATRIBUTO=@IDATRIBUTO

DECLARE @NOMBRECLIENTE VARCHAR(300)
IF (UPPER(@VALOR)='DESPACHA')   SELECT @NOMBRECLIENTE =NIT FROM PROVEEDORES WHERE ID=@DESPACHA
IF (UPPER(@VALOR)='RECIBE')   SELECT @NOMBRECLIENTE = NIT FROM PROVEEDORES WHERE ID=@RECIBE
 

RETURN @NOMBRECLIENTE

END
GO
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_ATRIBUTO_PROVEEDOR]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================

CREATE  FUNCTION [dbo].[TRAE_NOMBRE_ATRIBUTO_PROVEEDOR] 
(
	@ID INT 
)
RETURNS VARCHAR(500)
AS
BEGIN
	


	DECLARE @NOMBRE VARCHAR(500);

	SELECT @NOMBRE= NOMBRE FROM PROVEEDORES_ATRIBUTOS  WHERE ID = @ID

	RETURN @NOMBRE

END
GO
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_ATRIBUTO_TIPO_DE_DOCUMENTO]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================

CREATE   FUNCTION [dbo].[TRAE_NOMBRE_ATRIBUTO_TIPO_DE_DOCUMENTO] 
(
	@ID INT 
)
RETURNS VARCHAR(500)
AS
BEGIN
	


	DECLARE @NOMBRE VARCHAR(500);

	SELECT @NOMBRE= NOMBRE FROM TABLA_TIPOS_DE_DOCUMENTO_ATRIBUTOS  WHERE ID = @ID

	RETURN @NOMBRE

END
GO
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_CIUDAD]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================

CREATE FUNCTION [dbo].[TRAE_NOMBRE_CIUDAD] 
(
	@ID VARCHAR(10) 
)
RETURNS VARCHAR(200)
AS
BEGIN
	


	DECLARE @NOMBRE VARCHAR(200);

	SELECT @NOMBRE= NOMBRE FROM TABLA_CIUDADES WHERE CIUDAD = @ID

	RETURN @NOMBRE

END
GO
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_CLASIFICACION_DE_AGENTES]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================

CREATE   FUNCTION [dbo].[TRAE_NOMBRE_CLASIFICACION_DE_AGENTES] 
(
	@ID INT 
)
RETURNS VARCHAR(400)
AS
BEGIN


declare @nivel1 int
declare @nivel2 int
declare @nivel3 int


declare @nombrenivel1 varchar(300)
declare @nombrenivel2 varchar(300)
declare @nombrenivel3 varchar(300)

declare @xnombrenivel1 varchar(300)
declare @xnombrenivel2 varchar(300)
declare @xnombrenivel3 varchar(300)



declare @clasificacion int

select     @clasificacion =  clasificacion from PROVEEDORES WHERE id = @id


select @nivel1 = nivel1 , @nivel2=nivel2 ,@nivel3=nivel3  from TABLA_CLASIFICACION_DE_AGENTES
where id = @clasificacion

select @nombrenivel1=RTRIM(LTRIM(ISNULL(NOMBRE,'') ))   from TABLA_CLASIFICACION_DE_AGENTES where nivel1 = @nivel1 and nivel2=0 and nivel3=0 
select @nombrenivel2=RTRIM(LTRIM(ISNULL(NOMBRE,'') ))   from TABLA_CLASIFICACION_DE_AGENTES where nivel1 = @nivel1 and nivel2=@nivel2 and nivel3=0
select @nombrenivel3=RTRIM(LTRIM(ISNULL(NOMBRE,'') ))   from TABLA_CLASIFICACION_DE_AGENTES where nivel1 = @nivel1 and nivel2=@nivel2 and nivel3=@nivel3 

set @xnombrenivel1=@nombrenivel1
set @xnombrenivel2=@nombrenivel2
set @xnombrenivel3=@nombrenivel3




	DECLARE @NOMBRE VARCHAR(400);
	if (@nombrenivel1=@nombrenivel2) set @xnombrenivel2=''
	if (@nombrenivel2=@nombrenivel3) set @xnombrenivel3=''


	SELECT @NOMBRE= @xnombrenivel1 +'  '+@xnombrenivel2 + '  ' +@xnombrenivel3 
	RETURN @NOMBRE


END
GO
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_CLASIFICACION_DE_MATERIAS_PRIMAS]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================

CREATE  FUNCTION [dbo].[TRAE_NOMBRE_CLASIFICACION_DE_MATERIAS_PRIMAS] 
(
	@ID varchar(30)
)
RETURNS VARCHAR(400)
AS
BEGIN


declare @nivel1 int
declare @nivel2 int
declare @nivel3 int
declare @nivel4 int
declare @nivel5 int

declare @nombrenivel1 varchar(300)
declare @nombrenivel2 varchar(300)
declare @nombrenivel3 varchar(300)
declare @nombrenivel4 varchar(300)
declare @nombrenivel5 varchar(300)



declare @xnombrenivel1 varchar(300)
declare @xnombrenivel2 varchar(300)
declare @xnombrenivel3 varchar(300)
declare @xnombrenivel4 varchar(300)
declare @xnombrenivel5 varchar(300)



declare @clasificacion int

select     @clasificacion =  clasificacion from PRODUCTOS WHERE id = @id


select @nivel1 = nivel1 , @nivel2=nivel2 ,@nivel3=nivel3 , @nivel4 = nivel4 , @nivel5=nivel5 from TABLA_CLASIFICACION_DE_MATERIAS_PRIMAS
where id = @clasificacion

select @nombrenivel1=RTRIM(LTRIM(ISNULL(NOMBRE,'') ))   from TABLA_CLASIFICACION_DE_MATERIAS_PRIMAS where nivel1 = @nivel1 and nivel2=0 and nivel3=0 and nivel4=0 and nivel5=0
select @nombrenivel2=RTRIM(LTRIM(ISNULL(NOMBRE,'') ))   from TABLA_CLASIFICACION_DE_MATERIAS_PRIMAS where nivel1 = @nivel1 and nivel2=@nivel2 and nivel3=0 and nivel4=0 and nivel5=0
select @nombrenivel3=RTRIM(LTRIM(ISNULL(NOMBRE,'') ))   from TABLA_CLASIFICACION_DE_MATERIAS_PRIMAS where nivel1 = @nivel1 and nivel2=@nivel2 and nivel3=@nivel3 and nivel4=0 and nivel5=0
select @nombrenivel4=RTRIM(LTRIM(ISNULL(NOMBRE,'') ))   from TABLA_CLASIFICACION_DE_MATERIAS_PRIMAS where nivel1 = @nivel1 and nivel2=@nivel2 and nivel3=@nivel3 and nivel4=@nivel4 and nivel5=0
select @nombrenivel5=RTRIM(LTRIM(ISNULL(NOMBRE,'') ))   from TABLA_CLASIFICACION_DE_MATERIAS_PRIMAS where nivel1 = @nivel1 and nivel2=@nivel2 and nivel3=@nivel3 and nivel4=@nivel4 and nivel5=@nivel5



set @xnombrenivel1=@nombrenivel1
set @xnombrenivel2=@nombrenivel2
set @xnombrenivel3=@nombrenivel3
set @xnombrenivel4=@nombrenivel4
set @xnombrenivel5=@nombrenivel5




	DECLARE @NOMBRE VARCHAR(400);
	if (@nombrenivel1=@nombrenivel2) set @xnombrenivel2=''
	if (@nombrenivel2=@nombrenivel3) set @xnombrenivel3=''
	if (@nombrenivel3=@nombrenivel4) set @xnombrenivel4=''
    if (@nombrenivel4=@nombrenivel5) set @xnombrenivel5=''



	SELECT @NOMBRE= @xnombrenivel1 +'  '+@xnombrenivel2 + '  ' +@xnombrenivel3 + '  ' + @xnombrenivel4 + '  ' + @xnombrenivel5
	RETURN @NOMBRE


END
GO
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_COLOR]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================

CREATE  FUNCTION [dbo].[TRAE_NOMBRE_COLOR] 
(
	@ID INT 
)
RETURNS VARCHAR(500)
AS
BEGIN
	


	DECLARE @NOMBRE VARCHAR(500);

	SELECT @NOMBRE= NOMBRE FROM TABLA_COLORES WHERE ID = @ID

	RETURN @NOMBRE

END
GO
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_CONCEPTO_NOTA_DEBITO_CREDITO]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================

CREATE   FUNCTION [dbo].[TRAE_NOMBRE_CONCEPTO_NOTA_DEBITO_CREDITO] 
(
	@ID INT 
)
RETURNS VARCHAR(500)
AS
BEGIN
	


	DECLARE @NOMBRE VARCHAR(500);

	SELECT @NOMBRE= NOMBRE FROM TABLA_CONCEPTOS_NOTA_DEBITO_Y_CREDITO WHERE ID = @ID

	RETURN @NOMBRE

END
GO
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_DEPARTAMENTO]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================

CREATE FUNCTION [dbo].[TRAE_NOMBRE_DEPARTAMENTO] 
(
	@ID VARCHAR(20) 
)
RETURNS VARCHAR(200)
AS
BEGIN
	


	DECLARE @NOMBRE VARCHAR(200);

	SELECT @NOMBRE= NOMBRE FROM TABLA_DEPARTAMENTOS WHERE ID = @ID

	RETURN @NOMBRE

END
GO
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_DEPARTAMENTO_DE_LA_CIUDAD]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================

CREATE FUNCTION [dbo].[TRAE_NOMBRE_DEPARTAMENTO_DE_LA_CIUDAD] 
(
	@CODIGOCIUDAD VARCHAR(20) 
)
RETURNS VARCHAR(200)
AS
BEGIN
	

	DECLARE @CODIGODEPARTAMENTO VARCHAR(10)



	DECLARE @NOMBRE VARCHAR(200);

	SELECT @CODIGODEPARTAMENTO= DEPARTAMENTO FROM TABLA_CIUDADES WHERE CIUDAD = @CODIGOCIUDAD
	SELECT @NOMBRE = NOMBRE FROM TABLA_DEPARTAMENTOS WHERE ID =@CODIGODEPARTAMENTO

	RETURN @NOMBRE

END
GO
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_ESTADO_DEL_REGISTRO]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================

CREATE  FUNCTION [dbo].[TRAE_NOMBRE_ESTADO_DEL_REGISTRO] 
(
	@CODIGO VARCHAR(1) 
)
RETURNS VARCHAR(100)
AS
BEGIN
	

	IF (@CODIGO IS NULL) SET @CODIGO=''

	DECLARE @ESTADODELREGISTRO VARCHAR(30);

	SELECT @ESTADODELREGISTRO= NOMBRE FROM TABLA_TIPOS_DE_ESTADO_DE_UN_REGISTRO WHERE ID = @CODIGO

	RETURN @ESTADODELREGISTRO

END
GO
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_FORMA_DE_PAGO]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================

CREATE  FUNCTION [dbo].[TRAE_NOMBRE_FORMA_DE_PAGO] 
(
	@ID INT 
)
RETURNS VARCHAR(500)
AS
BEGIN
	


	DECLARE @NOMBRE VARCHAR(500);

	SELECT @NOMBRE= NOMBRE FROM TABLA_FORMAS_DE_PAGO WHERE ID = @ID

	RETURN @NOMBRE

END
GO
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_PAIS]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================

CREATE FUNCTION [dbo].[TRAE_NOMBRE_PAIS] 
(
	@ID VARCHAR(20) 
)
RETURNS VARCHAR(200)
AS
BEGIN
	


	DECLARE @NOMBRE VARCHAR(200);

	SELECT @NOMBRE= NOMBRE FROM TABLA_PAISES WHERE ID = @ID

	RETURN @NOMBRE

END
GO
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_PAIS_DE_LA_CIUDAD]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================

CREATE FUNCTION [dbo].[TRAE_NOMBRE_PAIS_DE_LA_CIUDAD] 
(
	@CODIGOCIUDAD VARCHAR(20) 
)
RETURNS VARCHAR(200)
AS
BEGIN
	

	DECLARE @CODIGOPAIS VARCHAR(10)



	DECLARE @NOMBRE VARCHAR(200);

	SELECT @CODIGOPAIS= PAIS FROM TABLA_CIUDADES WHERE CIUDAD = @CODIGOCIUDAD
	SELECT @NOMBRE = NOMBRE FROM TABLA_PAISES WHERE ID =@CODIGOPAIS

	RETURN @NOMBRE

END
GO
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_PARAMETRO]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================

CREATE  FUNCTION [dbo].[TRAE_NOMBRE_PARAMETRO] 
(
	@NOMBREDELPARAMETRO VARCHAR(300) 
)
RETURNS VARCHAR(300)
AS
BEGIN
	
	SET @NOMBREDELPARAMETRO = UPPER(@NOMBREDELPARAMETRO)

	DECLARE @NOMBRE VARCHAR(300);

	SELECT @NOMBRE= VALOR FROM PARAMETROS  WHERE UPPER(PARAMETRO) = @NOMBREDELPARAMETRO

	RETURN @NOMBRE

END
GO
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_PRODUCTO]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================

CREATE  FUNCTION [dbo].[TRAE_NOMBRE_PRODUCTO] 
(
	@ID varchar(30) 
)
RETURNS VARCHAR(500)
AS
BEGIN
	


	DECLARE @NOMBRE VARCHAR(500);

	SELECT @NOMBRE= NOMBRE FROM PRODUCTOS WHERE ID = @ID

	RETURN @NOMBRE

END
GO
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_PROVEEDOR]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================

CREATE  FUNCTION [dbo].[TRAE_NOMBRE_PROVEEDOR] 
(
	@ID INT 
)
RETURNS VARCHAR(300)
AS
BEGIN
	


	DECLARE @NOMBRE VARCHAR(300);

	SELECT @NOMBRE= NOMBRE FROM PROVEEDORES WHERE ID = @ID

	RETURN @NOMBRE

END
GO
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_PROVEEDOR_DE_LA_TRANSACCION]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================

CREATE FUNCTION [dbo].[TRAE_NOMBRE_PROVEEDOR_DE_LA_TRANSACCION] 
(
	@TIPODEDOCUMENTO INT ,
	@DESPACHA INT,
	@RECIBE INT
)
RETURNS VARCHAR(300)
AS
BEGIN
	
DECLARE @VALOR VARCHAR(20)
DECLARE @NOMBREATRIBUTO VARCHAR(100) ='eldocumentoseimprimeanombrededespachaorecibe'
DECLARE @IDATRIBUTO INT
SELECT  @IDATRIBUTO=  ID FROM TABLA_TIPOS_DE_DOCUMENTO_ATRIBUTOS WHERE LOWER(NOMBRE)=@NOMBREATRIBUTO 


SELECT @VALOR=VALOR FROM TABLA_TIPOS_DE_DOCUMENTO_ATRIBUTOS_ASIGNADOS  WHERE 
TIPO_DE_DOCUMENTO = @TIPODEDOCUMENTO AND ATRIBUTO=@IDATRIBUTO

DECLARE @NOMBRECLIENTE VARCHAR(300)
IF (UPPER(@VALOR)='DESPACHA')   SELECT @NOMBRECLIENTE = NOMBRE FROM PROVEEDORES WHERE ID=@DESPACHA
IF (UPPER(@VALOR)='RECIBE')   SELECT @NOMBRECLIENTE = NOMBRE FROM PROVEEDORES WHERE ID=@RECIBE
 

RETURN @NOMBRECLIENTE

END
GO
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_RETENCION]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================

CREATE   FUNCTION [dbo].[TRAE_NOMBRE_RETENCION] 
(
	@ID INT 
)
RETURNS VARCHAR(500)
AS
BEGIN
	


	DECLARE @NOMBRE VARCHAR(500);

	SELECT @NOMBRE= NOMBRE FROM RETENCIONES WHERE ID = @ID

	RETURN @NOMBRE

END
GO
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_TIPO_DE_AGENTE]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================

CREATE FUNCTION [dbo].[TRAE_NOMBRE_TIPO_DE_AGENTE] 
(
	@ID INT 
)
RETURNS VARCHAR(200)
AS
BEGIN
	


	DECLARE @NOMBRE VARCHAR(200);

	SELECT @NOMBRE= NOMBRE FROM TABLA_TIPOS_DE_AGENTE WHERE ID = @ID

	RETURN @NOMBRE

END
GO
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_TIPO_DE_CUENTA_BANCARIA]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================

CREATE  FUNCTION [dbo].[TRAE_NOMBRE_TIPO_DE_CUENTA_BANCARIA] 
(
	@ID INT 
)
RETURNS VARCHAR(200)
AS
BEGIN
	


	DECLARE @NOMBRE VARCHAR(200);

	SELECT @NOMBRE= NOMBRE FROM TABLA_TIPOS_DE_CUENTA_BANCARIA WHERE ID = @ID

	RETURN @NOMBRE

END
GO
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_TIPO_DE_DOCUMENTO]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================

CREATE  FUNCTION [dbo].[TRAE_NOMBRE_TIPO_DE_DOCUMENTO] 
(
	@ID INT 
)
RETURNS VARCHAR(200)
AS
BEGIN
	


	DECLARE @NOMBRE VARCHAR(200);

	SELECT @NOMBRE= NOMBRE FROM TABLA_TIPOS_DE_DOCUMENTO WHERE ID = @ID

	RETURN @NOMBRE

END
GO
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_TIPO_DE_RETENCION]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================

CREATE   FUNCTION [dbo].[TRAE_NOMBRE_TIPO_DE_RETENCION] 
(
	@ID INT 
)
RETURNS VARCHAR(500)
AS
BEGIN
	


	DECLARE @NOMBRE VARCHAR(500);

	SELECT @NOMBRE= NOMBRE FROM TABLA_TIPOS_DE_RETENCION  WHERE ID = @ID

	RETURN @NOMBRE

END
GO
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_UNIDAD_DE_MEDIDA]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================

CREATE  FUNCTION [dbo].[TRAE_NOMBRE_UNIDAD_DE_MEDIDA] 
(
	@ID VARCHAR(10) 
)
RETURNS VARCHAR(200)
AS
BEGIN
	


	DECLARE @NOMBRE VARCHAR(200);

	SELECT @NOMBRE= NOMBRE FROM TABLA_UNIDADES_DE_MEDIDA WHERE ID = @ID

	RETURN @NOMBRE

END
GO
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRES_RETENCIONES_DE_UN_PROVEEDOR]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================

CREATE  FUNCTION [dbo].[TRAE_NOMBRES_RETENCIONES_DE_UN_PROVEEDOR] (@ID INT)  
RETURNS varchar(300) AS  
BEGIN

DECLARE @CADENASISTEMAS VARCHAR(1000)
DECLARE @SIS_NOMBRE VARCHAR (500)


set @CADENASISTEMAS = ''

		DECLARE SISTEMAS CURSOR FOR
		SELECT  dbo.TRAE_NOMBRE_RETENCION(ID_RETENCION) AS NOMBRE_RETENCION FROM PROVEEDORES_RETENCIONES
		WHERE ID_PROVEEDOR= @ID 

	OPEN SISTEMAS
	FETCH NEXT FROM SISTEMAS INTO @SIS_NOMBRE
	WHILE @@FETCH_STATUS = 0
	BEGIN
		set @CADENASISTEMAS = @CADENASISTEMAS + @SIS_NOMBRE + ',' 
	FETCH NEXT FROM SISTEMAS INTO @SIS_NOMBRE
	END
	CLOSE SISTEMAS
	DEALLOCATE SISTEMAS
	
	IF(len(@CADENASISTEMAS)>0)
	BEGIN
		set @CADENASISTEMAS = SUBSTRING (@CADENASISTEMAS, 1, LEN(@CADENASISTEMAS)-1) 
	END
	
	RETURN(@CADENASISTEMAS)

END


GO
/****** Object:  UserDefinedFunction [dbo].[TRAE_VALOR_CON_COMAS]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE function [dbo].[TRAE_VALOR_CON_COMAS] (@VALOR  decimal(18))
RETURNS varchar(20) AS 
Begin

	RETURN   FORMAT(@VALOR,'N');
End
GO
/****** Object:  UserDefinedFunction [dbo].[TRAE_VALOR_DE_UN_ATRIBUTO_TIPO_DE_DOCUMENTO]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================

CREATE    FUNCTION [dbo].[TRAE_VALOR_DE_UN_ATRIBUTO_TIPO_DE_DOCUMENTO] 
(
@TIPODDEDOCUMENTO INT,
	@NOMBRE_ATRIBUTO VARCHAR(300) 
)
RETURNS VARCHAR(500)
AS
BEGIN
	
	DECLARE @ID INT
	SELECT @ID =ID FROM TABLA_TIPOS_DE_DOCUMENTO_ATRIBUTOS WHERE lower(NOMBRE)=lower(@NOMBRE_ATRIBUTO)

	DECLARE @NOMBRE VARCHAR(500);

	SELECT @NOMBRE= VALOR FROM TABLA_TIPOS_DE_DOCUMENTO_ATRIBUTOS_ASIGNADOS   WHERE 
	TIPO_DE_DOCUMENTO=@TIPODDEDOCUMENTO AND ATRIBUTO = @ID

	RETURN @NOMBRE

END
GO
/****** Object:  Table [dbo].[ACTIVIDADESECONOMICAS]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACTIVIDADESECONOMICAS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](100) NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL,
 CONSTRAINT [PK_TABLA_ACTIVIDADES_ECONOMICAS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[COLORES]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COLORES](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](50) NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CONCEPTOSNOTADEBITOYCREDITO]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONCEPTOSNOTADEBITOYCREDITO](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](100) NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL,
 CONSTRAINT [PK_TABLA_CONCEPTOS_NOTA_DEBITO_Y_CREDITO] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ESTADOSDEUNREGISTRO]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ESTADOSDEUNREGISTRO](
	[ID] [int] NOT NULL,
	[NOMBRE] [varchar](30) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FORMASDEPAGO]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FORMASDEPAGO](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](100) NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FORMULAS]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FORMULAS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FORMULA] [int] NOT NULL,
	[COMPONENTE] [int] NOT NULL,
	[CANTIDAD] [decimal](18, 5) NULL,
 CONSTRAINT [PK_FORMULAS_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IVAS]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IVAS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](20) NULL,
	[porcentaje] [decimal](5, 2) NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL,
 CONSTRAINT [PK_IVAS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LOG]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOG](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DESCRIPCION_DE_LA_OPERACION] [ntext] NULL,
	[FECHA_DE_ACTUALIZACION] [datetime] NULL,
 CONSTRAINT [PK_LOG] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MENSAJESDELSISTEMA]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MENSAJESDELSISTEMA](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[FECHA_DESDE] [datetime] NULL,
	[FECHA_HASTA] [datetime] NULL,
	[MENSAJE] [varchar](max) NULL,
 CONSTRAINT [PK_MENSAJESDELSISTEMA] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MENU]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MENU](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ORDEN] [varchar](10) NOT NULL,
	[NOMBRE] [varchar](100) NULL,
	[PAGINA_WEB] [varchar](300) NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MOVIMIENTODEINVENTARIOS]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVIMIENTODEINVENTARIOS](
	[ID] [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	[DESPACHA] [int] NOT NULL,
	[NOMBREDESPACHA] [varchar](200) NULL,
	[RECIBE] [int] NOT NULL,
	[NOMBRERECIBE] [varchar](200) NULL,
	[TIPODEDOCUMENTO] [int] NOT NULL,
	[NOMBRETIPODEDOCUMENJTO] [varchar](100) NULL,
	[NUMERODELDOCUMENTO] [int] NOT NULL,
	[DESPACHAAAFECTAR] [int] NULL,
	[NOMBREDESPACHAAAFECTAR] [varchar](200) NULL,
	[RECIBEAAFECTAR] [int] NULL,
	[NOMBRERECIBEAAFECTAR] [varchar](200) NULL,
	[TIPODEDOCUMENTOAAFECTAR] [int] NULL,
	[NOMBRETIPODEDOCUMENTOAAFECTAR] [varchar](200) NULL,
	[NUMERODELDOCUMENTOAAFECTAR] [int] NULL,
	[FECHADELDOCUMENTO] [datetime] NULL,
	[PLAZO] [int] NULL,
	[FECHADEVENCIMIENTODELDOCUMENTO] [datetime] NULL,
	[PROGRAMA] [int] NULL,
	[NOMBREPROGRAMA] [varchar](200) NULL,
	[VENDEDOR] [int] NULL,
	[NOMBREVENDEDOR] [varchar](200) NULL,
	[FORMADEPAGO] [int] NULL,
	[NOMBREFORMADEPAGO] [varchar](200) NULL,
	[NUMERODELPAGO] [varchar](50) NULL,
	[BANCO] [int] NULL,
	[NOMBREBANCO] [varchar](200) NULL,
	[CODIGOCONCEPTONOTADEBITOCREDITO] [int] NULL,
	[NOMBRECONCEPTONOTADEBITOCREDITO] [varchar](50) NULL,
	[OBSERVACIONES] [varchar](1000) NULL,
	[FORMULA] [int] NULL,
	[NOMBREFORMULA] [varchar](200) NULL,
	[PRODUCTO] [int] NULL,
	[UNIDADDEMEDIDA] [int] NULL,
	[NOMBREUNIDADDEMEDIDA] [varchar](20) NULL,
	[TALLA] [int] NULL,
	[COLOR] [int] NULL,
	[NOMBREPRODUCTO] [varchar](300) NULL,
	[NOMBRETALLA] [varchar](15) NULL,
	[NOMBRECOLOR] [varchar](30) NULL,
	[NUMERODEEMPAQUES] [decimal](18, 0) NULL,
	[UNIDADDEEMPAQUE] [varchar](10) NULL,
	[NOMBREUNIDADDEEMPAQUE] [varchar](30) NULL,
	[CANTIDADPOREMPAQUE] [decimal](18, 5) NULL,
	[CANTIDAD] [decimal](18, 5) NULL,
	[VALORUNITARIO] [decimal](18, 5) NULL,
	[COSTODEPRODUCCIONPORUNIDAD] [decimal](18, 5) NULL,
	[COSTOULTIMOPORUNIDAD] [decimal](18, 5) NULL,
	[COSTOPROMEDIOPORUNIDAD] [decimal](18, 5) NULL,
	[COSTOFLETEPORUNIDAD] [decimal](18, 2) NULL,
	[SUBTOTAL] [decimal](18, 5) NULL,
	[CODIGODESCUENTO1] [int] NULL,
	[NOMBRECODIGODESCUENTO1] [varchar](50) NULL,
	[PORCENTAJEDESCUENTO1] [decimal](5, 2) NULL,
	[VALORDESCUENTO1] [int] NULL,
	[CODIGOIVA1] [int] NULL,
	[NOMBRECODIGOIVA1] [varchar](50) NULL,
	[PORCENTAJEDEIVA1] [decimal](5, 2) NULL,
	[VALORIVA1] [int] NULL,
	[FLETES] [int] NULL,
	[CODIGORETENCION1] [int] NULL,
	[NOMBRECODIGORETENCION1] [varchar](50) NULL,
	[PORCENTAJEDERETENCION1] [numeric](5, 2) NULL,
	[VALORRETENCION1] [int] NULL,
	[VALORNETO] [decimal](18, 5) NULL,
	[FECHADEPROGRAMACIONDELPAGO] [datetime] NULL,
	[LA_CANTIDAD_ESTA_DESPACHADA] [varchar](1) NULL,
	[EL_DOCUMENTO_ESTA_CANCELADO] [varchar](1) NULL,
	[SUMA_O_RESTA_EN_INVENTARIO] [varchar](1) NULL,
	[SUMA_O_RESTA_EN_CARTERA] [varchar](1) NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL,
	[FECHA_DE_CREACION] [datetime] NULL,
	[USUARIO_QUE_ACTUALIZO] [varchar](200) NULL,
	[TRASLADO_RECIBIDO_Y_APROBADO_POR] [varchar](200) NULL,
	[FECHA_TRASLADO_RECIBIDO_Y_APROBADO] [datetime] NULL,
 CONSTRAINT [PK_MOVIMIENTODEINVENTARIOS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MOVIMIENTODEINVENTARIOSTMP]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVIMIENTODEINVENTARIOSTMP](
	[ID] [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	[DESPACHA] [int] NOT NULL,
	[NOMBREDESPACHA] [varchar](200) NOT NULL,
	[RECIBE] [int] NOT NULL,
	[NOMBRERECIBE] [varchar](200) NOT NULL,
	[TIPODEDOCUMENTO] [int] NOT NULL,
	[NOMBRETIPODEDOCUMENJTO] [varchar](100) NOT NULL,
	[NUMERODELDOCUMENTO] [int] NOT NULL,
	[DESPACHAAAFECTAR] [int] NOT NULL,
	[NOMBREDESPACHAAAFECTAR] [varchar](200) NOT NULL,
	[RECIBEAAFECTAR] [int] NOT NULL,
	[NOMBRERECIBEAAFECTAR] [varchar](200) NOT NULL,
	[TIPODEDOCUMENTOAAFECTAR] [int] NOT NULL,
	[NOMBRETIPODEDOCUMENTOAAFECTAR] [varchar](200) NOT NULL,
	[NUMERODELDOCUMENTOAAFECTAR] [int] NOT NULL,
	[FECHADELDOCUMENTO] [datetime] NOT NULL,
	[PLAZO] [int] NULL,
	[FECHADEVENCIMIENTODELDOCUMENTO] [datetime] NOT NULL,
	[PROGRAMA] [int] NOT NULL,
	[NOMBREPROGRAMA] [varchar](200) NOT NULL,
	[VENDEDOR] [int] NOT NULL,
	[NOMBREVENDEDOR] [varchar](200) NOT NULL,
	[FORMADEPAGO] [int] NOT NULL,
	[NOMBREFORMADEPAGO] [varchar](200) NOT NULL,
	[NUMERODELPAGO] [varchar](50) NOT NULL,
	[BANCO] [int] NOT NULL,
	[NOMBREBANCO] [varchar](200) NOT NULL,
	[CODIGOCONCEPTONOTADEBITOCREDITO] [int] NOT NULL,
	[NOMBRECONCEPTONOTADEBITOCREDITO] [varchar](50) NOT NULL,
	[OBSERVACIONES] [varchar](1000) NOT NULL,
	[FORMULA] [int] NULL,
	[NOMBREFORMULA] [varchar](200) NULL,
	[PRODUCTO] [int] NOT NULL,
	[UNIDADDEMEDIDA] [int] NULL,
	[TALLA] [int] NOT NULL,
	[COLOR] [int] NOT NULL,
	[NOMBREPRODUCTO] [varchar](300) NOT NULL,
	[NOMBREUNIDADDEMEDIDA] [varchar](20) NULL,
	[NOMBRETALLA] [varchar](15) NOT NULL,
	[NOMBRECOLOR] [varchar](30) NOT NULL,
	[NUMERODEEMPAQUES] [decimal](18, 0) NOT NULL,
	[UNIDADDEEMPAQUE] [varchar](10) NOT NULL,
	[NOMBREUNIDADDEEMPAQUE] [varchar](30) NOT NULL,
	[CANTIDADPOREMPAQUE] [decimal](18, 5) NOT NULL,
	[CANTIDAD] [decimal](18, 5) NOT NULL,
	[VALORUNITARIO] [decimal](18, 5) NOT NULL,
	[COSTOULTIMOPORUNIDAD] [decimal](18, 5) NOT NULL,
	[COSTOFLETEPORUNIDAD] [decimal](18, 2) NOT NULL,
	[SUBTOTAL] [decimal](18, 5) NOT NULL,
	[CODIGODESCUENTO1] [int] NOT NULL,
	[NOMBRECODIGODESCUENTO1] [varchar](50) NOT NULL,
	[PORCENTAJEDESCUENTO1] [decimal](5, 2) NOT NULL,
	[VALORDESCUENTO1] [int] NOT NULL,
	[CODIGOIVA1] [int] NOT NULL,
	[NOMBRECODIGOIVA1] [varchar](50) NOT NULL,
	[PORCENTAJEDEIVA1] [decimal](5, 2) NOT NULL,
	[VALORIVA1] [int] NOT NULL,
	[FLETES] [int] NOT NULL,
	[CODIGORETENCION1] [int] NOT NULL,
	[NOMBRECODIGORETENCION1] [varchar](50) NOT NULL,
	[PORCENTAJEDERETENCION1] [numeric](5, 2) NOT NULL,
	[VALORRETENCION1] [int] NOT NULL,
	[VALORNETO] [decimal](18, 5) NOT NULL,
	[FECHADEPROGRAMACIONDELPAGO] [datetime] NOT NULL,
	[LA_CANTIDAD_ESTA_DESPACHADA] [varchar](1) NOT NULL,
	[EL_DOCUMENTO_ESTA_CANCELADO] [varchar](1) NOT NULL,
	[SUMA_O_RESTA_EN_INVENTARIO] [varchar](1) NOT NULL,
	[SUMA_O_RESTA_EN_CARTERA] [varchar](1) NOT NULL,
	[ESTADO_DEL_REGISTRO] [int] NOT NULL,
	[FECHA_DE_CREACION] [datetime] NOT NULL,
	[USUARIO_QUE_ACTUALIZO] [varchar](200) NOT NULL,
	[TRASLADO_RECIBIDO_Y_APROBADO_POR] [varchar](200) NOT NULL,
	[FECHA_TRASLADO_RECIBIDO_Y_APROBADO] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PERFILES]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PERFILES](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](100) NULL,
	[PROGRAMAS] [varchar](500) NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL,
 CONSTRAINT [PK_PERFILES] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PRODUCTOS]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTOS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](300) NULL,
	[UNIDADDEMEDIDA] [int] NULL,
	[PRECIO1] [decimal](18, 5) NULL,
	[COSTOULTIMO] [decimal](18, 5) NULL,
	[CODIGOIVA1] [int] NULL,
	[NIVEL1] [varchar](100) NULL,
	[NIVEL2] [varchar](100) NULL,
	[NIVEL3] [varchar](100) NULL,
	[NIVEL4] [varchar](100) NULL,
	[NIVEL5] [varchar](100) NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL,
	[SECARGAALINVENTARIO] [varchar](1) NULL,
 CONSTRAINT [PK_PRODUCTOS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PROGRAMAS]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PROGRAMAS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](100) NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL,
 CONSTRAINT [PK_TABLA_TIPOS_DE_PROGRAMAS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PROVEEDORES]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PROVEEDORES](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](200) NULL,
	[direccion] [varchar](150) NULL,
	[ciudad] [varchar](10) NULL,
	[telefono] [varchar](20) NULL,
	[celular1] [varchar](20) NULL,
	[celular2] [varchar](20) NULL,
	[email1] [varchar](50) NULL,
	[email2] [varchar](50) NULL,
	[nit] [varchar](12) NULL,
	[fechadeingreso] [datetime] NULL,
	[observaciones] [varchar](300) NULL,
	[contactos] [varchar](300) NULL,
	[actividadcomercial] [int] NULL,
	[seleretienefuente] [varchar](1) NULL,
	[seleretieneiva] [varchar](1) NULL,
	[seleretieneica] [varchar](1) NULL,
	[puedecobrariva] [varchar](1) NULL,
	[espersonanaturalojuridica] [varchar](1) NULL,
	[declararenta] [varchar](1) NULL,
	[esgrancontribuyente] [varchar](1) NULL,
	[tipoderegimen] [int] NULL,
	[TIPO_DE_AGENTE] [int] NULL,
	[CUENTACONTABLE] [varchar](20) NULL,
	[codigoderetencionaaplicar] [int] NULL,
	[cuentabancaria] [varchar](20) NULL,
	[tipodecuenta] [varchar](1) NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL,
	[nivel1] [varchar](50) NULL,
	[nivel2] [varchar](50) NULL,
	[nivel3] [varchar](50) NULL,
	[nivel4] [varchar](50) NULL,
	[nivel5] [varchar](50) NULL,
 CONSTRAINT [PK_PROVEEDORES] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RETENCIONES]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RETENCIONES](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](300) NOT NULL,
	[PORCENTAJE] [decimal](18, 2) NULL,
	[BASEDELARETENCION] [decimal](18, 2) NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL,
 CONSTRAINT [PK_RETENCIONES] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SALDOS]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SALDOS](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[PRODUCTO] [int] NULL,
	[bodega] [int] NULL,
	[saldoinicial] [decimal](18, 5) NULL,
	[entradas] [decimal](18, 5) NULL,
	[salidas] [decimal](18, 5) NULL,
	[saldo] [decimal](18, 5) NULL,
	[saldofisico] [decimal](18, 5) NULL,
	[costopromedio] [decimal](18, 5) NULL,
	[fechadelaultimaentrada] [datetime] NULL,
	[fechadelaultimasalida] [datetime] NULL,
	[stockminimo] [decimal](18, 5) NULL,
	[stockmaximo] [decimal](18, 5) NULL,
 CONSTRAINT [PK_SALDOS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SINO]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SINO](
	[id] [varchar](1) NULL,
	[nombre] [varchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TALLAS]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TALLAS](
	[id] [int] NULL,
	[nombre] [varchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TIPOSDEAGENTE]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPOSDEAGENTE](
	[id] [int] NULL,
	[nombre] [varchar](30) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TIPOSDECUENTABANCARIA]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPOSDECUENTABANCARIA](
	[id] [int] NULL,
	[nombre] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TIPOSDEDEDOCUMENTO]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPOSDEDEDOCUMENTO](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](100) NULL,
	[abreviatura] [varchar](30) NULL,
	[consecutivo] [decimal](18, 0) NULL,
	[cuentacontabledebito] [varchar](30) NULL,
	[cuentacontablecredito] [varchar](30) NULL,
	[DESPACHA] [varchar](10) NULL,
	[RECIBE] [varchar](10) NULL,
	[PIDEFECHADEVENCIMIENTO] [varchar](1) NULL,
	[pideprograma] [varchar](1) NULL,
	[pideconceptonotadebitocredito] [varchar](1) NULL,
	[pidevendedor] [varchar](1) NULL,
	[pidetipodedocumentoaafectar] [varchar](1) NULL,
	[pideproducto] [varchar](1) NULL,
	[pidetalla] [varchar](1) NULL,
	[pidecolor] [varchar](1) NULL,
	[pideempaque] [varchar](1) NULL,
	[pidecantidad] [varchar](1) NULL,
	[pidevalorunitario] [varchar](1) NULL,
	[pidesubtotal] [varchar](1) NULL,
	[pidedescuentodetalle] [varchar](1) NULL,
	[pideivadetalle] [varchar](1) NULL,
	[pidetipodedocumentoaafectardetalle] [varchar](1) NULL,
	[pideconsecutivoautomatico] [varchar](1) NULL,
	[eldocumentoseimprime] [varchar](1) NULL,
	[esunacompra] [varchar](1) NULL,
	[esunaventa] [varchar](1) NULL,
	[esunpago] [varchar](1) NULL,
	[restarcartera] [varchar](1) NULL,
	[sumarcartera] [varchar](1) NULL,
	[restainventario] [varchar](1) NULL,
	[sumainventario] [varchar](1) NULL,
	[saldarcantidadesdeldocumentollamado] [varchar](1) NULL,
	[leyendaimpresaeneldocumento] [varchar](500) NULL,
	[pidefisico] [varchar](1) NULL,
	[eldocumentoallamarsolosepuedellamarunavez] [varchar](1) NULL,
	[eldocumentoseimprimeanombrededespachaorecibe] [varchar](1) NULL,
	[esunanota] [varchar](1) NULL,
	[esuninventarioinicial] [varchar](1) NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL,
	[titulodespacha] [varchar](50) NULL,
	[titulorecibe] [varchar](50) NULL,
	[transaccionesquepuedellamar] [varchar](10) NULL,
 CONSTRAINT [PK_TABLA_TIPOS_DE_DOCUMENTO] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TIPOSDEPERSONA]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPOSDEPERSONA](
	[id] [varchar](1) NULL,
	[nombre] [varchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TIPOSDEREGIMEN]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPOSDEREGIMEN](
	[id] [int] NULL,
	[nombre] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UNIDADESDEMEDIDA]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UNIDADESDEMEDIDA](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](100) NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL,
 CONSTRAINT [PK_TABLA_UNIDADES_DE_MEDIDA] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USUARIOS]    Script Date: 02/05/2024 21:42:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USUARIOS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AREA] [varchar](100) NULL,
	[NOMBRE] [varchar](100) NULL,
	[CARGO] [varchar](100) NULL,
	[DIRECCION] [varchar](100) NULL,
	[TELEFONO] [varchar](100) NULL,
	[CORREO_ELECTRONICO] [varchar](100) NULL,
	[LOGIN] [varchar](20) NULL,
	[PASSWORD] [varchar](20) NULL,
	[PERFIL] [int] NULL,
	[TIPOSDEDOCUMENTO] [varchar](500) NULL,
	[BODEGA] [int] NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL,
 CONSTRAINT [PK_USUARIOS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ACTIVIDADESECONOMICAS] ON 

INSERT [dbo].[ACTIVIDADESECONOMICAS] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (0, N'No aplica', 1)
INSERT [dbo].[ACTIVIDADESECONOMICAS] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (1, N'pesca', 1)
INSERT [dbo].[ACTIVIDADESECONOMICAS] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (2, N'explotacion de minerales', 1)
INSERT [dbo].[ACTIVIDADESECONOMICAS] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (3, N'informatica...', 1)
INSERT [dbo].[ACTIVIDADESECONOMICAS] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (4, N'arriendo de inmuebles', 1)
INSERT [dbo].[ACTIVIDADESECONOMICAS] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (5, N'militar', 1)
INSERT [dbo].[ACTIVIDADESECONOMICAS] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (6, N'aseo', 1)
INSERT [dbo].[ACTIVIDADESECONOMICAS] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (7, N'aeronautica', 1)
INSERT [dbo].[ACTIVIDADESECONOMICAS] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (18, N'prueba', 1)
SET IDENTITY_INSERT [dbo].[ACTIVIDADESECONOMICAS] OFF
GO
SET IDENTITY_INSERT [dbo].[COLORES] ON 

INSERT [dbo].[COLORES] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (0, N'No aplica', 1)
INSERT [dbo].[COLORES] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (1, N'Azul', 1)
INSERT [dbo].[COLORES] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (2, N'Amarillo', 1)
INSERT [dbo].[COLORES] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (3, N'Rojo', 1)
INSERT [dbo].[COLORES] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (4, N'Fucsia', 1)
INSERT [dbo].[COLORES] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (5, N'Verde', 1)
INSERT [dbo].[COLORES] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (6, N'Naranja', 1)
INSERT [dbo].[COLORES] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (7, N'Blanco', 1)
INSERT [dbo].[COLORES] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (8, N'Negro', 1)
INSERT [dbo].[COLORES] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (9, N'Lavanda', 1)
SET IDENTITY_INSERT [dbo].[COLORES] OFF
GO
SET IDENTITY_INSERT [dbo].[CONCEPTOSNOTADEBITOYCREDITO] ON 

INSERT [dbo].[CONCEPTOSNOTADEBITOYCREDITO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (0, N'No aplica', 1)
INSERT [dbo].[CONCEPTOSNOTADEBITOYCREDITO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (1, N'Menor valor facturado', 1)
INSERT [dbo].[CONCEPTOSNOTADEBITOYCREDITO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (2, N'Se entrego mercancia de mas', 1)
INSERT [dbo].[CONCEPTOSNOTADEBITOYCREDITO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (3, N'Mercancia en mal estado', 1)
INSERT [dbo].[CONCEPTOSNOTADEBITOYCREDITO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (4, N'Mayor valor facturado', 1)
INSERT [dbo].[CONCEPTOSNOTADEBITOYCREDITO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (5, N'La mercancia no lleo', 1)
INSERT [dbo].[CONCEPTOSNOTADEBITOYCREDITO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (6, N'La mercancia llego tarde', 1)
INSERT [dbo].[CONCEPTOSNOTADEBITOYCREDITO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (7, N'Cruce con deuda enterior', 1)
SET IDENTITY_INSERT [dbo].[CONCEPTOSNOTADEBITOYCREDITO] OFF
GO
INSERT [dbo].[ESTADOSDEUNREGISTRO] ([ID], [NOMBRE]) VALUES (1, N'ACTIVO')
INSERT [dbo].[ESTADOSDEUNREGISTRO] ([ID], [NOMBRE]) VALUES (2, N'INTACTIVO')
GO
SET IDENTITY_INSERT [dbo].[FORMASDEPAGO] ON 

INSERT [dbo].[FORMASDEPAGO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (0, N'No aplica', 1)
INSERT [dbo].[FORMASDEPAGO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (1, N'Efectivo', 1)
INSERT [dbo].[FORMASDEPAGO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (2, N'Cheque', 1)
INSERT [dbo].[FORMASDEPAGO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (3, N'T.db', 1)
INSERT [dbo].[FORMASDEPAGO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (4, N'T.cr', 1)
INSERT [dbo].[FORMASDEPAGO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (5, N'Cruce', 1)
INSERT [dbo].[FORMASDEPAGO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (6, N'Voucher', 1)
INSERT [dbo].[FORMASDEPAGO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (7, N'Bono', 1)
INSERT [dbo].[FORMASDEPAGO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (8, N'Cheque Posf.', 1)
INSERT [dbo].[FORMASDEPAGO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (9, N'nota debito', 1)
INSERT [dbo].[FORMASDEPAGO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (10, N'nota credito---', 1)
SET IDENTITY_INSERT [dbo].[FORMASDEPAGO] OFF
GO
SET IDENTITY_INSERT [dbo].[FORMULAS] ON 

INSERT [dbo].[FORMULAS] ([ID], [FORMULA], [COMPONENTE], [CANTIDAD]) VALUES (1, 14, 15, CAST(0.50000 AS Decimal(18, 5)))
INSERT [dbo].[FORMULAS] ([ID], [FORMULA], [COMPONENTE], [CANTIDAD]) VALUES (2, 14, 17, CAST(15.00000 AS Decimal(18, 5)))
INSERT [dbo].[FORMULAS] ([ID], [FORMULA], [COMPONENTE], [CANTIDAD]) VALUES (3, 14, 16, CAST(20.00000 AS Decimal(18, 5)))
INSERT [dbo].[FORMULAS] ([ID], [FORMULA], [COMPONENTE], [CANTIDAD]) VALUES (6, 20, 21, CAST(2.00000 AS Decimal(18, 5)))
INSERT [dbo].[FORMULAS] ([ID], [FORMULA], [COMPONENTE], [CANTIDAD]) VALUES (7, 20, 22, CAST(5.00000 AS Decimal(18, 5)))
SET IDENTITY_INSERT [dbo].[FORMULAS] OFF
GO
SET IDENTITY_INSERT [dbo].[IVAS] ON 

INSERT [dbo].[IVAS] ([ID], [NOMBRE], [porcentaje], [ESTADO_DEL_REGISTRO]) VALUES (0, N'No aplica', CAST(0.00 AS Decimal(5, 2)), 1)
INSERT [dbo].[IVAS] ([ID], [NOMBRE], [porcentaje], [ESTADO_DEL_REGISTRO]) VALUES (1, N'IVA A LAS VENTAS', CAST(19.00 AS Decimal(5, 2)), 1)
INSERT [dbo].[IVAS] ([ID], [NOMBRE], [porcentaje], [ESTADO_DEL_REGISTRO]) VALUES (2, N'IVA AL LICOR..', CAST(35.00 AS Decimal(5, 2)), 1)
SET IDENTITY_INSERT [dbo].[IVAS] OFF
GO
SET IDENTITY_INSERT [dbo].[LOG] ON 

INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4356, N'operacion Modifico Formula
id = 1
Formula = 14
Componente = 15
Cantidad = 0,25
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-09T14:57:26.693' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4357, N'operacion Modifico Formula
id = 1
Formula = 14
Componente = 15
Cantidad = 0,26
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-09T14:57:53.073' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4358, N'operacion Agrego Formula
id = 8
Formula = 14
Componente = 21
Cantidad = 11
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-09T14:59:48.443' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4359, N'operacion Borro Formula
id = 8
Formula = 14
Componente = 21
Cantidad = 11,00000
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-09T15:01:48.920' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4360, N'operacion Agrego Formula
id = 9
Formula = 14
Componente = 21
Cantidad = 11
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-09T15:03:10.567' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4361, N'operacion Borro Formula
id = 9
Formula = 14
Componente = 21
Cantidad = 11,00000
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-09T15:12:56.577' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4362, N'operacion Modifico Productos
id = 15
Nombre = camaron
Unidad de medida = 8
Precion1 = 9500
Costo Ultimo = 4500
Se carga al inventario = N
Codigo iva 1 = 1
NIVEL 1 Materias primasNIVEL 2 carnes de marNIVEL 3 NIVEL 4 NIVEL 5 Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-09T15:50:30.747' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4363, N'operacion Modifico Formula
id = 1
Formula = 14
Componente = 15
Cantidad = 0,26
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-09T15:56:06.643' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4364, N'operacion Modifico Formula
id = 1
Formula = 14
Componente = 15
Cantidad = 0,5
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-16T11:01:57.470' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4365, N'operacion Agrego Producto
id = 24
Nombre = pastel de chocolate
Unidad de medida = 12
Precion1 = 4000
Costo Ultimo = 5000
Se carga al inventario = 
Codigo iva 1 = 1
NIVEL 1 Productos terminadosNIVEL 2 NIVEL 3 NIVEL 4 NIVEL 5 Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-17T15:19:57.277' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4366, N'operacion Modifico Productos
id = 24
Nombre = pastel de chocolate
Unidad de medida = 12
Precion1 = 4000
Costo Ultimo = 5000
Se carga al inventario = 
Codigo iva 1 = 1
NIVEL 1 Productos terminadosNIVEL 2 NIVEL 3 NIVEL 4 NIVEL 5 Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-17T15:36:07.027' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4367, N'operacion Modifico Productos
id = 24
Nombre = pastel de chocolate
Unidad de medida = 12
Precion1 = 4000
Costo Ultimo = 5000
Se carga al inventario = 
Codigo iva 1 = 1
NIVEL 1 Productos terminadosNIVEL 2 NIVEL 3 NIVEL 4 NIVEL 5 Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-17T15:37:57.607' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4368, N'operacion Borro Producto
id = 24
Nombre = pastel de chocolate
Unidad de medida = 12
Precion1 = 4000,00000
Costo Ultimo = 5000,00000
Se carga al inventario = 
Codigo iva 1 = 1
NIVEL 1 Productos terminadosNIVEL 2 NIVEL 3 NIVEL 4 NIVEL 5 Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-17T16:42:22.547' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4369, N'operacion Modifico Iva
id = 1
Nombre = IVA A LAS VENTAS
Porcentaje = 19
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-17T16:58:26.490' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4370, N'operacion Modifico Iva
id = 1
Nombre = IVA A LAS VENTAS
Porcentaje = 19
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-17T17:18:58.680' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4371, N'operacion Modifico Iva
id = 2
Nombre = IVA AL LICOR..
Porcentaje = 35
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-17T17:22:11.107' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4372, N'operacion Modifico Productos
id = 15
Nombre = camaron
Unidad de medida = 8
Precion1 = 9500
Costo Ultimo = 4500
Se carga al inventario = N
Codigo iva 1 = 1
NIVEL 1 Productos terminadosNIVEL 2 carnes de marNIVEL 3 NIVEL 4 NIVEL 5 Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-18T11:58:53.680' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4373, N'operacion Modifico Productos
id = 1
Nombre = pijama nina peterpan
Unidad de medida = 12
Precion1 = 29997
Costo Ultimo = 17000
Se carga al inventario = S
Codigo iva 1 = 1
NIVEL 1 Productos terminadosNIVEL 2 TelasNIVEL 3 NIVEL 4 NIVEL 5 Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-18T12:01:52.070' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4374, N'operacion Modifico Productos
id = 16
Nombre = salsa de tomate
Unidad de medida = 6
Precion1 = 20
Costo Ultimo = 3
Se carga al inventario = 
Codigo iva 1 = 1
NIVEL 1 Materias primasNIVEL 2 condimentosNIVEL 3 condimentos aNIVEL 4 condimentos bNIVEL 5 condimentos cEstado del Registro = A
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-18T12:08:34.693' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4375, N'operacion Modifico Productos
id = 16
Nombre = salsa de tomate
Unidad de medida = 6
Precion1 = 20
Costo Ultimo = 3
Se carga al inventario = 
Codigo iva 1 = 1
NIVEL 1 condimentos bNIVEL 2 condimentosNIVEL 3 NIVEL 4 NIVEL 5 Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-18T12:09:59.427' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4376, N'operacion Modifico Productos
id = 16
Nombre = salsa de tomate
Unidad de medida = 6
Precion1 = 20
Costo Ultimo = 3
Se carga al inventario = 
Codigo iva 1 = 1
NIVEL 1 condimentos bNIVEL 2 condimentosNIVEL 3 condimentos bNIVEL 4 NIVEL 5 Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-18T12:18:32.573' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4377, N'operacion Modifico Productos
id = 16
Nombre = salsa de tomate
Unidad de medida = 6
Precion1 = 20
Costo Ultimo = 3
Se carga al inventario = 
Codigo iva 1 = 1
NIVEL 1 condimentos bNIVEL 2 condimentosNIVEL 3 NIVEL 4 NIVEL 5 Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-18T12:18:49.350' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4378, N'operacion Modifico Programas
id = 1
Nombre = CAJANAL..
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-18T12:53:05.147' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4379, N'operacion Agrego Actividades Economicas
id = 4
Nombre = senado
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-18T12:53:16.237' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4380, N'operacion Borro Actividades Economicas
id = 4
Nombre = senado
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-18T12:53:34.567' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4381, N'operacion Modifico Productos
id = 16
Nombre = salsa de tomate
Unidad de medida = 6
Precion1 = 20
Costo Ultimo = 3
Se carga al inventario = 
Codigo iva 1 = 1
NIVEL 1 Materias primasNIVEL 2 condimentosNIVEL 3 NIVEL 4 NIVEL 5 Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-18T13:23:29.720' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4382, N'operacion Modifico Productos
id = 16
Nombre = salsa de tomate
Unidad de medida = 6
Precion1 = 20
Costo Ultimo = 3
Se carga al inventario = 
Codigo iva 1 = 1
NIVEL 1 aaaaNIVEL 2 condimentosNIVEL 3 NIVEL 4 NIVEL 5 Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-18T13:26:58.690' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4383, N'operacion Modifico Productos
id = 16
Nombre = salsa de tomate
Unidad de medida = 6
Precion1 = 20
Costo Ultimo = 3
Se carga al inventario = 
Codigo iva 1 = 1
NIVEL 1 Productos terminadosNIVEL 2 condimentosNIVEL 3 NIVEL 4 NIVEL 5 Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-18T13:27:18.487' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4384, N'operacion Modifico Productos
id = 16
Nombre = salsa de tomate
Unidad de medida = 6
Precion1 = 20
Costo Ultimo = 3
Se carga al inventario = 
Codigo iva 1 = 1
NIVEL 1 Productos terminadosNIVEL 2 condimentosNIVEL 3 NIVEL 4 NIVEL 5 Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-18T13:27:44.813' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4385, N'operacion Modifico Productos
id = 15
Nombre = camaron
Unidad de medida = 8
Precion1 = 9500
Costo Ultimo = 4500
Se carga al inventario = N
Codigo iva 1 = 1
NIVEL 1 Productos terminadosNIVEL 2 carnes de marNIVEL 3 aaaaNIVEL 4 NIVEL 5 Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-18T13:32:12.917' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4386, N'operacion Modifico Productos
id = 15
Nombre = camaron
Unidad de medida = 8
Precion1 = 9500
Costo Ultimo = 4500
Se carga al inventario = N
Codigo iva 1 = 1
NIVEL 1 Productos terminadosNIVEL 2 carnes de marNIVEL 3 NIVEL 4 NIVEL 5 Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-18T13:32:24.570' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4387, N'operacion Modifico Actividadeseconomicas
id = 7
Nombre = aeronautica....
Estado del Registro = 2
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-18T17:12:58.833' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4388, N'operacion Modifico Actividadeseconomicas
id = 7
Nombre = aeronautica....
Estado del Registro = 1
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-18T17:13:06.767' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4389, N'operacion Modifico Actividadeseconomicas
id = 7
Nombre = aeronautica....
Estado del Registro = 1
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-18T17:13:20.373' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4390, N'operacion Modifico Actividadeseconomicas
id = 7
Nombre = aeronautica
Estado del Registro = 1
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-18T17:14:19.730' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4391, N'operacion Modifico Conceptos Nota Debito Credito
id = 7
Nombre = CRUCE CON UNA DEUDA ANTERIOR      
Estado del Registro = 1
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-18T17:14:45.043' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4392, N'operacion Modifico Formas de pago
id = 10
Nombre = nota credito
Estado del Registro = 1
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-18T17:15:04.493' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4393, N'operacion Modifico menu
id = 8
Orden  = 0101
Nombre = Actividades Economicas
Pagina web = actividadeseconomicas
Estado del Registro = 2
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-18T18:21:47.413' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4394, N'operacion Modifico menu
id = 8
Orden  = 0101
Nombre = Actividades Economicas
Pagina web = actividadeseconomicas
Estado del Registro = 1
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-18T18:21:53.460' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4395, N'operacion Modifico Perfiles
id = 1
Nombre = ADMINISTRADOR
Estado del Registro = 1
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-18T18:22:59.300' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4396, N'operacion Modifico usuario
id = 1
tipos de documento a accesar = ,7=AMBIN,8=AMBIN,9=AMBIN,11=AMBIN,12=AMBIN,14=AMBIN,15=AMBIN,16=AMBIN,17=AMBIN,18=AMBIN,19=AMBIN,20=AMBIN,21=AMBIN,22=AMBIN,23=AMBIN,25=AMBIN,28=AMBIN,29=AMBIN,30=AMBIN,
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-18T19:34:29.277' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4397, N'operacion Modifico usuario
id = 1
tipos de documento a accesar = ,7=AMBIN,8=AMBIN,9=AMBIN,11=AMBIN,12=AMBIN,14=AMBIN,15=AMBIN,16=AMBIN,17=AMBIN,18=AMBIN,19=AMBIN,20=AMBIN,21=AMBIN,22=AMBIN,23=AMBIN,25=AMBIN,28=AMBIN,29=AMBIN,30=AMBIN,
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-18T19:34:29.420' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4398, N'operacion Modifico usuario
id = 1
Area  = SISTEMAS
Nombre = tanya roberts
Cargo = JEFE
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Tipos de documento = ,7=AMBIN,8=AMBIN,9=AMBIN,11=AMBIN,12=AMBIN,14=AMBIN,15=AMBIN,16=AMBIN,17=AMBIN,18=AMBIN,19=AMBIN,20=AMBIN,21=AMBIN,22=AMBIN,23=AMBIN,25=AMBIN,28=AMBIN,29=AMBIN,30=AMBIN,
Estado del Registro = 1
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-18T19:34:32.783' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4399, N'operacion Modifico usuario
id = 2
tipos de documento a accesar = ,7=AMBIN,8=AMBIN,9=AMBIN,11=AMBIN,12=AMBIN,14=AMBIN,15=AMBIN,16=AMBIN,17=AMBIN,18=AMBIN,19=AMBIN,20=AMBIN,21=AMBIN,22=AMBIN,23=AMBIN,25=AMBIN,28=AMBIN,29=AMBIN,30=AMBIN,
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-18T19:34:54.527' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4400, N'operacion Modifico usuario
id = 2
tipos de documento a accesar = ,7=AMBIN,8=AMBIN,9=AMBIN,11=AMBIN,12=AMBIN,14=AMBIN,15=AMBIN,16=AMBIN,17=AMBIN,18=AMBIN,19=AMBIN,20=AMBIN,21=AMBIN,22=AMBIN,23=AMBIN,25=AMBIN,28=AMBIN,29=AMBIN,30=AMBIN,
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-18T19:34:55.090' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4401, N'operacion Modifico usuario
id = 2
Area  = INFORMATICA
Nombre = heather locklead
Cargo = director
direccion = car 123  No 14-26
telefono = 2459696
Correo Electronico = supervisor@hotmail.com
login = REVISOR
password = REVISOR
Perfil = 2
Tipos de documento = ,7=AMBIN,8=AMBIN,9=AMBIN,11=AMBIN,12=AMBIN,14=AMBIN,15=AMBIN,16=AMBIN,17=AMBIN,18=AMBIN,19=AMBIN,20=AMBIN,21=AMBIN,22=AMBIN,23=AMBIN,25=AMBIN,28=AMBIN,29=AMBIN,30=AMBIN,
Estado del Registro = 1
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2024-04-18T19:34:56.437' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4402, N'operacion Modifico Perfiles
id = 1
Nombre = ADMINISTRADOR..
Estado del Registro = 1
Usuario que actualizo =tanya roberts', CAST(N'2024-04-18T20:40:37.023' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4403, N'operacion Modifico Perfiles
id = 1
Nombre = ADMINISTRADOR..
Estado del Registro = 1
Usuario que actualizo =tanya roberts', CAST(N'2024-04-18T20:45:57.380' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4404, N'operacion Modifico Perfiles
id = 2
Nombre = REVISOR..
Estado del Registro = 1
Usuario que actualizo =tanya roberts', CAST(N'2024-04-18T20:46:30.977' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4405, N'operacion Modifico usuario
id = 1
tipos de documento a accesar = ,7=AMBIN,8=AMBIN,9=AMBIN,11=AMBIN,12=AMBIN,14=AMBIN,15=AMBIN,16=AMBIN,17=AMBIN,18=AMBIN,19=AMBIN,20=AMBIN,21=AMBIN,22=AMBIN,23=AMBIN,25=AMBIN,28=AMBIN,29=AMBIN,30=AMBIN,
Usuario que actualizo =tanya roberts', CAST(N'2024-04-18T20:47:29.470' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4406, N'operacion Modifico usuario
id = 1
tipos de documento a accesar = ,7=AMBIN,8=AMBIN,9=AMBIN,11=AMBIN,12=AMBIN,14=AMBIN,15=AMBIN,16=AMBIN,17=AMBIN,18=AMBIN,19=AMBIN,20=AMBIN,21=AMBIN,22=AMBIN,23=AMBIN,25=AMBIN,28=AMBIN,29=AMBIN,30=AMBIN,
Usuario que actualizo =tanya roberts', CAST(N'2024-04-18T20:47:29.607' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4407, N'operacion Modifico usuario
id = 1
Area  = SISTEMAS
Nombre = tanya roberts
Cargo = JEFE
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Tipos de documento = ,7=AMBIN,8=AMBIN,9=AMBIN,11=AMBIN,12=AMBIN,14=AMBIN,15=AMBIN,16=AMBIN,17=AMBIN,18=AMBIN,19=AMBIN,20=AMBIN,21=AMBIN,22=AMBIN,23=AMBIN,25=AMBIN,28=AMBIN,29=AMBIN,30=AMBIN,
Estado del Registro = 1
Usuario que actualizo =tanya roberts', CAST(N'2024-04-18T20:47:33.807' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4408, N'operacion Modifico usuario
id = 2
tipos de documento a accesar = ,7=AMBIN,8=AMBIN,9=AMBIN,11=AMBIN,12=AMBIN,14=AMBIN,15=AMBIN,16=AMBIN,17=AMBIN,18=AMBIN,19=AMBIN,20=AMBIN,21=AMBIN,22=AMBIN,23=AMBIN,25=AMBIN,28=AMBIN,29=AMBIN,30=AMBIN,
Usuario que actualizo =tanya roberts', CAST(N'2024-04-18T20:48:08.813' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4409, N'operacion Modifico usuario
id = 2
Area  = INFORMATICA
Nombre = heather locklead
Cargo = director
direccion = car 123  No 14-26
telefono = 2459696
Correo Electronico = supervisor@hotmail.com
login = REVISOR
password = REVISOR
Perfil = 2
Tipos de documento = ,7=AMBIN,8=AMBIN,9=AMBIN,11=AMBIN,12=AMBIN,14=AMBIN,15=AMBIN,16=AMBIN,17=AMBIN,18=AMBIN,19=AMBIN,20=AMBIN,21=AMBIN,22=AMBIN,23=AMBIN,25=AMBIN,28=AMBIN,29=AMBIN,30=AMBIN,
Estado del Registro = 1
Usuario que actualizo =tanya roberts', CAST(N'2024-04-18T20:48:13.507' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4410, N'operacion Modifico usuario
id = 2
Area  = INFORMATICA
Nombre = heather locklead
Cargo = director
direccion = car 123  No 14-26
telefono = 2459696
Correo Electronico = supervisor@hotmail.com
login = REVISOR
password = REVISOR
Perfil = 2
Tipos de documento = ,7=AMBIN,8=AMBIN,9=AMBIN,11=AMBIN,12=AMBIN,14=AMBIN,15=AMBIN,16=AMBIN,17=AMBIN,18=AMBIN,19=AMBIN,20=AMBIN,21=AMBIN,22=AMBIN,23=AMBIN,25=AMBIN,28=AMBIN,29=AMBIN,30=AMBIN,
Estado del Registro = 1
Usuario que actualizo =tanya roberts', CAST(N'2024-04-18T21:02:07.813' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4411, N'operacion Modifico menu
id = 1
Orden  = 01
Nombre =   TABLAS MAESTRAS...
Pagina web = 
Estado del Registro = 2
Usuario que actualizo =tanya roberts', CAST(N'2024-04-18T21:04:13.507' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4412, N'operacion Modifico menu
id = 1
Orden  = 01
Nombre =   TABLAS MAESTRAS...
Pagina web = 
Estado del Registro = 1
Usuario que actualizo =tanya roberts', CAST(N'2024-04-18T21:04:22.237' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4413, N'operacion Modifico menu
id = 1
Orden  = 01
Nombre =   TABLAS MAESTRAS...
Pagina web = 
Estado del Registro = 2
Usuario que actualizo =tanya roberts', CAST(N'2024-04-18T21:04:44.240' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4414, N'operacion Modifico menu
id = 1
Orden  = 01
Nombre =   TABLAS MAESTRAS...
Pagina web = 
Estado del Registro = 1
Usuario que actualizo =tanya roberts', CAST(N'2024-04-18T21:05:09.097' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4415, N'operacion Modifico Productos
id = 15
Nombre = camaron
Unidad de medida = 8
Precion1 = 9500
Costo Ultimo = 4500
Se carga al inventario = N
Codigo iva 1 = 1
NIVEL 1 Productos terminadosNIVEL 2 carnes de marNIVEL 3 aNIVEL 4 bNIVEL 5 cEstado del Registro = 1
Usuario que actualizo =tanya roberts', CAST(N'2024-04-19T11:06:48.167' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4416, N'operacion Modifico Productos
id = 15
Nombre = camaron
Unidad de medida = 8
Precion1 = 9500
Costo Ultimo = 4500
Se carga al inventario = N
Codigo iva 1 = 1
NIVEL 1 bNIVEL 2 carnes de marNIVEL 3 NIVEL 4 NIVEL 5 Estado del Registro = 1
Usuario que actualizo =tanya roberts', CAST(N'2024-04-19T11:07:21.933' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4417, N'operacion Modifico Productos
id = 15
Nombre = camaron
Unidad de medida = 8
Precion1 = 9500
Costo Ultimo = 4500
Se carga al inventario = N
Codigo iva 1 = 1
NIVEL 1 Productos terminadosNIVEL 2 carnes de marNIVEL 3 NIVEL 4 NIVEL 5 Estado del Registro = 1
Usuario que actualizo =tanya roberts', CAST(N'2024-04-19T11:11:03.477' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4418, N'operacion Agrego Producto
id = 24
Nombre = aaaaaaaa
Unidad de medida = 1
Precion1 = 0
Costo Ultimo = 0
Se carga al inventario = S
Codigo iva 1 = 0
NIVEL 1 stringNIVEL 2 stringNIVEL 3 stringNIVEL 4 stringNIVEL 5 stringEstado del Registro = 0
Usuario que actualizo =tanya roberts', CAST(N'2024-04-19T11:18:49.170' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4419, N'operacion Modifico Color
id = S
Nombre = YEs
Usuario que actualizo =tanya roberts', CAST(N'2024-04-19T11:34:23.450' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4420, N'operacion Modifico Color
id = S
Nombre = Si
Usuario que actualizo =tanya roberts', CAST(N'2024-04-19T11:34:31.423' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4421, N'operacion Modifico Productos
id = 24
Nombre = aaaaaaaa
Unidad de medida = 1
Precion1 = 0
Costo Ultimo = 0
Se carga al inventario = S
Codigo iva 1 = 0
NIVEL 1 stringNIVEL 2 stringNIVEL 3 stringNIVEL 4 stringNIVEL 5 stringEstado del Registro = 0
Usuario que actualizo =tanya roberts', CAST(N'2024-04-19T12:03:49.110' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4422, N'operacion Modifico Productos
id = 24
Nombre = aaaaaaaa
Unidad de medida = 1
Precion1 = 0
Costo Ultimo = 0
Se carga al inventario = N
Codigo iva 1 = 0
NIVEL 1 stringNIVEL 2 stringNIVEL 3 stringNIVEL 4 stringNIVEL 5 stringEstado del Registro = 0
Usuario que actualizo =tanya roberts', CAST(N'2024-04-19T12:04:02.473' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4423, N'operacion Modifico Productos
id = 24
Nombre = aaaaaaaa
Unidad de medida = 1
Precion1 = 0
Costo Ultimo = 0
Se carga al inventario = S
Codigo iva 1 = 0
NIVEL 1 stringNIVEL 2 stringNIVEL 3 stringNIVEL 4 stringNIVEL 5 stringEstado del Registro = 0
Usuario que actualizo =tanya roberts', CAST(N'2024-04-19T12:18:21.283' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4424, N'operacion Borro Producto
id = 24
Nombre = aaaaaaaa
Unidad de medida = 1
Precion1 = 0,00000
Costo Ultimo = 0,00000
Se carga al inventario = S
Codigo iva 1 = 0
NIVEL 1 stringNIVEL 2 stringNIVEL 3 stringNIVEL 4 stringNIVEL 5 stringEstado del Registro = 0
Usuario que actualizo =tanya roberts', CAST(N'2024-04-19T12:18:29.113' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4425, N'operacion Modifico Productos
id = 15
Nombre = camaron
Unidad de medida = 8
Precion1 = 9500
Costo Ultimo = 4500
Se carga al inventario = S
Codigo iva 1 = 1
NIVEL 1 Productos terminadosNIVEL 2 carnes de marNIVEL 3 NIVEL 4 NIVEL 5 Estado del Registro = 1
Usuario que actualizo =tanya roberts', CAST(N'2024-04-19T12:24:44.443' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4426, N'operacion Modifico Productos
id = 15
Nombre = camaron
Unidad de medida = 8
Precion1 = 9500
Costo Ultimo = 4500
Se carga al inventario = S
Codigo iva 1 = 1
NIVEL 1 Productos terminadosNIVEL 2 carnes de marNIVEL 3 NIVEL 4 NIVEL 5 Estado del Registro = 1
Usuario que actualizo =tanya roberts', CAST(N'2024-04-19T12:24:55.480' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4427, N'operacion Modifico Productos
id = 17
Nombre = mayonesa
Unidad de medida = 6
Precion1 = 4
Costo Ultimo = 2
Se carga al inventario = S
Codigo iva 1 = 1
NIVEL 1 Materias primasNIVEL 2 condimentosNIVEL 3 NIVEL 4 NIVEL 5 Estado del Registro = 1
Usuario que actualizo =tanya roberts', CAST(N'2024-04-19T12:25:08.670' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4428, N'operacion Modifico Productos
id = 17
Nombre = mayonesa
Unidad de medida = 6
Precion1 = 4
Costo Ultimo = 2
Se carga al inventario = S
Codigo iva 1 = 1
NIVEL 1 Materias primasNIVEL 2 condimentosNIVEL 3 NIVEL 4 NIVEL 5 Estado del Registro = 1
Usuario que actualizo =tanya roberts', CAST(N'2024-04-19T12:25:12.187' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4429, N'operacion Modifico Productos
id = 1
Nombre = pijama nina peterpan
Unidad de medida = 12
Precion1 = 29997
Costo Ultimo = 17000
Se carga al inventario = S
Codigo iva 1 = 1
NIVEL 1 Productos terminadosNIVEL 2 TelasNIVEL 3 NIVEL 4 NIVEL 5 Estado del Registro = 1
Usuario que actualizo =tanya roberts', CAST(N'2024-04-19T12:25:20.790' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4430, N'operacion Modifico Productos
id = 16
Nombre = salsa de tomate
Unidad de medida = 6
Precion1 = 20
Costo Ultimo = 3
Se carga al inventario = S
Codigo iva 1 = 1
NIVEL 1 Productos terminadosNIVEL 2 condimentosNIVEL 3 NIVEL 4 NIVEL 5 Estado del Registro = 1
Usuario que actualizo =tanya roberts', CAST(N'2024-04-19T12:25:28.323' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4431, N'operacion Modifico Formas de pago
id = 10
Nombre = nota credito---
Estado del Registro = 1
Usuario que actualizo =tanya roberts', CAST(N'2024-04-19T14:41:17.440' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4432, N'operacion Borro Tipos de Documento
id = 34
Nombre = xxxx
pideprograma = 
pideconceptonotadebitocredito = 
pidevendedor = 
pidetipodedocumentoaafectar= 
pideproducto = 
pidetalla = 
pidecolor = 
pideempaque = 
pidecantidad = 
pidevalorunitario = 
pidesubtotal = 
pidedescuentodetalle = 
pideivadetalle = 
pidetipodedocumentoaafectatdetalle = 
pideconsecutivoautomatico = 
eldocumentoseimprime = 
esunacompra = 
esuncaventa = 
esunpago = 
restarcartera= 
sumarcartera = 
restarinventario = 
sumainventario = 
saldarcantidadesdeldocumentollamado = 
leyendaimpresaeneldocumento = 
pidefisico = 
eldocumentoallamarsolosepuedellamarunavez = 
eldocumentoseimprimeanombrededespachaorecibe = 
esunanota = 
esuninventarioinicial = 
titulodespacha  = titulorecibe =transaccionesquepuedellamar =Estado del Registro = 
Usuario que actualizo =tanya roberts', CAST(N'2024-04-19T14:59:46.560' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4433, N'operacion Modifico TiposDeDocumento
id = 7
Nombre = cc nota credito
pideprograma = 
pideconceptonotadebitocredito = 
pidevendedor = 
pidetipodedocumentoaafectar= 
pideproducto = 
pidetalla = 
pidecolor = 
pideempaque = 
pidecantidad = 
pidevalorunitario = 
pidesubtotal = 
pidedescuentodetalle = 
pideivadetalle = 
pidetipodedocumentoaafectatdetalle = 
pideconsecutivoautomatico = 
eldocumentoseimprime = 
esunacompra = 
esuncaventa = 
esunpago = 
restarcartera= 
sumarcartera = 
restarinventario = 
sumainventario = 
saldarcantidadesdeldocumentollamado = 
leyendaimpresaeneldocumento = xxx
pidefisico = 
eldocumentoallamarsolosepuedellamarunavez = 
eldocumentoseimprimeanombrededespachaorecibe = 
esunanota = 
esuninventarioinicial = 
titulodespacha  = titulorecibe =transaccionesquepuedellamar =Estado del Registro = 1
Usuario que actualizo =tanya roberts', CAST(N'2024-04-19T15:30:59.593' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4434, N'operacion Modifico TiposDeDocumento
id = 7
Nombre = cc nota creditomod
pideprograma = 
pideconceptonotadebitocredito = 
pidevendedor = 
pidetipodedocumentoaafectar= 
pideproducto = 
pidetalla = 
pidecolor = 
pideempaque = 
pidecantidad = 
pidevalorunitario = 
pidesubtotal = 
pidedescuentodetalle = 
pideivadetalle = 
pidetipodedocumentoaafectatdetalle = 
pideconsecutivoautomatico = 
eldocumentoseimprime = 
esunacompra = 
esuncaventa = 
esunpago = 
restarcartera= 
sumarcartera = 
restarinventario = 
sumainventario = 
saldarcantidadesdeldocumentollamado = 
leyendaimpresaeneldocumento = xxx
pidefisico = 
eldocumentoallamarsolosepuedellamarunavez = 
eldocumentoseimprimeanombrededespachaorecibe = 
esunanota = 
esuninventarioinicial = 
titulodespacha  = titulorecibe =transaccionesquepuedellamar =Estado del Registro = 1
Usuario que actualizo =tanya roberts', CAST(N'2024-04-19T15:37:07.293' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4435, N'operacion Modifico TiposDeDocumento
id = 7
Nombre = cc nota credito
pideprograma = 
pideconceptonotadebitocredito = 
pidevendedor = 
pidetipodedocumentoaafectar= 
pideproducto = 
pidetalla = 
pidecolor = 
pideempaque = 
pidecantidad = 
pidevalorunitario = 
pidesubtotal = 
pidedescuentodetalle = 
pideivadetalle = 
pidetipodedocumentoaafectatdetalle = 
pideconsecutivoautomatico = 
eldocumentoseimprime = 
esunacompra = 
esuncaventa = 
esunpago = 
restarcartera= 
sumarcartera = 
restarinventario = 
sumainventario = 
saldarcantidadesdeldocumentollamado = 
leyendaimpresaeneldocumento = xxx
pidefisico = 
eldocumentoallamarsolosepuedellamarunavez = 
eldocumentoseimprimeanombrededespachaorecibe = 
esunanota = 
esuninventarioinicial = 
titulodespacha  = titulorecibe =transaccionesquepuedellamar =Estado del Registro = 1
Usuario que actualizo =tanya roberts', CAST(N'2024-04-19T15:37:25.790' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4436, N'operacion Modifico TiposDeDocumento
id = 7
Nombre = cc nota credito
pideprograma = S
pideconceptonotadebitocredito = 
pidevendedor = 
pidetipodedocumentoaafectar= 
pideproducto = 
pidetalla = 
pidecolor = 
pideempaque = 
pidecantidad = 
pidevalorunitario = 
pidesubtotal = 
pidedescuentodetalle = 
pideivadetalle = 
pidetipodedocumentoaafectatdetalle = 
pideconsecutivoautomatico = 
eldocumentoseimprime = 
esunacompra = 
esuncaventa = 
esunpago = 
restarcartera= 
sumarcartera = 
restarinventario = 
sumainventario = 
saldarcantidadesdeldocumentollamado = 
leyendaimpresaeneldocumento = xxx
pidefisico = 
eldocumentoallamarsolosepuedellamarunavez = 
eldocumentoseimprimeanombrededespachaorecibe = 
esunanota = 
esuninventarioinicial = 
titulodespacha  = titulorecibe =transaccionesquepuedellamar =Estado del Registro = 1
Usuario que actualizo =tanya roberts', CAST(N'2024-04-19T15:39:23.723' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4437, N'operacion Agrego Saldo
id = 1342
Bodega = 1
Producto = 1
Saldo inicial = 4
Entradas      = 1
Salidas       = 2
Saldo         = 3
Fecha Ultima entrada = 15/04/2024 0:00:00
Fecha Ultima salida = 16/04/2024 0:00:00
Stock minimo = 10
Stock maximo = 15
Usuario que actualizo =tanya roberts', CAST(N'2024-04-19T17:21:33.173' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4438, N'operacion Modifico Saldo
id = 1342
Bodega = 1
Producto = 1
Saldo inicial = 9
Entradas      = 10
Salidas       = 11
Saldo         = 8
Fecha Ultima entrada = 01/04/2024 0:00:00
Fecha Ultima salida = 02/04/2024 0:00:00
Stock minimo = 10
Stock maximo = 15
Usuario que actualizo =tanya roberts', CAST(N'2024-04-19T18:11:55.637' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4439, N'operacion Modifico Saldo
id = 0
Bodega = 1
Producto = 1
Saldo inicial = 4
Entradas      = 1
Salidas       = 2
Saldo         = 3
Fecha Ultima entrada = 01/04/2024 0:00:00
Fecha Ultima salida = 06/04/2024 0:00:00
Stock minimo = 10
Stock maximo = 15
Usuario que actualizo =tanya roberts', CAST(N'2024-04-19T18:18:24.043' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4440, N'operacion Modifico Tipo de agente
id = 2
Nombre = Banco..
Usuario que actualizo =tanya roberts', CAST(N'2024-04-22T15:26:50.660' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4441, N'operacion Modifico Tipo de agente
id = 1
Nombre = Ahorros..
Usuario que actualizo =tanya roberts', CAST(N'2024-04-22T15:42:10.847' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4442, N'operacion Modifico Color
id = J
Nombre = Juridica..
Usuario que actualizo =tanya roberts', CAST(N'2024-04-22T16:00:20.273' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4443, N'operacion Modifico menu
id = 1
Orden  = 01
Nombre = TABLAS MAESTRAS...
Pagina web = 
Estado del Registro = 1
Usuario que actualizo =tanya roberts', CAST(N'2024-04-22T17:28:29.860' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4444, N'operacion Modifico Perfiles
id = 1
Nombre = ADMINISTRADOR
Estado del Registro = 1
Usuario que actualizo =tanya roberts', CAST(N'2024-04-22T17:41:11.883' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4445, N'operacion Modifico Saldo
id = 0
Bodega = 1
Producto = 1
Talla = 0
Color = 0
Saldo inicial = 0
Entradas      = 0
Salidas       = 0
Saldo         = 0
Fecha Ultima entrada = 24/04/2024 15:25:28
Fecha Ultima salida = 24/04/2024 15:25:28
Stock minimo = 0
Stock maximo = 0
Usuario que actualizo =tanya roberts', CAST(N'2024-04-24T10:25:53.043' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4446, N'operacion Modifico Saldo
id = 0
Bodega = 1
Producto = 1
Talla = 0
Color = 0
Saldo inicial = 0
Entradas      = 0
Salidas       = 0
Saldo         = 0
Fecha Ultima entrada = 24/04/2024 15:25:28
Fecha Ultima salida = 24/04/2024 15:25:28
Stock minimo = 0
Stock maximo = 0
Usuario que actualizo =tanya roberts', CAST(N'2024-04-24T10:29:14.607' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4447, N'operacion Modifico Saldo
id = 0
Bodega = 1
Producto = 14
Talla = 0
Color = 0
Saldo inicial = 0
Entradas      = 0
Salidas       = 0
Saldo         = 0
Fecha Ultima entrada = 24/04/2024 15:25:28
Fecha Ultima salida = 24/04/2024 15:25:28
Stock minimo = 0
Stock maximo = 0
Usuario que actualizo =tanya roberts', CAST(N'2024-04-24T10:29:58.740' AS DateTime))
SET IDENTITY_INSERT [dbo].[LOG] OFF
GO
SET IDENTITY_INSERT [dbo].[MENSAJESDELSISTEMA] ON 

INSERT [dbo].[MENSAJESDELSISTEMA] ([id], [FECHA_DESDE], [FECHA_HASTA], [MENSAJE]) VALUES (3, CAST(N'2024-04-15T00:00:00.000' AS DateTime), CAST(N'2024-04-15T00:00:00.000' AS DateTime), N'buenos dias como esta, debe tomar inventario fisico el 1 de marzo de 2020  para efectos de fin de año y no se le olvide imprimir los formatos y activar los lectores de codigo de barras para la fecha de inicio, recuerde pida asesoria a francisco que va a estar ese dia en linea para apoyarlos en lo que se necesite.')
SET IDENTITY_INSERT [dbo].[MENSAJESDELSISTEMA] OFF
GO
SET IDENTITY_INSERT [dbo].[MENU] ON 

INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (1, N'01', N'TABLAS MAESTRAS...', N'', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (2, N'0101', N'Actividades Economicas', N'actividadeseconomicas', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (4, N'0103', N'Conceptos Nota debito y Credito', N'conceptosnotadebitocredito', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (19, N'0118', N'Tipos de documento', N'tiposdedocumento', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (6, N'0105', N'Formas de pago..', N'formasdepago', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (7, N'0106', N'Formulas', N'formulas', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (8, N'0107', N'Ivas', N'ivas', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (9, N'0108', N'Productos', N'productos', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (10, N'0109', N'Programas', N'programas', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (11, N'0110', N'Proveedores', N'proveedores', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (12, N'0111', N'Retenciones', N'retenciones', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (21, N'0120', N'Unidades de medida', N'unidadesdemedida', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (3, N'0102', N'Colores', N'colores', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (16, N'0115', N'Tipo de persona', N'tiposdepersona', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (15, N'0114', N'Tallas', N'tallas', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (5, N'0104', N'Estados de un registro', N'estadosdeunregistor', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (17, N'0116', N'Tipos de agente', N'tiposdeagente', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (18, N'0117', N'Tipos de cuenta bancaria', N'tiposdecuentabancaria', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (20, N'0119', N'Tipos de regimen', N'tiposderegimen', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (14, N'0113', N'Sino', N'sino', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (13, N'0112', N'Saldos', N'saldos', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (22, N'02', N'  INVENTARIOS', N'', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (24, N'0202', N'Captura de movimiento', N'capturademovimiento', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (33, N'0211', N'kardex', N'Kardex', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (31, N'0209', N'Informe de una transaccion', N'InformeDeUnaTransaccion', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (28, N'0206', N'Cuadro Comparativo entre meses', N'CuadroComparativoEntreMeses', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (30, N'0208', N'Informe de pedidos', N'InformeDePedidos', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (23, N'0201', N'Aprobar traslados', N'AprobarTraslados', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (29, N'0207', N'Extracto de cartera', N'ExtractoDeCartera', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (25, N'0203', N'Cartera por edades', N'CarteraPorEdades', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (27, N'0205', N'Comisiones para vendedores', N'ComisionesParaVendedores', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (34, N'0212', N'Programar pagos', N'ProgramarPagos', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (32, N'0210', N'Interfaz contable', N'InterfazContable', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (26, N'0204', N'Cierre contable', N'CierreContable', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (35, N'03', N'  SEGURIDAD', N'', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (39, N'0305', N'Perfiles', N'perfiles', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (40, N'0306', N'Usuarios.', N'usuarios', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (38, N'0304', N'Menu', N'menu', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (37, N'0302', N'Log', N'log', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (36, N'0301', N'Activar mensaje', N'mensajesdelsistema', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (41, N'04', N'   SERVICIO AL CLIENTE', N'', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (42, N'0401', N'Consultar pedido', N'ConsultarPedido', 1)
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (43, N'0402', N'Pagos.', N'Pagos ', 1)
SET IDENTITY_INSERT [dbo].[MENU] OFF
GO
SET IDENTITY_INSERT [dbo].[PERFILES] ON 

INSERT [dbo].[PERFILES] ([ID], [NOMBRE], [PROGRAMAS], [ESTADO_DEL_REGISTRO]) VALUES (1, N'ADMINISTRADOR', N',41=AMBIN,22=AMBIN,35=AMBIN,36=AMBIN,2=AMBIN,23=AMBIN,24=AMBIN,25=AMBIN,26=AMBIN,3=AMBIN,27=AMBIN,4=AMBIN,42=AMBIN,28=AMBIN,5=AMBIN,29=AMBIN,6=AMBIN,7=AMBIN,30=AMBIN,31=AMBIN,32=AMBIN,8=AMBIN,33=AMBIN,37=AMBIN,38=AMBIN,43=AMBIN,39=AMBIN,9=AMBIN,34=AMBIN,10=AMBIN,11=AMBIN,12=AMBIN,13=AMBIN,14=AMBIN,1=AMBIN,15=AMBIN,16=AMBIN,17=AMBIN,18=AMBIN,19=AMBIN,20=AMBIN,21=AMBIN,40=AMBIN,', 1)
INSERT [dbo].[PERFILES] ([ID], [NOMBRE], [PROGRAMAS], [ESTADO_DEL_REGISTRO]) VALUES (2, N'REVISOR..', N',41=AMBIN,22=AMBIN,35=AMBIN,1=AMBIN,36=AMBIN,2=AMBIN,23=AMBIN,24=AMBIN,25=AMBIN,26=AMBIN,3=AMBIN,27=AMBIN,4=AMBIN,42=AMBIN,28=AMBIN,5=AMBIN,29=AMBIN,6=AMBIN,7=AMBIN,30=AMBIN,31=AMBIN,32=AMBIN,8=AMBIN,33=AMBIN,37=AMBIN,38=AMBIN,43=AMBIN,39=AMBIN,9=AMBIN,34=AMBIN,10=AMBIN,11=AMBIN,12=AMBIN,13=AMBIN,14=AMBIN,15=AMBIN,16=AMBIN,17=AMBIN,18=AMBIN,19=AMBIN,20=AMBIN,21=AMBIN,40=AMBIN,', 1)
SET IDENTITY_INSERT [dbo].[PERFILES] OFF
GO
SET IDENTITY_INSERT [dbo].[PRODUCTOS] ON 

INSERT [dbo].[PRODUCTOS] ([ID], [NOMBRE], [UNIDADDEMEDIDA], [PRECIO1], [COSTOULTIMO], [CODIGOIVA1], [NIVEL1], [NIVEL2], [NIVEL3], [NIVEL4], [NIVEL5], [ESTADO_DEL_REGISTRO], [SECARGAALINVENTARIO]) VALUES (1, N'pijama nina peterpan', 12, CAST(29997.00000 AS Decimal(18, 5)), CAST(17000.00000 AS Decimal(18, 5)), 1, N'Productos terminados', N'Telas', N'', N'', N'', 1, N'S')
INSERT [dbo].[PRODUCTOS] ([ID], [NOMBRE], [UNIDADDEMEDIDA], [PRECIO1], [COSTOULTIMO], [CODIGOIVA1], [NIVEL1], [NIVEL2], [NIVEL3], [NIVEL4], [NIVEL5], [ESTADO_DEL_REGISTRO], [SECARGAALINVENTARIO]) VALUES (14, N'coctel de camarones.', 12, CAST(15150.00000 AS Decimal(18, 5)), CAST(2340.00000 AS Decimal(18, 5)), 1, N'Productos terminados', N'Cocteles', N'', N'', N'', 1, N'')
INSERT [dbo].[PRODUCTOS] ([ID], [NOMBRE], [UNIDADDEMEDIDA], [PRECIO1], [COSTOULTIMO], [CODIGOIVA1], [NIVEL1], [NIVEL2], [NIVEL3], [NIVEL4], [NIVEL5], [ESTADO_DEL_REGISTRO], [SECARGAALINVENTARIO]) VALUES (15, N'camaron', 8, CAST(9500.00000 AS Decimal(18, 5)), CAST(4500.00000 AS Decimal(18, 5)), 1, N'Productos terminados', N'carnes de mar', N'', N'', N'', 1, N'S')
INSERT [dbo].[PRODUCTOS] ([ID], [NOMBRE], [UNIDADDEMEDIDA], [PRECIO1], [COSTOULTIMO], [CODIGOIVA1], [NIVEL1], [NIVEL2], [NIVEL3], [NIVEL4], [NIVEL5], [ESTADO_DEL_REGISTRO], [SECARGAALINVENTARIO]) VALUES (16, N'salsa de tomate', 6, CAST(20.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), 1, N'Productos terminados', N'condimentos', N'', N'', N'', 1, N'S')
INSERT [dbo].[PRODUCTOS] ([ID], [NOMBRE], [UNIDADDEMEDIDA], [PRECIO1], [COSTOULTIMO], [CODIGOIVA1], [NIVEL1], [NIVEL2], [NIVEL3], [NIVEL4], [NIVEL5], [ESTADO_DEL_REGISTRO], [SECARGAALINVENTARIO]) VALUES (17, N'mayonesa', 6, CAST(4.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), 1, N'Materias primas', N'condimentos', N'', N'', N'', 1, N'S')
INSERT [dbo].[PRODUCTOS] ([ID], [NOMBRE], [UNIDADDEMEDIDA], [PRECIO1], [COSTOULTIMO], [CODIGOIVA1], [NIVEL1], [NIVEL2], [NIVEL3], [NIVEL4], [NIVEL5], [ESTADO_DEL_REGISTRO], [SECARGAALINVENTARIO]) VALUES (20, N'coctel de coco loco.', 12, CAST(5050.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), 1, N'Productos terminados', N'Cocteles', N'', N'', N'', 1, N'')
INSERT [dbo].[PRODUCTOS] ([ID], [NOMBRE], [UNIDADDEMEDIDA], [PRECIO1], [COSTOULTIMO], [CODIGOIVA1], [NIVEL1], [NIVEL2], [NIVEL3], [NIVEL4], [NIVEL5], [ESTADO_DEL_REGISTRO], [SECARGAALINVENTARIO]) VALUES (21, N'jugo de coco', 9, CAST(1010.00000 AS Decimal(18, 5)), CAST(850.00000 AS Decimal(18, 5)), 1, N'Productos terminados', N'jugos', N'', N'', N'', 1, N'')
INSERT [dbo].[PRODUCTOS] ([ID], [NOMBRE], [UNIDADDEMEDIDA], [PRECIO1], [COSTOULTIMO], [CODIGOIVA1], [NIVEL1], [NIVEL2], [NIVEL3], [NIVEL4], [NIVEL5], [ESTADO_DEL_REGISTRO], [SECARGAALINVENTARIO]) VALUES (22, N'pina colada', 9, CAST(2020.00000 AS Decimal(18, 5)), CAST(350.00000 AS Decimal(18, 5)), 1, N'Productos terminados', N'Cocteles', N'', N'', N'', 1, N'')
SET IDENTITY_INSERT [dbo].[PRODUCTOS] OFF
GO
SET IDENTITY_INSERT [dbo].[PROGRAMAS] ON 

INSERT [dbo].[PROGRAMAS] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (0, N'No aplica', 1)
INSERT [dbo].[PROGRAMAS] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (1, N'CAJANAL..', 1)
INSERT [dbo].[PROGRAMAS] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (2, N'FERROVIAS', 1)
INSERT [dbo].[PROGRAMAS] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (3, N'ISS...', 1)
SET IDENTITY_INSERT [dbo].[PROGRAMAS] OFF
GO
SET IDENTITY_INSERT [dbo].[PROVEEDORES] ON 

INSERT [dbo].[PROVEEDORES] ([id], [nombre], [direccion], [ciudad], [telefono], [celular1], [celular2], [email1], [email2], [nit], [fechadeingreso], [observaciones], [contactos], [actividadcomercial], [seleretienefuente], [seleretieneiva], [seleretieneica], [puedecobrariva], [espersonanaturalojuridica], [declararenta], [esgrancontribuyente], [tipoderegimen], [TIPO_DE_AGENTE], [CUENTACONTABLE], [codigoderetencionaaplicar], [cuentabancaria], [tipodecuenta], [ESTADO_DEL_REGISTRO], [nivel1], [nivel2], [nivel3], [nivel4], [nivel5]) VALUES (0, N'No Aplica..', N'', N'11001000', N' ', N' ', N'', N'mauriciojaramillopardo@gmail.com', N'', N'1', CAST(N'1900-01-01T00:00:00.000' AS DateTime), N'', N'', 0, N'', N'', N'', N'', N'', N'', N'', 0, 0, NULL, NULL, NULL, NULL, 1, N'No aplica', NULL, NULL, NULL, NULL)
INSERT [dbo].[PROVEEDORES] ([id], [nombre], [direccion], [ciudad], [telefono], [celular1], [celular2], [email1], [email2], [nit], [fechadeingreso], [observaciones], [contactos], [actividadcomercial], [seleretienefuente], [seleretieneiva], [seleretieneica], [puedecobrariva], [espersonanaturalojuridica], [declararenta], [esgrancontribuyente], [tipoderegimen], [TIPO_DE_AGENTE], [CUENTACONTABLE], [codigoderetencionaaplicar], [cuentabancaria], [tipodecuenta], [ESTADO_DEL_REGISTRO], [nivel1], [nivel2], [nivel3], [nivel4], [nivel5]) VALUES (1, N'Materias primas', N' ', N'11001000', N' ', N' ', N'', N'mauriciojaramillopardo@gmail.com', N'', N'2', CAST(N'2005-08-03T00:00:00.000' AS DateTime), N' ', N' ', 0, N'', N'', N'', N'', N'', N'', N'', 0, 0, NULL, NULL, NULL, NULL, 1, N'Colombia', N'Cundinamarca', N'Bogota', N'Bodega', NULL)
INSERT [dbo].[PROVEEDORES] ([id], [nombre], [direccion], [ciudad], [telefono], [celular1], [celular2], [email1], [email2], [nit], [fechadeingreso], [observaciones], [contactos], [actividadcomercial], [seleretienefuente], [seleretieneiva], [seleretieneica], [puedecobrariva], [espersonanaturalojuridica], [declararenta], [esgrancontribuyente], [tipoderegimen], [TIPO_DE_AGENTE], [CUENTACONTABLE], [codigoderetencionaaplicar], [cuentabancaria], [tipodecuenta], [ESTADO_DEL_REGISTRO], [nivel1], [nivel2], [nivel3], [nivel4], [nivel5]) VALUES (2, N'Produccion', N' ', N'11001000', N' ', N' ', N'', N'mauriciojaramillopardo@gmail.com', N'', N'3', CAST(N'2008-01-01T00:00:00.000' AS DateTime), N' ', N' ', 0, N'N', N'N', N'N', N'', N'', N'N', N'N', 0, 0, NULL, NULL, NULL, NULL, 1, N'Colombia', N'Cundinamarca', N'Bogota', N'Bodega', NULL)
INSERT [dbo].[PROVEEDORES] ([id], [nombre], [direccion], [ciudad], [telefono], [celular1], [celular2], [email1], [email2], [nit], [fechadeingreso], [observaciones], [contactos], [actividadcomercial], [seleretienefuente], [seleretieneiva], [seleretieneica], [puedecobrariva], [espersonanaturalojuridica], [declararenta], [esgrancontribuyente], [tipoderegimen], [TIPO_DE_AGENTE], [CUENTACONTABLE], [codigoderetencionaaplicar], [cuentabancaria], [tipodecuenta], [ESTADO_DEL_REGISTRO], [nivel1], [nivel2], [nivel3], [nivel4], [nivel5]) VALUES (3, N'Prod terminado', N'Av Cali No 132-39, Bogota Colombia', N'11001000', N'2455623', N'3112569888', N'3145899669', N'mauriciojaramillopardo@gmail.com', N'', N'456789654-3', CAST(N'2008-01-01T00:00:00.000' AS DateTime), N' ', N' ', 0, N'N', N'N', N'N', N'', N'', N'N', N'N', 0, 0, NULL, NULL, NULL, NULL, 1, N'Colombia', N'Cundinamarca', N'Bogota', N'Bodega', NULL)
INSERT [dbo].[PROVEEDORES] ([id], [nombre], [direccion], [ciudad], [telefono], [celular1], [celular2], [email1], [email2], [nit], [fechadeingreso], [observaciones], [contactos], [actividadcomercial], [seleretienefuente], [seleretieneiva], [seleretieneica], [puedecobrariva], [espersonanaturalojuridica], [declararenta], [esgrancontribuyente], [tipoderegimen], [TIPO_DE_AGENTE], [CUENTACONTABLE], [codigoderetencionaaplicar], [cuentabancaria], [tipodecuenta], [ESTADO_DEL_REGISTRO], [nivel1], [nivel2], [nivel3], [nivel4], [nivel5]) VALUES (10, N'Banco de Colombia', N'Bulervar 1o piso                          ', N'11001000', N'2659863             ', N'03310152659         ', N'3102565623', N'mauriciojaramillopardo@gmail.com', N'2', N'79258698 -1', CAST(N'2005-11-24T00:00:00.000' AS DateTime), N'b', N'c', 3, N'S', N'S', N'S', N'', N'J', N'S', N'S', 2, 2, N'11210101', NULL, NULL, NULL, 1, N'Colombia', N'Cundinamarca', N'Bogota', N'Banco', NULL)
INSERT [dbo].[PROVEEDORES] ([id], [nombre], [direccion], [ciudad], [telefono], [celular1], [celular2], [email1], [email2], [nit], [fechadeingreso], [observaciones], [contactos], [actividadcomercial], [seleretienefuente], [seleretieneiva], [seleretieneica], [puedecobrariva], [espersonanaturalojuridica], [declararenta], [esgrancontribuyente], [tipoderegimen], [TIPO_DE_AGENTE], [CUENTACONTABLE], [codigoderetencionaaplicar], [cuentabancaria], [tipodecuenta], [ESTADO_DEL_REGISTRO], [nivel1], [nivel2], [nivel3], [nivel4], [nivel5]) VALUES (11, N'Banco Ganadero', N'CENTRO COMERCIAL NIZA                                       ', N'11001000', N'2659896             ', N'                    ', N'', N'mauriciojaramillopardo@gmail.com', N'', N'795236598-1', CAST(N'2003-11-21T00:00:00.000' AS DateTime), N'PRESTAMO POR INTERES', N'SANDRA VARGAS', 7, N'N', N'N', N'N', N'', N'J', N'S', N'S', 2, 2, N'11210102', NULL, NULL, NULL, 1, N'Colombia', N'Cundinamarca', N'Bogota', N'Banco', NULL)
INSERT [dbo].[PROVEEDORES] ([id], [nombre], [direccion], [ciudad], [telefono], [celular1], [celular2], [email1], [email2], [nit], [fechadeingreso], [observaciones], [contactos], [actividadcomercial], [seleretienefuente], [seleretieneiva], [seleretieneica], [puedecobrariva], [espersonanaturalojuridica], [declararenta], [esgrancontribuyente], [tipoderegimen], [TIPO_DE_AGENTE], [CUENTACONTABLE], [codigoderetencionaaplicar], [cuentabancaria], [tipodecuenta], [ESTADO_DEL_REGISTRO], [nivel1], [nivel2], [nivel3], [nivel4], [nivel5]) VALUES (12, N'Almacenes Paguemenos                                  ', N'CRA 13 # 58-58 BOGOTA                                       ', N'11001000', N'2365698             ', N'03315658985         ', N'', N'mauriciojaramillopardo@gmail.com', N'', N'96336978-9', CAST(N'2003-11-21T00:00:00.000' AS DateTime), N'MERCANCIA EN CONSIGNACION', N'CARLOS ROMERO', 2, N'S', N'S', N'S', N'', N'J', N'S', N'S', 1, 1, NULL, NULL, NULL, NULL, 1, N'Colombia', N'Cundinamarca', N'Bogota', N'Cliente', NULL)
INSERT [dbo].[PROVEEDORES] ([id], [nombre], [direccion], [ciudad], [telefono], [celular1], [celular2], [email1], [email2], [nit], [fechadeingreso], [observaciones], [contactos], [actividadcomercial], [seleretienefuente], [seleretieneiva], [seleretieneica], [puedecobrariva], [espersonanaturalojuridica], [declararenta], [esgrancontribuyente], [tipoderegimen], [TIPO_DE_AGENTE], [CUENTACONTABLE], [codigoderetencionaaplicar], [cuentabancaria], [tipodecuenta], [ESTADO_DEL_REGISTRO], [nivel1], [nivel2], [nivel3], [nivel4], [nivel5]) VALUES (13, N'Proveedora rioka', N'FACATATIVA                                                  ', N'11001000', N'2011006             ', N'03315636998         ', N'', N'mauriciojaramillopardo@gmail.com', N'', N'963258963-1', CAST(N'2003-11-21T00:00:00.000' AS DateTime), N'RIANURA SELIN', N'CARMENZA FLORES', 2, N'S', N'S', N'S', N'', N'J', N'S', N'S', 1, 3, N'2110101', NULL, NULL, NULL, 1, N'Colombia', N'Cundinamarca', N'Bogota', N'Proveedor', NULL)
INSERT [dbo].[PROVEEDORES] ([id], [nombre], [direccion], [ciudad], [telefono], [celular1], [celular2], [email1], [email2], [nit], [fechadeingreso], [observaciones], [contactos], [actividadcomercial], [seleretienefuente], [seleretieneiva], [seleretieneica], [puedecobrariva], [espersonanaturalojuridica], [declararenta], [esgrancontribuyente], [tipoderegimen], [TIPO_DE_AGENTE], [CUENTACONTABLE], [codigoderetencionaaplicar], [cuentabancaria], [tipodecuenta], [ESTADO_DEL_REGISTRO], [nivel1], [nivel2], [nivel3], [nivel4], [nivel5]) VALUES (14, N'Almacens al costo', N'CALLE 131 KRA 107 AURES II                                  ', N'11001000', N'6875989             ', N'                    ', N'', N'mauriciojaramillopardo@gmail.com', N'', N'125896369-7 ', CAST(N'2005-08-03T00:00:00.000' AS DateTime), N'', N'', 1, N'S', N'S', N'S', N'', N'J', N'S', N'S', 1, 1, NULL, NULL, NULL, NULL, 1, N'Colombia', N'Cundinamarca', N'Bogota', N'Cliente', NULL)
INSERT [dbo].[PROVEEDORES] ([id], [nombre], [direccion], [ciudad], [telefono], [celular1], [celular2], [email1], [email2], [nit], [fechadeingreso], [observaciones], [contactos], [actividadcomercial], [seleretienefuente], [seleretieneiva], [seleretieneica], [puedecobrariva], [espersonanaturalojuridica], [declararenta], [esgrancontribuyente], [tipoderegimen], [TIPO_DE_AGENTE], [CUENTACONTABLE], [codigoderetencionaaplicar], [cuentabancaria], [tipodecuenta], [ESTADO_DEL_REGISTRO], [nivel1], [nivel2], [nivel3], [nivel4], [nivel5]) VALUES (20, N'carlos lopez', N'', N'', N'', N'', N'', N'mauriciojaramillopardo@gmail.com', N'', N'79868400', CAST(N'2019-01-01T00:00:00.000' AS DateTime), N'', N'', 0, N'', N'', N'', N'', N'', N'', N'', 0, 4, NULL, NULL, NULL, NULL, 1, N'Colombia', N'Cundinamarca', N'Bogota', N'Vendedor', NULL)
INSERT [dbo].[PROVEEDORES] ([id], [nombre], [direccion], [ciudad], [telefono], [celular1], [celular2], [email1], [email2], [nit], [fechadeingreso], [observaciones], [contactos], [actividadcomercial], [seleretienefuente], [seleretieneiva], [seleretieneica], [puedecobrariva], [espersonanaturalojuridica], [declararenta], [esgrancontribuyente], [tipoderegimen], [TIPO_DE_AGENTE], [CUENTACONTABLE], [codigoderetencionaaplicar], [cuentabancaria], [tipodecuenta], [ESTADO_DEL_REGISTRO], [nivel1], [nivel2], [nivel3], [nivel4], [nivel5]) VALUES (21, N'maria andara', N'', N'', N'', N'', N'', N'mauriciojaramillopardo@gmail.com', N'', N'75862659', CAST(N'2019-01-01T00:00:00.000' AS DateTime), N'', N'', 0, N'', N'', N'', N'', N'', N'', N'', 0, 4, NULL, NULL, NULL, NULL, 1, N'Colombia', N'Cundinamarca', N'Bogota', N'Vendedor', NULL)
INSERT [dbo].[PROVEEDORES] ([id], [nombre], [direccion], [ciudad], [telefono], [celular1], [celular2], [email1], [email2], [nit], [fechadeingreso], [observaciones], [contactos], [actividadcomercial], [seleretienefuente], [seleretieneiva], [seleretieneica], [puedecobrariva], [espersonanaturalojuridica], [declararenta], [esgrancontribuyente], [tipoderegimen], [TIPO_DE_AGENTE], [CUENTACONTABLE], [codigoderetencionaaplicar], [cuentabancaria], [tipodecuenta], [ESTADO_DEL_REGISTRO], [nivel1], [nivel2], [nivel3], [nivel4], [nivel5]) VALUES (22, N'Proveedora jumbo', N'PLAZA IMPERIAL', N'11001000', N'2568485', N'3102458595', N'', N'mauriciojaramillopardo@gmail.com', N'', N'864562326-9', CAST(N'2003-11-21T00:00:00.000' AS DateTime), N'', N'DANI TREJO', 2, N'S', N'S', N'S', N'', N'J', N'S', N'S', 1, 3, N'2110102', NULL, NULL, NULL, 1, N'Colombia', N'Cundinamarca', N'Bogota', N'Proveedor', NULL)
SET IDENTITY_INSERT [dbo].[PROVEEDORES] OFF
GO
SET IDENTITY_INSERT [dbo].[RETENCIONES] ON 

INSERT [dbo].[RETENCIONES] ([ID], [NOMBRE], [PORCENTAJE], [BASEDELARETENCION], [ESTADO_DEL_REGISTRO]) VALUES (0, N'No aplica..', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[RETENCIONES] ([ID], [NOMBRE], [PORCENTAJE], [BASEDELARETENCION], [ESTADO_DEL_REGISTRO]) VALUES (1, N'RETENCION EN LA FUENTE PERSONAS NATURALES.', CAST(10.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[RETENCIONES] ([ID], [NOMBRE], [PORCENTAJE], [BASEDELARETENCION], [ESTADO_DEL_REGISTRO]) VALUES (2, N'RETENCION EN LA FUENTE PERSONA JURIDICA.', CAST(11.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[RETENCIONES] ([ID], [NOMBRE], [PORCENTAJE], [BASEDELARETENCION], [ESTADO_DEL_REGISTRO]) VALUES (3, N'RETENCION SOBRE IVA', CAST(50.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[RETENCIONES] ([ID], [NOMBRE], [PORCENTAJE], [BASEDELARETENCION], [ESTADO_DEL_REGISTRO]) VALUES (4, N'RETENCION DE INDUSTRIA Y COMERCIO.', CAST(6.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1)
SET IDENTITY_INSERT [dbo].[RETENCIONES] OFF
GO
SET IDENTITY_INSERT [dbo].[SALDOS] ON 

INSERT [dbo].[SALDOS] ([id], [PRODUCTO], [bodega], [saldoinicial], [entradas], [salidas], [saldo], [saldofisico], [costopromedio], [fechadelaultimaentrada], [fechadelaultimasalida], [stockminimo], [stockmaximo]) VALUES (1342, 1, 1, CAST(1.00000 AS Decimal(18, 5)), CAST(1.00000 AS Decimal(18, 5)), CAST(1.00000 AS Decimal(18, 5)), CAST(1.00000 AS Decimal(18, 5)), CAST(1.00000 AS Decimal(18, 5)), CAST(1.00000 AS Decimal(18, 5)), CAST(N'2024-04-24T15:25:28.440' AS DateTime), CAST(N'2024-04-24T15:25:28.440' AS DateTime), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)))
INSERT [dbo].[SALDOS] ([id], [PRODUCTO], [bodega], [saldoinicial], [entradas], [salidas], [saldo], [saldofisico], [costopromedio], [fechadelaultimaentrada], [fechadelaultimasalida], [stockminimo], [stockmaximo]) VALUES (1343, 14, 1, CAST(2.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(N'2023-01-01T00:00:00.000' AS DateTime), CAST(N'2024-02-02T00:00:00.000' AS DateTime), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)))
INSERT [dbo].[SALDOS] ([id], [PRODUCTO], [bodega], [saldoinicial], [entradas], [salidas], [saldo], [saldofisico], [costopromedio], [fechadelaultimaentrada], [fechadelaultimasalida], [stockminimo], [stockmaximo]) VALUES (1344, 15, 1, CAST(3.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(N'2023-01-01T00:00:00.000' AS DateTime), CAST(N'2024-02-03T00:00:00.000' AS DateTime), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)))
INSERT [dbo].[SALDOS] ([id], [PRODUCTO], [bodega], [saldoinicial], [entradas], [salidas], [saldo], [saldofisico], [costopromedio], [fechadelaultimaentrada], [fechadelaultimasalida], [stockminimo], [stockmaximo]) VALUES (1345, 16, 1, CAST(4.00000 AS Decimal(18, 5)), CAST(4.00000 AS Decimal(18, 5)), CAST(4.00000 AS Decimal(18, 5)), CAST(4.00000 AS Decimal(18, 5)), CAST(4.00000 AS Decimal(18, 5)), CAST(4.00000 AS Decimal(18, 5)), CAST(N'2023-01-01T00:00:00.000' AS DateTime), CAST(N'2024-02-04T00:00:00.000' AS DateTime), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)))
INSERT [dbo].[SALDOS] ([id], [PRODUCTO], [bodega], [saldoinicial], [entradas], [salidas], [saldo], [saldofisico], [costopromedio], [fechadelaultimaentrada], [fechadelaultimasalida], [stockminimo], [stockmaximo]) VALUES (1346, 17, 1, CAST(5.00000 AS Decimal(18, 5)), CAST(5.00000 AS Decimal(18, 5)), CAST(5.00000 AS Decimal(18, 5)), CAST(5.00000 AS Decimal(18, 5)), CAST(5.00000 AS Decimal(18, 5)), CAST(5.00000 AS Decimal(18, 5)), CAST(N'2023-01-01T00:00:00.000' AS DateTime), CAST(N'2024-02-05T00:00:00.000' AS DateTime), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)))
INSERT [dbo].[SALDOS] ([id], [PRODUCTO], [bodega], [saldoinicial], [entradas], [salidas], [saldo], [saldofisico], [costopromedio], [fechadelaultimaentrada], [fechadelaultimasalida], [stockminimo], [stockmaximo]) VALUES (1347, 17, 2, CAST(6.00000 AS Decimal(18, 5)), CAST(6.00000 AS Decimal(18, 5)), CAST(6.00000 AS Decimal(18, 5)), CAST(6.00000 AS Decimal(18, 5)), CAST(6.00000 AS Decimal(18, 5)), CAST(6.00000 AS Decimal(18, 5)), CAST(N'2023-01-01T00:00:00.000' AS DateTime), CAST(N'2024-02-06T00:00:00.000' AS DateTime), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)))
INSERT [dbo].[SALDOS] ([id], [PRODUCTO], [bodega], [saldoinicial], [entradas], [salidas], [saldo], [saldofisico], [costopromedio], [fechadelaultimaentrada], [fechadelaultimasalida], [stockminimo], [stockmaximo]) VALUES (1348, 16, 2, CAST(7.00000 AS Decimal(18, 5)), CAST(7.00000 AS Decimal(18, 5)), CAST(7.00000 AS Decimal(18, 5)), CAST(7.00000 AS Decimal(18, 5)), CAST(7.00000 AS Decimal(18, 5)), CAST(7.00000 AS Decimal(18, 5)), CAST(N'2023-01-01T00:00:00.000' AS DateTime), CAST(N'2024-02-07T00:00:00.000' AS DateTime), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)))
SET IDENTITY_INSERT [dbo].[SALDOS] OFF
GO
INSERT [dbo].[SINO] ([id], [nombre]) VALUES (N'S', N'Si')
INSERT [dbo].[SINO] ([id], [nombre]) VALUES (N'N', N'No')
GO
INSERT [dbo].[TALLAS] ([id], [nombre]) VALUES (2, N'2')
INSERT [dbo].[TALLAS] ([id], [nombre]) VALUES (4, N'4')
INSERT [dbo].[TALLAS] ([id], [nombre]) VALUES (6, N'7')
INSERT [dbo].[TALLAS] ([id], [nombre]) VALUES (8, N'8')
INSERT [dbo].[TALLAS] ([id], [nombre]) VALUES (10, N'10')
INSERT [dbo].[TALLAS] ([id], [nombre]) VALUES (12, N'12')
INSERT [dbo].[TALLAS] ([id], [nombre]) VALUES (14, N'14')
INSERT [dbo].[TALLAS] ([id], [nombre]) VALUES (28, N'28')
INSERT [dbo].[TALLAS] ([id], [nombre]) VALUES (30, N'30')
INSERT [dbo].[TALLAS] ([id], [nombre]) VALUES (31, N'31')
INSERT [dbo].[TALLAS] ([id], [nombre]) VALUES (32, N'32')
INSERT [dbo].[TALLAS] ([id], [nombre]) VALUES (33, N'33')
INSERT [dbo].[TALLAS] ([id], [nombre]) VALUES (34, N'34')
INSERT [dbo].[TALLAS] ([id], [nombre]) VALUES (35, N'35')
INSERT [dbo].[TALLAS] ([id], [nombre]) VALUES (36, N'36')
INSERT [dbo].[TALLAS] ([id], [nombre]) VALUES (37, N'37')
INSERT [dbo].[TALLAS] ([id], [nombre]) VALUES (38, N'38')
INSERT [dbo].[TALLAS] ([id], [nombre]) VALUES (39, N'39')
INSERT [dbo].[TALLAS] ([id], [nombre]) VALUES (40, N'40')
INSERT [dbo].[TALLAS] ([id], [nombre]) VALUES (41, N'42')
INSERT [dbo].[TALLAS] ([id], [nombre]) VALUES (42, N'42')
INSERT [dbo].[TALLAS] ([id], [nombre]) VALUES (0, N'No aplica')
GO
INSERT [dbo].[TIPOSDEAGENTE] ([id], [nombre]) VALUES (0, N'Bodega')
INSERT [dbo].[TIPOSDEAGENTE] ([id], [nombre]) VALUES (1, N'Cliente')
INSERT [dbo].[TIPOSDEAGENTE] ([id], [nombre]) VALUES (2, N'Banco..')
INSERT [dbo].[TIPOSDEAGENTE] ([id], [nombre]) VALUES (3, N'Proveedor')
INSERT [dbo].[TIPOSDEAGENTE] ([id], [nombre]) VALUES (4, N'Vendedor')
INSERT [dbo].[TIPOSDEAGENTE] ([id], [nombre]) VALUES (5, N'Cliente/proveedor')
INSERT [dbo].[TIPOSDEAGENTE] ([id], [nombre]) VALUES (6, N'Usuarios')
GO
INSERT [dbo].[TIPOSDECUENTABANCARIA] ([id], [nombre]) VALUES (1, N'Ahorros..')
INSERT [dbo].[TIPOSDECUENTABANCARIA] ([id], [nombre]) VALUES (2, N'Corriente')
GO
SET IDENTITY_INSERT [dbo].[TIPOSDEDEDOCUMENTO] ON 

INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO], [titulodespacha], [titulorecibe], [transaccionesquepuedellamar]) VALUES (0, N'No aplica', N'  ', CAST(0 AS Decimal(18, 0)), N' ', N' ', N' ', N' ', N' ', N' ', N' ', N' ', N' ', N' ', N' ', N' ', N' ', N' ', N' ', N' ', N' ', N' ', N' ', N' ', N' ', N' ', N' ', N' ', N' ', N' ', N' ', N' ', N' ', N' ', N' ', N' ', N' ', N' ', N' ', 1, N' ', N' ', N' ')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO], [titulodespacha], [titulorecibe], [transaccionesquepuedellamar]) VALUES (7, N'cc nota credito', N'ncr', CAST(0 AS Decimal(18, 0)), N'', N'', N'', N'', N'S', N'S', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'xxx', N'', N'', N'', N'', N'', 1, N'', N'', N'')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO], [titulodespacha], [titulorecibe], [transaccionesquepuedellamar]) VALUES (8, N'cc nota debito', N'ndb', CAST(0 AS Decimal(18, 0)), N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', 1, N'', N'', N'')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO], [titulodespacha], [titulorecibe], [transaccionesquepuedellamar]) VALUES (9, N'cc recibo de caja', N'r.caja', CAST(0 AS Decimal(18, 0)), N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', 1, N'', N'', N'')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO], [titulodespacha], [titulorecibe], [transaccionesquepuedellamar]) VALUES (11, N'cp nota debito', N'ndb', CAST(0 AS Decimal(18, 0)), N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', 1, N'', N'', N'')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO], [titulodespacha], [titulorecibe], [transaccionesquepuedellamar]) VALUES (12, N'cp nota credito', N'ncr', CAST(0 AS Decimal(18, 0)), N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', 1, N'', N'', N'')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO], [titulodespacha], [titulorecibe], [transaccionesquepuedellamar]) VALUES (14, N'mp  devolucion al proveedor', N'devolucion', CAST(0 AS Decimal(18, 0)), N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', 1, N'', N'', N'')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO], [titulodespacha], [titulorecibe], [transaccionesquepuedellamar]) VALUES (15, N'inventario fisico.', N'inv fisico', CAST(0 AS Decimal(18, 0)), N'', N'', N'0', N'1', N'S', N'S', N'S', N'S', N'S', N'S', N'S', N'S', N'S', N'S', N'S', N'N', N'N', N'N', N'N', N'N', N'N', N'N', N'N', N'N', N'N', N'N', N'N', N'N', N'N', N'', N'S', N'', N'R', N'N', N'N', 1, N'', N'Bodega', N'')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO], [titulodespacha], [titulorecibe], [transaccionesquepuedellamar]) VALUES (16, N'orden de compra', N'orden comp', CAST(0 AS Decimal(18, 0)), N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', 1, N'', N'', N'')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO], [titulodespacha], [titulorecibe], [transaccionesquepuedellamar]) VALUES (17, N'remision de compra', N'remision', CAST(0 AS Decimal(18, 0)), N'', N'', N'      ', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', 1, N'', N'', N'')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO], [titulodespacha], [titulorecibe], [transaccionesquepuedellamar]) VALUES (18, N'inventario inicial', N'S.inicial', CAST(0 AS Decimal(18, 0)), N'', N'', N'0', N'1', N'S', N'S', N'S', N'S', N'S', N'S', N'S', N'S', N'S', N'S', N'S', N'S', N'S', N'S', N'S', N'S', N'S', N'', N'S', N'S', N'', N'', N'', N'S', N'', N'', N'', N'', N'R', N'', N'S', 1, N'', N'Bodega', N'')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO], [titulodespacha], [titulorecibe], [transaccionesquepuedellamar]) VALUES (19, N'Salidas por ajuste', N'ajuste -', CAST(0 AS Decimal(18, 0)), N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', 1, N'', N'', N'')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO], [titulodespacha], [titulorecibe], [transaccionesquepuedellamar]) VALUES (20, N'Entradas por  ajuste', N'ajuste +', CAST(1 AS Decimal(18, 0)), N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', 1, N'', N'', N'')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO], [titulodespacha], [titulorecibe], [transaccionesquepuedellamar]) VALUES (21, N'devolucion del cliente', N'devolucion', CAST(0 AS Decimal(18, 0)), N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', 1, N'', N'', N'')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO], [titulodespacha], [titulorecibe], [transaccionesquepuedellamar]) VALUES (22, N'pedidos del cliente', N'pedido', CAST(3 AS Decimal(18, 0)), N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', 1, N'', N'', N'')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO], [titulodespacha], [titulorecibe], [transaccionesquepuedellamar]) VALUES (23, N'te remision al cliente ', N'remision', CAST(0 AS Decimal(18, 0)), N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', 1, N'', N'', N'')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO], [titulodespacha], [titulorecibe], [transaccionesquepuedellamar]) VALUES (25, N'traslado', N'Traslado', CAST(0 AS Decimal(18, 0)), N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', 1, N'', N'', N'')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO], [titulodespacha], [titulorecibe], [transaccionesquepuedellamar]) VALUES (28, N'Factura de venta', N'factura', CAST(0 AS Decimal(18, 0)), N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', 1, N'', N'', N'')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO], [titulodespacha], [titulorecibe], [transaccionesquepuedellamar]) VALUES (29, N'pr Orden de produccion', N'Ord.Pro', CAST(0 AS Decimal(18, 0)), N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', 1, N'', N'', N'')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO], [titulodespacha], [titulorecibe], [transaccionesquepuedellamar]) VALUES (30, N'pr Entrega producto terminado', N'Ent.Pro', CAST(0 AS Decimal(18, 0)), N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', 1, N'', N'', N'')
SET IDENTITY_INSERT [dbo].[TIPOSDEDEDOCUMENTO] OFF
GO
INSERT [dbo].[TIPOSDEPERSONA] ([id], [nombre]) VALUES (N'N', N'Natural')
INSERT [dbo].[TIPOSDEPERSONA] ([id], [nombre]) VALUES (N'J', N'Juridica..')
GO
INSERT [dbo].[TIPOSDEREGIMEN] ([id], [nombre]) VALUES (1, N'Comun')
INSERT [dbo].[TIPOSDEREGIMEN] ([id], [nombre]) VALUES (2, N'Simplificado')
GO
SET IDENTITY_INSERT [dbo].[UNIDADESDEMEDIDA] ON 

INSERT [dbo].[UNIDADESDEMEDIDA] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (0, N'No aplica', 1)
INSERT [dbo].[UNIDADESDEMEDIDA] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (1, N'Bolsa', 1)
INSERT [dbo].[UNIDADESDEMEDIDA] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (2, N'Caja..', 1)
INSERT [dbo].[UNIDADESDEMEDIDA] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (3, N'Cms', 1)
INSERT [dbo].[UNIDADESDEMEDIDA] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (4, N'Frasco', 1)
INSERT [dbo].[UNIDADESDEMEDIDA] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (5, N'Grajea', 1)
INSERT [dbo].[UNIDADESDEMEDIDA] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (6, N'Grm', 1)
INSERT [dbo].[UNIDADESDEMEDIDA] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (7, N'Filo', 1)
INSERT [dbo].[UNIDADESDEMEDIDA] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (8, N'lbr', 1)
INSERT [dbo].[UNIDADESDEMEDIDA] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (9, N'litro', 1)
INSERT [dbo].[UNIDADESDEMEDIDA] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (10, N'mililitro', 1)
INSERT [dbo].[UNIDADESDEMEDIDA] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (11, N'Mtr', 1)
INSERT [dbo].[UNIDADESDEMEDIDA] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (12, N'Unidad', 1)
SET IDENTITY_INSERT [dbo].[UNIDADESDEMEDIDA] OFF
GO
SET IDENTITY_INSERT [dbo].[USUARIOS] ON 

INSERT [dbo].[USUARIOS] ([ID], [AREA], [NOMBRE], [CARGO], [DIRECCION], [TELEFONO], [CORREO_ELECTRONICO], [LOGIN], [PASSWORD], [PERFIL], [TIPOSDEDOCUMENTO], [BODEGA], [ESTADO_DEL_REGISTRO]) VALUES (1, N'SISTEMAS', N'tanya roberts', N'JEFE', N'MINCULTURA', N'2565656', N'ADMIN@HOTMAIL.COM', N'ADMIN', N'ADMIN', 1, N',7=AMBIN,8=AMBIN,9=AMBIN,11=AMBIN,12=AMBIN,14=AMBIN,15=AMBIN,16=AMBIN,17=AMBIN,18=AMBIN,19=AMBIN,20=AMBIN,21=AMBIN,22=AMBIN,23=AMBIN,25=AMBIN,28=AMBIN,29=AMBIN,30=AMBIN,', 1, 1)
INSERT [dbo].[USUARIOS] ([ID], [AREA], [NOMBRE], [CARGO], [DIRECCION], [TELEFONO], [CORREO_ELECTRONICO], [LOGIN], [PASSWORD], [PERFIL], [TIPOSDEDOCUMENTO], [BODEGA], [ESTADO_DEL_REGISTRO]) VALUES (2, N'INFORMATICA', N'heather locklead', N'director', N'car 123  No 14-26', N'2459696', N'supervisor@hotmail.com', N'REVISOR', N'REVISOR', 2, N',7=AMBIN,8=AMBIN,9=AMBIN,11=AMBIN,12=AMBIN,14=AMBIN,15=AMBIN,16=AMBIN,17=AMBIN,18=AMBIN,19=AMBIN,20=AMBIN,21=AMBIN,22=AMBIN,23=AMBIN,25=AMBIN,28=AMBIN,29=AMBIN,30=AMBIN,', 1, 1)
SET IDENTITY_INSERT [dbo].[USUARIOS] OFF
GO
/****** Object:  Index [IX_ESTADOSDEUNREGISTRO]    Script Date: 02/05/2024 21:42:39 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_ESTADOSDEUNREGISTRO] ON [dbo].[ESTADOSDEUNREGISTRO]
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK_FORMASDEPAGO]    Script Date: 02/05/2024 21:42:39 ******/
CREATE NONCLUSTERED INDEX [PK_FORMASDEPAGO] ON [dbo].[FORMASDEPAGO]
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_FORMULAS]    Script Date: 02/05/2024 21:42:39 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_FORMULAS] ON [dbo].[FORMULAS]
(
	[FORMULA] ASC,
	[COMPONENTE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_MOVIMIENTODEINVENTARIOS]    Script Date: 02/05/2024 21:42:39 ******/
CREATE NONCLUSTERED INDEX [IX_MOVIMIENTODEINVENTARIOS] ON [dbo].[MOVIMIENTODEINVENTARIOS]
(
	[DESPACHA] ASC,
	[RECIBE] ASC,
	[TIPODEDOCUMENTO] ASC,
	[NUMERODELDOCUMENTO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_MOVIMIENTODEINVENTARIOS_1]    Script Date: 02/05/2024 21:42:39 ******/
CREATE NONCLUSTERED INDEX [IX_MOVIMIENTODEINVENTARIOS_1] ON [dbo].[MOVIMIENTODEINVENTARIOS]
(
	[DESPACHAAAFECTAR] ASC,
	[RECIBEAAFECTAR] ASC,
	[TIPODEDOCUMENTOAAFECTAR] ASC,
	[NUMERODELDOCUMENTOAAFECTAR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_MOVIMIENTODEINVENTARIOS_2]    Script Date: 02/05/2024 21:42:39 ******/
CREATE NONCLUSTERED INDEX [IX_MOVIMIENTODEINVENTARIOS_2] ON [dbo].[MOVIMIENTODEINVENTARIOS]
(
	[TIPODEDOCUMENTO] ASC,
	[NUMERODELDOCUMENTO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_MOVIMIENTODEINVENTARIOS_3]    Script Date: 02/05/2024 21:42:39 ******/
CREATE NONCLUSTERED INDEX [IX_MOVIMIENTODEINVENTARIOS_3] ON [dbo].[MOVIMIENTODEINVENTARIOS]
(
	[TIPODEDOCUMENTO] ASC,
	[FECHA_DE_CREACION] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_MOVIMIENTODEINVENTARIOSTMP]    Script Date: 02/05/2024 21:42:39 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_MOVIMIENTODEINVENTARIOSTMP] ON [dbo].[MOVIMIENTODEINVENTARIOSTMP]
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_MOVIMIENTODEINVENTARIOSTMP_1]    Script Date: 02/05/2024 21:42:39 ******/
CREATE NONCLUSTERED INDEX [IX_MOVIMIENTODEINVENTARIOSTMP_1] ON [dbo].[MOVIMIENTODEINVENTARIOSTMP]
(
	[TIPODEDOCUMENTO] ASC,
	[NUMERODELDOCUMENTO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PRODUCTOS]    Script Date: 02/05/2024 21:42:39 ******/
CREATE NONCLUSTERED INDEX [IX_PRODUCTOS] ON [dbo].[PRODUCTOS]
(
	[NOMBRE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PRODUCTOS_1]    Script Date: 02/05/2024 21:42:39 ******/
CREATE NONCLUSTERED INDEX [IX_PRODUCTOS_1] ON [dbo].[PRODUCTOS]
(
	[NIVEL1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PRODUCTOS_2]    Script Date: 02/05/2024 21:42:39 ******/
CREATE NONCLUSTERED INDEX [IX_PRODUCTOS_2] ON [dbo].[PRODUCTOS]
(
	[NIVEL2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PRODUCTOS_3]    Script Date: 02/05/2024 21:42:39 ******/
CREATE NONCLUSTERED INDEX [IX_PRODUCTOS_3] ON [dbo].[PRODUCTOS]
(
	[NIVEL3] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PRODUCTOS_4]    Script Date: 02/05/2024 21:42:39 ******/
CREATE NONCLUSTERED INDEX [IX_PRODUCTOS_4] ON [dbo].[PRODUCTOS]
(
	[NIVEL4] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PRODUCTOS_5]    Script Date: 02/05/2024 21:42:39 ******/
CREATE NONCLUSTERED INDEX [IX_PRODUCTOS_5] ON [dbo].[PRODUCTOS]
(
	[NIVEL5] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PROVEEDORES]    Script Date: 02/05/2024 21:42:39 ******/
CREATE NONCLUSTERED INDEX [IX_PROVEEDORES] ON [dbo].[PROVEEDORES]
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PROVEEDORES_1]    Script Date: 02/05/2024 21:42:39 ******/
CREATE NONCLUSTERED INDEX [IX_PROVEEDORES_1] ON [dbo].[PROVEEDORES]
(
	[nivel1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PROVEEDORES_2]    Script Date: 02/05/2024 21:42:39 ******/
CREATE NONCLUSTERED INDEX [IX_PROVEEDORES_2] ON [dbo].[PROVEEDORES]
(
	[nivel2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PROVEEDORES_3]    Script Date: 02/05/2024 21:42:39 ******/
CREATE NONCLUSTERED INDEX [IX_PROVEEDORES_3] ON [dbo].[PROVEEDORES]
(
	[nivel3] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PROVEEDORES_4]    Script Date: 02/05/2024 21:42:39 ******/
CREATE NONCLUSTERED INDEX [IX_PROVEEDORES_4] ON [dbo].[PROVEEDORES]
(
	[nivel4] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PROVEEDORES_5]    Script Date: 02/05/2024 21:42:39 ******/
CREATE NONCLUSTERED INDEX [IX_PROVEEDORES_5] ON [dbo].[PROVEEDORES]
(
	[nivel5] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_SALDOS]    Script Date: 02/05/2024 21:42:39 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_SALDOS] ON [dbo].[SALDOS]
(
	[PRODUCTO] ASC,
	[bodega] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_TALLAS]    Script Date: 02/05/2024 21:42:39 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_TALLAS] ON [dbo].[TALLAS]
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SALDOS]  WITH CHECK ADD  CONSTRAINT [FK_SALDOS_SALDOS] FOREIGN KEY([id])
REFERENCES [dbo].[SALDOS] ([id])
GO
ALTER TABLE [dbo].[SALDOS] CHECK CONSTRAINT [FK_SALDOS_SALDOS]
GO
/****** Object:  StoredProcedure [dbo].[borrar]    Script Date: 02/05/2024 21:42:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[borrar]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM SALDOS
	DELETE FROM MOVIMIENTODEINVENTARIOS
	DELETE FROM TMP_MOVIMIENTODEINVENTARIOS
	UPDATE TABLA_TIPOS_DE_DOCUMENTO SET CONSECUTIVO=0;
	DELETE FROM LOG
	UPDATE PROVEEDORES SET CONSECUTIVOCHEQUE=10 WHERE ID=10
	UPDATE PROVEEDORES SET CONSECUTIVOCHEQUE=11 WHERE ID=11

   
END
GO
/****** Object:  StoredProcedure [dbo].[CONSULTARPEDIDOS]    Script Date: 02/05/2024 21:42:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CONSULTARPEDIDOS]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	select 
	TIPODEDOCUMENTO,
	NUMERODELDOCUMENTO,
	FECHADEPROGRAMACIONDELPAGO,
	despacha,
	recibe,
	TIPODEDOCUMENTOAAFECTAR,
	NUMERODELDOCUMENTOAAFECTAR,
	PRODUCTO,
	DETALLE_DEL_PRODUCTO,
	CANTIDADPOREMPAQUE,
	CANTIDAD,
	LA_CANTIDAD_ESTA_DESPACHADA,
	FORMADEPAGO,
	SUBTOTAL,
	VALORDESCUENTO1,
	VALORDESCUENTO2,
	VALORIVA1,
	VALORIVA2,
	VALORRETENCION1,
	VALORRETENCION2,
	VALORNETO,
	EL_DOCUMENTO_ESTA_CANCELADO


	from MOVIMIENTODEINVENTARIOS 
	WHERE TIPODEDOCUMENTO=11 OR TIPODEDOCUMENTO=8
	order by TIPODEDOCUMENTO,NUMERODELDOCUMENTO

END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'la fecha que tiene  impreso el documento' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MOVIMIENTODEINVENTARIOS', @level2type=N'COLUMN',@level2name=N'FECHADELDOCUMENTO'
GO
USE [master]
GO
ALTER DATABASE [inventarios] SET  READ_WRITE 
GO
