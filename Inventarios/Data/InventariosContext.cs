using System;
using System.Collections.Generic;
using Inventarios.Models;
using Microsoft.EntityFrameworkCore;

namespace Inventarios.Data;

public partial class InventariosContext : DbContext
{
    private readonly IConfiguration _iconfiguration;

    public InventariosContext(DbContextOptions<InventariosContext> options, IConfiguration configutarion_)
        : base(options)
    {
        _iconfiguration = configutarion_;
    }

    public virtual DbSet<ActividadesEconomicas> Actividadeseconomicas { get; set; }

 

  

    public virtual DbSet<Colore> Colores { get; set; }

    public virtual DbSet<ConceptosNotaDebitoCredito> ConceptosNotaDebitoCredito { get; set; }

    public virtual DbSet<FormasDePago> FormasDePago { get; set; }

    public virtual DbSet<Formulas> Formulas { get; set; }

    public virtual DbSet<Ivas> Ivas { get; set; }

    public virtual DbSet<Log> Logs { get; set; }

    public virtual DbSet<Mensajesdelsistema> Mensajesdelsistema { get; set; }

    public virtual DbSet<Menu> Menus { get; set; }

    public virtual DbSet<Movimientodeinventario> Movimientodeinventarios { get; set; }

    public virtual DbSet<Perfiles> Perfiles { get; set; }

    public virtual DbSet<Productos> Productos { get; set; }

    public virtual DbSet<Proveedores> Proveedores { get; set; }

    public virtual DbSet<Saldos> Saldos { get; set; }

    public virtual DbSet<TiposDeDocumento> TiposDeDocumento { get; set; }

    public virtual DbSet<TiposDePrograma> TiposDePrograma { get; set; }

    public virtual DbSet<TmpMovimientodeinventario> TmpMovimientodeinventarios { get; set; }

    public virtual DbSet<UnidadesDeMedida> UnidadesDeMedida { get; set; }

    public virtual DbSet<Usuarios> Usuarios { get; set; }

    //protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    //    => optionsBuilder.UseSqlServer("Server=DESKTOP-56QVMV6\\SQLEXPRESS;Database=inventarios;Trusted_Connection=True;TrustServerCertificate=true;");

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseSqlServer(_iconfiguration.GetConnectionString("connectionstring"));

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

        modelBuilder.Entity<ConceptosNotaDebitoCredito>(entity =>
        {
            entity.HasKey(e => e.id).HasName("PK_TABLA_CONCEPTOS_NOTA_DEBITO_Y_CREDITO");

            entity.ToTable("CONCEPTOSNOTADEBITOYCREDITO");

            entity.Property(e => e.id).HasColumnName("ID");
            entity.Property(e => e.estadodelregistro)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");

            entity.Property(e => e.nombre)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("NOMBRE");
        });

        modelBuilder.Entity<FormasDePago>(entity =>
        {
            entity.HasKey(e => e.id).HasName("PK_TABLA_FORMAS_DE_PAGO");

            entity.ToTable("FORMASDEPAGO");

            entity.Property(e => e.id).HasColumnName("ID");
            entity.Property(e => e.estadodelregistro)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");

            entity.Property(e => e.nombre)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("NOMBRE");
        });

        modelBuilder.Entity<Formulas>(entity =>
        {
            entity.HasKey(e => e.id).HasName("PK_FORMULAS_1");

            entity.ToTable("FORMULAS");

            entity.HasIndex(e => new { e.formula, e.componente }, "IX_FORMULAS").IsUnique();

            entity.Property(e => e.id).HasColumnName("ID");
            entity.Property(e => e.cantidad)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("CANTIDAD");
            entity.Property(e => e.componente).HasColumnName("COMPONENTE");

            entity.Property(e => e.formula).HasColumnName("FORMULA");
        });

        modelBuilder.Entity<Ivas>(entity =>
        {
            entity.ToTable("IVAS");

            entity.Property(e => e.id).HasColumnName("ID");
            entity.Property(e => e.estadodelregistro)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");

            entity.Property(e => e.nombre)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("NOMBRE");
            entity.Property(e => e.porcentaje)
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
            entity.HasKey(e => e.id).HasName("PK_MENSAJESDELSISTEMA");

            entity.ToTable("MENSAJESDELSISTEMA");

            entity.Property(e => e.id).HasColumnName("ID").ValueGeneratedOnAdd();

            entity.Property(e => e.fechadesde)
                .HasColumnType("datetime")
                .HasColumnName("FECHA_DESDE");
            entity.Property(e => e.fechahasta)
                .HasColumnType("datetime")
                .HasColumnName("FECHA_HASTA");
            entity.Property(e => e.id)
                .ValueGeneratedOnAdd()
                .HasColumnName("id");
            entity.Property(e => e.mensaje)
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

            entity.HasIndex(e => new { e.despacha, e.recibe, e.tipodedocumento, e.numerodeldocumento }, "IX_MOVIMIENTODEINVENTARIOS");

            entity.HasIndex(e => new { e.despachaaafectar, e.recibeaafectar, e.tipodedocumentoaafectar, e.numerodeldocumentoaafectar }, "IX_MOVIMIENTODEINVENTARIOS_1");

            entity.HasIndex(e => new { e.tipodedocumento, e.numerodeldocumento }, "IX_MOVIMIENTODEINVENTARIOS_2");

            entity.HasIndex(e => new { e.tipodedocumento, e.fechadecreacion }, "IX_MOVIMIENTODEINVENTARIOS_3");

            entity.Property(e => e.id)
                .ValueGeneratedOnAdd()
                .HasColumnType("decimal(18, 0)")
                .HasColumnName("ID");
            entity.Property(e => e.banco).HasColumnName("BANCO");
            entity.Property(e => e.cantidad)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("CANTIDAD");
            entity.Property(e => e.cantidadporempaque)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("CANTIDADPOREMPAQUE");
            entity.Property(e => e.codigoconceptonotadebitocredito).HasColumnName("CODIGOCONCEPTONOTADEBITOCREDITO");
            entity.Property(e => e.codigodescuento1).HasColumnName("CODIGODESCUENTO1");

            entity.Property(e => e.codigoiva1).HasColumnName("CODIGOIVA1");

            entity.Property(e => e.codigoretencion1).HasColumnName("CODIGORETENCION1");

            entity.Property(e => e.costodeproduccionporunidad)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("COSTODEPRODUCCIONPORUNIDAD");
            entity.Property(e => e.costofleteporunidad)
                .HasColumnType("decimal(18, 2)")
                .HasColumnName("COSTOFLETEPORUNIDAD");
            entity.Property(e => e.costopromedioporunidad)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("COSTOPROMEDIOPORUNIDAD");
            entity.Property(e => e.costoultimoporunidad)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("COSTOULTIMOPORUNIDAD");
            entity.Property(e => e.despacha).HasColumnName("DESPACHA");
            entity.Property(e => e.despachaaafectar).HasColumnName("DESPACHAAAFECTAR");
            entity.Property(e => e.detalleDelProducto)
                .HasMaxLength(500)
                .IsUnicode(false)
                .HasColumnName("DETALLE_DEL_PRODUCTO");
            entity.Property(e => e.eldocumentoestacancelado)
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
            entity.Property(e => e.fechatrasladorecibidoyaprobado)
                .HasColumnType("datetime")
                .HasColumnName("FECHA_TRASLADO_RECIBIDO_Y_APROBADO");
            entity.Property(e => e.fechadeldocumento)
                .HasComment("la fecha que tiene  impreso el documento")
                .HasColumnType("datetime")
                .HasColumnName("FECHADELDOCUMENTO");
            entity.Property(e => e.fechadeprogramaciondelpago)
                .HasColumnType("datetime")
                .HasColumnName("FECHADEPROGRAMACIONDELPAGO");
            entity.Property(e => e.fechadevencimientodeldocumento)
                .HasColumnType("datetime")
                .HasColumnName("FECHADEVENCIMIENTODELDOCUMENTO");
            entity.Property(e => e.fletes).HasColumnName("FLETES");
            entity.Property(e => e.formadepago).HasColumnName("FORMADEPAGO");
            entity.Property(e => e.formula)
                .HasMaxLength(30)
                .IsUnicode(false)
                .HasColumnName("FORMULA");
            entity.Property(e => e.lacantidadestadespachada)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("LA_CANTIDAD_ESTA_DESPACHADA");
            entity.Property(e => e.numerodeempaques)
                .HasColumnType("decimal(18, 0)")
                .HasColumnName("NUMERODEEMPAQUES");
            entity.Property(e => e.numerodeldocumento).HasColumnName("NUMERODELDOCUMENTO");
            entity.Property(e => e.numerodeldocumentoaafectar).HasColumnName("NUMERODELDOCUMENTOAAFECTAR");
            entity.Property(e => e.numerodelpago)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("NUMERODELPAGO");
            entity.Property(e => e.observaciones)
                .HasMaxLength(3000)
                .IsUnicode(false)
                .HasColumnName("OBSERVACIONES");
            entity.Property(e => e.porcentajedeiva1)
                .HasColumnType("decimal(5, 2)")
                .HasColumnName("PORCENTAJEDEIVA1");

            entity.Property(e => e.porcentajederetencion1)
                .HasColumnType("numeric(5, 2)")
                .HasColumnName("PORCENTAJEDERETENCION1");

            entity.Property(e => e.porcentajedescuento1)
                .HasColumnType("decimal(5, 2)")
                .HasColumnName("PORCENTAJEDESCUENTO1");

            entity.Property(e => e.producto)
                .HasMaxLength(30)
                .IsUnicode(false)
                .HasColumnName("PRODUCTO");
            entity.Property(e => e.programa).HasColumnName("PROGRAMA");
            entity.Property(e => e.recibe).HasColumnName("RECIBE");
            entity.Property(e => e.recibeaafectar).HasColumnName("RECIBEAAFECTAR");
            entity.Property(e => e.subtotal)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("SUBTOTAL");
            entity.Property(e => e.sumaorestaencartera)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("SUMA_O_RESTA_EN_CARTERA");
            entity.Property(e => e.sumaorestaeninventario)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("SUMA_O_RESTA_EN_INVENTARIO");
            entity.Property(e => e.tipodedocumento).HasColumnName("TIPODEDOCUMENTO");
            entity.Property(e => e.tipodedocumentoaafectar).HasColumnName("TIPODEDOCUMENTOAAFECTAR");
            entity.Property(e => e.trasladorecibidoyaprobadopor)
                .HasMaxLength(200)
                .IsUnicode(false)
                .HasColumnName("TRASLADO_RECIBIDO_Y_APROBADO_POR");
            entity.Property(e => e.unidaddeempaque)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("UNIDADDEEMPAQUE");
            entity.Property(e => e.usuarioqueactualizo)
                .HasMaxLength(200)
                .IsUnicode(false)
                .HasColumnName("USUARIO_QUE_ACTUALIZO");
            entity.Property(e => e.valordescuento1).HasColumnName("VALORDESCUENTO1");

            entity.Property(e => e.valoriva1).HasColumnName("VALORIVA1");

            entity.Property(e => e.valorneto)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("VALORNETO");
            entity.Property(e => e.valorretencion1).HasColumnName("VALORRETENCION1");

            entity.Property(e => e.valorunitario)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("VALORUNITARIO");
            entity.Property(e => e.vendedor).HasColumnName("VENDEDOR");
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

        modelBuilder.Entity<Productos>(entity =>
        {
            entity.ToTable("PRODUCTOS");

            entity.HasIndex(e => e.nombre, "IX_PRODUCTOS");
            entity.HasIndex(e => e.id, "PK_PRODUCTOS").IsUnique();
            entity.HasIndex(e => e.nivel1, "IX_PRODUCTOS_1");
            entity.HasIndex(e => e.nivel2, "IX_PRODUCTOS_2");
            entity.HasIndex(e => e.nivel3, "IX_PRODUCTOS_3");
            entity.HasIndex(e => e.nivel4, "IX_PRODUCTOS_4");
            entity.HasIndex(e => e.nivel5, "IX_PRODUCTOS_5");

            entity.Property(e => e.id).HasColumnName("ID");
            entity.Property(e => e.nombre)
                .HasMaxLength(300)
                .IsUnicode(false)
                .HasColumnName("NOMBRE");
            entity.Property(e => e.costoultimo)
             .HasColumnType("decimal(18, 5)")
             .HasColumnName("COSTOULTIMO");

            entity.Property(e => e.precio1)
            .HasColumnType("decimal(18, 5)")
            .HasColumnName("PRECIO1");

            entity.Property(e => e.codigoiva1).HasColumnName("CODIGOIVA1");

            entity.Property(e => e.estadodelregistro)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");

            entity.Property(e => e.unidaddemedida).HasColumnName("UNIDADDEMEDIDA");
            entity.Property(e => e.secargalinventario).HasColumnName("SECARGAALINVENTARIO");
            entity.Property(e => e.nivel1)
             .HasMaxLength(50)
             .IsUnicode(false)
             .HasColumnName("NIVEL1");
            entity.Property(e => e.nivel2)
            .HasMaxLength(50)
            .IsUnicode(false)
            .HasColumnName("NIVEL2");

            entity.Property(e => e.nivel3)
                        .HasMaxLength(50)
                        .IsUnicode(false)
                        .HasColumnName("NIVEL3");

            entity.Property(e => e.nivel4)
                        .HasMaxLength(50)
                        .IsUnicode(false)
                        .HasColumnName("NIVEL4");

            entity.Property(e => e.nivel5)
                        .HasMaxLength(50)
                        .IsUnicode(false)
                        .HasColumnName("NIVEL5");
        });

        modelBuilder.Entity<Proveedores>(entity =>
        {
            entity.ToTable("PROVEEDORES");

            entity.HasIndex(e => e.nombre, "IX_PROVEEDORES");

            entity.HasIndex(e => e.nit, "PK_PROVEEDORES").IsUnique();

            entity.HasIndex(e => e.nivel1, "IX_PROVEEDORES_1");
            entity.HasIndex(e => e.nivel2, "IX_PROVEEDORES_2");
            entity.HasIndex(e => e.nivel3, "IX_PROVEEDORES_3");
            entity.HasIndex(e => e.nivel4, "IX_PROVEEDORES_4");
            entity.HasIndex(e => e.nivel5, "IX_PROVEEDORES_5");

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
            entity.Property(e => e.cuentabancaria)
              .HasMaxLength(20)
              .IsUnicode(false)
              .HasColumnName("cuentabancaria");
            entity.Property(e => e.tipodecuenta)
              .HasMaxLength(1)
              .IsUnicode(false)
              .HasColumnName("tipodecuenta");


            entity.Property(e => e.nivel1)
         .HasMaxLength(50)
         .IsUnicode(false)
         .HasColumnName("NIVEL1");
            entity.Property(e => e.nivel2)
            .HasMaxLength(50)
            .IsUnicode(false)
            .HasColumnName("NIVEL2");

            entity.Property(e => e.nivel3)
                        .HasMaxLength(50)
                        .IsUnicode(false)
                        .HasColumnName("NIVEL3");

            entity.Property(e => e.nivel4)
                        .HasMaxLength(50)
                        .IsUnicode(false)
                        .HasColumnName("NIVEL4");

            entity.Property(e => e.nivel5)
                        .HasMaxLength(50)
                        .IsUnicode(false)
                        .HasColumnName("NIVEL5");

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
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("DESPACHA");
            entity.Property(e => e.eldocumentoallamarsolosepuedellamarunavez)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("eldocumentoallamarsolosepuedellamarunavez");
            entity.Property(e => e.eldocumentoseimprime)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("eldocumentoseimprime");
            entity.Property(e => e.eldocumentoseimprimeanombrededespachaorecibe)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("eldocumentoseimprimeanombrededespachaorecibe");
            entity.Property(e => e.estadodelregistro)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");
            entity.Property(e => e.esunacompra)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("esunacompra");
            entity.Property(e => e.esunanota)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("esunanota");
            entity.Property(e => e.esunaventa)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("esunaventa");
            entity.Property(e => e.esuninventarioinicial)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("esuninventarioinicial");
            entity.Property(e => e.esunpago)
                .HasMaxLength(1)
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
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("pidecantidad");
            entity.Property(e => e.pidecolor)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("pidecolor");
            entity.Property(e => e.pideconceptonotadebitocredito)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("pideconceptonotadebitocredito");
            entity.Property(e => e.pideconsecutivoautomatico)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("pideconsecutivoautomatico");
            entity.Property(e => e.pidedescuentodetalle)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("pidedescuentodetalle");
            entity.Property(e => e.pideempaque)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("pideempaque");

            entity.Property(e => e.pidefechadevencimiento)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("PIDEFECHADEVENCIMIENTO");
            entity.Property(e => e.pidefisico)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("pidefisico");
            entity.Property(e => e.pideivadetalle)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("pideivadetalle");
            entity.Property(e => e.pideproducto)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("pideproducto");
            entity.Property(e => e.pideprograma)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("pideprograma");
            entity.Property(e => e.pidesubtotal)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("pidesubtotal");
            entity.Property(e => e.pidetalla)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("pidetalla");
            entity.Property(e => e.pidetipodedocumentoaafectar)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("pidetipodedocumentoaafectar");
            entity.Property(e => e.pidetipodedocumentoaafectardetalle)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("pidetipodedocumentoaafectardetalle");
            entity.Property(e => e.pidevalorunitario)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("pidevalorunitario");
            entity.Property(e => e.pidevendedor)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("pidevendedor");
            entity.Property(e => e.recibe)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("RECIBE");
            entity.Property(e => e.restainventario)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("restainventario");
            entity.Property(e => e.restarcartera)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("restarcartera");
            entity.Property(e => e.saldarcantidadesdeldocumentollamado)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("saldarcantidadesdeldocumentollamado");
            entity.Property(e => e.sumainventario)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("sumainventario");
            entity.Property(e => e.sumarcartera)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("sumarcartera");
            entity.Property(e => e.tipoagentedespacha)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("tipoagentedespacha");
            entity.Property(e => e.tipoagenterecibe)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("tipoagenterecibe");

            entity.Property(e => e.titulodespacha)
            .HasMaxLength(50)
            .IsUnicode(false)
            .HasColumnName("titulodespacha");
            entity.Property(e => e.titulorecibe)
         .HasMaxLength(50)
         .IsUnicode(false)
         .HasColumnName("titulorecibe");
            entity.Property(e => e.transaccionesquepuedellamar)
    .HasMaxLength(50)
    .IsUnicode(false)
    .HasColumnName("transaccionesquepuedellamar");
        });

        modelBuilder.Entity<TiposDePrograma>(entity =>
        {
            entity.HasKey(e => e.id).HasName("PK_TABLA_TIPOS_DE_PROGRAMAS");

            entity.ToTable("TIPOSDEPROGRAMAS");

            entity.Property(e => e.id).HasColumnName("ID");
            entity.Property(e => e.estadodelregistro)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");

            entity.Property(e => e.nombre)
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

        modelBuilder.Entity<UnidadesDeMedida>(entity =>
        {
            entity.HasKey(e => e.id).HasName("PK_TABLA_UNIDADES_DE_MEDIDA");

            entity.ToTable("UNIDADESDEMEDIDA");

            entity.Property(e => e.id).HasColumnName("ID");
            entity.Property(e => e.estadodelregistro)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");

            entity.Property(e => e.nombre)
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

    private partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}

public partial class InventariosContext : DbContext
{
    private partial void OnModelCreatingPartial(ModelBuilder modelBuilder)
    { }
}