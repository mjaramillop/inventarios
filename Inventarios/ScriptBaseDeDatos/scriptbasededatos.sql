USE [master]
GO
/****** Object:  Database [inventarios]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_ABREVIATURA_TIPO_DE_DOCUMENTO]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_CODIGO_NOMBRE_ATRIBUTO_DE_UN_TIPO_DE_DOCUMENTO]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_FECHA_FORMATO_DDMMMAAAA]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_FECHA_FORMATO_DMA]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NIT_DE_LA_TRANSACCION]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_ATRIBUTO_PROVEEDOR]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_ATRIBUTO_TIPO_DE_DOCUMENTO]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_CIUDAD]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_CLASIFICACION_DE_AGENTES]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_CLASIFICACION_DE_MATERIAS_PRIMAS]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_COLOR]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_CONCEPTO_NOTA_DEBITO_CREDITO]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_DEPARTAMENTO]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_DEPARTAMENTO_DE_LA_CIUDAD]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_ESTADO_DEL_REGISTRO]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_FORMA_DE_PAGO]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_PAIS]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_PAIS_DE_LA_CIUDAD]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_PARAMETRO]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_PRODUCTO]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_PROVEEDOR]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_PROVEEDOR_DE_LA_TRANSACCION]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_RETENCION]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_TIPO_DE_AGENTE]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_TIPO_DE_CUENTA_BANCARIA]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_TIPO_DE_DOCUMENTO]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_TIPO_DE_RETENCION]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRE_UNIDAD_DE_MEDIDA]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_NOMBRES_RETENCIONES_DE_UN_PROVEEDOR]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_VALOR_CON_COMAS]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  UserDefinedFunction [dbo].[TRAE_VALOR_DE_UN_ATRIBUTO_TIPO_DE_DOCUMENTO]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  Table [dbo].[ACTIVIDADESECONOMICAS]    Script Date: 21/06/2024 18:35:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACTIVIDADESECONOMICAS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](100) NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL,
	[IDUSUARIO] [int] NULL,
	[NOMBREUSUARIO] [varchar](100) NULL,
 CONSTRAINT [PK_TABLA_ACTIVIDADES_ECONOMICAS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[COLORES]    Script Date: 21/06/2024 18:35:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COLORES](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](50) NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL,
	[IDUSUARIO] [int] NULL,
	[NOMBREUSUARIO] [varchar](100) NULL,
 CONSTRAINT [PK_COLORES] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CONCEPTOSNOTADEBITOYCREDITO]    Script Date: 21/06/2024 18:35:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONCEPTOSNOTADEBITOYCREDITO](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](100) NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL,
	[IDUSUARIO] [int] NULL,
	[NOMBREUSUARIO] [varchar](100) NULL,
 CONSTRAINT [PK_TABLA_CONCEPTOS_NOTA_DEBITO_Y_CREDITO] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ESTADOSDEUNREGISTRO]    Script Date: 21/06/2024 18:35:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ESTADOSDEUNREGISTRO](
	[ID] [int] NOT NULL,
	[NOMBRE] [varchar](30) NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL,
	[IDUSUARIO] [int] NULL,
	[NOMBREUSUARIO] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FECHADECIERRE]    Script Date: 21/06/2024 18:35:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FECHADECIERRE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FECHADECIERRE] [datetime] NULL,
 CONSTRAINT [PK_FECHADECIERRE] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FORMASDEPAGO]    Script Date: 21/06/2024 18:35:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FORMASDEPAGO](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](100) NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL,
	[IDUSUARIO] [int] NULL,
	[NOMBREUSUARIO] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FORMULAS]    Script Date: 21/06/2024 18:35:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FORMULAS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FORMULA] [int] NOT NULL,
	[COMPONENTE] [int] NOT NULL,
	[CANTIDAD] [decimal](18, 5) NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL,
	[IDUSUARIO] [int] NULL,
	[NOMBREUSUARIO] [varchar](100) NULL,
 CONSTRAINT [PK_FORMULAS_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IVAS]    Script Date: 21/06/2024 18:35:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IVAS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](20) NULL,
	[porcentaje] [decimal](5, 2) NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL,
	[IDUSUARIO] [int] NULL,
	[NOMBREUSUARIO] [varchar](100) NULL,
 CONSTRAINT [PK_IVAS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LOG]    Script Date: 21/06/2024 18:35:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOG](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DESCRIPCION_DE_LA_OPERACION] [ntext] NULL,
	[FECHA_DE_ACTUALIZACION] [datetime] NULL,
	[IDUSUARIO] [int] NULL,
	[NOMBREUSUARIO] [varchar](100) NULL,
 CONSTRAINT [PK_LOG] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MENSAJESDELSISTEMA]    Script Date: 21/06/2024 18:35:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MENSAJESDELSISTEMA](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[FECHA_DESDE] [datetime] NULL,
	[FECHA_HASTA] [datetime] NULL,
	[MENSAJE] [varchar](max) NULL,
	[IDUSUARIO] [int] NULL,
	[NOMBREUSUARIO] [varchar](100) NULL,
 CONSTRAINT [PK_MENSAJESDELSISTEMA] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MENU]    Script Date: 21/06/2024 18:35:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MENU](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ORDEN] [varchar](10) NOT NULL,
	[NOMBRE] [varchar](100) NULL,
	[PAGINA_WEB] [varchar](300) NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL,
	[IDUSUARIO] [int] NULL,
	[NOMBREUSUARIO] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MOVIMIENTODEINVENTARIOS]    Script Date: 21/06/2024 18:35:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVIMIENTODEINVENTARIOS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DESPACHA] [int] NOT NULL,
	[NOMBREDESPACHA] [varchar](200) NULL,
	[RECIBE] [int] NOT NULL,
	[NOMBRERECIBE] [varchar](200) NULL,
	[TIPODEDOCUMENTO] [int] NOT NULL,
	[NOMBRETIPODEDOCUMENTO] [varchar](100) NULL,
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
	[NUMERODEEMPAQUES] [int] NULL,
	[UNIDADDEEMPAQUE] [int] NULL,
	[NOMBREUNIDADDEEMPAQUE] [varchar](30) NULL,
	[CANTIDADPOREMPAQUE] [decimal](18, 5) NULL,
	[CANTIDAD] [decimal](18, 5) NULL,
	[VALORUNITARIO] [decimal](18, 5) NULL,
	[COSTOULTIMOPORUNIDAD] [decimal](18, 5) NULL,
	[COSTOPROMEDIOPORUNIDAD] [decimal](18, 5) NULL,
	[COSTOFLETEPORUNIDAD] [decimal](18, 2) NULL,
	[SUBTOTAL] [decimal](18, 5) NULL,
	[CODIGODESCUENTO1] [int] NULL,
	[NOMBRECODIGODESCUENTO1] [varchar](50) NULL,
	[PORCENTAJEDESCUENTO1] [decimal](18, 5) NULL,
	[VALORDESCUENTO1] [int] NULL,
	[CODIGOIVA1] [int] NULL,
	[NOMBRECODIGOIVA1] [varchar](50) NULL,
	[PORCENTAJEDEIVA1] [decimal](18, 5) NULL,
	[VALORIVA1] [int] NULL,
	[FLETES] [int] NULL,
	[CODIGORETENCION1] [int] NULL,
	[NOMBRECODIGORETENCION1] [varchar](50) NULL,
	[PORCENTAJEDERETENCION1] [decimal](18, 5) NULL,
	[VALORRETENCION1] [int] NULL,
	[VALORNETO] [decimal](18, 5) NULL,
	[FECHADEPROGRAMACIONDELPAGO] [datetime] NULL,
	[LA_CANTIDAD_ESTA_DESPACHADA] [varchar](1) NULL,
	[EL_DOCUMENTO_ESTA_CANCELADO] [varchar](1) NULL,
	[SUMA_O_RESTA_EN_INVENTARIO] [varchar](1) NULL,
	[SUMA_O_RESTA_EN_CARTERA] [varchar](1) NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL,
	[FECHA_DE_CREACION] [datetime] NULL,
	[TRASLADO_RECIBIDO_Y_APROBADO_POR] [varchar](200) NULL,
	[FECHA_TRASLADO_RECIBIDO_Y_APROBADO] [datetime] NULL,
	[CONSECUTIVOUSUARIO] [varchar](20) NULL,
	[IDUSUARIO] [int] NULL,
	[NOMBREUSUARIO] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MOVIMIENTODEINVENTARIOSTMP]    Script Date: 21/06/2024 18:35:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVIMIENTODEINVENTARIOSTMP](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DESPACHA] [int] NOT NULL,
	[NOMBREDESPACHA] [varchar](200) NOT NULL,
	[RECIBE] [int] NOT NULL,
	[NOMBRERECIBE] [varchar](200) NOT NULL,
	[TIPODEDOCUMENTO] [int] NOT NULL,
	[NOMBRETIPODEDOCUMENTO] [varchar](100) NOT NULL,
	[NUMERODELDOCUMENTO] [int] NOT NULL,
	[DESPACHAAAFECTAR] [int] NOT NULL,
	[NOMBREDESPACHAAAFECTAR] [varchar](200) NOT NULL,
	[RECIBEAAFECTAR] [int] NOT NULL,
	[NOMBRERECIBEAAFECTAR] [varchar](200) NOT NULL,
	[TIPODEDOCUMENTOAAFECTAR] [int] NOT NULL,
	[NOMBRETIPODEDOCUMENTOAAFECTAR] [varchar](200) NOT NULL,
	[NUMERODELDOCUMENTOAAFECTAR] [int] NOT NULL,
	[FECHADELDOCUMENTO] [datetime] NOT NULL,
	[PLAZO] [int] NOT NULL,
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
	[FORMULA] [int] NOT NULL,
	[NOMBREFORMULA] [varchar](200) NOT NULL,
	[PRODUCTO] [int] NOT NULL,
	[UNIDADDEMEDIDA] [int] NOT NULL,
	[TALLA] [int] NOT NULL,
	[COLOR] [int] NOT NULL,
	[NOMBREPRODUCTO] [varchar](300) NOT NULL,
	[NOMBREUNIDADDEMEDIDA] [varchar](20) NOT NULL,
	[NOMBRETALLA] [varchar](15) NOT NULL,
	[NOMBRECOLOR] [varchar](30) NOT NULL,
	[NUMERODEEMPAQUES] [int] NOT NULL,
	[UNIDADDEEMPAQUE] [int] NOT NULL,
	[NOMBREUNIDADDEEMPAQUE] [varchar](30) NOT NULL,
	[CANTIDADPOREMPAQUE] [decimal](18, 5) NOT NULL,
	[CANTIDAD] [decimal](18, 5) NOT NULL,
	[VALORUNITARIO] [decimal](18, 5) NOT NULL,
	[COSTOULTIMOPORUNIDAD] [decimal](18, 5) NOT NULL,
	[COSTOPROMEDIOPORUNIDAD] [decimal](18, 5) NULL,
	[COSTOFLETEPORUNIDAD] [decimal](18, 2) NOT NULL,
	[SUBTOTAL] [decimal](18, 5) NOT NULL,
	[CODIGODESCUENTO1] [int] NOT NULL,
	[NOMBRECODIGODESCUENTO1] [varchar](50) NOT NULL,
	[PORCENTAJEDESCUENTO1] [decimal](18, 5) NOT NULL,
	[VALORDESCUENTO1] [int] NOT NULL,
	[CODIGOIVA1] [int] NOT NULL,
	[NOMBRECODIGOIVA1] [varchar](50) NOT NULL,
	[PORCENTAJEDEIVA1] [decimal](18, 5) NOT NULL,
	[VALORIVA1] [int] NOT NULL,
	[FLETES] [int] NOT NULL,
	[CODIGORETENCION1] [int] NOT NULL,
	[NOMBRECODIGORETENCION1] [varchar](50) NOT NULL,
	[PORCENTAJEDERETENCION1] [decimal](18, 5) NOT NULL,
	[VALORRETENCION1] [int] NOT NULL,
	[VALORNETO] [decimal](18, 5) NOT NULL,
	[FECHADEPROGRAMACIONDELPAGO] [datetime] NOT NULL,
	[LA_CANTIDAD_ESTA_DESPACHADA] [varchar](1) NOT NULL,
	[EL_DOCUMENTO_ESTA_CANCELADO] [varchar](1) NOT NULL,
	[SUMA_O_RESTA_EN_INVENTARIO] [varchar](1) NOT NULL,
	[SUMA_O_RESTA_EN_CARTERA] [varchar](1) NOT NULL,
	[ESTADO_DEL_REGISTRO] [int] NOT NULL,
	[FECHA_DE_CREACION] [datetime] NOT NULL,
	[TRASLADO_RECIBIDO_Y_APROBADO_POR] [varchar](200) NOT NULL,
	[FECHA_TRASLADO_RECIBIDO_Y_APROBADO] [datetime] NOT NULL,
	[CONSECUTIVOUSUARIO] [varchar](20) NULL,
	[IDUSUARIO] [int] NULL,
	[NOMBREUSUARIO] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PERFILES]    Script Date: 21/06/2024 18:35:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PERFILES](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](100) NULL,
	[PROGRAMAS] [varchar](500) NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL,
	[IDUSUARIO] [int] NULL,
	[NOMBREUSUARIO] [varchar](100) NULL,
 CONSTRAINT [PK_PERFILES] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PRODUCTOS]    Script Date: 21/06/2024 18:35:44 ******/
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
	[IDUSUARIO] [int] NULL,
	[NOMBREUSUARIO] [varchar](100) NULL,
 CONSTRAINT [PK_PRODUCTOS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PROGRAMAS]    Script Date: 21/06/2024 18:35:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PROGRAMAS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](100) NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL,
	[IDUSUARIO] [int] NULL,
	[NOMBREUSUARIO] [varchar](100) NULL,
 CONSTRAINT [PK_TABLA_TIPOS_DE_PROGRAMAS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PROVEEDORES]    Script Date: 21/06/2024 18:35:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PROVEEDORES](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](200) NULL,
	[direccion] [varchar](150) NULL,
	[telefono] [varchar](20) NULL,
	[celular1] [varchar](20) NULL,
	[celular2] [varchar](20) NULL,
	[email1] [varchar](150) NULL,
	[email2] [varchar](150) NULL,
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
	[TIPODEAGENTE] [int] NULL,
	[CUENTACONTABLE] [varchar](20) NULL,
	[codigoderetencionaaplicar] [int] NULL,
	[cuentabancaria] [varchar](20) NULL,
	[tipodecuenta] [int] NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL,
	[nivel1] [varchar](50) NULL,
	[nivel2] [varchar](50) NULL,
	[nivel3] [varchar](50) NULL,
	[nivel4] [varchar](50) NULL,
	[nivel5] [varchar](50) NULL,
	[IDUSUARIO] [int] NULL,
	[NOMBREUSUARIO] [varchar](100) NULL,
	[CLAVEDESEGURIDADPARAPEDIDOSPORWEB] [varchar](20) NULL,
	[secargainventario] [varchar](1) NULL,
 CONSTRAINT [PK_PROVEEDORES] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RETENCIONES]    Script Date: 21/06/2024 18:35:44 ******/
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
	[IDUSUARIO] [int] NULL,
	[NOMBREUSUARIO] [varchar](100) NULL,
 CONSTRAINT [PK_RETENCIONES] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SALDOS]    Script Date: 21/06/2024 18:35:44 ******/
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
	[fechadelaultimasalida] [datetime] NULL,
	[stockminimo] [decimal](18, 5) NULL,
	[stockmaximo] [decimal](18, 5) NULL,
 CONSTRAINT [PK_SALDOS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SINO]    Script Date: 21/06/2024 18:35:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SINO](
	[id] [varchar](1) NOT NULL,
	[nombre] [varchar](10) NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL,
	[IDUSUARIO] [int] NULL,
	[NOMBREUSUARIO] [varchar](100) NULL,
 CONSTRAINT [PK_SINO] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TALLAS]    Script Date: 21/06/2024 18:35:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TALLAS](
	[id] [int] NULL,
	[nombre] [varchar](10) NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL,
	[IDUSUARIO] [int] NULL,
	[NOMBREUSUARIO] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TIPOSDEAGENTE]    Script Date: 21/06/2024 18:35:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPOSDEAGENTE](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](30) NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL,
	[IDUSUARIO] [int] NULL,
	[NOMBREUSUARIO] [varchar](100) NULL,
 CONSTRAINT [PK_TIPOSDEAGENTE] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TIPOSDECUENTABANCARIA]    Script Date: 21/06/2024 18:35:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPOSDECUENTABANCARIA](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL,
	[IDUSUARIO] [int] NULL,
	[NOMBREUSUARIO] [varchar](100) NULL,
 CONSTRAINT [PK_TIPOSDECUENTABANCARIA] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TIPOSDEDEDOCUMENTO]    Script Date: 21/06/2024 18:35:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPOSDEDEDOCUMENTO](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](100) NULL,
	[abreviatura] [varchar](30) NULL,
	[consecutivo] [int] NULL,
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
	[IDUSUARIO] [int] NULL,
	[NOMBREUSUARIO] [varchar](100) NULL,
 CONSTRAINT [PK_TABLA_TIPOS_DE_DOCUMENTO] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TIPOSDEPERSONA]    Script Date: 21/06/2024 18:35:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPOSDEPERSONA](
	[id] [varchar](1) NOT NULL,
	[nombre] [varchar](20) NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL,
	[IDUSUARIO] [int] NULL,
	[NOMBREUSUARIO] [varchar](100) NULL,
 CONSTRAINT [PK_TIPOSDEPERSONA] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TIPOSDEREGIMEN]    Script Date: 21/06/2024 18:35:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPOSDEREGIMEN](
	[id] [int] NOT NULL,
	[nombre] [varchar](50) NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL,
	[IDUSUARIO] [int] NULL,
	[NOMBREUSUARIO] [varchar](100) NULL,
 CONSTRAINT [PK_TIPOSDEREGIMEN] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UNIDADESDEMEDIDA]    Script Date: 21/06/2024 18:35:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UNIDADESDEMEDIDA](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](100) NULL,
	[ESTADO_DEL_REGISTRO] [int] NULL,
	[IDUSUARIO] [int] NULL,
	[NOMBREUSUARIO] [varchar](100) NULL,
 CONSTRAINT [PK_TABLA_UNIDADES_DE_MEDIDA] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USUARIOS]    Script Date: 21/06/2024 18:35:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USUARIOS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AREA] [varchar](100) NOT NULL,
	[NOMBRE] [varchar](100) NOT NULL,
	[CARGO] [varchar](100) NOT NULL,
	[DIRECCION] [varchar](100) NOT NULL,
	[TELEFONO] [varchar](100) NOT NULL,
	[CORREO_ELECTRONICO] [varchar](100) NOT NULL,
	[LOGIN] [varchar](20) NOT NULL,
	[PASSWORD] [varchar](20) NOT NULL,
	[PERFIL] [int] NOT NULL,
	[TIPOSDEDOCUMENTO] [varchar](500) NOT NULL,
	[BODEGA] [int] NOT NULL,
	[ESTADO_DEL_REGISTRO] [int] NOT NULL,
	[CONSECUTIVO] [int] NOT NULL,
	[IDUSUARIO] [int] NULL,
	[NOMBREUSUARIO] [varchar](100) NULL,
 CONSTRAINT [PK_USUARIOS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_ESTADOSDEUNREGISTRO]    Script Date: 21/06/2024 18:35:44 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_ESTADOSDEUNREGISTRO] ON [dbo].[ESTADOSDEUNREGISTRO]
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK_FORMASDEPAGO]    Script Date: 21/06/2024 18:35:44 ******/
CREATE NONCLUSTERED INDEX [PK_FORMASDEPAGO] ON [dbo].[FORMASDEPAGO]
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_FORMULAS]    Script Date: 21/06/2024 18:35:44 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_FORMULAS] ON [dbo].[FORMULAS]
(
	[FORMULA] ASC,
	[COMPONENTE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_MOVIMIENTODEINVENTARIOS]    Script Date: 21/06/2024 18:35:44 ******/
CREATE NONCLUSTERED INDEX [IX_MOVIMIENTODEINVENTARIOS] ON [dbo].[MOVIMIENTODEINVENTARIOS]
(
	[DESPACHA] ASC,
	[RECIBE] ASC,
	[TIPODEDOCUMENTO] ASC,
	[NUMERODELDOCUMENTO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_MOVIMIENTODEINVENTARIOS_1]    Script Date: 21/06/2024 18:35:44 ******/
CREATE NONCLUSTERED INDEX [IX_MOVIMIENTODEINVENTARIOS_1] ON [dbo].[MOVIMIENTODEINVENTARIOS]
(
	[DESPACHAAAFECTAR] ASC,
	[RECIBEAAFECTAR] ASC,
	[TIPODEDOCUMENTOAAFECTAR] ASC,
	[NUMERODELDOCUMENTOAAFECTAR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_MOVIMIENTODEINVENTARIOS_2]    Script Date: 21/06/2024 18:35:44 ******/
CREATE NONCLUSTERED INDEX [IX_MOVIMIENTODEINVENTARIOS_2] ON [dbo].[MOVIMIENTODEINVENTARIOS]
(
	[TIPODEDOCUMENTO] ASC,
	[NUMERODELDOCUMENTO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_MOVIMIENTODEINVENTARIOS_3]    Script Date: 21/06/2024 18:35:44 ******/
CREATE NONCLUSTERED INDEX [IX_MOVIMIENTODEINVENTARIOS_3] ON [dbo].[MOVIMIENTODEINVENTARIOS]
(
	[TIPODEDOCUMENTO] ASC,
	[FECHA_DE_CREACION] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_MOVIMIENTODEINVENTARIOS_4]    Script Date: 21/06/2024 18:35:44 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_MOVIMIENTODEINVENTARIOS_4] ON [dbo].[MOVIMIENTODEINVENTARIOS]
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_MOVIMIENTODEINVENTARIOSTMP]    Script Date: 21/06/2024 18:35:44 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_MOVIMIENTODEINVENTARIOSTMP] ON [dbo].[MOVIMIENTODEINVENTARIOSTMP]
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_MOVIMIENTODEINVENTARIOSTMP_1]    Script Date: 21/06/2024 18:35:44 ******/
CREATE NONCLUSTERED INDEX [IX_MOVIMIENTODEINVENTARIOSTMP_1] ON [dbo].[MOVIMIENTODEINVENTARIOSTMP]
(
	[TIPODEDOCUMENTO] ASC,
	[CONSECUTIVOUSUARIO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PRODUCTOS]    Script Date: 21/06/2024 18:35:44 ******/
CREATE NONCLUSTERED INDEX [IX_PRODUCTOS] ON [dbo].[PRODUCTOS]
(
	[NOMBRE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PRODUCTOS_1]    Script Date: 21/06/2024 18:35:44 ******/
CREATE NONCLUSTERED INDEX [IX_PRODUCTOS_1] ON [dbo].[PRODUCTOS]
(
	[NIVEL1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PRODUCTOS_2]    Script Date: 21/06/2024 18:35:44 ******/
CREATE NONCLUSTERED INDEX [IX_PRODUCTOS_2] ON [dbo].[PRODUCTOS]
(
	[NIVEL2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PRODUCTOS_3]    Script Date: 21/06/2024 18:35:44 ******/
CREATE NONCLUSTERED INDEX [IX_PRODUCTOS_3] ON [dbo].[PRODUCTOS]
(
	[NIVEL3] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PRODUCTOS_4]    Script Date: 21/06/2024 18:35:44 ******/
CREATE NONCLUSTERED INDEX [IX_PRODUCTOS_4] ON [dbo].[PRODUCTOS]
(
	[NIVEL4] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PRODUCTOS_5]    Script Date: 21/06/2024 18:35:44 ******/
CREATE NONCLUSTERED INDEX [IX_PRODUCTOS_5] ON [dbo].[PRODUCTOS]
(
	[NIVEL5] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_PRODUCTOS_6]    Script Date: 21/06/2024 18:35:44 ******/
CREATE NONCLUSTERED INDEX [IX_PRODUCTOS_6] ON [dbo].[PRODUCTOS]
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_NIT]    Script Date: 21/06/2024 18:35:44 ******/
CREATE NONCLUSTERED INDEX [IX_NIT] ON [dbo].[PROVEEDORES]
(
	[nit] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PROVEEDORES]    Script Date: 21/06/2024 18:35:44 ******/
CREATE NONCLUSTERED INDEX [IX_PROVEEDORES] ON [dbo].[PROVEEDORES]
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PROVEEDORES_1]    Script Date: 21/06/2024 18:35:44 ******/
CREATE NONCLUSTERED INDEX [IX_PROVEEDORES_1] ON [dbo].[PROVEEDORES]
(
	[nivel1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PROVEEDORES_2]    Script Date: 21/06/2024 18:35:44 ******/
CREATE NONCLUSTERED INDEX [IX_PROVEEDORES_2] ON [dbo].[PROVEEDORES]
(
	[nivel2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PROVEEDORES_3]    Script Date: 21/06/2024 18:35:44 ******/
CREATE NONCLUSTERED INDEX [IX_PROVEEDORES_3] ON [dbo].[PROVEEDORES]
(
	[nivel3] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PROVEEDORES_4]    Script Date: 21/06/2024 18:35:44 ******/
CREATE NONCLUSTERED INDEX [IX_PROVEEDORES_4] ON [dbo].[PROVEEDORES]
(
	[nivel4] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PROVEEDORES_5]    Script Date: 21/06/2024 18:35:44 ******/
CREATE NONCLUSTERED INDEX [IX_PROVEEDORES_5] ON [dbo].[PROVEEDORES]
(
	[nivel5] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_SALDOS]    Script Date: 21/06/2024 18:35:44 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_SALDOS] ON [dbo].[SALDOS]
(
	[PRODUCTO] ASC,
	[bodega] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_TALLAS]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  StoredProcedure [dbo].[borrar]    Script Date: 21/06/2024 18:35:44 ******/
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
/****** Object:  StoredProcedure [dbo].[CONSULTARPEDIDOS]    Script Date: 21/06/2024 18:35:44 ******/
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
