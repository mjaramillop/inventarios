﻿using System;
using System.Collections.Generic;
using Inventarios.Models;
using Microsoft.EntityFrameworkCore;


namespace Inventarios.Data;

public partial class InventariosContext : DbContext
{

  
    private readonly IConfiguration _iconfiguration;

    public InventariosContext(DbContextOptions<InventariosContext> options,IConfiguration configutarion_  )
        : base(options)
    {
        _iconfiguration = configutarion_;
     
    }


    public virtual DbSet<ActividadesEconomicas> Actividadeseconomicas { get; set; }

    public virtual DbSet<Ciudades> Ciudades { get; set; }

    public virtual DbSet<Clasificaciondemateriasprima> Clasificaciondemateriasprimas { get; set; }

    public virtual DbSet<Colore> Colores { get; set; }

    public virtual DbSet<Conceptosnotadebitoycredito> Conceptosnotadebitoycreditos { get; set; }

    public virtual DbSet<Cuentasbancaria> Cuentasbancarias { get; set; }

   
    public virtual DbSet<Formasdepago> Formasdepagos { get; set; }

    public virtual DbSet<Formula> Formulas { get; set; }

    public virtual DbSet<Iva> Ivas { get; set; }

    public virtual DbSet<Log> Logs { get; set; }

    public virtual DbSet<Mensajesdelsistema> Mensajesdelsistemas { get; set; }

    public virtual DbSet<Menu> Menus { get; set; }

    public virtual DbSet<Movimientodeinventario> Movimientodeinventarios { get; set; }

    public virtual DbSet<Perfiles> Perfiles { get; set; }

   public virtual DbSet<Producto> Productos { get; set; }

    public virtual DbSet<Proveedores> Proveedores { get; set; }

 
    public virtual DbSet<Saldos> Saldos { get; set; }

    public virtual DbSet<TiposDeDocumento> TiposDeDocumento { get; set; }

    public virtual DbSet<Tiposdeprograma> Tiposdeprogramas { get; set; }

 
    public virtual DbSet<TmpMovimientodeinventario> TmpMovimientodeinventarios { get; set; }

    public virtual DbSet<Unidadesdemedida> Unidadesdemedida { get; set; }

    public virtual DbSet<Usuarios> Usuarios { get; set; }

   

    //protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    //    => optionsBuilder.UseSqlServer("Server=DESKTOP-56QVMV6\\SQLEXPRESS;Database=inventarios;Trusted_Connection=True;TrustServerCertificate=true;");

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseSqlServer(_iconfiguration.GetConnectionString("connectionstring") ) ;



    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<ActividadesEconomicas>(entity =>
        {
            entity.HasKey(e => e.id).HasName("PK_TABLA_ACTIVIDADES_ECONOMICAS");
            
           

            entity.ToTable("ACTIVIDADESECONOMICAS");

            entity.Property(e => e.id).HasColumnName("ID").ValueGeneratedOnAdd();
         
            entity.Property(e => e.estadodelregistro)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");
          
            entity.Property(e => e.nombre)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("NOMBRE");
          
        });

        modelBuilder.Entity<Ciudades>(entity =>
        {
            entity.HasKey(e => e.id).HasName("PK_CIUDADES");



            entity.ToTable("CIUDADES");


            entity.HasIndex(e => new { e.nivel1, e.nivel2, e.nivel3, e.nivel4, e.nivel5 }, "IX_CIUDADES").IsUnique();

            entity.HasIndex(e => new { e.codigo1, e.codigo2, e.codigo3, e.codigo4, e.codigo5 }, "IX_CIUDADES_1").IsUnique();


            entity.Property(e => e.id).HasColumnName("ID");
            entity.Property(e => e.codigo1)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("CODIGO1");
            entity.Property(e => e.codigo2)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("CODIGO2");
            entity.Property(e => e.codigo3)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("CODIGO3");
            entity.Property(e => e.codigo4)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("CODIGO4");
            entity.Property(e => e.codigo5)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("CODIGO5");
            entity.Property(e => e.estadodelregistro)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");
            entity.Property(e => e.nivel1)
                .HasMaxLength(30)
                .IsUnicode(false)
                .HasColumnName("NIVEL1");
            entity.Property(e => e.nivel2)
                .HasMaxLength(30)
                .IsUnicode(false)
                .HasColumnName("NIVEL2");
            entity.Property(e => e.nivel3)
                .HasMaxLength(30)
                .IsUnicode(false)
                .HasColumnName("NIVEL3");
            entity.Property(e => e.nivel4)
                .HasMaxLength(30)
                .IsUnicode(false)
                .HasColumnName("NIVEL4");
            entity.Property(e => e.nivel5)
                .HasMaxLength(30)
                .IsUnicode(false)
                .HasColumnName("NIVEL5");

        });

        modelBuilder.Entity<Clasificaciondemateriasprima>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK_TABLA_DE_CLASIFICACION_DE_MATERIAS_PRIMAS");

            entity.ToTable("CLASIFICACIONDEMATERIASPRIMAS");

            entity.HasIndex(e => new { e.nivel1, e.nivel2, e.nivel3, e.nivel4, e.nivel5 }, "IX_TABLA_CLASIFICACION_DE_MATERIAS_PRIMAS");

            entity.Property(e => e.codigo1)
       .HasMaxLength(10)
       .IsUnicode(false)
       .HasColumnName("CODIGO1");
            entity.Property(e => e.nivel1)
              .HasMaxLength(30)
              .IsUnicode(false)
              .HasColumnName("NIVEL1");

            entity.Property(e => e.codigo2)
              .HasMaxLength(10)
              .IsUnicode(false)
              .HasColumnName("CODIGO2");
            entity.Property(e => e.nivel2)
              .HasMaxLength(30)
              .IsUnicode(false)
              .HasColumnName("NIVEL2");

            entity.Property(e => e.codigo3)
                          .HasMaxLength(10)
                          .IsUnicode(false)
                          .HasColumnName("CODIGO3");
            entity.Property(e => e.nivel3)
              .HasMaxLength(30)
              .IsUnicode(false)
              .HasColumnName("NIVEL3");


            entity.Property(e => e.codigo4)
                          .HasMaxLength(10)
                          .IsUnicode(false)
                          .HasColumnName("CODIGO4");
            entity.Property(e => e.nivel4)
              .HasMaxLength(30)
              .IsUnicode(false)
              .HasColumnName("NIVEL4");


            entity.Property(e => e.codigo5)
                          .HasMaxLength(10)
                          .IsUnicode(false)
                          .HasColumnName("CODIGO5");
            entity.Property(e => e.nivel5)
              .HasMaxLength(30)
              .IsUnicode(false)
              .HasColumnName("NIVEL5");



            entity.Property(e => e.estadodelregistro)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");

        });

        modelBuilder.Entity<Colore>(entity =>
        {
            entity
                .HasNoKey()
                .ToTable("COLORES");

            entity.Property(e => e.estadodelregistro)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");
           
            entity.Property(e => e.Id)
                .ValueGeneratedOnAdd()
                .HasColumnName("ID");
            entity.Property(e => e.Nombre)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("NOMBRE");
           
        });

        modelBuilder.Entity<Conceptosnotadebitoycredito>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK_TABLA_CONCEPTOS_NOTA_DEBITO_Y_CREDITO");

            entity.ToTable("CONCEPTOSNOTADEBITOYCREDITO");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.estadodelregistro)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");
           
            entity.Property(e => e.Nombre)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("NOMBRE");
           
        });

        modelBuilder.Entity<Cuentasbancaria>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK_CUENTAS_BANCARIAS");

            entity.ToTable("CUENTASBANCARIAS");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.Banco).HasColumnName("BANCO");
            entity.Property(e => e.Cuenta)
                .HasMaxLength(15)
                .IsUnicode(false)
                .HasColumnName("CUENTA");
            entity.Property(e => e.estadodelregistro)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");
          
            entity.Property(e => e.TipoDeCuenta)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("TIPO_DE_CUENTA");
          
        });

  

        modelBuilder.Entity<Formasdepago>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK_TABLA_FORMAS_DE_PAGO");

            entity.ToTable("FORMASDEPAGO");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.estadodelregistro)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");
           
            entity.Property(e => e.Nombre)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("NOMBRE");
           
        });

        modelBuilder.Entity<Formula>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK_FORMULAS_1");

            entity.ToTable("FORMULAS");

            entity.HasIndex(e => new { e.Formula1, e.Componente }, "IX_FORMULAS").IsUnique();

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.Cantidad)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("CANTIDAD");
            entity.Property(e => e.Componente)
                .HasMaxLength(30)
                .IsUnicode(false)
                .HasColumnName("COMPONENTE");
         
            entity.Property(e => e.Formula1)
                .HasMaxLength(30)
                .IsUnicode(false)
                .HasColumnName("FORMULA");
          
        });

        modelBuilder.Entity<Iva>(entity =>
        {
            entity.ToTable("IVAS");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.estadodelregistro)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");
           
            entity.Property(e => e.Nombre)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("NOMBRE");
            entity.Property(e => e.Porcentaje)
                .HasColumnType("decimal(5, 2)")
                .HasColumnName("porcentaje");
           
        });

        modelBuilder.Entity<Log>(entity =>
        {
            entity.ToTable("LOG");

            entity.Property(e => e.id).HasColumnName("ID");
            entity.Property(e => e.descripciondelaoperacion)
                .HasColumnType("ntext")
                .HasColumnName("DESCRIPCION_DE_LA_OPERACION");
            entity.Property(e => e.fechadeactualizacion)
                .HasColumnType("datetime")
                .HasColumnName("FECHA_DE_ACTUALIZACION");
        });

        modelBuilder.Entity<Mensajesdelsistema>(entity =>
        {
            entity
                .HasNoKey()
                .ToTable("MENSAJESDELSISTEMA");

            entity.Property(e => e.FechaDesde)
                .HasColumnType("datetime")
                .HasColumnName("FECHA_DESDE");
            entity.Property(e => e.FechaHasta)
                .HasColumnType("datetime")
                .HasColumnName("FECHA_HASTA");
            entity.Property(e => e.Id)
                .ValueGeneratedOnAdd()
                .HasColumnName("id");
            entity.Property(e => e.Mensaje)
                .IsUnicode(false)
                .HasColumnName("MENSAJE");
        });

        modelBuilder.Entity<Menu>(entity =>
        {
            entity.HasKey(e => e.orden);

            entity.ToTable("MENU");

            entity.Property(e => e.orden)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("ORDEN");
            entity.Property(e => e.estadodelregistro)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");
           
            entity.Property(e => e.id)
                .ValueGeneratedOnAdd()
                .HasColumnName("ID");
            entity.Property(e => e.nombre)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("NOMBRE");
            entity.Property(e => e.paginaweb)
                .HasMaxLength(300)
                .IsUnicode(false)
                .HasColumnName("PAGINA_WEB");
           
        });

        modelBuilder.Entity<Movimientodeinventario>(entity =>
        {
            entity.ToTable("MOVIMIENTODEINVENTARIOS");

            entity.HasIndex(e => new { e.Despacha, e.Recibe, e.Tipodedocumento, e.Numerodeldocumento }, "IX_MOVIMIENTODEINVENTARIOS");

            entity.HasIndex(e => new { e.Despachaaafectar, e.Recibeaafectar, e.Tipodedocumentoaafectar, e.Numerodeldocumentoaafectar }, "IX_MOVIMIENTODEINVENTARIOS_1");

            entity.HasIndex(e => new { e.Tipodedocumento, e.Numerodeldocumento }, "IX_MOVIMIENTODEINVENTARIOS_2");

            entity.HasIndex(e => new { e.Tipodedocumento, e.fechadecreacion }, "IX_MOVIMIENTODEINVENTARIOS_3");

            entity.Property(e => e.Id)
                .ValueGeneratedOnAdd()
                .HasColumnType("decimal(18, 0)")
                .HasColumnName("ID");
            entity.Property(e => e.Banco).HasColumnName("BANCO");
            entity.Property(e => e.Cantidad)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("CANTIDAD");
            entity.Property(e => e.Cantidadporempaque)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("CANTIDADPOREMPAQUE");
            entity.Property(e => e.Codigoconceptonotadebitocredito).HasColumnName("CODIGOCONCEPTONOTADEBITOCREDITO");
            entity.Property(e => e.Codigodescuento1).HasColumnName("CODIGODESCUENTO1");
            entity.Property(e => e.Codigodescuento2).HasColumnName("CODIGODESCUENTO2");
            entity.Property(e => e.Codigoiva1).HasColumnName("CODIGOIVA1");
            entity.Property(e => e.Codigoiva2).HasColumnName("CODIGOIVA2");
            entity.Property(e => e.Codigoretencion1).HasColumnName("CODIGORETENCION1");
            entity.Property(e => e.Codigoretencion2).HasColumnName("CODIGORETENCION2");
            entity.Property(e => e.Costodeproduccionporunidad)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("COSTODEPRODUCCIONPORUNIDAD");
            entity.Property(e => e.Costofleteporunidad)
                .HasColumnType("decimal(18, 2)")
                .HasColumnName("COSTOFLETEPORUNIDAD");
            entity.Property(e => e.Costopromedioporunidad)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("COSTOPROMEDIOPORUNIDAD");
            entity.Property(e => e.Costoultimoporunidad)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("COSTOULTIMOPORUNIDAD");
            entity.Property(e => e.Despacha).HasColumnName("DESPACHA");
            entity.Property(e => e.Despachaaafectar).HasColumnName("DESPACHAAAFECTAR");
            entity.Property(e => e.DetalleDelProducto)
                .HasMaxLength(500)
                .IsUnicode(false)
                .HasColumnName("DETALLE_DEL_PRODUCTO");
            entity.Property(e => e.ElDocumentoEstaCancelado)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("EL_DOCUMENTO_ESTA_CANCELADO");
            entity.Property(e => e.estadodelregistro)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");
            entity.Property(e => e.fechadecreacion)
                .HasColumnType("datetime")
                .HasColumnName("FECHA_DE_CREACION");
            entity.Property(e => e.FechaTrasladoRecibidoYAprobado)
                .HasColumnType("datetime")
                .HasColumnName("FECHA_TRASLADO_RECIBIDO_Y_APROBADO");
            entity.Property(e => e.Fechadeldocumento)
                .HasComment("la fecha que tiene  impreso el documento")
                .HasColumnType("datetime")
                .HasColumnName("FECHADELDOCUMENTO");
            entity.Property(e => e.Fechadeprogramaciondelpago)
                .HasColumnType("datetime")
                .HasColumnName("FECHADEPROGRAMACIONDELPAGO");
            entity.Property(e => e.Fechadevencimientodeldocumento)
                .HasColumnType("datetime")
                .HasColumnName("FECHADEVENCIMIENTODELDOCUMENTO");
            entity.Property(e => e.Fletes).HasColumnName("FLETES");
            entity.Property(e => e.Formadepago).HasColumnName("FORMADEPAGO");
            entity.Property(e => e.Formula)
                .HasMaxLength(30)
                .IsUnicode(false)
                .HasColumnName("FORMULA");
            entity.Property(e => e.LaCantidadEstaDespachada)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("LA_CANTIDAD_ESTA_DESPACHADA");
            entity.Property(e => e.Numerodeempaques)
                .HasColumnType("decimal(18, 0)")
                .HasColumnName("NUMERODEEMPAQUES");
            entity.Property(e => e.Numerodeldocumento).HasColumnName("NUMERODELDOCUMENTO");
            entity.Property(e => e.Numerodeldocumentoaafectar).HasColumnName("NUMERODELDOCUMENTOAAFECTAR");
            entity.Property(e => e.Numerodelpago)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("NUMERODELPAGO");
            entity.Property(e => e.Observaciones)
                .HasMaxLength(3000)
                .IsUnicode(false)
                .HasColumnName("OBSERVACIONES");
            entity.Property(e => e.Porcentajedeiva1)
                .HasColumnType("decimal(5, 2)")
                .HasColumnName("PORCENTAJEDEIVA1");
            entity.Property(e => e.Porcentajedeiva2)
                .HasColumnType("decimal(5, 2)")
                .HasColumnName("PORCENTAJEDEIVA2");
            entity.Property(e => e.Porcentajederetencion1)
                .HasColumnType("numeric(5, 2)")
                .HasColumnName("PORCENTAJEDERETENCION1");
            entity.Property(e => e.Porcentajederetencion2)
                .HasColumnType("numeric(5, 2)")
                .HasColumnName("PORCENTAJEDERETENCION2");
            entity.Property(e => e.Porcentajedescuento1)
                .HasColumnType("decimal(5, 2)")
                .HasColumnName("PORCENTAJEDESCUENTO1");
            entity.Property(e => e.Porcentajedescuento2)
                .HasColumnType("decimal(5, 2)")
                .HasColumnName("PORCENTAJEDESCUENTO2");
            entity.Property(e => e.Producto)
                .HasMaxLength(30)
                .IsUnicode(false)
                .HasColumnName("PRODUCTO");
            entity.Property(e => e.Programa).HasColumnName("PROGRAMA");
            entity.Property(e => e.Recibe).HasColumnName("RECIBE");
            entity.Property(e => e.Recibeaafectar).HasColumnName("RECIBEAAFECTAR");
            entity.Property(e => e.Subtotal)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("SUBTOTAL");
            entity.Property(e => e.SumaORestaEnCartera)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("SUMA_O_RESTA_EN_CARTERA");
            entity.Property(e => e.SumaORestaEnInventario)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("SUMA_O_RESTA_EN_INVENTARIO");
            entity.Property(e => e.Tipodedocumento).HasColumnName("TIPODEDOCUMENTO");
            entity.Property(e => e.Tipodedocumentoaafectar).HasColumnName("TIPODEDOCUMENTOAAFECTAR");
            entity.Property(e => e.TrasladoRecibidoYAprobadoPor)
                .HasMaxLength(200)
                .IsUnicode(false)
                .HasColumnName("TRASLADO_RECIBIDO_Y_APROBADO_POR");
            entity.Property(e => e.Unidaddeempaque)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("UNIDADDEEMPAQUE");
            entity.Property(e => e.usuarioqueactualizo)
                .HasMaxLength(200)
                .IsUnicode(false)
                .HasColumnName("USUARIO_QUE_ACTUALIZO");
            entity.Property(e => e.Valordescuento1).HasColumnName("VALORDESCUENTO1");
            entity.Property(e => e.Valordescuento2).HasColumnName("VALORDESCUENTO2");
            entity.Property(e => e.Valoriva1).HasColumnName("VALORIVA1");
            entity.Property(e => e.Valoriva2).HasColumnName("VALORIVA2");
            entity.Property(e => e.Valorneto)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("VALORNETO");
            entity.Property(e => e.Valorretencion1).HasColumnName("VALORRETENCION1");
            entity.Property(e => e.Valorretencion2).HasColumnName("VALORRETENCION2");
            entity.Property(e => e.Valorunitario)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("VALORUNITARIO");
            entity.Property(e => e.Vendedor).HasColumnName("VENDEDOR");
        });

      

   

        modelBuilder.Entity<Perfiles>(entity =>
        {
            entity.ToTable("PERFILES");

            entity.Property(e => e.programas)
                .HasMaxLength(500)
                .IsUnicode(false)
                .HasColumnName("PROGRAMAS");
            entity.Property(e => e.estadodelregistro)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");
          
            entity.Property(e => e.id)
                .ValueGeneratedOnAdd()
                .HasColumnName("ID");
            entity.Property(e => e.nombre)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("NOMBRE");
           
        });

    

        modelBuilder.Entity<Producto>(entity =>
        {
            entity.ToTable("PRODUCTOS");

            entity.HasIndex(e => e.Nombre, "IX_PRODUCTOS");

            entity.HasIndex(e => e.Codigodebarras, "IX_PRODUCTOS_1").IsUnique();

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.Clasificacion).HasColumnName("CLASIFICACION");
            entity.Property(e => e.Codigodebarras)
                .HasMaxLength(30)
                .IsUnicode(false)
                .HasColumnName("CODIGODEBARRAS");
            entity.Property(e => e.Codigoiva1).HasColumnName("CODIGOIVA1");
            entity.Property(e => e.Codigoiva2).HasColumnName("CODIGOIVA2");
            entity.Property(e => e.Codigoiva3).HasColumnName("CODIGOIVA3");
            entity.Property(e => e.Costodeproduccion)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("COSTODEPRODUCCION");
            entity.Property(e => e.Costoultimo)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("COSTOULTIMO");
            entity.Property(e => e.estadodelregistro)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");
           
            entity.Property(e => e.Generico)
                .HasMaxLength(300)
                .IsUnicode(false)
                .HasColumnName("GENERICO");
            entity.Property(e => e.Nombre)
                .HasMaxLength(300)
                .IsUnicode(false)
                .HasColumnName("NOMBRE");
            entity.Property(e => e.Precio1)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("PRECIO1");
            entity.Property(e => e.Unidaddemedida)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("UNIDADDEMEDIDA");
           
        });

        modelBuilder.Entity<Proveedores>(entity =>
        {
            entity.ToTable("PROVEEDORES");

            entity.HasIndex(e => e.nombre, "IX_PROVEEDORES");

            entity.HasIndex(e => e.nit, "IX_PROVEEDORES_1").IsUnique();

            entity.Property(e => e.id).HasColumnName("id");
            entity.Property(e => e.actividadcomercial).HasColumnName("actividadcomercial");
            entity.Property(e => e.celular1)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("celular1");
            entity.Property(e => e.celular2)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("celular2");
            entity.Property(e => e.ciudad)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("ciudad");
            entity.Property(e => e.clasificacion).HasColumnName("CLASIFICACION");
            entity.Property(e => e.codigoderetencionaaplicar).HasColumnName("codigoderetencionaaplicar");
            entity.Property(e => e.contactos)
                .HasMaxLength(300)
                .IsUnicode(false)
                .HasColumnName("contactos");
            entity.Property(e => e.cuentacontable)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("CUENTACONTABLE");
            entity.Property(e => e.declararenta)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("declararenta");
            entity.Property(e => e.direccion)
                .HasMaxLength(150)
                .IsUnicode(false)
                .HasColumnName("direccion");
            entity.Property(e => e.email1)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("email1");
            entity.Property(e => e.email2)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("email2");
            entity.Property(e => e.esgrancontribuyente)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("esgrancontribuyente");
            entity.Property(e => e.espersonanaturalojuridica)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("espersonanaturalojuridica");
            entity.Property(e => e.estadodelregistro)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");
           
            entity.Property(e => e.fechadeingreso)
                .HasColumnType("datetime")
                .HasColumnName("fechadeingreso");
            entity.Property(e => e.nit)
                .HasMaxLength(12)
                .IsUnicode(false)
                .HasColumnName("nit");
            entity.Property(e => e.nombre)
                .HasMaxLength(200)
                .IsUnicode(false)
                .HasColumnName("nombre");
            entity.Property(e => e.observaciones)
                .HasMaxLength(300)
                .IsUnicode(false)
                .HasColumnName("observaciones");
            entity.Property(e => e.puedecobrariva)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("puedecobrariva");
            entity.Property(e => e.seleretienefuente)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("seleretienefuente");
            entity.Property(e => e.seleretieneica)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("seleretieneica");
            entity.Property(e => e.seleretieneiva)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("seleretieneiva");
            entity.Property(e => e.telefono)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("telefono");
            entity.Property(e => e.tipodeagente).HasColumnName("TIPO_DE_AGENTE");
            entity.Property(e => e.tipoderegimen).HasColumnName("tipoderegimen");
           
        });

      

        modelBuilder.Entity<Saldos>(entity =>
        {
            entity.ToTable("SALDOS");

            entity.HasIndex(e => new { e.Producto, e.Bodega }, "IX_SALDOS").IsUnique();

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Bodega).HasColumnName("bodega");
            entity.Property(e => e.Costopromedio)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("costopromedio");
            entity.Property(e => e.Costoultimo)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("costoultimo");
            entity.Property(e => e.Entradas)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("entradas");
            entity.Property(e => e.Fechadelaultimaentrada)
                .HasColumnType("datetime")
                .HasColumnName("fechadelaultimaentrada");
            entity.Property(e => e.Fechadelaultimasalida)
                .HasColumnType("datetime")
                .HasColumnName("fechadelaultimasalida");
            entity.Property(e => e.Producto)
                .HasMaxLength(30)
                .IsUnicode(false)
                .HasColumnName("PRODUCTO");
            entity.Property(e => e.saldo)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("saldo");
            entity.Property(e => e.Saldofisico)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("saldofisico");
            entity.Property(e => e.Saldoinicial)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("saldoinicial");
            entity.Property(e => e.Salidas)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("salidas");
            entity.Property(e => e.Stockmaximo)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("stockmaximo");
            entity.Property(e => e.Stockminimo)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("stockminimo");
          
        });

        modelBuilder.Entity<TiposDeDocumento>(entity =>
        {
            entity.HasKey(e => e.id).HasName("PK_TABLA_TIPOS_DE_DOCUMENTO");

            entity.ToTable("TIPOSDEDEDOCUMENTO");

            entity.Property(e => e.id).HasColumnName("ID");
            entity.Property(e => e.abreviatura)
                .HasMaxLength(30)
                .IsUnicode(false)
                .HasColumnName("abreviatura");
            entity.Property(e => e.consecutivo)
                .HasColumnType("decimal(18, 0)")
                .HasColumnName("consecutivo");
            entity.Property(e => e.cuentacontablecredito)
                .HasMaxLength(30)
                .IsUnicode(false)
                .HasColumnName("cuentacontablecredito");
            entity.Property(e => e.cuentacontabledebito)
                .HasMaxLength(30)
                .IsUnicode(false)
                .HasColumnName("cuentacontabledebito");
            entity.Property(e => e.despacha)
                .HasMaxLength(300)
                .IsUnicode(false)
                .HasColumnName("DESPACHA");
            entity.Property(e => e.eldocumentoallamarsolosepuedellamarunavez)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("eldocumentoallamarsolosepuedellamarunavez");
            entity.Property(e => e.eldocumentoseimprime)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("eldocumentoseimprime");
            entity.Property(e => e.eldocumentoseimprimeanombrededespachaorecibe)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("eldocumentoseimprimeanombrededespachaorecibe");
            entity.Property(e => e.estadodelregistro)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");
            entity.Property(e => e.esunacompra)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("esunacompra");
            entity.Property(e => e.esunanota)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("esunanota");
            entity.Property(e => e.esunaventa)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("esunaventa");
            entity.Property(e => e.esuninventarioinicial)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("esuninventarioinicial");
            entity.Property(e => e.esunpago)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("esunpago");
           
            entity.Property(e => e.leyendaimpresaeneldocumento)
                .HasMaxLength(500)
                .IsUnicode(false)
                .HasColumnName("leyendaimpresaeneldocumento");
            entity.Property(e => e.nombre)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("NOMBRE");
            entity.Property(e => e.pidecantidad)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("pidecantidad");
            entity.Property(e => e.pidecolor)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("pidecolor");
            entity.Property(e => e.pideconceptonotadebitocredito)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("pideconceptonotadebitocredito");
            entity.Property(e => e.pideconsecutivoautomatico)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("pideconsecutivoautomatico");
            entity.Property(e => e.pidedescuentodetalle)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("pidedescuentodetalle");
            entity.Property(e => e.pideempaque)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("pideempaque");
            entity.Property(e => e.pidefechadeldocumento)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("PIDEFECHADELDOCUMENTO");
            entity.Property(e => e.pidefechadevencimiento)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("PIDEFECHADEVENCIMIENTO");
            entity.Property(e => e.pidefisico)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("pidefisico");
            entity.Property(e => e.pideivadetalle)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("pideivadetalle");
            entity.Property(e => e.pideproducto)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("pideproducto");
            entity.Property(e => e.pideprograma)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("pideprograma");
            entity.Property(e => e.pidesubtotal)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("pidesubtotal");
            entity.Property(e => e.pidetalla)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("pidetalla");
            entity.Property(e => e.pidetipodedocumentoaafectar)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("pidetipodedocumentoaafectar");
            entity.Property(e => e.pidetipodedocumentoaafectardetalle)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("pidetipodedocumentoaafectardetalle");
            entity.Property(e => e.pidevalorunitario)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("pidevalorunitario");
            entity.Property(e => e.pidevendedor)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("pidevendedor");
            entity.Property(e => e.recibe)
                .HasMaxLength(300)
                .IsUnicode(false)
                .HasColumnName("RECIBE");
            entity.Property(e => e.restainventario)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("restainventario");
            entity.Property(e => e.restarcartera)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("restarcartera");
            entity.Property(e => e.saldarcantidadesdeldocumentollamado)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("saldarcantidadesdeldocumentollamado");
            entity.Property(e => e.sumainventario)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("sumainventario");
            entity.Property(e => e.sumarcartera)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("sumarcartera");
            entity.Property(e => e.tipoagentedespacha)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("tipoagentedespacha");
            entity.Property(e => e.tipoagenterecibe)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("tipoagenterecibe");
           
        });

        modelBuilder.Entity<Tiposdeprograma>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK_TABLA_TIPOS_DE_PROGRAMAS");

            entity.ToTable("TIPOSDEPROGRAMAS");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.estadodelregistro)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");
          
            entity.Property(e => e.Nombre)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("NOMBRE");
           
        });

 

        modelBuilder.Entity<TmpMovimientodeinventario>(entity =>
        {
            entity.ToTable("TMP_MOVIMIENTODEINVENTARIOS");

            entity.HasIndex(e => new { e.Tipodedocumento, e.Numerodeldocumento }, "IX_TMP_MOVIMIENTODEINVENTARIOS");

            entity.Property(e => e.Id)
                .ValueGeneratedOnAdd()
                .HasColumnType("decimal(18, 0)")
                .HasColumnName("ID");
            entity.Property(e => e.Banco).HasColumnName("BANCO");
            entity.Property(e => e.Cantidad)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("CANTIDAD");
            entity.Property(e => e.Cantidadporempaque)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("CANTIDADPOREMPAQUE");
            entity.Property(e => e.Codigoconceptonotadebitocredito).HasColumnName("CODIGOCONCEPTONOTADEBITOCREDITO");
            entity.Property(e => e.Codigodescuento1).HasColumnName("CODIGODESCUENTO1");
            entity.Property(e => e.Codigodescuento2).HasColumnName("CODIGODESCUENTO2");
            entity.Property(e => e.Codigoiva1).HasColumnName("CODIGOIVA1");
            entity.Property(e => e.Codigoiva2).HasColumnName("CODIGOIVA2");
            entity.Property(e => e.Codigoretencion1).HasColumnName("CODIGORETENCION1");
            entity.Property(e => e.Codigoretencion2).HasColumnName("CODIGORETENCION2");
            entity.Property(e => e.Costodeproduccionporunidad)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("COSTODEPRODUCCIONPORUNIDAD");
            entity.Property(e => e.Costofleteporunidad)
                .HasColumnType("decimal(18, 2)")
                .HasColumnName("COSTOFLETEPORUNIDAD");
            entity.Property(e => e.Costopromedioporunidad)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("COSTOPROMEDIOPORUNIDAD");
            entity.Property(e => e.Costoultimoporunidad)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("COSTOULTIMOPORUNIDAD");
            entity.Property(e => e.Despacha).HasColumnName("DESPACHA");
            entity.Property(e => e.Despachaaafectar).HasColumnName("DESPACHAAAFECTAR");
            entity.Property(e => e.DetalleDelProducto)
                .HasMaxLength(500)
                .IsUnicode(false)
                .HasColumnName("DETALLE_DEL_PRODUCTO");
            entity.Property(e => e.ElDocumentoEstaCancelado)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("EL_DOCUMENTO_ESTA_CANCELADO");
            entity.Property(e => e.estadodelregistro)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");
            entity.Property(e => e.fechadecreacion)
                .HasColumnType("datetime")
                .HasColumnName("FECHA_DE_CREACION");
            entity.Property(e => e.FechaTrasladoRecibidoYAprobado)
                .HasColumnType("datetime")
                .HasColumnName("FECHA_TRASLADO_RECIBIDO_Y_APROBADO");
            entity.Property(e => e.Fechadeldocumento)
                .HasColumnType("datetime")
                .HasColumnName("FECHADELDOCUMENTO");
            entity.Property(e => e.Fechadeprogramaciondelpago)
                .HasColumnType("datetime")
                .HasColumnName("FECHADEPROGRAMACIONDELPAGO");
            entity.Property(e => e.Fechadevencimientodeldocumento)
                .HasColumnType("datetime")
                .HasColumnName("FECHADEVENCIMIENTODELDOCUMENTO");
            entity.Property(e => e.Fletes).HasColumnName("FLETES");
            entity.Property(e => e.Formadepago).HasColumnName("FORMADEPAGO");
            entity.Property(e => e.Formula)
                .HasMaxLength(30)
                .IsUnicode(false)
                .HasColumnName("FORMULA");
            entity.Property(e => e.LaCantidadEstaDespachada)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("LA_CANTIDAD_ESTA_DESPACHADA");
            entity.Property(e => e.Numerodeempaques)
                .HasColumnType("decimal(18, 0)")
                .HasColumnName("NUMERODEEMPAQUES");
            entity.Property(e => e.Numerodeldocumento).HasColumnName("NUMERODELDOCUMENTO");
            entity.Property(e => e.Numerodeldocumentoaafectar).HasColumnName("NUMERODELDOCUMENTOAAFECTAR");
            entity.Property(e => e.Numerodelpago)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("NUMERODELPAGO");
            entity.Property(e => e.Observaciones)
                .HasMaxLength(3000)
                .IsUnicode(false)
                .HasColumnName("OBSERVACIONES");
            entity.Property(e => e.Porcentajedeiva1)
                .HasColumnType("decimal(5, 2)")
                .HasColumnName("PORCENTAJEDEIVA1");
            entity.Property(e => e.Porcentajedeiva2)
                .HasColumnType("decimal(5, 2)")
                .HasColumnName("PORCENTAJEDEIVA2");
            entity.Property(e => e.Porcentajederetencion1)
                .HasColumnType("numeric(5, 2)")
                .HasColumnName("PORCENTAJEDERETENCION1");
            entity.Property(e => e.Porcentajederetencion2)
                .HasColumnType("numeric(5, 2)")
                .HasColumnName("PORCENTAJEDERETENCION2");
            entity.Property(e => e.Porcentajedescuento1)
                .HasColumnType("decimal(5, 2)")
                .HasColumnName("PORCENTAJEDESCUENTO1");
            entity.Property(e => e.Porcentajedescuento2)
                .HasColumnType("decimal(5, 2)")
                .HasColumnName("PORCENTAJEDESCUENTO2");
            entity.Property(e => e.Producto)
                .HasMaxLength(30)
                .IsUnicode(false)
                .HasColumnName("PRODUCTO");
            entity.Property(e => e.Programa).HasColumnName("PROGRAMA");
            entity.Property(e => e.Recibe).HasColumnName("RECIBE");
            entity.Property(e => e.Recibeaafectar).HasColumnName("RECIBEAAFECTAR");
            entity.Property(e => e.Subtotal)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("SUBTOTAL");
            entity.Property(e => e.SumaORestaEnCartera)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("SUMA_O_RESTA_EN_CARTERA");
            entity.Property(e => e.SumaORestaEnInventario)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("SUMA_O_RESTA_EN_INVENTARIO");
            entity.Property(e => e.Tipodedocumento).HasColumnName("TIPODEDOCUMENTO");
            entity.Property(e => e.Tipodedocumentoaafectar).HasColumnName("TIPODEDOCUMENTOAAFECTAR");
            entity.Property(e => e.TrasladoRecibidoYAprobadoPor)
                .HasMaxLength(200)
                .IsUnicode(false)
                .HasColumnName("TRASLADO_RECIBIDO_Y_APROBADO_POR");
            entity.Property(e => e.Unidaddeempaque)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("UNIDADDEEMPAQUE");
            entity.Property(e => e.usuarioqueactualizo)
                .HasMaxLength(200)
                .IsUnicode(false)
                .HasColumnName("USUARIO_QUE_ACTUALIZO");
            entity.Property(e => e.Valordescuento1).HasColumnName("VALORDESCUENTO1");
            entity.Property(e => e.Valordescuento2).HasColumnName("VALORDESCUENTO2");
            entity.Property(e => e.Valoriva1).HasColumnName("VALORIVA1");
            entity.Property(e => e.Valoriva2).HasColumnName("VALORIVA2");
            entity.Property(e => e.Valorneto)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("VALORNETO");
            entity.Property(e => e.Valorretencion1).HasColumnName("VALORRETENCION1");
            entity.Property(e => e.Valorretencion2).HasColumnName("VALORRETENCION2");
            entity.Property(e => e.Valorunitario)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("VALORUNITARIO");
            entity.Property(e => e.Vendedor).HasColumnName("VENDEDOR");
        });

        modelBuilder.Entity<Unidadesdemedida>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK_TABLA_UNIDADES_DE_MEDIDA");

            entity.ToTable("UNIDADESDEMEDIDA");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.estadodelregistro)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");
          
            entity.Property(e => e.Nombre)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("NOMBRE");
          
        });

        modelBuilder.Entity<Usuarios>(entity =>
        {
            entity.ToTable("USUARIOS");

            entity.Property(e => e.id).HasColumnName("ID");
            entity.Property(e => e.area)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("AREA");
            entity.Property(e => e.bodega).HasColumnName("BODEGA");
            entity.Property(e => e.cargo)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("CARGO");
            entity.Property(e => e.correoelectronico)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("CORREO_ELECTRONICO");
            entity.Property(e => e.direccion)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("DIRECCION");
            entity.Property(e => e.estadodelregistro)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");
           
            entity.Property(e => e.login)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("LOGIN");
            entity.Property(e => e.nombre)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("NOMBRE");
            entity.Property(e => e.password)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("PASSWORD");
            entity.Property(e => e.perfil).HasColumnName("PERFIL");
            entity.Property(e => e.telefono)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("TELEFONO");
            entity.Property(e => e.tiposdedocumento)
                .HasMaxLength(500)
                .IsUnicode(false)
                .HasColumnName("TIPOSDEDOCUMENTO");
            
        });



        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
