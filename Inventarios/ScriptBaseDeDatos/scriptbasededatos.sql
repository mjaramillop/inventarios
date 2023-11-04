USE [master]
GO
/****** Object:  Database [inventarios]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_ABREVIATURA_TIPO_DE_DOCUMENTO]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_CODIGO_NOMBRE_ATRIBUTO_DE_UN_TIPO_DE_DOCUMENTO]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_FECHA_FORMATO_DDMMMAAAA]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_FECHA_FORMATO_DMA]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NIT_DE_LA_TRANSACCION]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_ATRIBUTO_PROVEEDOR]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_ATRIBUTO_TIPO_DE_DOCUMENTO]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_CIUDAD]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_CLASIFICACION_DE_AGENTES]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_CLASIFICACION_DE_MATERIAS_PRIMAS]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_COLOR]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_CONCEPTO_NOTA_DEBITO_CREDITO]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_DEPARTAMENTO]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_DEPARTAMENTO_DE_LA_CIUDAD]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_ESTADO_DEL_REGISTRO]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_FORMA_DE_PAGO]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_PAIS]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_PAIS_DE_LA_CIUDAD]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_PARAMETRO]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_PRODUCTO]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_PROVEEDOR]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_PROVEEDOR_DE_LA_TRANSACCION]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_RETENCION]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_TIPO_DE_AGENTE]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_TIPO_DE_CUENTA_BANCARIA]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_TIPO_DE_DOCUMENTO]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_TIPO_DE_RETENCION]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_UNIDAD_DE_MEDIDA]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRES_RETENCIONES_DE_UN_PROVEEDOR]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_VALOR_CON_COMAS]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_VALOR_DE_UN_ATRIBUTO_TIPO_DE_DOCUMENTO]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  Table [dbo].[ACTIVIDADESECONOMICAS]    Script Date: 2/11/2023 6:43:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACTIVIDADESECONOMICAS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](100) NULL,
	[ESTADO_DEL_REGISTRO] [varchar](1) NULL,
 CONSTRAINT [PK_TABLA_ACTIVIDADES_ECONOMICAS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CIUDADES]    Script Date: 2/11/2023 6:43:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CIUDADES](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CODIGO1] [varchar](10) NOT NULL,
	[NIVEL1] [varchar](30) NOT NULL,
	[CODIGO2] [varchar](10) NULL,
	[NIVEL2] [varchar](30) NULL,
	[CODIGO3] [varchar](10) NULL,
	[NIVEL3] [varchar](30) NULL,
	[CODIGO4] [varchar](10) NULL,
	[NIVEL4] [varchar](30) NULL,
	[CODIGO5] [varchar](10) NULL,
	[NIVEL5] [varchar](30) NULL,
	[ESTADO_DEL_REGISTRO] [varchar](1) NULL,
 CONSTRAINT [PK_CIUDADES] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CLASIFICACIONDEMATERIASPRIMAS]    Script Date: 2/11/2023 6:43:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLASIFICACIONDEMATERIASPRIMAS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CODIGO1] [varchar](10) NULL,
	[NIVEL1] [varchar](30) NOT NULL,
	[CODIGO2] [varchar](10) NULL,
	[NIVEL2] [varchar](30) NOT NULL,
	[CODIGO3] [varchar](10) NULL,
	[NIVEL3] [varchar](30) NOT NULL,
	[CODIGO4] [varchar](10) NULL,
	[NIVEL4] [varchar](30) NOT NULL,
	[CODIGO5] [varchar](10) NULL,
	[NIVEL5] [varchar](30) NOT NULL,
	[ESTADO_DEL_REGISTRO] [varchar](1) NULL,
 CONSTRAINT [PK_TABLA_DE_CLASIFICACION_DE_MATERIAS_PRIMAS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[COLORES]    Script Date: 2/11/2023 6:43:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COLORES](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](50) NULL,
	[ESTADO_DEL_REGISTRO] [varchar](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CONCEPTOSNOTADEBITOYCREDITO]    Script Date: 2/11/2023 6:43:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONCEPTOSNOTADEBITOYCREDITO](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](100) NULL,
	[ESTADO_DEL_REGISTRO] [varchar](1) NULL,
 CONSTRAINT [PK_TABLA_CONCEPTOS_NOTA_DEBITO_Y_CREDITO] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CUENTASBANCARIAS]    Script Date: 2/11/2023 6:43:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CUENTASBANCARIAS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[BANCO] [int] NOT NULL,
	[CUENTA] [varchar](15) NOT NULL,
	[TIPO_DE_CUENTA] [varchar](1) NULL,
	[ESTADO_DEL_REGISTRO] [varchar](1) NULL,
 CONSTRAINT [PK_CUENTAS_BANCARIAS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FORMASDEPAGO]    Script Date: 2/11/2023 6:43:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FORMASDEPAGO](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](100) NULL,
	[ESTADO_DEL_REGISTRO] [varchar](1) NULL,
 CONSTRAINT [PK_TABLA_FORMAS_DE_PAGO] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FORMULAS]    Script Date: 2/11/2023 6:43:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FORMULAS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FORMULA] [varchar](30) NOT NULL,
	[COMPONENTE] [varchar](30) NOT NULL,
	[CANTIDAD] [decimal](18, 5) NULL,
	[ESTADO_DEL_REGISTRO] [varchar](1) NULL,
 CONSTRAINT [PK_FORMULAS_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IVAS]    Script Date: 2/11/2023 6:43:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IVAS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](20) NULL,
	[porcentaje] [decimal](5, 2) NULL,
	[ESTADO_DEL_REGISTRO] [varchar](1) NULL,
 CONSTRAINT [PK_IVAS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LOG]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  Table [dbo].[MENSAJESDELSISTEMA]    Script Date: 2/11/2023 6:43:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MENSAJESDELSISTEMA](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[FECHA_DESDE] [datetime] NULL,
	[FECHA_HASTA] [datetime] NULL,
	[MENSAJE] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MENU]    Script Date: 2/11/2023 6:43:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MENU](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ORDEN] [varchar](10) NOT NULL,
	[NOMBRE] [varchar](100) NULL,
	[PAGINA_WEB] [varchar](300) NULL,
	[ESTADO_DEL_REGISTRO] [varchar](1) NULL,
 CONSTRAINT [PK_MENU] PRIMARY KEY CLUSTERED 
(
	[ORDEN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MOVIMIENTODEINVENTARIOS]    Script Date: 2/11/2023 6:43:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVIMIENTODEINVENTARIOS](
	[ID] [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	[DESPACHA] [int] NOT NULL,
	[RECIBE] [int] NOT NULL,
	[TIPODEDOCUMENTO] [int] NOT NULL,
	[NUMERODELDOCUMENTO] [int] NOT NULL,
	[DESPACHAAAFECTAR] [int] NULL,
	[RECIBEAAFECTAR] [int] NULL,
	[TIPODEDOCUMENTOAAFECTAR] [int] NULL,
	[NUMERODELDOCUMENTOAAFECTAR] [int] NULL,
	[FECHADELDOCUMENTO] [datetime] NULL,
	[FECHADEVENCIMIENTODELDOCUMENTO] [datetime] NULL,
	[PROGRAMA] [int] NULL,
	[VENDEDOR] [int] NULL,
	[FORMADEPAGO] [int] NULL,
	[NUMERODELPAGO] [varchar](50) NULL,
	[BANCO] [int] NULL,
	[CODIGOCONCEPTONOTADEBITOCREDITO] [int] NULL,
	[OBSERVACIONES] [varchar](3000) NULL,
	[FORMULA] [varchar](30) NULL,
	[PRODUCTO] [varchar](30) NULL,
	[DETALLE_DEL_PRODUCTO] [varchar](500) NULL,
	[NUMERODEEMPAQUES] [decimal](18, 0) NULL,
	[UNIDADDEEMPAQUE] [varchar](10) NULL,
	[CANTIDADPOREMPAQUE] [decimal](18, 5) NULL,
	[CANTIDAD] [decimal](18, 5) NULL,
	[VALORUNITARIO] [decimal](18, 5) NULL,
	[COSTODEPRODUCCIONPORUNIDAD] [decimal](18, 5) NULL,
	[COSTOULTIMOPORUNIDAD] [decimal](18, 5) NULL,
	[COSTOPROMEDIOPORUNIDAD] [decimal](18, 5) NULL,
	[COSTOFLETEPORUNIDAD] [decimal](18, 2) NULL,
	[SUBTOTAL] [decimal](18, 5) NULL,
	[CODIGODESCUENTO1] [int] NULL,
	[PORCENTAJEDESCUENTO1] [decimal](5, 2) NULL,
	[VALORDESCUENTO1] [int] NULL,
	[CODIGODESCUENTO2] [int] NULL,
	[PORCENTAJEDESCUENTO2] [decimal](5, 2) NULL,
	[VALORDESCUENTO2] [int] NULL,
	[CODIGOIVA1] [int] NULL,
	[PORCENTAJEDEIVA1] [decimal](5, 2) NULL,
	[VALORIVA1] [int] NULL,
	[CODIGOIVA2] [int] NULL,
	[PORCENTAJEDEIVA2] [decimal](5, 2) NULL,
	[VALORIVA2] [int] NULL,
	[FLETES] [int] NULL,
	[CODIGORETENCION1] [int] NULL,
	[PORCENTAJEDERETENCION1] [numeric](5, 2) NULL,
	[VALORRETENCION1] [int] NULL,
	[CODIGORETENCION2] [int] NULL,
	[PORCENTAJEDERETENCION2] [numeric](5, 2) NULL,
	[VALORRETENCION2] [int] NULL,
	[VALORNETO] [decimal](18, 5) NULL,
	[FECHADEPROGRAMACIONDELPAGO] [datetime] NULL,
	[LA_CANTIDAD_ESTA_DESPACHADA] [varchar](1) NULL,
	[EL_DOCUMENTO_ESTA_CANCELADO] [varchar](1) NULL,
	[SUMA_O_RESTA_EN_INVENTARIO] [varchar](1) NULL,
	[SUMA_O_RESTA_EN_CARTERA] [varchar](1) NULL,
	[ESTADO_DEL_REGISTRO] [varchar](1) NULL,
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
/****** Object:  Table [dbo].[PERFILES]    Script Date: 2/11/2023 6:43:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PERFILES](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](100) NULL,
	[PROGRAMAS] [varchar](500) NULL,
	[ESTADO_DEL_REGISTRO] [varchar](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PRODUCTOS]    Script Date: 2/11/2023 6:43:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTOS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](300) NULL,
	[GENERICO] [varchar](300) NULL,
	[UNIDADDEMEDIDA] [varchar](10) NULL,
	[PRECIO1] [decimal](18, 5) NULL,
	[COSTODEPRODUCCION] [decimal](18, 5) NULL,
	[COSTOULTIMO] [decimal](18, 5) NULL,
	[CODIGOIVA1] [int] NULL,
	[CODIGOIVA2] [int] NULL,
	[CODIGOIVA3] [int] NULL,
	[CLASIFICACION] [int] NULL,
	[CODIGODEBARRAS] [varchar](30) NULL,
	[ESTADO_DEL_REGISTRO] [varchar](1) NULL,
 CONSTRAINT [PK_PRODUCTOS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PROVEEDORES]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
	[CLASIFICACION] [int] NULL,
	[TIPO_DE_AGENTE] [int] NULL,
	[CUENTACONTABLE] [varchar](20) NULL,
	[codigoderetencionaaplicar] [int] NULL,
	[ESTADO_DEL_REGISTRO] [varchar](1) NULL,
 CONSTRAINT [PK_PROVEEDORES] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RETENCIONES]    Script Date: 2/11/2023 6:43:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RETENCIONES](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](300) NOT NULL,
	[PORCENTAJE] [decimal](18, 2) NULL,
	[BASE] [decimal](18, 2) NULL,
	[RETIENESOBREIVA] [varchar](1) NULL,
	[TIPODERETENCION] [int] NULL,
	[ESTADO_DEL_REGISTRO] [varchar](1) NULL,
 CONSTRAINT [PK_RETENCIONES] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SALDOS]    Script Date: 2/11/2023 6:43:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SALDOS](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[PRODUCTO] [varchar](30) NULL,
	[bodega] [int] NULL,
	[saldoinicial] [decimal](18, 5) NULL,
	[entradas] [decimal](18, 5) NULL,
	[salidas] [decimal](18, 5) NULL,
	[saldo] [decimal](18, 5) NULL,
	[saldofisico] [decimal](18, 5) NULL,
	[costoultimo] [decimal](18, 5) NULL,
	[costopromedio] [decimal](18, 5) NULL,
	[fechadelaultimaentrada] [datetime] NULL,
	[fechadelaultimasalida] [datetime] NULL,
	[stockminimo] [decimal](18, 5) NULL,
	[stockmaximo] [decimal](18, 5) NULL,
	[ESTADO_DEL_REGISTRO] [varchar](1) NULL,
 CONSTRAINT [PK_SALDOS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TIPOSDEDEDOCUMENTO]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
	[DESPACHA] [varchar](300) NULL,
	[RECIBE] [varchar](300) NULL,
	[PIDEFECHADELDOCUMENTO] [varchar](20) NULL,
	[PIDEFECHADEVENCIMIENTO] [varchar](20) NULL,
	[pideprograma] [varchar](20) NULL,
	[pideconceptonotadebitocredito] [varchar](20) NULL,
	[pidevendedor] [varchar](20) NULL,
	[pidetipodedocumentoaafectar] [varchar](20) NULL,
	[pideproducto] [varchar](20) NULL,
	[pidetalla] [varchar](20) NULL,
	[pidecolor] [varchar](20) NULL,
	[pideempaque] [varchar](20) NULL,
	[pidecantidad] [varchar](20) NULL,
	[pidevalorunitario] [varchar](20) NULL,
	[pidesubtotal] [varchar](20) NULL,
	[pidedescuentodetalle] [varchar](20) NULL,
	[pideivadetalle] [varchar](20) NULL,
	[pidetipodedocumentoaafectardetalle] [varchar](20) NULL,
	[pideconsecutivoautomatico] [varchar](20) NULL,
	[eldocumentoseimprime] [varchar](20) NULL,
	[esunacompra] [varchar](20) NULL,
	[esunaventa] [varchar](20) NULL,
	[esunpago] [varchar](20) NULL,
	[restarcartera] [varchar](20) NULL,
	[sumarcartera] [varchar](20) NULL,
	[restainventario] [varchar](20) NULL,
	[sumainventario] [varchar](20) NULL,
	[saldarcantidadesdeldocumentollamado] [varchar](20) NULL,
	[leyendaimpresaeneldocumento] [varchar](500) NULL,
	[pidefisico] [varchar](20) NULL,
	[tipoagentedespacha] [varchar](20) NULL,
	[tipoagenterecibe] [varchar](20) NULL,
	[eldocumentoallamarsolosepuedellamarunavez] [varchar](20) NULL,
	[eldocumentoseimprimeanombrededespachaorecibe] [varchar](20) NULL,
	[esunanota] [varchar](20) NULL,
	[esuninventarioinicial] [varchar](20) NULL,
	[ESTADO_DEL_REGISTRO] [varchar](1) NULL,
 CONSTRAINT [PK_TABLA_TIPOS_DE_DOCUMENTO] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TIPOSDEPROGRAMAS]    Script Date: 2/11/2023 6:43:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPOSDEPROGRAMAS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](100) NULL,
	[ESTADO_DEL_REGISTRO] [varchar](1) NULL,
 CONSTRAINT [PK_TABLA_TIPOS_DE_PROGRAMAS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TMP_MOVIMIENTODEINVENTARIOS]    Script Date: 2/11/2023 6:43:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TMP_MOVIMIENTODEINVENTARIOS](
	[ID] [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	[DESPACHA] [int] NOT NULL,
	[RECIBE] [int] NOT NULL,
	[TIPODEDOCUMENTO] [int] NOT NULL,
	[NUMERODELDOCUMENTO] [int] NOT NULL,
	[DESPACHAAAFECTAR] [int] NULL,
	[RECIBEAAFECTAR] [int] NULL,
	[TIPODEDOCUMENTOAAFECTAR] [int] NULL,
	[NUMERODELDOCUMENTOAAFECTAR] [int] NULL,
	[FECHADELDOCUMENTO] [datetime] NULL,
	[FECHADEVENCIMIENTODELDOCUMENTO] [datetime] NULL,
	[PROGRAMA] [int] NULL,
	[VENDEDOR] [int] NULL,
	[FORMADEPAGO] [int] NULL,
	[NUMERODELPAGO] [varchar](50) NULL,
	[BANCO] [int] NULL,
	[CODIGOCONCEPTONOTADEBITOCREDITO] [int] NULL,
	[OBSERVACIONES] [varchar](3000) NULL,
	[FORMULA] [varchar](30) NULL,
	[PRODUCTO] [varchar](30) NULL,
	[DETALLE_DEL_PRODUCTO] [varchar](500) NULL,
	[NUMERODEEMPAQUES] [decimal](18, 0) NULL,
	[UNIDADDEEMPAQUE] [varchar](10) NULL,
	[CANTIDADPOREMPAQUE] [decimal](18, 5) NULL,
	[CANTIDAD] [decimal](18, 5) NULL,
	[VALORUNITARIO] [decimal](18, 5) NULL,
	[COSTODEPRODUCCIONPORUNIDAD] [decimal](18, 5) NULL,
	[COSTOULTIMOPORUNIDAD] [decimal](18, 5) NULL,
	[COSTOPROMEDIOPORUNIDAD] [decimal](18, 5) NULL,
	[COSTOFLETEPORUNIDAD] [decimal](18, 2) NULL,
	[SUBTOTAL] [decimal](18, 5) NULL,
	[CODIGODESCUENTO1] [int] NULL,
	[PORCENTAJEDESCUENTO1] [decimal](5, 2) NULL,
	[VALORDESCUENTO1] [int] NULL,
	[CODIGODESCUENTO2] [int] NULL,
	[PORCENTAJEDESCUENTO2] [decimal](5, 2) NULL,
	[VALORDESCUENTO2] [int] NULL,
	[CODIGOIVA1] [int] NULL,
	[PORCENTAJEDEIVA1] [decimal](5, 2) NULL,
	[VALORIVA1] [int] NULL,
	[CODIGOIVA2] [int] NULL,
	[PORCENTAJEDEIVA2] [decimal](5, 2) NULL,
	[VALORIVA2] [int] NULL,
	[FLETES] [int] NULL,
	[CODIGORETENCION1] [int] NULL,
	[PORCENTAJEDERETENCION1] [numeric](5, 2) NULL,
	[VALORRETENCION1] [int] NULL,
	[CODIGORETENCION2] [int] NULL,
	[PORCENTAJEDERETENCION2] [numeric](5, 2) NULL,
	[VALORRETENCION2] [int] NULL,
	[VALORNETO] [decimal](18, 5) NULL,
	[FECHADEPROGRAMACIONDELPAGO] [datetime] NULL,
	[LA_CANTIDAD_ESTA_DESPACHADA] [varchar](1) NULL,
	[EL_DOCUMENTO_ESTA_CANCELADO] [varchar](1) NULL,
	[SUMA_O_RESTA_EN_INVENTARIO] [varchar](1) NULL,
	[SUMA_O_RESTA_EN_CARTERA] [varchar](1) NULL,
	[ESTADO_DEL_REGISTRO] [varchar](1) NULL,
	[FECHA_DE_CREACION] [datetime] NULL,
	[USUARIO_QUE_ACTUALIZO] [varchar](200) NULL,
	[TRASLADO_RECIBIDO_Y_APROBADO_POR] [varchar](200) NULL,
	[FECHA_TRASLADO_RECIBIDO_Y_APROBADO] [datetime] NULL,
 CONSTRAINT [PK_TMP_MOVIMIENTODEINVENTARIOS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UNIDADESDEMEDIDA]    Script Date: 2/11/2023 6:43:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UNIDADESDEMEDIDA](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](100) NULL,
	[ESTADO_DEL_REGISTRO] [varchar](1) NULL,
 CONSTRAINT [PK_TABLA_UNIDADES_DE_MEDIDA] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USUARIOS]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
	[ESTADO_DEL_REGISTRO] [varchar](1) NULL,
 CONSTRAINT [PK_USUARIOS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ACTIVIDADESECONOMICAS] ON 

INSERT [dbo].[ACTIVIDADESECONOMICAS] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (0, N'No aplica', N'A')
INSERT [dbo].[ACTIVIDADESECONOMICAS] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (1, N'pesca', N'A')
INSERT [dbo].[ACTIVIDADESECONOMICAS] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (2, N'explotacion de minerales', N'A')
INSERT [dbo].[ACTIVIDADESECONOMICAS] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (3, N'informatica', N'A')
INSERT [dbo].[ACTIVIDADESECONOMICAS] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (4, N'arriendo de inmuebles', N'A')
INSERT [dbo].[ACTIVIDADESECONOMICAS] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (5, N'militar', N'A')
INSERT [dbo].[ACTIVIDADESECONOMICAS] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (6, N'aseo', N'A')
INSERT [dbo].[ACTIVIDADESECONOMICAS] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (7, N'aeronatuica', N'A')
SET IDENTITY_INSERT [dbo].[ACTIVIDADESECONOMICAS] OFF
GO
SET IDENTITY_INSERT [dbo].[CIUDADES] ON 

INSERT [dbo].[CIUDADES] ([ID], [CODIGO1], [NIVEL1], [CODIGO2], [NIVEL2], [CODIGO3], [NIVEL3], [CODIGO4], [NIVEL4], [CODIGO5], [NIVEL5], [ESTADO_DEL_REGISTRO]) VALUES (1, N'CO', N'COLOMBIA', N'01', N'CUNDINAMARCA', N'03', N'BOGOTA', NULL, NULL, NULL, N'Sin Asignar', N'A')
INSERT [dbo].[CIUDADES] ([ID], [CODIGO1], [NIVEL1], [CODIGO2], [NIVEL2], [CODIGO3], [NIVEL3], [CODIGO4], [NIVEL4], [CODIGO5], [NIVEL5], [ESTADO_DEL_REGISTRO]) VALUES (2, N'CO ', N'COLOMBIA', N'01', N'CUNDINAMARCA', N'04', N'CHIA', NULL, NULL, NULL, N'MEDELLÍN', N'A')
INSERT [dbo].[CIUDADES] ([ID], [CODIGO1], [NIVEL1], [CODIGO2], [NIVEL2], [CODIGO3], [NIVEL3], [CODIGO4], [NIVEL4], [CODIGO5], [NIVEL5], [ESTADO_DEL_REGISTRO]) VALUES (3, N'CO', N'COLOMBIA', N'01', N'CUNDINAMARCA', N'05', N'SOACHA', NULL, NULL, NULL, N'ABEJORRAL', N'A')
INSERT [dbo].[CIUDADES] ([ID], [CODIGO1], [NIVEL1], [CODIGO2], [NIVEL2], [CODIGO3], [NIVEL3], [CODIGO4], [NIVEL4], [CODIGO5], [NIVEL5], [ESTADO_DEL_REGISTRO]) VALUES (4, N'CO', N'COLOMBIA', N'02', N'ATLANTICO', N'06', N'BARRANQUILLA', NULL, NULL, NULL, N'ABRIAQUÍ', N'A')
SET IDENTITY_INSERT [dbo].[CIUDADES] OFF
GO
SET IDENTITY_INSERT [dbo].[CLASIFICACIONDEMATERIASPRIMAS] ON 

INSERT [dbo].[CLASIFICACIONDEMATERIASPRIMAS] ([ID], [CODIGO1], [NIVEL1], [CODIGO2], [NIVEL2], [CODIGO3], [NIVEL3], [CODIGO4], [NIVEL4], [CODIGO5], [NIVEL5], [ESTADO_DEL_REGISTRO]) VALUES (2, N'1', N'bodega materias primas        ', N'1', N'condimentos                   ', NULL, N'0', NULL, N'0', NULL, N'0', NULL)
INSERT [dbo].[CLASIFICACIONDEMATERIASPRIMAS] ([ID], [CODIGO1], [NIVEL1], [CODIGO2], [NIVEL2], [CODIGO3], [NIVEL3], [CODIGO4], [NIVEL4], [CODIGO5], [NIVEL5], [ESTADO_DEL_REGISTRO]) VALUES (3, N'1', N'bodega materias primas        ', N'2', N'lacteos                       ', NULL, N'0', NULL, N'0', NULL, N'0', NULL)
INSERT [dbo].[CLASIFICACIONDEMATERIASPRIMAS] ([ID], [CODIGO1], [NIVEL1], [CODIGO2], [NIVEL2], [CODIGO3], [NIVEL3], [CODIGO4], [NIVEL4], [CODIGO5], [NIVEL5], [ESTADO_DEL_REGISTRO]) VALUES (4, N'1', N'bodega materias primas        ', N'3', N'licores                       ', NULL, N'0', NULL, N'0', NULL, N'0', NULL)
INSERT [dbo].[CLASIFICACIONDEMATERIASPRIMAS] ([ID], [CODIGO1], [NIVEL1], [CODIGO2], [NIVEL2], [CODIGO3], [NIVEL3], [CODIGO4], [NIVEL4], [CODIGO5], [NIVEL5], [ESTADO_DEL_REGISTRO]) VALUES (5, N'1', N'bodega materias primas        ', N'4', N'carnicos                      ', NULL, N'0', NULL, N'0', NULL, N'0', NULL)
INSERT [dbo].[CLASIFICACIONDEMATERIASPRIMAS] ([ID], [CODIGO1], [NIVEL1], [CODIGO2], [NIVEL2], [CODIGO3], [NIVEL3], [CODIGO4], [NIVEL4], [CODIGO5], [NIVEL5], [ESTADO_DEL_REGISTRO]) VALUES (6, N'1', N'bodega materias primas        ', N'5', N'carnicos de mar               ', NULL, N'0', NULL, N'0', NULL, N'0', NULL)
INSERT [dbo].[CLASIFICACIONDEMATERIASPRIMAS] ([ID], [CODIGO1], [NIVEL1], [CODIGO2], [NIVEL2], [CODIGO3], [NIVEL3], [CODIGO4], [NIVEL4], [CODIGO5], [NIVEL5], [ESTADO_DEL_REGISTRO]) VALUES (7, N'1', N'bodega materias primas        ', N'6', N'frutas..', NULL, N'0', NULL, N'0', NULL, N'0', NULL)
INSERT [dbo].[CLASIFICACIONDEMATERIASPRIMAS] ([ID], [CODIGO1], [NIVEL1], [CODIGO2], [NIVEL2], [CODIGO3], [NIVEL3], [CODIGO4], [NIVEL4], [CODIGO5], [NIVEL5], [ESTADO_DEL_REGISTRO]) VALUES (8, N'1', N'bodega materias primas        ', N'7', N'granos                        ', NULL, N'0', NULL, N'0', NULL, N'0', NULL)
INSERT [dbo].[CLASIFICACIONDEMATERIASPRIMAS] ([ID], [CODIGO1], [NIVEL1], [CODIGO2], [NIVEL2], [CODIGO3], [NIVEL3], [CODIGO4], [NIVEL4], [CODIGO5], [NIVEL5], [ESTADO_DEL_REGISTRO]) VALUES (9, N'1', N'bodega materias primas        ', N'8', N'verduras', NULL, N'0', NULL, N'0', NULL, N'0', NULL)
INSERT [dbo].[CLASIFICACIONDEMATERIASPRIMAS] ([ID], [CODIGO1], [NIVEL1], [CODIGO2], [NIVEL2], [CODIGO3], [NIVEL3], [CODIGO4], [NIVEL4], [CODIGO5], [NIVEL5], [ESTADO_DEL_REGISTRO]) VALUES (12, N'3', N'bodega de productos terminados', N'1', N'platos                        ', NULL, N'0', NULL, N'0', NULL, N'0', NULL)
INSERT [dbo].[CLASIFICACIONDEMATERIASPRIMAS] ([ID], [CODIGO1], [NIVEL1], [CODIGO2], [NIVEL2], [CODIGO3], [NIVEL3], [CODIGO4], [NIVEL4], [CODIGO5], [NIVEL5], [ESTADO_DEL_REGISTRO]) VALUES (13, N'3', N'bodega de productos terminados', N'2', N'cocteles                      ', NULL, N'0', NULL, N'0', NULL, N'0', NULL)
SET IDENTITY_INSERT [dbo].[CLASIFICACIONDEMATERIASPRIMAS] OFF
GO
SET IDENTITY_INSERT [dbo].[COLORES] ON 

INSERT [dbo].[COLORES] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (0, N'No aplica', N'A')
INSERT [dbo].[COLORES] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (1, N'Azul', N'A')
INSERT [dbo].[COLORES] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (2, N'Amarillo', N'A')
INSERT [dbo].[COLORES] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (3, N'Rojo', N'A')
INSERT [dbo].[COLORES] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (4, N'Fucsia', N'A')
INSERT [dbo].[COLORES] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (5, N'Verde', N'A')
INSERT [dbo].[COLORES] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (6, N'Naranja', N'A')
INSERT [dbo].[COLORES] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (7, N'Blanco', N'A')
INSERT [dbo].[COLORES] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (8, N'Negro', N'A')
INSERT [dbo].[COLORES] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (9, N'Lavanda', N'A')
SET IDENTITY_INSERT [dbo].[COLORES] OFF
GO
SET IDENTITY_INSERT [dbo].[CONCEPTOSNOTADEBITOYCREDITO] ON 

INSERT [dbo].[CONCEPTOSNOTADEBITOYCREDITO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (0, N'No aplica', N'A')
INSERT [dbo].[CONCEPTOSNOTADEBITOYCREDITO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (1, N'MENOR VALOR FACTURADO                                       ', N'A')
INSERT [dbo].[CONCEPTOSNOTADEBITOYCREDITO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (2, N'SE ENTREGO MERCANCIA DE MAS', N'A')
INSERT [dbo].[CONCEPTOSNOTADEBITOYCREDITO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (3, N'SE ENTREGO MERCANCIA EN MAL ESTADO                          ', N'A')
INSERT [dbo].[CONCEPTOSNOTADEBITOYCREDITO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (4, N'MAYOR VALOR FACTURADO                                       ', N'A')
INSERT [dbo].[CONCEPTOSNOTADEBITOYCREDITO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (5, N'LA MERCANCIA NO LLEGO                                       ', N'A')
INSERT [dbo].[CONCEPTOSNOTADEBITOYCREDITO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (6, N'LA MERCANCIA LLEGO TARDE                                    ', N'A')
INSERT [dbo].[CONCEPTOSNOTADEBITOYCREDITO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (7, N'CRUCE CON UNA DEUDA ANTERIOR                                ', N'A')
SET IDENTITY_INSERT [dbo].[CONCEPTOSNOTADEBITOYCREDITO] OFF
GO
SET IDENTITY_INSERT [dbo].[CUENTASBANCARIAS] ON 

INSERT [dbo].[CUENTASBANCARIAS] ([ID], [BANCO], [CUENTA], [TIPO_DE_CUENTA], [ESTADO_DEL_REGISTRO]) VALUES (1, 10, N'123456', N'1', N'A')
INSERT [dbo].[CUENTASBANCARIAS] ([ID], [BANCO], [CUENTA], [TIPO_DE_CUENTA], [ESTADO_DEL_REGISTRO]) VALUES (2, 11, N'1234567890', N'1', N'A')
INSERT [dbo].[CUENTASBANCARIAS] ([ID], [BANCO], [CUENTA], [TIPO_DE_CUENTA], [ESTADO_DEL_REGISTRO]) VALUES (16, 10, N'123456789', N'1', N'A')
INSERT [dbo].[CUENTASBANCARIAS] ([ID], [BANCO], [CUENTA], [TIPO_DE_CUENTA], [ESTADO_DEL_REGISTRO]) VALUES (17, 11, N'987654321', N'2', N'A')
SET IDENTITY_INSERT [dbo].[CUENTASBANCARIAS] OFF
GO
SET IDENTITY_INSERT [dbo].[FORMASDEPAGO] ON 

INSERT [dbo].[FORMASDEPAGO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (0, N'No aplica', N'A')
INSERT [dbo].[FORMASDEPAGO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (1, N'Efectivo', N'A')
INSERT [dbo].[FORMASDEPAGO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (2, N'Cheque', N'A')
INSERT [dbo].[FORMASDEPAGO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (3, N'T.db', N'A')
INSERT [dbo].[FORMASDEPAGO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (4, N'T.cr', N'A')
INSERT [dbo].[FORMASDEPAGO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (5, N'Cruce', N'A')
INSERT [dbo].[FORMASDEPAGO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (6, N'Voucher', N'A')
INSERT [dbo].[FORMASDEPAGO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (7, N'Bono', N'A')
INSERT [dbo].[FORMASDEPAGO] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (8, N'Cheque Posf.', NULL)
SET IDENTITY_INSERT [dbo].[FORMASDEPAGO] OFF
GO
SET IDENTITY_INSERT [dbo].[FORMULAS] ON 

INSERT [dbo].[FORMULAS] ([ID], [FORMULA], [COMPONENTE], [CANTIDAD], [ESTADO_DEL_REGISTRO]) VALUES (1, N'14', N'15', CAST(0.25000 AS Decimal(18, 5)), N'A')
INSERT [dbo].[FORMULAS] ([ID], [FORMULA], [COMPONENTE], [CANTIDAD], [ESTADO_DEL_REGISTRO]) VALUES (2, N'14', N'17', CAST(15.00000 AS Decimal(18, 5)), N'A')
INSERT [dbo].[FORMULAS] ([ID], [FORMULA], [COMPONENTE], [CANTIDAD], [ESTADO_DEL_REGISTRO]) VALUES (3, N'14', N'16', CAST(20.00000 AS Decimal(18, 5)), N'A')
INSERT [dbo].[FORMULAS] ([ID], [FORMULA], [COMPONENTE], [CANTIDAD], [ESTADO_DEL_REGISTRO]) VALUES (4, N'18', N'15', CAST(3.00000 AS Decimal(18, 5)), N'A')
INSERT [dbo].[FORMULAS] ([ID], [FORMULA], [COMPONENTE], [CANTIDAD], [ESTADO_DEL_REGISTRO]) VALUES (5, N'18', N'16', CAST(15.00000 AS Decimal(18, 5)), N'A')
INSERT [dbo].[FORMULAS] ([ID], [FORMULA], [COMPONENTE], [CANTIDAD], [ESTADO_DEL_REGISTRO]) VALUES (6, N'20', N'21', CAST(2.00000 AS Decimal(18, 5)), N'A')
INSERT [dbo].[FORMULAS] ([ID], [FORMULA], [COMPONENTE], [CANTIDAD], [ESTADO_DEL_REGISTRO]) VALUES (7, N'20', N'22', CAST(5.00000 AS Decimal(18, 5)), N'A')
SET IDENTITY_INSERT [dbo].[FORMULAS] OFF
GO
SET IDENTITY_INSERT [dbo].[IVAS] ON 

INSERT [dbo].[IVAS] ([ID], [NOMBRE], [porcentaje], [ESTADO_DEL_REGISTRO]) VALUES (0, N'NINGUNO', CAST(0.00 AS Decimal(5, 2)), NULL)
INSERT [dbo].[IVAS] ([ID], [NOMBRE], [porcentaje], [ESTADO_DEL_REGISTRO]) VALUES (1, N'IVA A LAS VENTAS', CAST(16.00 AS Decimal(5, 2)), N'')
INSERT [dbo].[IVAS] ([ID], [NOMBRE], [porcentaje], [ESTADO_DEL_REGISTRO]) VALUES (2, N'IVA AL LICOR..', CAST(35.00 AS Decimal(5, 2)), NULL)
SET IDENTITY_INSERT [dbo].[IVAS] OFF
GO
SET IDENTITY_INSERT [dbo].[LOG] ON 

INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4115, N'operacion Modifico Actividadeseconomicas
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 7
Nombre = aeronatuica
Estado del Registro = 
Fecha de creacion = 28/09/2018 2:40:05 p. m.
Fecha de actualizacion = 23/10/2023 5:07:24 p. m.
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-23T17:11:36.163' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4116, N'operacion Modifico Actividadeseconomicas
Usuario  ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE
id = 1
Nombre = pesca..
Estado del Registro = 
Fecha de creacion = 
Fecha de actualizacion = 27/09/2018 11:52:52 a. m.
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-23T17:12:12.380' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4117, N'operacion Modifico Actividadeseconomicas
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 7
Nombre = aeronatuica...
Estado del Registro = 
Fecha de creacion = 28/09/2018 2:40:05 p. m.
Fecha de actualizacion = 23/10/2023 5:11:36 p. m.
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-23T17:22:25.153' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4118, N'operacion Agrego Actividades Economicas
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 15
Nombre = sexis
Estado del Registro = 
Fecha de creacion = 23/10/2023 5:22:37 p. m.
Fecha de actualizacion = 23/10/2023 5:22:37 p. m.
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-23T17:22:37.503' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4119, N'operacion Borro Actividades Economicas
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 15
Nombre = sexis
Estado del Registro = 
Fecha de creacion = 23/10/2023 5:22:37 p. m.
Fecha de actualizacion = 23/10/2023 5:22:37 p. m.
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-23T17:22:51.163' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4120, N'operacion Modifico menu
Usuario  
id = 7
Orden  = 01
Nombre = TABLAS MAESTRAS
Pagina web = 
Estado del Registro = 
Fecha de creacion = 
Fecha de actualizacion = 
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-23T17:52:57.657' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4121, N'operacion Modifico menu
Usuario  
id = 3
Orden  = 0302
Nombre = Usuarios
Pagina web = usuarios
Estado del Registro = A
Fecha de creacion = 
Fecha de actualizacion = 
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-23T17:53:09.623' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4122, N'operacion Modifico menu
Usuario  
id = 3
Orden  = 0302
Nombre = Usuarios..
Pagina web = usuarios
Estado del Registro = 
Fecha de creacion = 
Fecha de actualizacion = 
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-23T17:53:29.640' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4123, N'operacion Modifico menu
Usuario  
id = 8
Orden  = 0101
Nombre = Actividades Economicas
Pagina web = actividadeseconomicas
Estado del Registro = 
Fecha de creacion = 
Fecha de actualizacion = 
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-23T17:58:29.820' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4124, N'operacion Modifico menu
Usuario  
id = 7
Orden  = 01
Nombre = TABLAS MAESTRAS...
Pagina web = 
Estado del Registro = 
Fecha de creacion = 
Fecha de actualizacion = 
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-23T18:02:48.987' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4125, N'operacion Modifico menu
Usuario  
id = 7
Orden  = 01
Nombre = TABLAS MAESTRAS.......
Pagina web = 
Estado del Registro = 
Fecha de creacion = 
Fecha de actualizacion = 
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-23T18:03:04.667' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4126, N'operacion Modifico menu
Usuario  
id = 7
Orden  = 01
Nombre = TABLAS MAESTRAS
Pagina web = 
Estado del Registro = 
Fecha de creacion = 
Fecha de actualizacion = 
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-23T18:03:16.177' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4127, N'operacion Modifico menu
Usuario  
id = 2
Orden  = 0301
Nombre = Perfiles
Pagina web = perfiles
Estado del Registro = A
Fecha de creacion = 
Fecha de actualizacion = 
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-23T18:06:55.027' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4128, N'operacion Modifico menu
Usuario  
id = 2
Orden  = 0301
Nombre = Perfiles
Pagina web = perfiles
Estado del Registro = 
Fecha de creacion = 
Fecha de actualizacion = 
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-23T18:07:17.867' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4129, N'operacion Modifico menu
Usuario  
id = 8
Orden  = 0101
Nombre = Actividades Economicas
Pagina web = actividadeseconomicas
Estado del Registro = A
Fecha de creacion = 
Fecha de actualizacion = 
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-23T18:18:07.497' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4130, N'operacion Modifico menu
Usuario  
id = 8
Orden  = 0101
Nombre = Actividades Economicas
Pagina web = actividadeseconomicas
Estado del Registro = 
Fecha de creacion = 
Fecha de actualizacion = 
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-23T18:18:49.210' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4131, N'operacion Agrego menu
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 101
Orden  = 0120
Nombre = xxxxx
Pagina web = xxx
Estado del Registro = A
Fecha de creacion = 23/10/2023 6:19:15 p. m.
Fecha de actualizacion = 23/10/2023 6:19:15 p. m.
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-23T18:19:15.940' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4132, N'operacion Borro menu
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 101
Orden  = 0120
Nombre = xxxxx
Pagina web = xxx
Estado del Registro = A
Fecha de creacion = 23/10/2023 6:19:15 p. m.
Fecha de actualizacion = 23/10/2023 6:19:15 p. m.
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-23T18:19:27.913' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4133, N'operacion Agrego Actividades Economicas
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 16
Nombre = xxxx
Estado del Registro = 
Fecha de creacion = 23/10/2023 6:22:59 p. m.
Fecha de actualizacion = 23/10/2023 6:22:59 p. m.
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-23T18:22:59.157' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4134, N'operacion Borro Actividades Economicas
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 16
Nombre = xxxx
Estado del Registro = 
Fecha de creacion = 23/10/2023 6:22:59 p. m.
Fecha de actualizacion = 23/10/2023 6:22:59 p. m.
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-23T18:23:08.800' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4135, N'operacion Agrego menu
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 102
Orden  = 0403
Nombre = lllllll
Pagina web = lll
Estado del Registro = 
Fecha de creacion = 23/10/2023 6:24:00 p. m.
Fecha de actualizacion = 23/10/2023 6:24:00 p. m.
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-23T18:24:00.763' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4136, N'operacion Borro menu
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 102
Orden  = 0403
Nombre = lllllll
Pagina web = lll
Estado del Registro = 
Fecha de creacion = 23/10/2023 6:24:00 p. m.
Fecha de actualizacion = 23/10/2023 6:24:00 p. m.
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-23T18:24:11.460' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4137, N'operacion Modifico menu
Usuario  
id = 8
Orden  = 0101
Nombre = Actividades Economicas
Pagina web = actividadeseconomicas
Estado del Registro = A
Fecha de creacion = 
Fecha de actualizacion = 
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-24T17:27:20.080' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4138, N'operacion Modifico menu
Usuario  
id = 8
Orden  = 0101
Nombre = Actividades Economicas
Pagina web = actividadeseconomicas
Estado del Registro = 
Fecha de creacion = 
Fecha de actualizacion = 
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-24T17:27:31.140' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4139, N'operacion Modifico Actividadeseconomicas
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 7
Nombre = aeronatuica...
Estado del Registro = A
Fecha de creacion = 28/09/2018 2:40:05 p. m.
Fecha de actualizacion = 23/10/2023 5:22:25 p. m.
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-24T17:35:02.010' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4140, N'operacion Modifico Actividadeseconomicas
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 7
Nombre = aeronatuica...
Estado del Registro = 
Fecha de creacion = 28/09/2018 2:40:05 p. m.
Fecha de actualizacion = 24/10/2023 5:35:01 p. m.
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-24T17:35:09.027' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4141, N'operacion Modifico menu
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 8
Orden  = 0101
Nombre = Actividades Economicas..
Pagina web = actividadeseconomicas
Estado del Registro = 
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-25T10:20:45.690' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4142, N'operacion Modifico menu
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 8
Orden  = 0101
Nombre = Actividades Economicas
Pagina web = actividadeseconomicas
Estado del Registro = 
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-25T10:29:02.940' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4143, N'operacion Modifico menu
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 8
Orden  = 0101
Nombre = Actividades Economicas
Pagina web = actividadeseconomicas
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-26T12:08:29.780' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4144, N'operacion Modifico menu
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 8
Orden  = 0101
Nombre = Actividades Economicas
Pagina web = actividadeseconomicas
Estado del Registro = 
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-26T12:08:51.483' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4145, N'operacion Modifico menu
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 9
Orden  = 0102
Nombre = Ciudades
Pagina web = ciudades
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-26T12:10:09.067' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4146, N'operacion Modifico menu
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 9
Orden  = 0102
Nombre = Ciudades
Pagina web = ciudades
Estado del Registro = 
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-26T12:10:15.010' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4147, N'operacion Agrego menu
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 103
Orden  = 0403
Nombre = aaaaa
Pagina web = aeronatuica
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-26T16:31:43.420' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4148, N'operacion Modifico menu
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 8
Orden  = 0101
Nombre = Actividades Economicas
Pagina web = actividadeseconomicas
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-27T16:53:11.147' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4149, N'operacion Modifico menu
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 8
Orden  = 0101
Nombre = Actividades Economicas
Pagina web = actividadeseconomicas
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-27T17:19:45.177' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4150, N'operacion Modifico menu
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 48
Orden  = 0208
Nombre = Cartera por edades
Pagina web = CarteraPorEdades
Estado del Registro = I
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-27T17:20:00.103' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4151, N'operacion Modifico menu
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 48
Orden  = 0208
Nombre = Cartera por edades
Pagina web = CarteraPorEdades
Estado del Registro = a
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-27T17:20:09.813' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4152, N'operacion Modifico menu
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 7
Orden  = 01
Nombre = 
Pagina web = 
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-27T17:22:36.623' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4153, N'operacion Modifico menu
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 7
Orden  = 01
Nombre = TABLAS MAESTRAS
Pagina web = 
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-27T17:22:51.830' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4154, N'operacion Borro menu
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 103
Orden  = 0403
Nombre = aaaaa
Pagina web = aeronatuica
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-27T17:23:06.337' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4155, N'operacion Modifico menu
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 7
Orden  = 01
Nombre = TABLAS MAESTRAS
Pagina web = uu
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-27T17:47:23.897' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4156, N'operacion Modifico menu
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 7
Orden  = 01
Nombre = TABLAS MAESTRAS
Pagina web = 
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-27T17:47:29.447' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4157, N'operacion Modifico menu
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 61
Orden  = 0402
Nombre = Pagos.
Pagina web = Pagos 
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-27T18:18:08.683' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4158, N'operacion Modifico menu
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 7
Orden  = 01
Nombre = TABLAS MAESTRAS...
Pagina web = 
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-27T20:14:12.630' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4159, N'operacion Agrego menu
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 105
Orden  = 0403
Nombre = xxx
Pagina web = xxx
Estado del Registro = a
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-27T20:14:31.297' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4160, N'operacion Borro menu
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 105
Orden  = 0403
Nombre = xxx
Pagina web = xxx
Estado del Registro = a
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-27T20:14:39.160' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4161, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 1
Area  = SISTEMAS
Nombre = ADMINISTRADOR
Cargo = JEFE
direccion = MINCULTURA MODIF
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-30T15:08:31.723' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4162, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 1
Area  = SISTEMAS
Nombre = ADMINISTRADOR
Cargo = JEFE
direccion = MINCULTURA MODIF
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-30T15:11:11.490' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4163, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 1
Area  = SISTEMAS
Nombre = ADMINISTRADOR
Cargo = JEFE
direccion = MINCULTURA MODIF
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-30T15:11:23.110' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4164, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 1
Area  = SISTEMAS
Nombre = ADMINISTRADOR
Cargo = JEFE
direccion = MINCULTURA MODIF
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-30T15:11:27.877' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4165, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 1
Area  = SISTEMAS
Nombre = ADMINISTRADOR
Cargo = JEFE
direccion = MINCULTURA MODIF
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-30T15:11:32.537' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4166, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 1
Area  = SISTEMAS
Nombre = ADMINISTRADOR
Cargo = JEFE
direccion = MINCULTURA MODIF
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-30T15:11:37.297' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4167, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS..-JEFE
id = 1
Area  = SISTEMAS
Nombre = ADMINISTRADOR
Cargo = JEFE
direccion = MINCULTURA MODIF
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS..-JEFE', CAST(N'2023-10-30T15:11:44.410' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4168, N'operacion Modifico usuario
Usuario  ADMINISTRADOR-SISTEMAS-JEFE
id = 1
Area  = SISTEMAS..
Nombre = ADMINISTRADOR
Cargo = JEFE
direccion = MINCULTURA MODIF
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR-SISTEMAS-JEFE', CAST(N'2023-10-30T15:28:03.183' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4169, N'operacion Modifico usuario
Usuario  ADMINISTRADOR-SISTEMAS-JEFE
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR
Cargo = JEFE
direccion = MINCULTURA MODIF
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR-SISTEMAS-JEFE', CAST(N'2023-10-30T17:15:19.047' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4170, N'operacion Modifico usuario
Usuario  ADMINISTRADOR-SISTEMAS-JEFE
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR-SISTEMAS-JEFE', CAST(N'2023-10-30T17:15:35.650' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4171, N'operacion Modifico usuario
Usuario  ADMINISTRADOR-SISTEMAS-JEFE
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR-SISTEMAS-JEFE', CAST(N'2023-10-30T17:37:47.887' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4172, N'operacion Modifico usuario
Usuario  ADMINISTRADOR-SISTEMAS-JEFE
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR-SISTEMAS-JEFE', CAST(N'2023-10-30T17:44:19.910' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4173, N'operacion Modifico usuario
Usuario  ADMINISTRADOR-SISTEMAS-JEFE
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR-SISTEMAS-JEFE', CAST(N'2023-10-30T17:44:34.330' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4174, N'operacion Modifico usuario
Usuario  ADMINISTRADOR-SISTEMAS-JEFE
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR-SISTEMAS-JEFE', CAST(N'2023-10-30T17:44:59.600' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4175, N'operacion Modifico usuario
Usuario  ADMINISTRADOR-SISTEMAS-JEFE
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR-SISTEMAS-JEFE', CAST(N'2023-10-30T17:47:20.900' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4176, N'operacion Modifico usuario
Usuario  ADMINISTRADOR-SISTEMAS-JEFE
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR-SISTEMAS-JEFE', CAST(N'2023-10-30T17:58:13.740' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4177, N'operacion Modifico usuario
Usuario  ADMINISTRADOR-SISTEMAS-JEFE
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR-SISTEMAS-JEFE', CAST(N'2023-10-30T17:58:19.140' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4178, N'operacion Modifico usuario
Usuario  ADMINISTRADOR-SISTEMAS-JEFE
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR-SISTEMAS-JEFE', CAST(N'2023-10-30T18:02:03.917' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4179, N'operacion Modifico usuario
Usuario  ADMINISTRADOR-SISTEMAS-JEFE
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR-SISTEMAS-JEFE', CAST(N'2023-10-30T18:02:07.533' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4180, N'operacion Modifico usuario
Usuario  ADMINISTRADOR-SISTEMAS-JEFE
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR-SISTEMAS-JEFE', CAST(N'2023-10-30T18:02:07.710' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4181, N'operacion Modifico usuario
Usuario  ADMINISTRADOR-SISTEMAS-JEFE
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR-SISTEMAS-JEFE', CAST(N'2023-10-30T18:02:07.893' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4182, N'operacion Modifico usuario
Usuario  ADMINISTRADOR-SISTEMAS-JEFE
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR-SISTEMAS-JEFE', CAST(N'2023-10-30T18:02:08.067' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4183, N'operacion Modifico usuario
Usuario  ADMINISTRADOR-SISTEMAS-JEFE
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR-SISTEMAS-JEFE', CAST(N'2023-10-30T18:04:13.657' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4184, N'operacion Modifico usuario
Usuario  ADMINISTRADOR-SISTEMAS-JEFE
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR-SISTEMAS-JEFE', CAST(N'2023-10-30T18:04:41.707' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4185, N'operacion Modifico usuario
Usuario  ADMINISTRADOR-SISTEMAS-JEFE
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR-SISTEMAS-JEFE', CAST(N'2023-10-30T18:05:10.700' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4186, N'operacion Modifico usuario
Usuario  ADMINISTRADOR-SISTEMAS-JEFE
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR-SISTEMAS-JEFE', CAST(N'2023-10-30T18:06:10.390' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4187, N'operacion Modifico usuario
Usuario  ADMINISTRADOR-SISTEMAS-JEFE
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR-SISTEMAS-JEFE', CAST(N'2023-10-30T18:28:01.020' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4188, N'operacion Modifico usuario
Usuario  ADMINISTRADOR-SISTEMAS-JEFE
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR-SISTEMAS-JEFE', CAST(N'2023-10-30T18:36:15.513' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4189, N'operacion Modifico usuario
Usuario  ADMINISTRADOR-SISTEMAS-JEFE
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR-SISTEMAS-JEFE', CAST(N'2023-10-30T18:36:38.103' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4190, N'operacion Modifico usuario
Usuario  ADMINISTRADOR-SISTEMAS-JEFE
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR-SISTEMAS-JEFE', CAST(N'2023-10-30T18:37:07.710' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4191, N'operacion Modifico usuario
Usuario  ADMINISTRADOR-SISTEMAS-JEFE
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR-SISTEMAS-JEFE', CAST(N'2023-10-30T18:37:12.110' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4192, N'operacion Modifico usuario
Usuario  ADMINISTRADOR-SISTEMAS-JEFE
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR-SISTEMAS-JEFE', CAST(N'2023-10-30T18:37:27.097' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4193, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T19:19:12.987' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4194, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T19:21:29.757' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4195, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T21:15:22.897' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4196, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T21:21:32.983' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4197, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T21:24:15.917' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4198, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T21:26:49.537' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4199, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T21:29:46.140' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4200, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T21:29:52.610' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4201, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T21:30:00.107' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4202, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T21:30:09.270' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4203, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T21:30:13.773' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4204, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T21:30:19.477' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4205, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T21:30:25.730' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4206, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T21:30:51.323' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4207, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T21:30:57.457' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4208, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T21:31:01.747' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4209, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T21:31:06.030' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4210, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T21:36:10.777' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4211, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T21:36:34.787' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4212, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T22:16:01.613' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4213, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T22:16:44.610' AS DateTime))
GO
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4214, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T22:19:08.047' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4215, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T22:21:53.943' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4216, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T22:25:06.497' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4217, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T22:38:33.500' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4218, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T22:38:35.170' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4219, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T22:38:36.960' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4220, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T22:38:38.097' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4221, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T22:38:59.593' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4222, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T22:43:47.900' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4223, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T22:44:16.363' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4224, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T22:45:29.987' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4225, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T22:45:39.923' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4226, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T22:47:48.873' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4227, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T22:47:54.823' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4228, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T22:48:04.073' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4229, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T22:50:07.483' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4230, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T22:51:35.047' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4231, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T22:52:43.280' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4232, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T22:53:35.497' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4233, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T22:55:48.617' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4234, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-30T22:56:45.597' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4235, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = cccc
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-31T15:03:05.220' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4236, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = cccc
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-31T15:03:31.557' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4237, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = cccc
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-31T15:09:43.407' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4238, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = cccc
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-31T15:12:02.707' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4239, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = cccc
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-31T15:12:08.927' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4240, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = cccc
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-31T15:12:15.610' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4241, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = cccc
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-31T15:14:53.613' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4242, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = cccc
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-31T15:16:29.553' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4243, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = cccc
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-31T15:16:34.820' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4244, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = cccc
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-31T15:19:45.480' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4245, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-SISTEMAS.....-JEFE...
id = 1
Area  = cccc
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-SISTEMAS.....-JEFE...', CAST(N'2023-10-31T15:19:51.663' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4246, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-cccc-JEFE...
id = 1
Area  = cccc
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-cccc-JEFE...', CAST(N'2023-10-31T15:30:25.513' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4247, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-cccc-JEFE...
id = 1
Area  = cccc
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-cccc-JEFE...', CAST(N'2023-10-31T15:30:30.133' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4248, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-cccc-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-cccc-JEFE...', CAST(N'2023-10-31T16:16:13.613' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4249, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-cccc-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-cccc-JEFE...', CAST(N'2023-10-31T16:16:30.950' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4250, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-cccc-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-cccc-JEFE...', CAST(N'2023-10-31T16:23:04.303' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4251, N'operacion Modifico usuario
Usuario  ADMINISTRADOR...-cccc-JEFE...
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...-cccc-JEFE...', CAST(N'2023-10-31T16:23:15.867' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4252, N'operacion Modifico usuario
id = 1
Area  = SISTEMAS.....
Nombre = ADMINISTRADOR...
Cargo = JEFE...
direccion = MINCULTURA
telefono = 2565656
Correo Electronico = ADMIN@HOTMAIL.COM
login = ADMIN
password = ADMIN
Perfil = 1
Tipos de documento = ,7=AMBIN,8=AMBIN,9=AMBIN,12=AMBIN,11=AMBIN,20=AMBIN,28=AMBIN,15=AMBIN,18=AMBIN,14=AMBIN,16=AMBIN,17=AMBIN,30=AMBIN,29=AMBIN,19=AMBIN,21=AMBIN,22=AMBIN,23=AMBIN,25=AMBIN,
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2023-11-02T10:42:04.593' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4253, N'operacion Modifico Actividadeseconomicas
id = 7
Nombre = aeronatuica
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2023-11-02T18:39:07.123' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4254, N'operacion Modifico Actividadeseconomicas
id = 1
Nombre = pesca
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2023-11-02T18:39:18.857' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4255, N'operacion Modifico Actividadeseconomicas
id = 1
Nombre = pesca
Estado del Registro = i
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2023-11-02T18:39:38.157' AS DateTime))
INSERT [dbo].[LOG] ([ID], [DESCRIPCION_DE_LA_OPERACION], [FECHA_DE_ACTUALIZACION]) VALUES (4256, N'operacion Modifico Actividadeseconomicas
id = 1
Nombre = pesca
Estado del Registro = A
Usuario que actualizo =ADMINISTRADOR...', CAST(N'2023-11-02T18:40:01.090' AS DateTime))
SET IDENTITY_INSERT [dbo].[LOG] OFF
GO
SET IDENTITY_INSERT [dbo].[MENSAJESDELSISTEMA] ON 

INSERT [dbo].[MENSAJESDELSISTEMA] ([id], [FECHA_DESDE], [FECHA_HASTA], [MENSAJE]) VALUES (3, CAST(N'2020-02-20T00:00:00.000' AS DateTime), CAST(N'2020-02-21T00:00:00.000' AS DateTime), N'buenos dias como esta, debe totmar inventsrio fisico el 1 de marzo de 2020 , se activara a la media noche el programa para que solo permita capturar inventario fisico hasta las 12 pm
')
SET IDENTITY_INSERT [dbo].[MENSAJESDELSISTEMA] OFF
GO
SET IDENTITY_INSERT [dbo].[MENU] ON 

INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (7, N'01', N'TABLAS MAESTRAS...', N'', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (8, N'0101', N'Actividades Economicas', N'actividadeseconomicas', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (9, N'0102', N'Ciudades', N'ciudades', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (10, N'0103', N'Conceptos Nota debito y Credito', N'conceptosnotadebitocredito', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (12, N'0104', N'Cuentas Bancarias', N'cuantasbancarias', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (13, N'0105', N'Descuentos', N'descuentos', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (14, N'0106', N'Transacciones', N'transacciones', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (15, N'0107', N'Formas de pago', N'formasdepago', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (16, N'0108', N'Formulas', N'formulas', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (17, N'0109', N'Ivas', N'ivas', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (18, N'0110', N'Productos', N'productos', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (19, N'0111', N'Programas', N'programas', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (20, N'0112', N'Proveedores', N'proveedores', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (22, N'0113', N'Retenciones', N'retenciones', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (24, N'0114', N'Unidades de medida', N'unidadesdemedida', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (26, N'0116', N'Clasificacion de materias primas', N'clasificaciondemtaeriasprimas', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (31, N'0117', N'Departamentos', N'departamentos', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (32, N'0118', N'Paises', N'paises', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (39, N'0119', N'Colores', N'colores', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (40, N'02', N'INVENTARIOS', N'', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (41, N'0201', N'Captura de movimiento', N'CapturaDeMovimiento', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (42, N'0202', N'kardex', N'Kardex', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (43, N'0203', N'Informe de una transaccion', N'InformeDeUnaTransaccion', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (44, N'0204', N'Cuadro Comparativo entre meses', N'CuadroComparativoEntreMeses', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (45, N'0205', N'Informe de pedidos', N'InformeDePedidos', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (46, N'0206', N'Aprobar traslados', N'AprobarTraslados', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (47, N'0207', N'Extracto de cartera', N'ExtractoDeCartera', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (48, N'0208', N'Cartera por edades', N'CarteraPorEdades', N'a')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (49, N'0209', N'Comisiones para vendedores', N'ComisionesParaVendedores', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (51, N'0210', N'Programar pagos', N'ProgramarPagos', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (54, N'0211', N'Interfaz contable', N'InterfazContable', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (55, N'0212', N'cierre contable', N'CierreContable', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (1, N'03', N'SEGURIDAD', N' ', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (2, N'0301', N'Perfiles', N'perfiles', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (3, N'0302', N'Usuarios.', N'usuarios', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (4, N'0303', N'Menu', N'menu', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (5, N'0304', N'Log', N'log', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (57, N'0305', N'Activar mensaje', N'activafmensaje', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (59, N'04', N'SERVICIO AL CLIENTE', N'', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (60, N'0401', N'Consultar pedido', N'ConsultarPedido', N'A')
INSERT [dbo].[MENU] ([ID], [ORDEN], [NOMBRE], [PAGINA_WEB], [ESTADO_DEL_REGISTRO]) VALUES (61, N'0402', N'Pagos.', N'Pagos ', N'A')
SET IDENTITY_INSERT [dbo].[MENU] OFF
GO
SET IDENTITY_INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ON 

INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10755 AS Decimal(18, 0)), 12, 2, 29, 1, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-03-14T00:00:00.000' AS DateTime), 0, 20, 0, N'', 0, 0, N'  ', N'0', N'14', N'coctel de camarones.', CAST(1 AS Decimal(18, 0)), N'BL', CAST(10.00000 AS Decimal(18, 5)), CAST(10.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(50000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 8000, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(58000.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'', N'', N'', CAST(N'2020-02-13T13:19:47.353' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10757 AS Decimal(18, 0)), 14, 2, 29, 2, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-03-14T00:00:00.000' AS DateTime), 0, 20, 0, N'', 0, 0, N' ', N'0', N'14', N'coctel de camarones.', CAST(1 AS Decimal(18, 0)), N'BL', CAST(10.00000 AS Decimal(18, 5)), CAST(10.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(50000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 8000, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(58000.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'', N'', N'', CAST(N'2020-02-13T13:25:26.967' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10758 AS Decimal(18, 0)), 12, 2, 29, 3, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-03-14T00:00:00.000' AS DateTime), 0, 20, 0, N'', 0, 0, N' ', N'0', N'20', N'coctel de coco loco.', CAST(1 AS Decimal(18, 0)), N'BL', CAST(5.00000 AS Decimal(18, 5)), CAST(5.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(1800.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(25000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 4000, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(29000.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'', N'', N'', CAST(N'2020-02-13T13:32:58.173' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10764 AS Decimal(18, 0)), 12, 2, 44, 1, 12, 2, 29, 1, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'   ', N'0', N'14', N'coctel de camarones.', CAST(1 AS Decimal(18, 0)), N'BL', CAST(10.00000 AS Decimal(18, 5)), CAST(10.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(50000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 8000, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(58000.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'', N'', N'', CAST(N'2020-02-13T14:30:53.877' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10765 AS Decimal(18, 0)), 14, 2, 44, 2, 14, 2, 29, 2, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'  ', N'0', N'14', N'coctel de camarones.', CAST(1 AS Decimal(18, 0)), N'BL', CAST(10.00000 AS Decimal(18, 5)), CAST(10.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(50000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 8000, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(58000.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'', N'', N'', CAST(N'2020-02-13T14:31:15.413' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10766 AS Decimal(18, 0)), 12, 2, 44, 3, 12, 2, 29, 3, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'  ', N'0', N'20', N'coctel de coco loco.', CAST(1 AS Decimal(18, 0)), N'BL', CAST(5.00000 AS Decimal(18, 5)), CAST(5.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(1800.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(25000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 4000, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(29000.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'', N'', N'', CAST(N'2020-02-13T14:31:31.550' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10804 AS Decimal(18, 0)), 0, 2, 22, 1, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'15', N'camaron', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(5000000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 800000, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(5800000.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'+', N'', N'', CAST(N'2020-02-13T19:15:30.970' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10805 AS Decimal(18, 0)), 0, 2, 22, 1, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'16', N'salsa de tomate', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(3000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 480, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(3480.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'+', N'', N'', CAST(N'2020-02-13T19:15:30.970' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10806 AS Decimal(18, 0)), 0, 2, 22, 1, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'17', N'mayonesa', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(2000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 320, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(2320.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'+', N'', N'', CAST(N'2020-02-13T19:15:30.970' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10807 AS Decimal(18, 0)), 0, 2, 22, 1, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'21', N'jugo de coco', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(850.00000 AS Decimal(18, 5)), CAST(800.00000 AS Decimal(18, 5)), CAST(850.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(850000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 136000, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(986000.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'+', N'', N'', CAST(N'2020-02-13T19:15:30.970' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10808 AS Decimal(18, 0)), 0, 2, 22, 1, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'22', N'pina colada', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(350.00000 AS Decimal(18, 5)), CAST(300.00000 AS Decimal(18, 5)), CAST(350.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(350000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 56000, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(406000.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'+', N'', N'', CAST(N'2020-02-13T19:15:30.970' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10809 AS Decimal(18, 0)), 2, 3, 45, 4, 12, 2, 44, 1, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'    ', N'0', N'14', N'coctel de camarones.', CAST(1 AS Decimal(18, 0)), N'BL', CAST(3.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(6000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 960, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(6960.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:16:37.603' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10810 AS Decimal(18, 0)), 2, 3, 45, 4, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'    ', N'14', N'15', N'camaron', CAST(1 AS Decimal(18, 0)), N'0', CAST(0.75000 AS Decimal(18, 5)), CAST(0.75000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(3750.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(3750.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:16:37.620' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10811 AS Decimal(18, 0)), 2, 3, 45, 4, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'    ', N'14', N'17', N'mayonesa', CAST(1 AS Decimal(18, 0)), N'0', CAST(45.00000 AS Decimal(18, 5)), CAST(45.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(90.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(90.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:16:37.627' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10812 AS Decimal(18, 0)), 2, 3, 45, 4, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'    ', N'14', N'16', N'salsa de tomate', CAST(1 AS Decimal(18, 0)), N'0', CAST(60.00000 AS Decimal(18, 5)), CAST(60.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(180.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(180.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:16:37.637' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10813 AS Decimal(18, 0)), 2, 3, 45, 5, 14, 2, 44, 2, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'   ', N'0', N'14', N'coctel de camarones.', CAST(1 AS Decimal(18, 0)), N'BL', CAST(3.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(6000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 960, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(6960.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:17:20.383' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10814 AS Decimal(18, 0)), 2, 3, 45, 5, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'   ', N'14', N'15', N'camaron', CAST(1 AS Decimal(18, 0)), N'0', CAST(0.75000 AS Decimal(18, 5)), CAST(0.75000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(3750.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(3750.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:17:20.400' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10815 AS Decimal(18, 0)), 2, 3, 45, 5, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'   ', N'14', N'17', N'mayonesa', CAST(1 AS Decimal(18, 0)), N'0', CAST(45.00000 AS Decimal(18, 5)), CAST(45.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(90.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(90.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:17:20.410' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10816 AS Decimal(18, 0)), 2, 3, 45, 5, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'   ', N'14', N'16', N'salsa de tomate', CAST(1 AS Decimal(18, 0)), N'0', CAST(60.00000 AS Decimal(18, 5)), CAST(60.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(180.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(180.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:17:20.420' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10817 AS Decimal(18, 0)), 2, 3, 45, 6, 12, 2, 44, 3, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'   ', N'0', N'20', N'coctel de coco loco.', CAST(1 AS Decimal(18, 0)), N'BL', CAST(3.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(1800.00000 AS Decimal(18, 5)), CAST(1800.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(5400.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 864, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(6264.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:17:43.100' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10818 AS Decimal(18, 0)), 2, 3, 45, 6, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'   ', N'20', N'21', N'jugo de coco', CAST(1 AS Decimal(18, 0)), N'0', CAST(6.00000 AS Decimal(18, 5)), CAST(6.00000 AS Decimal(18, 5)), CAST(850.00000 AS Decimal(18, 5)), CAST(800.00000 AS Decimal(18, 5)), CAST(850.00000 AS Decimal(18, 5)), CAST(850.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(5100.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(5100.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:17:43.110' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10819 AS Decimal(18, 0)), 2, 3, 45, 6, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'   ', N'20', N'22', N'pina colada', CAST(1 AS Decimal(18, 0)), N'0', CAST(15.00000 AS Decimal(18, 5)), CAST(15.00000 AS Decimal(18, 5)), CAST(350.00000 AS Decimal(18, 5)), CAST(300.00000 AS Decimal(18, 5)), CAST(350.00000 AS Decimal(18, 5)), CAST(350.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(5250.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(5250.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:17:43.120' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10820 AS Decimal(18, 0)), 2, 3, 45, 7, 12, 2, 44, 1, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'    ', N'0', N'14', N'coctel de camarones.', CAST(1 AS Decimal(18, 0)), N'BL', CAST(2.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(4000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 640, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(4640.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:36:28.220' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10821 AS Decimal(18, 0)), 2, 3, 45, 7, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'    ', N'14', N'15', N'camaron', CAST(1 AS Decimal(18, 0)), N'0', CAST(0.50000 AS Decimal(18, 5)), CAST(0.50000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(2500.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(2500.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:36:28.240' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10822 AS Decimal(18, 0)), 2, 3, 45, 7, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'    ', N'14', N'17', N'mayonesa', CAST(1 AS Decimal(18, 0)), N'0', CAST(30.00000 AS Decimal(18, 5)), CAST(30.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(60.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(60.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:36:28.247' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10823 AS Decimal(18, 0)), 2, 3, 45, 7, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'    ', N'14', N'16', N'salsa de tomate', CAST(1 AS Decimal(18, 0)), N'0', CAST(40.00000 AS Decimal(18, 5)), CAST(40.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(120.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(120.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:36:28.253' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10824 AS Decimal(18, 0)), 2, 3, 45, 8, 14, 2, 44, 2, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'   ', N'0', N'14', N'coctel de camarones.', CAST(1 AS Decimal(18, 0)), N'BL', CAST(3.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(6000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 960, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(6960.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:37:46.857' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10825 AS Decimal(18, 0)), 2, 3, 45, 8, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'   ', N'14', N'15', N'camaron', CAST(1 AS Decimal(18, 0)), N'0', CAST(0.75000 AS Decimal(18, 5)), CAST(0.75000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(3750.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(3750.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:37:46.870' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10826 AS Decimal(18, 0)), 2, 3, 45, 8, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'   ', N'14', N'17', N'mayonesa', CAST(1 AS Decimal(18, 0)), N'0', CAST(45.00000 AS Decimal(18, 5)), CAST(45.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(90.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(90.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:37:46.880' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10827 AS Decimal(18, 0)), 2, 3, 45, 8, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'   ', N'14', N'16', N'salsa de tomate', CAST(1 AS Decimal(18, 0)), N'0', CAST(60.00000 AS Decimal(18, 5)), CAST(60.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(180.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(180.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:37:46.887' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10828 AS Decimal(18, 0)), 2, 3, 45, 9, 12, 2, 44, 3, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'   ', N'0', N'20', N'coctel de coco loco.', CAST(1 AS Decimal(18, 0)), N'BL', CAST(2.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(1800.00000 AS Decimal(18, 5)), CAST(1800.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(3600.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 576, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(4176.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:38:00.823' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10829 AS Decimal(18, 0)), 2, 3, 45, 9, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'   ', N'20', N'21', N'jugo de coco', CAST(1 AS Decimal(18, 0)), N'0', CAST(4.00000 AS Decimal(18, 5)), CAST(4.00000 AS Decimal(18, 5)), CAST(850.00000 AS Decimal(18, 5)), CAST(800.00000 AS Decimal(18, 5)), CAST(850.00000 AS Decimal(18, 5)), CAST(850.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(3400.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(3400.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:38:00.833' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10830 AS Decimal(18, 0)), 2, 3, 45, 9, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'   ', N'20', N'22', N'pina colada', CAST(1 AS Decimal(18, 0)), N'0', CAST(10.00000 AS Decimal(18, 5)), CAST(10.00000 AS Decimal(18, 5)), CAST(350.00000 AS Decimal(18, 5)), CAST(300.00000 AS Decimal(18, 5)), CAST(350.00000 AS Decimal(18, 5)), CAST(350.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(3500.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(3500.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:38:00.843' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10831 AS Decimal(18, 0)), 22, 1, 11, 100, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'15', N'camaron', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(5000000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 800000, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 2, CAST(11.00 AS Numeric(5, 2)), 550550, 4, CAST(6.00 AS Numeric(5, 2)), 300300, CAST(5800000.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:26:16.290' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10832 AS Decimal(18, 0)), 22, 1, 11, 100, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'16', N'salsa de tomate', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(3000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 480, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(3480.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:26:16.290' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10833 AS Decimal(18, 0)), 22, 1, 11, 100, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'17', N'mayonesa', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(2000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 320, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(2320.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:26:16.290' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10834 AS Decimal(18, 0)), 22, 1, 11, 101, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'15', N'camaron', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(5000000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 800000, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 2, CAST(11.00 AS Numeric(5, 2)), 550550, 4, CAST(6.00 AS Numeric(5, 2)), 300300, CAST(5800000.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:33:51.950' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10835 AS Decimal(18, 0)), 22, 1, 11, 101, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'16', N'salsa de tomate', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(3000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 480, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(3480.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:33:51.950' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10836 AS Decimal(18, 0)), 22, 1, 11, 101, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'17', N'mayonesa', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(2000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 320, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(2320.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:33:51.950' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10837 AS Decimal(18, 0)), 13, 1, 11, 102, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'15', N'camaron', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(5000000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 800000, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 2, CAST(11.00 AS Numeric(5, 2)), 550550, 3, CAST(50.00 AS Numeric(5, 2)), 2502500, CAST(5800000.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:36:30.203' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10838 AS Decimal(18, 0)), 13, 1, 11, 102, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'16', N'salsa de tomate', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(3000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 480, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(3480.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:36:30.203' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10839 AS Decimal(18, 0)), 13, 1, 11, 102, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'17', N'mayonesa', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(2000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 320, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(2320.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:36:30.203' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10840 AS Decimal(18, 0)), 13, 1, 11, 103, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'15', N'camaron', CAST(1 AS Decimal(18, 0)), N'BL', CAST(500.00000 AS Decimal(18, 5)), CAST(500.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(2500000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 400000, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 2, CAST(11.00 AS Numeric(5, 2)), 275275, 3, CAST(50.00 AS Numeric(5, 2)), 1251250, CAST(2900000.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:39:51.113' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10841 AS Decimal(18, 0)), 13, 1, 11, 103, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'16', N'salsa de tomate', CAST(1 AS Decimal(18, 0)), N'BL', CAST(500.00000 AS Decimal(18, 5)), CAST(500.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(1500.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 240, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(1740.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:39:51.113' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10842 AS Decimal(18, 0)), 13, 1, 11, 103, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'17', N'mayonesa', CAST(1 AS Decimal(18, 0)), N'BL', CAST(500.00000 AS Decimal(18, 5)), CAST(500.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(1000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 160, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(1160.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:39:51.113' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10843 AS Decimal(18, 0)), 13, 1, 11, 104, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'15', N'camaron', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(5000000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 800000, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 2, CAST(11.00 AS Numeric(5, 2)), 550550, 3, CAST(50.00 AS Numeric(5, 2)), 2502500, CAST(5800000.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:43:41.653' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10844 AS Decimal(18, 0)), 13, 1, 11, 104, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'16', N'salsa de tomate', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(3000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 480, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(3480.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:43:41.653' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10845 AS Decimal(18, 0)), 13, 1, 11, 104, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'17', N'mayonesa', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(2000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 320, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(2320.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:43:41.653' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10846 AS Decimal(18, 0)), 13, 1, 11, 105, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'15', N'camaron', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(5000000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 800000, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 2, CAST(11.00 AS Numeric(5, 2)), 550550, 3, CAST(50.00 AS Numeric(5, 2)), 2502500, CAST(5800000.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:46:10.507' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10847 AS Decimal(18, 0)), 13, 1, 11, 105, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'16', N'salsa de tomate', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(3000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 480, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(3480.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:46:10.507' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10848 AS Decimal(18, 0)), 13, 1, 11, 105, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'17', N'mayonesa', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(2000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 320, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(2320.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:46:10.507' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10849 AS Decimal(18, 0)), 22, 1, 11, 106, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'15', N'camaron', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(5000000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 800000, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 2, CAST(11.00 AS Numeric(5, 2)), 550000, 4, CAST(6.00 AS Numeric(5, 2)), 300000, CAST(5800000.00000 AS Decimal(18, 5)), CAST(N'2020-02-20T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T14:33:40.570' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
SET IDENTITY_INSERT [dbo].[MOVIMIENTODEINVENTARIOS] OFF
GO
SET IDENTITY_INSERT [dbo].[PERFILES] ON 

INSERT [dbo].[PERFILES] ([ID], [NOMBRE], [PROGRAMAS], [ESTADO_DEL_REGISTRO]) VALUES (1, N'ADMINISTRADOR..', N',7=AMBIN,8=AMBIN,9=AMBIN,10=AMBIN,12=AMBIN,13=AMBIN,14=AMBIN,15=AMBIN,16=AMBIN,17=AMBIN,18=AMBIN,19=AMBIN,20=AMBIN,22=AMBIN,24=AMBIN,26=AMBIN,31=AMBIN,32=AMBIN,39=AMBIN,40=AMBIN,41=AMBIN,42=AMBIN,43=AMBIN,44=AMBIN,45=AMBIN,46=AMBIN,47=AMBIN,48=AMBIN,49=AMBIN,51=AMBIN,54=AMBIN,55=AMBIN,1=AMBIN,2=AMBIN,3=AMBIN,4=AMBIN,5=AMBIN,57=AMBIN,59=AMBIN,60=AMBIN,61=AMBIN,', N'A')
INSERT [dbo].[PERFILES] ([ID], [NOMBRE], [PROGRAMAS], [ESTADO_DEL_REGISTRO]) VALUES (2, N'REVISOR', N',7=AMBIN,8=AMBIN,9=AMBIN,10=AMBIN,12=AMBIN,13=AMBIN,14=AMBIN,15=AMBIN,16=AMBIN,17=AMBIN,18=AMBIN,19=AMBIN,20=AMBIN,22=AMBIN,24=AMBIN,26=AMBIN,31=AMBIN,32=AMBIN,39=AMBIN,40=AMBIN,41=AMBIN,42=AMBIN,43=AMBIN,44=AMBIN,45=AMBIN,46=AMBIN,47=AMBIN,48=AMBIN,49=AMBIN,51=AMBIN,54=AMBIN,55=AMBIN,1=AMBIN,2=AMBIN,3=AMBIN,4=AMBIN,5=AMBIN,57=AMBIN,59=AMBIN,60=AMBIN,61=AMBIN,', NULL)
SET IDENTITY_INSERT [dbo].[PERFILES] OFF
GO
SET IDENTITY_INSERT [dbo].[PRODUCTOS] ON 

INSERT [dbo].[PRODUCTOS] ([ID], [NOMBRE], [GENERICO], [UNIDADDEMEDIDA], [PRECIO1], [COSTODEPRODUCCION], [COSTOULTIMO], [CODIGOIVA1], [CODIGOIVA2], [CODIGOIVA3], [CLASIFICACION], [CODIGODEBARRAS], [ESTADO_DEL_REGISTRO]) VALUES (1, N'pijama nina peterpan', N'pijama nina peterpan', N'UN', CAST(30000.00000 AS Decimal(18, 5)), CAST(15000.00000 AS Decimal(18, 5)), CAST(17000.00000 AS Decimal(18, 5)), 1, 0, 0, 13, N'111', N'A')
INSERT [dbo].[PRODUCTOS] ([ID], [NOMBRE], [GENERICO], [UNIDADDEMEDIDA], [PRECIO1], [COSTODEPRODUCCION], [COSTOULTIMO], [CODIGOIVA1], [CODIGOIVA2], [CODIGOIVA3], [CLASIFICACION], [CODIGODEBARRAS], [ESTADO_DEL_REGISTRO]) VALUES (14, N'coctel de camarones.', N'coctel de camarones.', N'UN', CAST(5000.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), 1, 0, 0, 12, N'956985686982', N'A')
INSERT [dbo].[PRODUCTOS] ([ID], [NOMBRE], [GENERICO], [UNIDADDEMEDIDA], [PRECIO1], [COSTODEPRODUCCION], [COSTOULTIMO], [CODIGOIVA1], [CODIGOIVA2], [CODIGOIVA3], [CLASIFICACION], [CODIGODEBARRAS], [ESTADO_DEL_REGISTRO]) VALUES (15, N'camaron', N'camaron', N'LB', CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), 1, 0, 0, 1, N'999', N'A')
INSERT [dbo].[PRODUCTOS] ([ID], [NOMBRE], [GENERICO], [UNIDADDEMEDIDA], [PRECIO1], [COSTODEPRODUCCION], [COSTOULTIMO], [CODIGOIVA1], [CODIGOIVA2], [CODIGOIVA3], [CLASIFICACION], [CODIGODEBARRAS], [ESTADO_DEL_REGISTRO]) VALUES (16, N'salsa de tomate', N'salsa de tomate', N'GR', CAST(20.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), 1, 0, 0, 1, N'888', N'A')
INSERT [dbo].[PRODUCTOS] ([ID], [NOMBRE], [GENERICO], [UNIDADDEMEDIDA], [PRECIO1], [COSTODEPRODUCCION], [COSTOULTIMO], [CODIGOIVA1], [CODIGOIVA2], [CODIGOIVA3], [CLASIFICACION], [CODIGODEBARRAS], [ESTADO_DEL_REGISTRO]) VALUES (17, N'mayonesa', N'mayonesa', N'GR', CAST(4.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), 1, 0, 0, 1, N'98889', N'A')
INSERT [dbo].[PRODUCTOS] ([ID], [NOMBRE], [GENERICO], [UNIDADDEMEDIDA], [PRECIO1], [COSTODEPRODUCCION], [COSTOULTIMO], [CODIGOIVA1], [CODIGOIVA2], [CODIGOIVA3], [CLASIFICACION], [CODIGODEBARRAS], [ESTADO_DEL_REGISTRO]) VALUES (18, N'pijama nina', N'zapatilla', N'UN', CAST(35000.00000 AS Decimal(18, 5)), CAST(15000.00000 AS Decimal(18, 5)), CAST(17000.00000 AS Decimal(18, 5)), 1, 0, 0, 12, N'77889', N'A')
INSERT [dbo].[PRODUCTOS] ([ID], [NOMBRE], [GENERICO], [UNIDADDEMEDIDA], [PRECIO1], [COSTODEPRODUCCION], [COSTOULTIMO], [CODIGOIVA1], [CODIGOIVA2], [CODIGOIVA3], [CLASIFICACION], [CODIGODEBARRAS], [ESTADO_DEL_REGISTRO]) VALUES (20, N'coctel de coco loco.', N'coctel de coco loco', N'UN', CAST(5000.00000 AS Decimal(18, 5)), CAST(1800.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), 1, 0, 0, 12, N'65698956', N'A')
INSERT [dbo].[PRODUCTOS] ([ID], [NOMBRE], [GENERICO], [UNIDADDEMEDIDA], [PRECIO1], [COSTODEPRODUCCION], [COSTOULTIMO], [CODIGOIVA1], [CODIGOIVA2], [CODIGOIVA3], [CLASIFICACION], [CODIGODEBARRAS], [ESTADO_DEL_REGISTRO]) VALUES (21, N'jugo de coco', N'jugo de coco', N'LT', CAST(1000.00000 AS Decimal(18, 5)), CAST(800.00000 AS Decimal(18, 5)), CAST(850.00000 AS Decimal(18, 5)), 1, 0, 0, 1, N'65656569', N'A')
INSERT [dbo].[PRODUCTOS] ([ID], [NOMBRE], [GENERICO], [UNIDADDEMEDIDA], [PRECIO1], [COSTODEPRODUCCION], [COSTOULTIMO], [CODIGOIVA1], [CODIGOIVA2], [CODIGOIVA3], [CLASIFICACION], [CODIGODEBARRAS], [ESTADO_DEL_REGISTRO]) VALUES (22, N'pina colada', N'pina colada', N'LT', CAST(2000.00000 AS Decimal(18, 5)), CAST(300.00000 AS Decimal(18, 5)), CAST(350.00000 AS Decimal(18, 5)), 1, 0, 0, 1, N'87876867', N'A')
SET IDENTITY_INSERT [dbo].[PRODUCTOS] OFF
GO
SET IDENTITY_INSERT [dbo].[PROVEEDORES] ON 

INSERT [dbo].[PROVEEDORES] ([id], [nombre], [direccion], [ciudad], [telefono], [celular1], [celular2], [email1], [email2], [nit], [fechadeingreso], [observaciones], [contactos], [actividadcomercial], [seleretienefuente], [seleretieneiva], [seleretieneica], [puedecobrariva], [espersonanaturalojuridica], [declararenta], [esgrancontribuyente], [tipoderegimen], [CLASIFICACION], [TIPO_DE_AGENTE], [CUENTACONTABLE], [codigoderetencionaaplicar], [ESTADO_DEL_REGISTRO]) VALUES (0, N'No Aplica', N'AVENIDA LAS AMERICAS CRA 68                                 ', N'11001000', N' ', N' ', N'', N'mauriciojaramillopardo@gmail.com', N'', N'1', CAST(N'1900-01-01T00:00:00.000' AS DateTime), N'', N'', 0, N'', N'', N'', N'', N'', N'', N'', 0, 0, 0, NULL, NULL, N'A')
INSERT [dbo].[PROVEEDORES] ([id], [nombre], [direccion], [ciudad], [telefono], [celular1], [celular2], [email1], [email2], [nit], [fechadeingreso], [observaciones], [contactos], [actividadcomercial], [seleretienefuente], [seleretieneiva], [seleretieneica], [puedecobrariva], [espersonanaturalojuridica], [declararenta], [esgrancontribuyente], [tipoderegimen], [CLASIFICACION], [TIPO_DE_AGENTE], [CUENTACONTABLE], [codigoderetencionaaplicar], [ESTADO_DEL_REGISTRO]) VALUES (1, N'Materia primas', N' ', N'11001000', N' ', N' ', N'', N'mauriciojaramillopardo@gmail.com', N'', N'2', CAST(N'2005-08-03T00:00:00.000' AS DateTime), N' ', N' ', 0, N'', N'', N'', N'', N'', N'', N'', 0, 10, 0, NULL, NULL, N'A')
INSERT [dbo].[PROVEEDORES] ([id], [nombre], [direccion], [ciudad], [telefono], [celular1], [celular2], [email1], [email2], [nit], [fechadeingreso], [observaciones], [contactos], [actividadcomercial], [seleretienefuente], [seleretieneiva], [seleretieneica], [puedecobrariva], [espersonanaturalojuridica], [declararenta], [esgrancontribuyente], [tipoderegimen], [CLASIFICACION], [TIPO_DE_AGENTE], [CUENTACONTABLE], [codigoderetencionaaplicar], [ESTADO_DEL_REGISTRO]) VALUES (2, N'Produccion', N' ', N'11001000', N' ', N' ', N'', N'mauriciojaramillopardo@gmail.com', N'', N'3', CAST(N'2008-01-01T00:00:00.000' AS DateTime), N' ', N' ', 0, N'N', N'N', N'N', N'', N'', N'N', N'N', 0, 10, 0, NULL, NULL, N'A')
INSERT [dbo].[PROVEEDORES] ([id], [nombre], [direccion], [ciudad], [telefono], [celular1], [celular2], [email1], [email2], [nit], [fechadeingreso], [observaciones], [contactos], [actividadcomercial], [seleretienefuente], [seleretieneiva], [seleretieneica], [puedecobrariva], [espersonanaturalojuridica], [declararenta], [esgrancontribuyente], [tipoderegimen], [CLASIFICACION], [TIPO_DE_AGENTE], [CUENTACONTABLE], [codigoderetencionaaplicar], [ESTADO_DEL_REGISTRO]) VALUES (3, N'Prod terminado', N'Av Cali No 132-39', N'11001000', N'2455623', N'3112569888', N'3145899669', N'mauriciojaramillopardo@gmail.com', N'', N'456789654-3', CAST(N'2008-01-01T00:00:00.000' AS DateTime), N' ', N' ', 0, N'N', N'N', N'N', N'', N'', N'N', N'N', 0, 10, 0, NULL, NULL, N'A')
INSERT [dbo].[PROVEEDORES] ([id], [nombre], [direccion], [ciudad], [telefono], [celular1], [celular2], [email1], [email2], [nit], [fechadeingreso], [observaciones], [contactos], [actividadcomercial], [seleretienefuente], [seleretieneiva], [seleretieneica], [puedecobrariva], [espersonanaturalojuridica], [declararenta], [esgrancontribuyente], [tipoderegimen], [CLASIFICACION], [TIPO_DE_AGENTE], [CUENTACONTABLE], [codigoderetencionaaplicar], [ESTADO_DEL_REGISTRO]) VALUES (10, N'Banco de Colombia', N'Bulervar 1o piso                          ', N'11001000', N'2659863             ', N'03310152659         ', N'3102565623', N'mauriciojaramillopardo@gmail.com', N'2', N'79258698 -1', CAST(N'2005-11-24T00:00:00.000' AS DateTime), N'b', N'c', 3, N'S', N'S', N'S', N'', N'J', N'S', N'S', 2, 8, 2, N'11210101', NULL, N'A')
INSERT [dbo].[PROVEEDORES] ([id], [nombre], [direccion], [ciudad], [telefono], [celular1], [celular2], [email1], [email2], [nit], [fechadeingreso], [observaciones], [contactos], [actividadcomercial], [seleretienefuente], [seleretieneiva], [seleretieneica], [puedecobrariva], [espersonanaturalojuridica], [declararenta], [esgrancontribuyente], [tipoderegimen], [CLASIFICACION], [TIPO_DE_AGENTE], [CUENTACONTABLE], [codigoderetencionaaplicar], [ESTADO_DEL_REGISTRO]) VALUES (11, N'Banco Ganadero', N'CENTRO COMERCIAL NIZA                                       ', N'11001000', N'2659896             ', N'                    ', N'', N'mauriciojaramillopardo@gmail.com', N'', N'795236598-1', CAST(N'2003-11-21T00:00:00.000' AS DateTime), N'PRESTAMO POR INTERES', N'SANDRA VARGAS', 7, N'N', N'N', N'N', N'', N'J', N'S', N'S', 2, 8, 2, N'11210102', NULL, N'A')
INSERT [dbo].[PROVEEDORES] ([id], [nombre], [direccion], [ciudad], [telefono], [celular1], [celular2], [email1], [email2], [nit], [fechadeingreso], [observaciones], [contactos], [actividadcomercial], [seleretienefuente], [seleretieneiva], [seleretieneica], [puedecobrariva], [espersonanaturalojuridica], [declararenta], [esgrancontribuyente], [tipoderegimen], [CLASIFICACION], [TIPO_DE_AGENTE], [CUENTACONTABLE], [codigoderetencionaaplicar], [ESTADO_DEL_REGISTRO]) VALUES (12, N'Almacenes Paguemenos                                  ', N'CRA 13 # 58-58 BOGOTA                                       ', N'11001000', N'2365698             ', N'03315658985         ', N'', N'mauriciojaramillopardo@gmail.com', N'', N'96336978-9', CAST(N'2003-11-21T00:00:00.000' AS DateTime), N'MERCANCIA EN CONSIGNACION', N'CARLOS ROMERO', 2, N'S', N'S', N'S', N'', N'J', N'S', N'S', 1, 5, 1, NULL, NULL, N'A')
INSERT [dbo].[PROVEEDORES] ([id], [nombre], [direccion], [ciudad], [telefono], [celular1], [celular2], [email1], [email2], [nit], [fechadeingreso], [observaciones], [contactos], [actividadcomercial], [seleretienefuente], [seleretieneiva], [seleretieneica], [puedecobrariva], [espersonanaturalojuridica], [declararenta], [esgrancontribuyente], [tipoderegimen], [CLASIFICACION], [TIPO_DE_AGENTE], [CUENTACONTABLE], [codigoderetencionaaplicar], [ESTADO_DEL_REGISTRO]) VALUES (13, N'Proveedora rioka', N'FACATATIVA                                                  ', N'11001000', N'2011006             ', N'03315636998         ', N'', N'mauriciojaramillopardo@gmail.com', N'', N'963258963-1', CAST(N'2003-11-21T00:00:00.000' AS DateTime), N'RIANURA SELIN', N'CARMENZA FLORES', 2, N'S', N'S', N'S', N'', N'J', N'S', N'S', 1, 2, 3, N'2110101', NULL, N'A')
INSERT [dbo].[PROVEEDORES] ([id], [nombre], [direccion], [ciudad], [telefono], [celular1], [celular2], [email1], [email2], [nit], [fechadeingreso], [observaciones], [contactos], [actividadcomercial], [seleretienefuente], [seleretieneiva], [seleretieneica], [puedecobrariva], [espersonanaturalojuridica], [declararenta], [esgrancontribuyente], [tipoderegimen], [CLASIFICACION], [TIPO_DE_AGENTE], [CUENTACONTABLE], [codigoderetencionaaplicar], [ESTADO_DEL_REGISTRO]) VALUES (14, N'Almacens al costo', N'CALLE 131 KRA 107 AURES II                                  ', N'11001000', N'6875989             ', N'                    ', N'', N'mauriciojaramillopardo@gmail.com', N'', N'125896369-7 ', CAST(N'2005-08-03T00:00:00.000' AS DateTime), N'', N'', 1, N'S', N'S', N'S', N'', N'J', N'S', N'S', 1, 5, 1, NULL, NULL, N'A')
INSERT [dbo].[PROVEEDORES] ([id], [nombre], [direccion], [ciudad], [telefono], [celular1], [celular2], [email1], [email2], [nit], [fechadeingreso], [observaciones], [contactos], [actividadcomercial], [seleretienefuente], [seleretieneiva], [seleretieneica], [puedecobrariva], [espersonanaturalojuridica], [declararenta], [esgrancontribuyente], [tipoderegimen], [CLASIFICACION], [TIPO_DE_AGENTE], [CUENTACONTABLE], [codigoderetencionaaplicar], [ESTADO_DEL_REGISTRO]) VALUES (20, N'carlos lopez', N'', N'', N'', N'', N'', N'mauriciojaramillopardo@gmail.com', N'', N'79868400', CAST(N'2019-01-01T00:00:00.000' AS DateTime), N'', N'', 0, N'', N'', N'', N'', N'', N'', N'', 0, 14, 4, NULL, NULL, N'A')
INSERT [dbo].[PROVEEDORES] ([id], [nombre], [direccion], [ciudad], [telefono], [celular1], [celular2], [email1], [email2], [nit], [fechadeingreso], [observaciones], [contactos], [actividadcomercial], [seleretienefuente], [seleretieneiva], [seleretieneica], [puedecobrariva], [espersonanaturalojuridica], [declararenta], [esgrancontribuyente], [tipoderegimen], [CLASIFICACION], [TIPO_DE_AGENTE], [CUENTACONTABLE], [codigoderetencionaaplicar], [ESTADO_DEL_REGISTRO]) VALUES (21, N'maria andara', N'', N'', N'', N'', N'', N'mauriciojaramillopardo@gmail.com', N'', N'75862659', CAST(N'2019-01-01T00:00:00.000' AS DateTime), N'', N'', 0, N'', N'', N'', N'', N'', N'', N'', 0, 14, 4, NULL, NULL, N'A')
INSERT [dbo].[PROVEEDORES] ([id], [nombre], [direccion], [ciudad], [telefono], [celular1], [celular2], [email1], [email2], [nit], [fechadeingreso], [observaciones], [contactos], [actividadcomercial], [seleretienefuente], [seleretieneiva], [seleretieneica], [puedecobrariva], [espersonanaturalojuridica], [declararenta], [esgrancontribuyente], [tipoderegimen], [CLASIFICACION], [TIPO_DE_AGENTE], [CUENTACONTABLE], [codigoderetencionaaplicar], [ESTADO_DEL_REGISTRO]) VALUES (22, N'Proveedora jumbo', N'PLAZA IMPERIAL', N'11001000', N'2568485', N'3102458595', N'', N'mauriciojaramillopardo@gmail.com', N'', N'864562326-9', CAST(N'2003-11-21T00:00:00.000' AS DateTime), N'', N'DANI TREJO', 2, N'S', N'S', N'S', N'', N'J', N'S', N'S', 1, 2, 3, N'2110102', NULL, N'A')
SET IDENTITY_INSERT [dbo].[PROVEEDORES] OFF
GO
SET IDENTITY_INSERT [dbo].[RETENCIONES] ON 

INSERT [dbo].[RETENCIONES] ([ID], [NOMBRE], [PORCENTAJE], [BASE], [RETIENESOBREIVA], [TIPODERETENCION], [ESTADO_DEL_REGISTRO]) VALUES (0, N'No aplica..', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'', 0, N'A')
INSERT [dbo].[RETENCIONES] ([ID], [NOMBRE], [PORCENTAJE], [BASE], [RETIENESOBREIVA], [TIPODERETENCION], [ESTADO_DEL_REGISTRO]) VALUES (1, N'RETENCION EN LA FUENTE PERSONAS NATURALES.', CAST(10.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'N', 1, N'A')
INSERT [dbo].[RETENCIONES] ([ID], [NOMBRE], [PORCENTAJE], [BASE], [RETIENESOBREIVA], [TIPODERETENCION], [ESTADO_DEL_REGISTRO]) VALUES (2, N'RETENCION EN LA FUENTE PERSONA JURIDICA.', CAST(11.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'N', 1, N'A')
INSERT [dbo].[RETENCIONES] ([ID], [NOMBRE], [PORCENTAJE], [BASE], [RETIENESOBREIVA], [TIPODERETENCION], [ESTADO_DEL_REGISTRO]) VALUES (3, N'RETENCION SOBRE IVA', CAST(50.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'S', 2, N'A')
INSERT [dbo].[RETENCIONES] ([ID], [NOMBRE], [PORCENTAJE], [BASE], [RETIENESOBREIVA], [TIPODERETENCION], [ESTADO_DEL_REGISTRO]) VALUES (4, N'RETENCION DE INDUSTRIA Y COMERCIO.', CAST(6.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'N', 3, N'A')
SET IDENTITY_INSERT [dbo].[RETENCIONES] OFF
GO
SET IDENTITY_INSERT [dbo].[SALDOS] ON 

INSERT [dbo].[SALDOS] ([id], [PRODUCTO], [bodega], [saldoinicial], [entradas], [salidas], [saldo], [saldofisico], [costoultimo], [costopromedio], [fechadelaultimaentrada], [fechadelaultimasalida], [stockminimo], [stockmaximo], [ESTADO_DEL_REGISTRO]) VALUES (1332, N'15', 2, CAST(0.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(2.75000 AS Decimal(18, 5)), CAST(997.25000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), N'')
INSERT [dbo].[SALDOS] ([id], [PRODUCTO], [bodega], [saldoinicial], [entradas], [salidas], [saldo], [saldofisico], [costoultimo], [costopromedio], [fechadelaultimaentrada], [fechadelaultimasalida], [stockminimo], [stockmaximo], [ESTADO_DEL_REGISTRO]) VALUES (1333, N'16', 2, CAST(0.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(220.00000 AS Decimal(18, 5)), CAST(780.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), N'')
INSERT [dbo].[SALDOS] ([id], [PRODUCTO], [bodega], [saldoinicial], [entradas], [salidas], [saldo], [saldofisico], [costoultimo], [costopromedio], [fechadelaultimaentrada], [fechadelaultimasalida], [stockminimo], [stockmaximo], [ESTADO_DEL_REGISTRO]) VALUES (1334, N'17', 2, CAST(0.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(165.00000 AS Decimal(18, 5)), CAST(835.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), N'')
INSERT [dbo].[SALDOS] ([id], [PRODUCTO], [bodega], [saldoinicial], [entradas], [salidas], [saldo], [saldofisico], [costoultimo], [costopromedio], [fechadelaultimaentrada], [fechadelaultimasalida], [stockminimo], [stockmaximo], [ESTADO_DEL_REGISTRO]) VALUES (1335, N'21', 2, CAST(0.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(10.00000 AS Decimal(18, 5)), CAST(990.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(850.00000 AS Decimal(18, 5)), CAST(850.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), N'')
INSERT [dbo].[SALDOS] ([id], [PRODUCTO], [bodega], [saldoinicial], [entradas], [salidas], [saldo], [saldofisico], [costoultimo], [costopromedio], [fechadelaultimaentrada], [fechadelaultimasalida], [stockminimo], [stockmaximo], [ESTADO_DEL_REGISTRO]) VALUES (1336, N'22', 2, CAST(0.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(25.00000 AS Decimal(18, 5)), CAST(975.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(350.00000 AS Decimal(18, 5)), CAST(350.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), N'')
INSERT [dbo].[SALDOS] ([id], [PRODUCTO], [bodega], [saldoinicial], [entradas], [salidas], [saldo], [saldofisico], [costoultimo], [costopromedio], [fechadelaultimaentrada], [fechadelaultimasalida], [stockminimo], [stockmaximo], [ESTADO_DEL_REGISTRO]) VALUES (1337, N'14', 3, CAST(0.00000 AS Decimal(18, 5)), CAST(11.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(11.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'1900-01-01T00:00:00.000' AS DateTime), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), N'')
INSERT [dbo].[SALDOS] ([id], [PRODUCTO], [bodega], [saldoinicial], [entradas], [salidas], [saldo], [saldofisico], [costoultimo], [costopromedio], [fechadelaultimaentrada], [fechadelaultimasalida], [stockminimo], [stockmaximo], [ESTADO_DEL_REGISTRO]) VALUES (1341, N'20', 3, CAST(0.00000 AS Decimal(18, 5)), CAST(5.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(5.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(1800.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'1900-01-01T00:00:00.000' AS DateTime), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), N'')
SET IDENTITY_INSERT [dbo].[SALDOS] OFF
GO
SET IDENTITY_INSERT [dbo].[TIPOSDEDEDOCUMENTO] ON 

INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADELDOCUMENTO], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [tipoagentedespacha], [tipoagenterecibe], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO]) VALUES (7, N'cc nota credito', N'ncr', CAST(0 AS Decimal(18, 0)), NULL, NULL, N'A', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'A')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADELDOCUMENTO], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [tipoagentedespacha], [tipoagenterecibe], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO]) VALUES (8, N'cc nota debito', N'ndb', CAST(0 AS Decimal(18, 0)), NULL, NULL, N'A', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'A')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADELDOCUMENTO], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [tipoagentedespacha], [tipoagenterecibe], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO]) VALUES (9, N'cc recibo de caja', N'r.caja', CAST(0 AS Decimal(18, 0)), NULL, NULL, N'A', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'A')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADELDOCUMENTO], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [tipoagentedespacha], [tipoagenterecibe], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO]) VALUES (11, N'cp nota debito', N'ndb', CAST(0 AS Decimal(18, 0)), NULL, NULL, N'A', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'A')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADELDOCUMENTO], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [tipoagentedespacha], [tipoagenterecibe], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO]) VALUES (12, N'cp nota credito', N'ncr', CAST(0 AS Decimal(18, 0)), NULL, NULL, N'A', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'A')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADELDOCUMENTO], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [tipoagentedespacha], [tipoagenterecibe], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO]) VALUES (14, N'mp  devolucion al proveedor', N'devolucion', CAST(0 AS Decimal(18, 0)), NULL, NULL, N'A', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'A')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADELDOCUMENTO], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [tipoagentedespacha], [tipoagenterecibe], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO]) VALUES (15, N'inventario fisico', N'inv fisico', CAST(0 AS Decimal(18, 0)), NULL, NULL, N'A', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'A')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADELDOCUMENTO], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [tipoagentedespacha], [tipoagenterecibe], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO]) VALUES (16, N'mp  orden de compra', N'orden comp', CAST(0 AS Decimal(18, 0)), NULL, NULL, N'A', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'A')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADELDOCUMENTO], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [tipoagentedespacha], [tipoagenterecibe], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO]) VALUES (17, N'mp  remision de compra', N'remision', CAST(0 AS Decimal(18, 0)), NULL, NULL, N'A', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'A')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADELDOCUMENTO], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [tipoagentedespacha], [tipoagenterecibe], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO]) VALUES (18, N'inventario inicial', N'S.inicial', CAST(0 AS Decimal(18, 0)), NULL, NULL, N'A', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'A')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADELDOCUMENTO], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [tipoagentedespacha], [tipoagenterecibe], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO]) VALUES (19, N'Salidas por ajuste', N'ajuste -', CAST(0 AS Decimal(18, 0)), NULL, NULL, N'A', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'A')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADELDOCUMENTO], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [tipoagentedespacha], [tipoagenterecibe], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO]) VALUES (20, N'Entradas por  ajuste', N'ajuste +', CAST(1 AS Decimal(18, 0)), NULL, NULL, N'A', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'A')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADELDOCUMENTO], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [tipoagentedespacha], [tipoagenterecibe], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO]) VALUES (21, N'te devolucion del cliente', N'devolucion', CAST(0 AS Decimal(18, 0)), NULL, NULL, N'A', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'A')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADELDOCUMENTO], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [tipoagentedespacha], [tipoagenterecibe], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO]) VALUES (22, N'te pedidos del cliente', N'pedido', CAST(3 AS Decimal(18, 0)), NULL, NULL, N'A', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'A')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADELDOCUMENTO], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [tipoagentedespacha], [tipoagenterecibe], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO]) VALUES (23, N'te remision al cliente ', N'remision', CAST(0 AS Decimal(18, 0)), NULL, NULL, N'A', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'A')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADELDOCUMENTO], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [tipoagentedespacha], [tipoagenterecibe], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO]) VALUES (25, N'traslado', N'Traslado', CAST(0 AS Decimal(18, 0)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'A')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADELDOCUMENTO], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [tipoagentedespacha], [tipoagenterecibe], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO]) VALUES (28, N'Factura de venta', N'factura', CAST(0 AS Decimal(18, 0)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'A')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADELDOCUMENTO], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [tipoagentedespacha], [tipoagenterecibe], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO]) VALUES (29, N'pr Orden de produccion', N'Ord.Pro', CAST(0 AS Decimal(18, 0)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'A')
INSERT [dbo].[TIPOSDEDEDOCUMENTO] ([ID], [NOMBRE], [abreviatura], [consecutivo], [cuentacontabledebito], [cuentacontablecredito], [DESPACHA], [RECIBE], [PIDEFECHADELDOCUMENTO], [PIDEFECHADEVENCIMIENTO], [pideprograma], [pideconceptonotadebitocredito], [pidevendedor], [pidetipodedocumentoaafectar], [pideproducto], [pidetalla], [pidecolor], [pideempaque], [pidecantidad], [pidevalorunitario], [pidesubtotal], [pidedescuentodetalle], [pideivadetalle], [pidetipodedocumentoaafectardetalle], [pideconsecutivoautomatico], [eldocumentoseimprime], [esunacompra], [esunaventa], [esunpago], [restarcartera], [sumarcartera], [restainventario], [sumainventario], [saldarcantidadesdeldocumentollamado], [leyendaimpresaeneldocumento], [pidefisico], [tipoagentedespacha], [tipoagenterecibe], [eldocumentoallamarsolosepuedellamarunavez], [eldocumentoseimprimeanombrededespachaorecibe], [esunanota], [esuninventarioinicial], [ESTADO_DEL_REGISTRO]) VALUES (30, N'pr Entrega producto terminado', N'Ent.Pro', CAST(0 AS Decimal(18, 0)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'A')
SET IDENTITY_INSERT [dbo].[TIPOSDEDEDOCUMENTO] OFF
GO
SET IDENTITY_INSERT [dbo].[TIPOSDEPROGRAMAS] ON 

INSERT [dbo].[TIPOSDEPROGRAMAS] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (0, N'No aplica', N'A')
INSERT [dbo].[TIPOSDEPROGRAMAS] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (1, N'CAJANAL', N'A')
INSERT [dbo].[TIPOSDEPROGRAMAS] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (2, N'FERROVIAS', N'A')
INSERT [dbo].[TIPOSDEPROGRAMAS] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (3, N'ISS...', N'A')
SET IDENTITY_INSERT [dbo].[TIPOSDEPROGRAMAS] OFF
GO
SET IDENTITY_INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ON 

INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10755 AS Decimal(18, 0)), 12, 2, 29, 1, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-03-14T00:00:00.000' AS DateTime), 0, 20, 0, N'', 0, 0, N'  ', N'0', N'14', N'coctel de camarones.', CAST(1 AS Decimal(18, 0)), N'BL', CAST(10.00000 AS Decimal(18, 5)), CAST(10.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(50000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 8000, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(58000.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'', N'', N'', CAST(N'2020-02-13T13:19:47.353' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10757 AS Decimal(18, 0)), 14, 2, 29, 2, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-03-14T00:00:00.000' AS DateTime), 0, 20, 0, N'', 0, 0, N' ', N'0', N'14', N'coctel de camarones.', CAST(1 AS Decimal(18, 0)), N'BL', CAST(10.00000 AS Decimal(18, 5)), CAST(10.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(50000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 8000, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(58000.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'', N'', N'', CAST(N'2020-02-13T13:25:26.967' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10758 AS Decimal(18, 0)), 12, 2, 29, 3, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-03-14T00:00:00.000' AS DateTime), 0, 20, 0, N'', 0, 0, N' ', N'0', N'20', N'coctel de coco loco.', CAST(1 AS Decimal(18, 0)), N'BL', CAST(5.00000 AS Decimal(18, 5)), CAST(5.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(1800.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(25000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 4000, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(29000.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'', N'', N'', CAST(N'2020-02-13T13:32:58.173' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10764 AS Decimal(18, 0)), 12, 2, 44, 1, 12, 2, 29, 1, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'   ', N'0', N'14', N'coctel de camarones.', CAST(1 AS Decimal(18, 0)), N'BL', CAST(10.00000 AS Decimal(18, 5)), CAST(10.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(50000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 8000, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(58000.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'', N'', N'', CAST(N'2020-02-13T14:30:53.877' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10765 AS Decimal(18, 0)), 14, 2, 44, 2, 14, 2, 29, 2, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'  ', N'0', N'14', N'coctel de camarones.', CAST(1 AS Decimal(18, 0)), N'BL', CAST(10.00000 AS Decimal(18, 5)), CAST(10.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(50000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 8000, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(58000.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'', N'', N'', CAST(N'2020-02-13T14:31:15.413' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10766 AS Decimal(18, 0)), 12, 2, 44, 3, 12, 2, 29, 3, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'  ', N'0', N'20', N'coctel de coco loco.', CAST(1 AS Decimal(18, 0)), N'BL', CAST(5.00000 AS Decimal(18, 5)), CAST(5.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(1800.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(25000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 4000, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(29000.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'', N'', N'', CAST(N'2020-02-13T14:31:31.550' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10804 AS Decimal(18, 0)), 0, 2, 22, 1, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'15', N'camaron', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(5000000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 800000, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(5800000.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'+', N'', N'', CAST(N'2020-02-13T19:15:30.970' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10805 AS Decimal(18, 0)), 0, 2, 22, 1, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'16', N'salsa de tomate', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(3000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 480, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(3480.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'+', N'', N'', CAST(N'2020-02-13T19:15:30.970' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10806 AS Decimal(18, 0)), 0, 2, 22, 1, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'17', N'mayonesa', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(2000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 320, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(2320.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'+', N'', N'', CAST(N'2020-02-13T19:15:30.970' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10807 AS Decimal(18, 0)), 0, 2, 22, 1, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'21', N'jugo de coco', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(850.00000 AS Decimal(18, 5)), CAST(800.00000 AS Decimal(18, 5)), CAST(850.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(850000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 136000, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(986000.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'+', N'', N'', CAST(N'2020-02-13T19:15:30.970' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10808 AS Decimal(18, 0)), 0, 2, 22, 1, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'22', N'pina colada', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(350.00000 AS Decimal(18, 5)), CAST(300.00000 AS Decimal(18, 5)), CAST(350.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(350000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 56000, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(406000.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'+', N'', N'', CAST(N'2020-02-13T19:15:30.970' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10809 AS Decimal(18, 0)), 2, 3, 45, 4, 12, 2, 44, 1, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'    ', N'0', N'14', N'coctel de camarones.', CAST(1 AS Decimal(18, 0)), N'BL', CAST(3.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(6000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 960, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(6960.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:16:37.603' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10810 AS Decimal(18, 0)), 2, 3, 45, 4, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'    ', N'14', N'15', N'camaron', CAST(1 AS Decimal(18, 0)), N'0', CAST(0.75000 AS Decimal(18, 5)), CAST(0.75000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(3750.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(3750.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:16:37.620' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10811 AS Decimal(18, 0)), 2, 3, 45, 4, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'    ', N'14', N'17', N'mayonesa', CAST(1 AS Decimal(18, 0)), N'0', CAST(45.00000 AS Decimal(18, 5)), CAST(45.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(90.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(90.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:16:37.627' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10812 AS Decimal(18, 0)), 2, 3, 45, 4, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'    ', N'14', N'16', N'salsa de tomate', CAST(1 AS Decimal(18, 0)), N'0', CAST(60.00000 AS Decimal(18, 5)), CAST(60.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(180.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(180.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:16:37.637' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10813 AS Decimal(18, 0)), 2, 3, 45, 5, 14, 2, 44, 2, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'   ', N'0', N'14', N'coctel de camarones.', CAST(1 AS Decimal(18, 0)), N'BL', CAST(3.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(6000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 960, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(6960.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:17:20.383' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10814 AS Decimal(18, 0)), 2, 3, 45, 5, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'   ', N'14', N'15', N'camaron', CAST(1 AS Decimal(18, 0)), N'0', CAST(0.75000 AS Decimal(18, 5)), CAST(0.75000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(3750.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(3750.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:17:20.400' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10815 AS Decimal(18, 0)), 2, 3, 45, 5, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'   ', N'14', N'17', N'mayonesa', CAST(1 AS Decimal(18, 0)), N'0', CAST(45.00000 AS Decimal(18, 5)), CAST(45.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(90.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(90.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:17:20.410' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10816 AS Decimal(18, 0)), 2, 3, 45, 5, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'   ', N'14', N'16', N'salsa de tomate', CAST(1 AS Decimal(18, 0)), N'0', CAST(60.00000 AS Decimal(18, 5)), CAST(60.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(180.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(180.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:17:20.420' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10817 AS Decimal(18, 0)), 2, 3, 45, 6, 12, 2, 44, 3, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'   ', N'0', N'20', N'coctel de coco loco.', CAST(1 AS Decimal(18, 0)), N'BL', CAST(3.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(1800.00000 AS Decimal(18, 5)), CAST(1800.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(5400.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 864, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(6264.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:17:43.100' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10818 AS Decimal(18, 0)), 2, 3, 45, 6, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'   ', N'20', N'21', N'jugo de coco', CAST(1 AS Decimal(18, 0)), N'0', CAST(6.00000 AS Decimal(18, 5)), CAST(6.00000 AS Decimal(18, 5)), CAST(850.00000 AS Decimal(18, 5)), CAST(800.00000 AS Decimal(18, 5)), CAST(850.00000 AS Decimal(18, 5)), CAST(850.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(5100.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(5100.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:17:43.110' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10819 AS Decimal(18, 0)), 2, 3, 45, 6, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'   ', N'20', N'22', N'pina colada', CAST(1 AS Decimal(18, 0)), N'0', CAST(15.00000 AS Decimal(18, 5)), CAST(15.00000 AS Decimal(18, 5)), CAST(350.00000 AS Decimal(18, 5)), CAST(300.00000 AS Decimal(18, 5)), CAST(350.00000 AS Decimal(18, 5)), CAST(350.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(5250.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(5250.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:17:43.120' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10820 AS Decimal(18, 0)), 2, 3, 45, 7, 12, 2, 44, 1, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'    ', N'0', N'14', N'coctel de camarones.', CAST(1 AS Decimal(18, 0)), N'BL', CAST(2.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(4000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 640, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(4640.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:36:28.220' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10821 AS Decimal(18, 0)), 2, 3, 45, 7, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'    ', N'14', N'15', N'camaron', CAST(1 AS Decimal(18, 0)), N'0', CAST(0.50000 AS Decimal(18, 5)), CAST(0.50000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(2500.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(2500.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:36:28.240' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10822 AS Decimal(18, 0)), 2, 3, 45, 7, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'    ', N'14', N'17', N'mayonesa', CAST(1 AS Decimal(18, 0)), N'0', CAST(30.00000 AS Decimal(18, 5)), CAST(30.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(60.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(60.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:36:28.247' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10823 AS Decimal(18, 0)), 2, 3, 45, 7, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'    ', N'14', N'16', N'salsa de tomate', CAST(1 AS Decimal(18, 0)), N'0', CAST(40.00000 AS Decimal(18, 5)), CAST(40.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(120.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(120.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:36:28.253' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10824 AS Decimal(18, 0)), 2, 3, 45, 8, 14, 2, 44, 2, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'   ', N'0', N'14', N'coctel de camarones.', CAST(1 AS Decimal(18, 0)), N'BL', CAST(3.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(6000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 960, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(6960.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:37:46.857' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10825 AS Decimal(18, 0)), 2, 3, 45, 8, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'   ', N'14', N'15', N'camaron', CAST(1 AS Decimal(18, 0)), N'0', CAST(0.75000 AS Decimal(18, 5)), CAST(0.75000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(3750.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(3750.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:37:46.870' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10826 AS Decimal(18, 0)), 2, 3, 45, 8, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'   ', N'14', N'17', N'mayonesa', CAST(1 AS Decimal(18, 0)), N'0', CAST(45.00000 AS Decimal(18, 5)), CAST(45.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(90.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(90.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:37:46.880' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10827 AS Decimal(18, 0)), 2, 3, 45, 8, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'   ', N'14', N'16', N'salsa de tomate', CAST(1 AS Decimal(18, 0)), N'0', CAST(60.00000 AS Decimal(18, 5)), CAST(60.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(180.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(180.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:37:46.887' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10828 AS Decimal(18, 0)), 2, 3, 45, 9, 12, 2, 44, 3, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'   ', N'0', N'20', N'coctel de coco loco.', CAST(1 AS Decimal(18, 0)), N'BL', CAST(2.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(1800.00000 AS Decimal(18, 5)), CAST(1800.00000 AS Decimal(18, 5)), CAST(2000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(3600.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 576, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(4176.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:38:00.823' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10829 AS Decimal(18, 0)), 2, 3, 45, 9, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'   ', N'20', N'21', N'jugo de coco', CAST(1 AS Decimal(18, 0)), N'0', CAST(4.00000 AS Decimal(18, 5)), CAST(4.00000 AS Decimal(18, 5)), CAST(850.00000 AS Decimal(18, 5)), CAST(800.00000 AS Decimal(18, 5)), CAST(850.00000 AS Decimal(18, 5)), CAST(850.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(3400.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(3400.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:38:00.833' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10830 AS Decimal(18, 0)), 2, 3, 45, 9, 0, 0, 0, 0, CAST(N'2020-02-13T00:00:00.000' AS DateTime), CAST(N'2020-02-13T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N'   ', N'20', N'22', N'pina colada', CAST(1 AS Decimal(18, 0)), N'0', CAST(10.00000 AS Decimal(18, 5)), CAST(10.00000 AS Decimal(18, 5)), CAST(350.00000 AS Decimal(18, 5)), CAST(300.00000 AS Decimal(18, 5)), CAST(350.00000 AS Decimal(18, 5)), CAST(350.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(3500.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(3500.00000 AS Decimal(18, 5)), CAST(N'2020-02-13T00:00:00.000' AS DateTime), N'', N'', N'-', N'', N'', CAST(N'2020-02-13T19:38:00.843' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10831 AS Decimal(18, 0)), 22, 1, 11, 100, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'15', N'camaron', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(5000000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 800000, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 2, CAST(11.00 AS Numeric(5, 2)), 550550, 4, CAST(6.00 AS Numeric(5, 2)), 300300, CAST(5800000.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:26:16.290' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10832 AS Decimal(18, 0)), 22, 1, 11, 100, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'16', N'salsa de tomate', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(3000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 480, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(3480.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:26:16.290' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10833 AS Decimal(18, 0)), 22, 1, 11, 100, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'17', N'mayonesa', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(2000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 320, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(2320.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:26:16.290' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10834 AS Decimal(18, 0)), 22, 1, 11, 101, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'15', N'camaron', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(5000000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 800000, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 2, CAST(11.00 AS Numeric(5, 2)), 550550, 4, CAST(6.00 AS Numeric(5, 2)), 300300, CAST(5800000.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:33:51.950' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10835 AS Decimal(18, 0)), 22, 1, 11, 101, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'16', N'salsa de tomate', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(3000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 480, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(3480.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:33:51.950' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10836 AS Decimal(18, 0)), 22, 1, 11, 101, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'17', N'mayonesa', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(2000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 320, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(2320.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:33:51.950' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10837 AS Decimal(18, 0)), 13, 1, 11, 102, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'15', N'camaron', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(5000000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 800000, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 2, CAST(11.00 AS Numeric(5, 2)), 550550, 3, CAST(50.00 AS Numeric(5, 2)), 2502500, CAST(5800000.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:36:30.203' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10838 AS Decimal(18, 0)), 13, 1, 11, 102, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'16', N'salsa de tomate', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(3000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 480, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(3480.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:36:30.203' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10839 AS Decimal(18, 0)), 13, 1, 11, 102, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'17', N'mayonesa', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(2000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 320, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(2320.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:36:30.203' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10840 AS Decimal(18, 0)), 13, 1, 11, 103, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'15', N'camaron', CAST(1 AS Decimal(18, 0)), N'BL', CAST(500.00000 AS Decimal(18, 5)), CAST(500.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(2500000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 400000, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 2, CAST(11.00 AS Numeric(5, 2)), 275275, 3, CAST(50.00 AS Numeric(5, 2)), 1251250, CAST(2900000.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:39:51.113' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10841 AS Decimal(18, 0)), 13, 1, 11, 103, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'16', N'salsa de tomate', CAST(1 AS Decimal(18, 0)), N'BL', CAST(500.00000 AS Decimal(18, 5)), CAST(500.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(1500.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 240, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(1740.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:39:51.113' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10842 AS Decimal(18, 0)), 13, 1, 11, 103, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'17', N'mayonesa', CAST(1 AS Decimal(18, 0)), N'BL', CAST(500.00000 AS Decimal(18, 5)), CAST(500.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(1000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 160, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(1160.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:39:51.113' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10843 AS Decimal(18, 0)), 13, 1, 11, 104, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'15', N'camaron', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(5000000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 800000, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 2, CAST(11.00 AS Numeric(5, 2)), 550550, 3, CAST(50.00 AS Numeric(5, 2)), 2502500, CAST(5800000.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:43:41.653' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10844 AS Decimal(18, 0)), 13, 1, 11, 104, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'16', N'salsa de tomate', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(3000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 480, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(3480.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:43:41.653' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10845 AS Decimal(18, 0)), 13, 1, 11, 104, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'17', N'mayonesa', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(2000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 320, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(2320.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:43:41.653' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10846 AS Decimal(18, 0)), 13, 1, 11, 105, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'15', N'camaron', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(5000000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 800000, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 2, CAST(11.00 AS Numeric(5, 2)), 550550, 3, CAST(50.00 AS Numeric(5, 2)), 2502500, CAST(5800000.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:46:10.507' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10847 AS Decimal(18, 0)), 13, 1, 11, 105, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'16', N'salsa de tomate', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(3.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(3000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 480, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(3480.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:46:10.507' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10848 AS Decimal(18, 0)), 13, 1, 11, 105, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'17', N'mayonesa', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(2.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(2000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 320, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, 0, CAST(0.00 AS Numeric(5, 2)), 0, CAST(2320.00000 AS Decimal(18, 5)), CAST(N'2020-02-15T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T11:46:10.507' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] ([ID], [DESPACHA], [RECIBE], [TIPODEDOCUMENTO], [NUMERODELDOCUMENTO], [DESPACHAAAFECTAR], [RECIBEAAFECTAR], [TIPODEDOCUMENTOAAFECTAR], [NUMERODELDOCUMENTOAAFECTAR], [FECHADELDOCUMENTO], [FECHADEVENCIMIENTODELDOCUMENTO], [PROGRAMA], [VENDEDOR], [FORMADEPAGO], [NUMERODELPAGO], [BANCO], [CODIGOCONCEPTONOTADEBITOCREDITO], [OBSERVACIONES], [FORMULA], [PRODUCTO], [DETALLE_DEL_PRODUCTO], [NUMERODEEMPAQUES], [UNIDADDEEMPAQUE], [CANTIDADPOREMPAQUE], [CANTIDAD], [VALORUNITARIO], [COSTODEPRODUCCIONPORUNIDAD], [COSTOULTIMOPORUNIDAD], [COSTOPROMEDIOPORUNIDAD], [COSTOFLETEPORUNIDAD], [SUBTOTAL], [CODIGODESCUENTO1], [PORCENTAJEDESCUENTO1], [VALORDESCUENTO1], [CODIGODESCUENTO2], [PORCENTAJEDESCUENTO2], [VALORDESCUENTO2], [CODIGOIVA1], [PORCENTAJEDEIVA1], [VALORIVA1], [CODIGOIVA2], [PORCENTAJEDEIVA2], [VALORIVA2], [FLETES], [CODIGORETENCION1], [PORCENTAJEDERETENCION1], [VALORRETENCION1], [CODIGORETENCION2], [PORCENTAJEDERETENCION2], [VALORRETENCION2], [VALORNETO], [FECHADEPROGRAMACIONDELPAGO], [LA_CANTIDAD_ESTA_DESPACHADA], [EL_DOCUMENTO_ESTA_CANCELADO], [SUMA_O_RESTA_EN_INVENTARIO], [SUMA_O_RESTA_EN_CARTERA], [ESTADO_DEL_REGISTRO], [FECHA_DE_CREACION], [USUARIO_QUE_ACTUALIZO], [TRASLADO_RECIBIDO_Y_APROBADO_POR], [FECHA_TRASLADO_RECIBIDO_Y_APROBADO]) VALUES (CAST(10849 AS Decimal(18, 0)), 22, 1, 11, 106, 0, 0, 0, 0, CAST(N'2020-02-14T00:00:00.000' AS DateTime), CAST(N'2020-03-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0, 0, N' ', N'0', N'15', N'camaron', CAST(1 AS Decimal(18, 0)), N'BL', CAST(1000.00000 AS Decimal(18, 5)), CAST(1000.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(5000.00000 AS Decimal(18, 5)), CAST(0.00000 AS Decimal(18, 5)), CAST(0.00 AS Decimal(18, 2)), CAST(5000000.00000 AS Decimal(18, 5)), 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, CAST(0.00 AS Decimal(5, 2)), 0, 1, CAST(16.00 AS Decimal(5, 2)), 800000, 0, CAST(0.00 AS Decimal(5, 2)), 0, 0, 2, CAST(11.00 AS Numeric(5, 2)), 550000, 4, CAST(6.00 AS Numeric(5, 2)), 300000, CAST(5800000.00000 AS Decimal(18, 5)), CAST(N'2020-02-20T00:00:00.000' AS DateTime), N'', N'', N'', N'+', N'', CAST(N'2020-02-14T14:33:40.570' AS DateTime), N'ADMINISTRADOR | AREA SISTEMAS.. |  CARGO JEFE', NULL, NULL)
SET IDENTITY_INSERT [dbo].[TMP_MOVIMIENTODEINVENTARIOS] OFF
GO
SET IDENTITY_INSERT [dbo].[UNIDADESDEMEDIDA] ON 

INSERT [dbo].[UNIDADESDEMEDIDA] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (0, N'No aplica', NULL)
INSERT [dbo].[UNIDADESDEMEDIDA] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (1, N'Bolsa', NULL)
INSERT [dbo].[UNIDADESDEMEDIDA] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (2, N'Caja', NULL)
INSERT [dbo].[UNIDADESDEMEDIDA] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (3, N'Cms', NULL)
INSERT [dbo].[UNIDADESDEMEDIDA] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (4, N'Frasco', NULL)
INSERT [dbo].[UNIDADESDEMEDIDA] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (5, N'Grajea', NULL)
INSERT [dbo].[UNIDADESDEMEDIDA] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (6, N'Grm', NULL)
INSERT [dbo].[UNIDADESDEMEDIDA] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (7, N'Filo', NULL)
INSERT [dbo].[UNIDADESDEMEDIDA] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (8, N'lbr', NULL)
INSERT [dbo].[UNIDADESDEMEDIDA] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (9, N'litro', NULL)
INSERT [dbo].[UNIDADESDEMEDIDA] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (10, N'mililitro', NULL)
INSERT [dbo].[UNIDADESDEMEDIDA] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (11, N'Mtr', NULL)
INSERT [dbo].[UNIDADESDEMEDIDA] ([ID], [NOMBRE], [ESTADO_DEL_REGISTRO]) VALUES (12, N'Unidad', NULL)
SET IDENTITY_INSERT [dbo].[UNIDADESDEMEDIDA] OFF
GO
SET IDENTITY_INSERT [dbo].[USUARIOS] ON 

INSERT [dbo].[USUARIOS] ([ID], [AREA], [NOMBRE], [CARGO], [DIRECCION], [TELEFONO], [CORREO_ELECTRONICO], [LOGIN], [PASSWORD], [PERFIL], [TIPOSDEDOCUMENTO], [BODEGA], [ESTADO_DEL_REGISTRO]) VALUES (1, N'SISTEMAS.....', N'ADMINISTRADOR...', N'JEFE...', N'MINCULTURA', N'2565656', N'ADMIN@HOTMAIL.COM', N'ADMIN', N'ADMIN', 1, N',7=AMBIN,8=AMBIN,9=AMBIN,12=AMBIN,11=AMBIN,20=AMBIN,28=AMBIN,15=AMBIN,18=AMBIN,14=AMBIN,16=AMBIN,17=AMBIN,30=AMBIN,29=AMBIN,19=AMBIN,21=AMBIN,22=AMBIN,23=AMBIN,25=AMBIN,', 1, N'A')
INSERT [dbo].[USUARIOS] ([ID], [AREA], [NOMBRE], [CARGO], [DIRECCION], [TELEFONO], [CORREO_ELECTRONICO], [LOGIN], [PASSWORD], [PERFIL], [TIPOSDEDOCUMENTO], [BODEGA], [ESTADO_DEL_REGISTRO]) VALUES (2, N'INFORMATICA', N'Revisor lopez', N'director', N'car 123  No 14-26', N'2459696', N'supervisor@hotmail.com', N'REVISOR', N'REVISOR', 2, N'7=AMBIN,8=AMBIN,9=AMBIN,', 1, N'A')
SET IDENTITY_INSERT [dbo].[USUARIOS] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_CIUDADES]    Script Date: 2/11/2023 6:43:15 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_CIUDADES] ON [dbo].[CIUDADES]
(
	[NIVEL1] ASC,
	[NIVEL2] ASC,
	[NIVEL3] ASC,
	[NIVEL4] ASC,
	[NIVEL5] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_TABLA_CLASIFICACION_DE_MATERIAS_PRIMAS]    Script Date: 2/11/2023 6:43:15 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_TABLA_CLASIFICACION_DE_MATERIAS_PRIMAS] ON [dbo].[CLASIFICACIONDEMATERIASPRIMAS]
(
	[NIVEL1] ASC,
	[NIVEL2] ASC,
	[NIVEL3] ASC,
	[NIVEL4] ASC,
	[NIVEL5] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_FORMULAS]    Script Date: 2/11/2023 6:43:15 p. m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_FORMULAS] ON [dbo].[FORMULAS]
(
	[FORMULA] ASC,
	[COMPONENTE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_MOVIMIENTODEINVENTARIOS]    Script Date: 2/11/2023 6:43:15 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_MOVIMIENTODEINVENTARIOS] ON [dbo].[MOVIMIENTODEINVENTARIOS]
(
	[DESPACHA] ASC,
	[RECIBE] ASC,
	[TIPODEDOCUMENTO] ASC,
	[NUMERODELDOCUMENTO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_MOVIMIENTODEINVENTARIOS_1]    Script Date: 2/11/2023 6:43:15 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_MOVIMIENTODEINVENTARIOS_1] ON [dbo].[MOVIMIENTODEINVENTARIOS]
(
	[DESPACHAAAFECTAR] ASC,
	[RECIBEAAFECTAR] ASC,
	[TIPODEDOCUMENTOAAFECTAR] ASC,
	[NUMERODELDOCUMENTOAAFECTAR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_MOVIMIENTODEINVENTARIOS_2]    Script Date: 2/11/2023 6:43:15 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_MOVIMIENTODEINVENTARIOS_2] ON [dbo].[MOVIMIENTODEINVENTARIOS]
(
	[TIPODEDOCUMENTO] ASC,
	[NUMERODELDOCUMENTO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_MOVIMIENTODEINVENTARIOS_3]    Script Date: 2/11/2023 6:43:15 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_MOVIMIENTODEINVENTARIOS_3] ON [dbo].[MOVIMIENTODEINVENTARIOS]
(
	[TIPODEDOCUMENTO] ASC,
	[FECHA_DE_CREACION] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PRODUCTOS]    Script Date: 2/11/2023 6:43:15 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_PRODUCTOS] ON [dbo].[PRODUCTOS]
(
	[NOMBRE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PRODUCTOS_1]    Script Date: 2/11/2023 6:43:15 p. m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_PRODUCTOS_1] ON [dbo].[PRODUCTOS]
(
	[CODIGODEBARRAS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PROVEEDORES]    Script Date: 2/11/2023 6:43:15 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_PROVEEDORES] ON [dbo].[PROVEEDORES]
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PROVEEDORES_1]    Script Date: 2/11/2023 6:43:15 p. m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_PROVEEDORES_1] ON [dbo].[PROVEEDORES]
(
	[nit] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_SALDOS]    Script Date: 2/11/2023 6:43:15 p. m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_SALDOS] ON [dbo].[SALDOS]
(
	[PRODUCTO] ASC,
	[bodega] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_TMP_MOVIMIENTODEINVENTARIOS]    Script Date: 2/11/2023 6:43:15 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_TMP_MOVIMIENTODEINVENTARIOS] ON [dbo].[TMP_MOVIMIENTODEINVENTARIOS]
(
	[TIPODEDOCUMENTO] ASC,
	[NUMERODELDOCUMENTO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SALDOS]  WITH CHECK ADD  CONSTRAINT [FK_SALDOS_SALDOS] FOREIGN KEY([id])
REFERENCES [dbo].[SALDOS] ([id])
GO
ALTER TABLE [dbo].[SALDOS] CHECK CONSTRAINT [FK_SALDOS_SALDOS]
GO
/****** Object:  StoredProcedure [dbo].[borrar]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[CONSULTARPEDIDOS]    Script Date: 2/11/2023 6:43:15 p. m. ******/
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
