using Inventarios.Models.CapturaDeMovimiento;
using Inventarios.Models.Seguridad;
using Inventarios.Models.TablasMaestras;

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

    public virtual DbSet<Programas> Programas { get; set; }

    public virtual DbSet<ActividadesEconomicas> ActividadesEconomicas { get; set; }

    public virtual DbSet<SiNo> SiNo { get; set; }

    public virtual DbSet<Colores> Colores { get; set; }

    public virtual DbSet<Tallas> Tallas { get; set; }

    public virtual DbSet<TiposDeAgente> TiposDeAgente { get; set; }

    public virtual DbSet<TiposDeCuentaBancaria> TiposDeCuentaBancaria { get; set; }

    public virtual DbSet<TiposDePersona> TiposDePersona { get; set; }

    public virtual DbSet<TiposDeRegimen> TiposDeRegimen { get; set; }

    public virtual DbSet<EstadosDeUnRegistro> EstadosDeUnRegistro { get; set; }

    public virtual DbSet<ConceptosNotaDebitoCredito> ConceptosNotaDebitoCredito { get; set; }

    public virtual DbSet<FormasDePago> FormasDePago { get; set; }

    public virtual DbSet<Formulas> Formulas { get; set; }

    public virtual DbSet<Ivas> Ivas { get; set; }

    public virtual DbSet<Retenciones> Retenciones { get; set; }

    public virtual DbSet<Log> Logs { get; set; }

    public virtual DbSet<Mensajesdelsistema> Mensajesdelsistema { get; set; }

    public virtual DbSet<Menu> Menus { get; set; }

    public virtual DbSet<Movimientodeinventarios> Movimientodeinventarios { get; set; }

    public virtual DbSet<Perfiles> Perfiles { get; set; }

    public virtual DbSet<Productos> Productos { get; set; }

    public virtual DbSet<Proveedores> Proveedores { get; set; }

    public virtual DbSet<Saldos> Saldos { get; set; }

    public virtual DbSet<TiposDeDocumento> TiposDeDocumento { get; set; }

    public virtual DbSet<Movimientodeinventariostmp> Movimientodeinventariostmp { get; set; }

    public virtual DbSet<UnidadesDeMedida> UnidadesDeMedida { get; set; }

    public virtual DbSet<Usuarios> Usuarios { get; set; }

    //protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    //    => optionsBuilder.UseSqlServer("Server=DESKTOP-56QVMV6\\SQLEXPRESS;Database=inventarios;Trusted_Connection=True;TrustServerCertificate=true;");

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseSqlServer(_iconfiguration.GetConnectionString("connectionstring"));

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<SiNo>(entity =>
        {
            entity.HasKey(e => e.id).HasName("PK_SINO");

            entity.ToTable("SiNo");

            entity.Property(e => e.id).HasColumnName("ID");

            entity.Property(e => e.nombre)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("NOMBRE");

            entity.Property(e => e.idusuario).HasColumnName("idusuario");
            entity.Property(e => e.nombreusuario)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("nombreusuario");
        });

        modelBuilder.Entity<Colores>(entity =>
        {
            entity.HasKey(e => e.id).HasName("PK_COLORES");

            entity.ToTable("Colores");

            entity.Property(e => e.id).HasColumnName("ID");

            entity.Property(e => e.estadodelregistro)
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");

            entity.Property(e => e.nombre)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("NOMBRE");

            entity.Property(e => e.idusuario).HasColumnName("idusuario");

            entity.Property(e => e.nombreusuario)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("nombreusuario");
        });

        modelBuilder.Entity<Tallas>(entity =>
        {
            entity.HasKey(e => e.id).HasName("PK_TALLAS");

            entity.ToTable("Tallas");

            entity.Property(e => e.id).HasColumnName("ID");

            entity.Property(e => e.nombre)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("NOMBRE");

            entity.Property(e => e.idusuario).HasColumnName("idusuario");

            entity.Property(e => e.nombreusuario)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("nombreusuario");
        });

        modelBuilder.Entity<TiposDeAgente>(entity =>
        {
            entity.HasKey(e => e.id).HasName("PK_TIPOSDEAGENTE");

            entity.ToTable("TiposDeAgente");

            entity.Property(e => e.id).HasColumnName("ID");

            entity.Property(e => e.nombre)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("NOMBRE");

            entity.Property(e => e.idusuario).HasColumnName("idusuario");
            entity.Property(e => e.nombreusuario)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("nombreusuario");
        });

        modelBuilder.Entity<TiposDeCuentaBancaria>(entity =>
        {
            entity.HasKey(e => e.id).HasName("PK_TIPOSDECUENTABANCARIA");

            entity.ToTable("TiposDeCuentaBancaria");

            entity.Property(e => e.id).HasColumnName("ID");

            entity.Property(e => e.nombre)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("NOMBRE");
            entity.Property(e => e.idusuario).HasColumnName("idusuario");
            entity.Property(e => e.nombreusuario)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("nombreusuario");
        });

        modelBuilder.Entity<TiposDePersona>(entity =>
        {
            entity.HasKey(e => e.id).HasName("PK_TIPOSDEPERSONA");

            entity.ToTable("TiposDePersona");

            entity.Property(e => e.id).HasColumnName("ID");

            entity.Property(e => e.nombre)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("NOMBRE");
            entity.Property(e => e.idusuario).HasColumnName("idusuario");
            entity.Property(e => e.nombreusuario)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("nombreusuario");
        });

        modelBuilder.Entity<TiposDeRegimen>(entity =>
        {
            entity.HasKey(e => e.id).HasName("PK_TIPOSDEREGIMEN");

            entity.ToTable("TiposDeRegimen");

            entity.Property(e => e.id).HasColumnName("ID");

            entity.Property(e => e.nombre)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("NOMBRE");
            entity.Property(e => e.idusuario).HasColumnName("idusuario");
            entity.Property(e => e.nombreusuario)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("nombreusuario");
        });

        modelBuilder.Entity<ActividadesEconomicas>(entity =>
        {
            entity.HasKey(e => e.id).HasName("PK_TABLA_ACTIVIDADES_ECONOMICAS");

            entity.ToTable("Actividadeseconomicas");

            entity.Property(e => e.id).HasColumnName("ID").ValueGeneratedOnAdd();

            entity.Property(e => e.estadodelregistro)
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");

            entity.Property(e => e.nombre)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("NOMBRE");
            entity.Property(e => e.idusuario).HasColumnName("idusuario");
            entity.Property(e => e.nombreusuario)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("nombreusuario");
        });

        modelBuilder.Entity<EstadosDeUnRegistro>(entity =>
        {
            entity.HasKey(e => e.id).HasName("IX_ESTADOSDEUNREGISTRO");
            entity.ToTable("Estadosdeunregistro");

            entity.Property(e => e.id)
              .HasMaxLength(1)
              .IsUnicode(false)
              .HasColumnName("ID");

            entity.Property(e => e.nombre)
                .HasMaxLength(30)
                .IsUnicode(false)
                .HasColumnName("NOMBRE");
        });

        modelBuilder.Entity<ConceptosNotaDebitoCredito>(entity =>
        {
            entity.HasKey(e => e.id).HasName("PK_TABLA_CONCEPTOS_NOTA_DEBITO_Y_CREDITO");

            entity.ToTable("CONCEPTOSNOTADEBITOYCREDITO");

            entity.Property(e => e.id).HasColumnName("ID");
            entity.Property(e => e.estadodelregistro)
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");

            entity.Property(e => e.nombre)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("NOMBRE");
            entity.Property(e => e.idusuario).HasColumnName("idusuario");
            entity.Property(e => e.nombreusuario)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("nombreusuario");
        });

        modelBuilder.Entity<FormasDePago>(entity =>
        {
            entity.HasKey(e => e.id).HasName("PK_FORMASDEPAGO");

            entity.ToTable("FORMASDEPAGO");

            entity.Property(e => e.id).HasColumnName("ID");
            entity.Property(e => e.estadodelregistro)
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");

            entity.Property(e => e.nombre)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("NOMBRE");
            entity.Property(e => e.idusuario).HasColumnName("idusuario");
            entity.Property(e => e.nombreusuario)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("nombreusuario");
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
            entity.Property(e => e.idusuario).HasColumnName("idusuario");
            entity.Property(e => e.nombreusuario)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("nombreusuario");
        });

        modelBuilder.Entity<Ivas>(entity =>
        {
            entity.HasKey(e => e.id).HasName("PK_IVAS");
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

            entity.Property(e => e.idusuario).HasColumnName("idusuario");
            entity.Property(e => e.nombreusuario)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("nombreusuario");
        });

        modelBuilder.Entity<Retenciones>(entity =>
        {
            entity.HasKey(e => e.id).HasName("PK_RETENCIONES");
            entity.ToTable("RETENCIONES");

            entity.Property(e => e.id).HasColumnName("ID");
            entity.Property(e => e.estadodelregistro)
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");

            entity.Property(e => e.nombre)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("NOMBRE");
            entity.Property(e => e.basedelaretencion)
                .HasColumnType("decimal(18, 2)")
                .HasColumnName("basedelaretencion");

            entity.Property(e => e.porcentaje)
              .HasColumnType("decimal(18, 2)")
              .HasColumnName("porcentaje");

            entity.Property(e => e.idusuario).HasColumnName("idusuario");
            entity.Property(e => e.nombreusuario)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("nombreusuario");
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
            entity.Property(e => e.idusuario).HasColumnName("idusuario");
            entity.Property(e => e.nombreusuario)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("nombreusuario");
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
            entity.Property(e => e.idusuario).HasColumnName("idusuario");
            entity.Property(e => e.nombreusuario)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("nombreusuario");
        });

        modelBuilder.Entity<Menu>(entity =>
        {
            entity.ToTable("MENU");

            entity.Property(e => e.orden)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("ORDEN");
            entity.Property(e => e.estadodelregistro)
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
            entity.Property(e => e.idusuario).HasColumnName("idusuario");
            entity.Property(e => e.nombreusuario)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("nombreusuario");
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
            entity.Property(e => e.idusuario).HasColumnName("idusuario");
            entity.Property(e => e.nombreusuario)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("nombreusuario");
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
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");

            entity.Property(e => e.unidaddemedida).HasColumnName("UNIDADDEMEDIDA");
            entity.Property(e => e.secargalinventario).HasColumnName("SECARGAALINVENTARIO");
            entity.Property(e => e.nivel1)
             .HasMaxLength(50)
             .IsUnicode(false)
             .HasColumnName("NIVEL1");
            entity.Property(e => e.nivel2)
            .HasMaxLength(100)
            .IsUnicode(false)
            .HasColumnName("NIVEL2");

            entity.Property(e => e.nivel3)
                        .HasMaxLength(100)
                        .IsUnicode(false)
                        .HasColumnName("NIVEL3");

            entity.Property(e => e.nivel4)
                        .HasMaxLength(100)
                        .IsUnicode(false)
                        .HasColumnName("NIVEL4");

            entity.Property(e => e.nivel5)
                        .HasMaxLength(100)
                        .IsUnicode(false)
                        .HasColumnName("NIVEL5");
        });

        modelBuilder.Entity<Proveedores>(entity =>
        {
            entity.ToTable("PROVEEDORES");

            entity.HasIndex(e => e.nombre, "IX_PROVEEDORES");

            entity.HasIndex(e => e.nit, "IX_NIT");

            entity.HasIndex(e => e.nivel1, "IX_PROVEEDORES_1");
            entity.HasIndex(e => e.nivel2, "IX_PROVEEDORES_2");
            entity.HasIndex(e => e.nivel3, "IX_PROVEEDORES_3");
            entity.HasIndex(e => e.nivel4, "IX_PROVEEDORES_4");
            entity.HasIndex(e => e.nivel5, "IX_PROVEEDORES_5");
            entity.HasIndex(e => e.nit, "IX_PROVEEDORES_6");

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
                .HasMaxLength(150)
                .IsUnicode(false)
                .HasColumnName("email1");
            entity.Property(e => e.email2)
                .HasMaxLength(150)
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
                .IsUnicode(false)
                .HasColumnName("ESTADODELREGISTRO");

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
            entity.Property(e => e.tipodeagente).HasColumnName("TIPODEAGENTE");
            entity.Property(e => e.tipoderegimen).HasColumnName("tipoderegimen");
            entity.Property(e => e.cuentabancaria)
              .HasMaxLength(20)
              .IsUnicode(false)
              .HasColumnName("cuentabancaria");
            entity.Property(e => e.tipodecuenta)
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

            entity.Property(e => e.idusuario).HasColumnName("idusuario");
            entity.Property(e => e.nombreusuario)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("nombreusuario");
            entity.Property(e => e.clavedeseguridadparapedidosporweb)
              .HasMaxLength(20)
              .IsUnicode(false)
              .HasColumnName("clavedeseguridadparapedidosporweb");
        });

        modelBuilder.Entity<Saldos>(entity =>
        {
            entity.ToTable("SALDOS");

            entity.HasIndex(e => new { e.producto, e.bodega }, "IX_SALDOS").IsUnique();
            entity.HasIndex(e => new { e.id }, "PK_SALDOS");

            entity.Property(e => e.id).HasColumnName("id");
            entity.Property(e => e.bodega).HasColumnName("bodega");
            entity.Property(e => e.costopromedio)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("costopromedio");

            entity.Property(e => e.entradas)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("entradas");
            entity.Property(e => e.fechadelaultimasalida)
                .HasColumnType("datetime")
                .HasColumnName("fechadelaultimasalida");

            entity.Property(e => e.producto)
                .HasMaxLength(30)
                .IsUnicode(false)
                .HasColumnName("PRODUCTO");

            entity.Property(e => e.saldo)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("saldo");
            entity.Property(e => e.saldofisico)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("saldofisico");
            entity.Property(e => e.saldoinicial)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("saldoinicial");
            entity.Property(e => e.salidas)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("salidas");
            entity.Property(e => e.stockmaximo)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("stockmaximo");
            entity.Property(e => e.stockminimo)
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

            entity.Property(e => e.idusuario).HasColumnName("idusuario");
            entity.Property(e => e.nombreusuario)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("nombreusuario");
        });

        modelBuilder.Entity<Programas>(entity =>
        {
            entity.HasKey(e => e.id).HasName("PK_TABLA_TIPOS_DE_PROGRAMAS");

            entity.ToTable("PROGRAMAS");

            entity.Property(e => e.id).HasColumnName("ID");
            entity.Property(e => e.estadodelregistro)
                 .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");

            entity.Property(e => e.nombre)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("NOMBRE");
            entity.Property(e => e.idusuario).HasColumnName("idusuario");
            entity.Property(e => e.nombreusuario)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("nombreusuario");
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
            entity.Property(e => e.idusuario).HasColumnName("idusuario");
            entity.Property(e => e.nombreusuario)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("nombreusuario");
        });

        modelBuilder.Entity<UnidadesDeMedida>(entity =>
        {
            entity.HasKey(e => e.id).HasName("PK_TABLA_UNIDADES_DE_MEDIDA");

            entity.ToTable("UNIDADESDEMEDIDA");

            entity.Property(e => e.id).HasColumnName("ID");
            entity.Property(e => e.estadodelregistro)
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");

            entity.Property(e => e.nombre)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("NOMBRE");
            entity.Property(e => e.idusuario).HasColumnName("idusuario");
            entity.Property(e => e.nombreusuario)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("nombreusuario");
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
            entity.Property(e => e.idusuario).HasColumnName("idusuario");
            entity.Property(e => e.nombreusuario)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("nombreusuario");
        });

        /////////////////////////////////////////////////////////////////
        ///  MOVMIIENTO DE INVENTARIO
        ///////////////////////////////////////////////////////////////

        modelBuilder.Entity<Movimientodeinventarios>(entity =>
        {
            entity.ToTable("MOVIMIENTODEINVENTARIOS");

            entity.HasIndex(e => new { e.despacha, e.recibe, e.tipodedocumento, e.numerodeldocumento }, "IX_MOVIMIENTODEINVENTARIOS");

            entity.HasIndex(e => new { e.despachaaafectar, e.recibeaafectar, e.tipodedocumentoaafectar, e.numerodeldocumentoaafectar }, "IX_MOVIMIENTODEINVENTARIOS_1");

            entity.HasIndex(e => new { e.tipodedocumento, e.numerodeldocumento }, "IX_MOVIMIENTODEINVENTARIOS_2");

            entity.HasIndex(e => new { e.tipodedocumento, e.fechadecreacion }, "IX_MOVIMIENTODEINVENTARIOS_3");

            /////////////////////
            ///// ENCABEZADO
            /////////////////////

            entity.Property(e => e.id)
                .ValueGeneratedOnAdd()
                .HasColumnName("ID");

            entity.Property(e => e.tipodedocumento).HasColumnName("TIPODEDOCUMENTO");

            entity.Property(e => e.nombretipodedocumento)
            .HasMaxLength(100)
            .IsUnicode(false)
            .HasColumnName("NOMBRETIPODEDOCUMENTO");

            entity.Property(e => e.numerodeldocumento).HasColumnName("NUMERODELDOCUMENTO");

            entity.Property(e => e.despacha).HasColumnName("DESPACHA");

            entity.Property(e => e.nombredespacha)
                .HasMaxLength(500)
                .IsUnicode(false)
                .HasColumnName("NOMBREDESPACHA");

            entity.Property(e => e.recibe).HasColumnName("RECIBE");

            entity.Property(e => e.nombrerecibe)
                  .HasMaxLength(500)
                  .IsUnicode(false)
                 .HasColumnName("NOMBRERECIBE");

            entity.Property(e => e.fechadeldocumento)
                .HasComment("la fecha que tiene  impreso el documento")
                .HasColumnType("datetime")
                .HasColumnName("FECHADELDOCUMENTO");

            entity.Property(e => e.plazo).HasColumnName("PLAZO");

            entity.Property(e => e.fechadevencimientodeldocumento)
               .HasColumnType("datetime")
               .HasColumnName("FECHADEVENCIMIENTODELDOCUMENTO");

            entity.Property(e => e.programa).HasColumnName("PROGRAMA");

            entity.Property(e => e.nombreprograma)
                  .HasMaxLength(500)
                  .IsUnicode(false)
                 .HasColumnName("NOMBREPROGRAMA");

            entity.Property(e => e.vendedor).HasColumnName("VENDEDOR");

            entity.Property(e => e.nombrevendedor)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("NOMBREVENDEDOR");

            entity.Property(e => e.tipodedocumentoaafectar).HasColumnName("TIPODEDOCUMENTOAAFECTAR");

            entity.Property(e => e.nombretipodedocumentoaafectar)
                  .HasMaxLength(500)
                  .IsUnicode(false)
                 .HasColumnName("NOMBRETIPODEDOCUMENTOAAFECTAR");

            entity.Property(e => e.numerodeldocumentoaafectar).HasColumnName("NUMERODELDOCUMENTOAAFECTAR");

            entity.Property(e => e.recibeaafectar).HasColumnName("RECIBEAAFECTAR");

            entity.Property(e => e.nombrerecibeaafectar)
                  .HasMaxLength(500)
                  .IsUnicode(false)
                 .HasColumnName("NOMBRERECIBEAAFECTAR");

            entity.Property(e => e.despachaaafectar).HasColumnName("DESPACHAAAFECTAR");

            entity.Property(e => e.nombredespachaaafectar)
             .HasMaxLength(500)
             .IsUnicode(false)
             .HasColumnName("NOMBREDESPACHAAAFECTAR");

            /////////////////////
            ///CAPTURA CARTERA
            /////////////////////

            entity.Property(e => e.formadepago).HasColumnName("FORMADEPAGO");

            entity.Property(e => e.nombreformadepago)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("NOMBREFORMADEPAGO");

            entity.Property(e => e.numerodelpago)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("NUMERODELPAGO");

            entity.Property(e => e.banco).HasColumnName("BANCO");

            entity.Property(e => e.nombrebanco)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("NOMBREBANCO");

            entity.Property(e => e.codigoconceptonotadebitocredito).HasColumnName("CODIGOCONCEPTONOTADEBITOCREDITO");

            entity.Property(e => e.nombreconceptonotadebitocredito).HasColumnName("NOMBRECONCEPTONOTADEBITOCREDITO");

            entity.Property(e => e.observaciones)
                .HasMaxLength(3000)
                .IsUnicode(false)
                .HasColumnName("OBSERVACIONES");

            //////////////////////
            ///// CAPTURA PRODUCTO
            /////////////////////

            entity.Property(e => e.formula)
    .HasMaxLength(30)
    .IsUnicode(false)
    .HasColumnName("FORMULA");

            entity.Property(e => e.nombreformula)
            .HasMaxLength(500)
            .IsUnicode(false)
            .HasColumnName("NOMBREFORMULA");

            entity.Property(e => e.producto)
                .HasMaxLength(30)
                .IsUnicode(false)
                .HasColumnName("PRODUCTO");

            entity.Property(e => e.nombreproducto)
            .HasMaxLength(500)
            .IsUnicode(false)
            .HasColumnName("NOMBREPRODUCTO");

            entity.Property(e => e.talla)
    .HasMaxLength(30)
    .IsUnicode(false)
    .HasColumnName("TALLA");

            entity.Property(e => e.nombretalla)
            .HasMaxLength(500)
            .IsUnicode(false)
            .HasColumnName("NOMBRETALLA");

            entity.Property(e => e.color)
    .HasMaxLength(30)
    .IsUnicode(false)
    .HasColumnName("COLOR");

            entity.Property(e => e.nombrecolor)
            .HasMaxLength(500)
            .IsUnicode(false)
            .HasColumnName("NOMBRECOLOR");

            entity.Property(e => e.unidaddemedida)
              .HasMaxLength(30)
              .IsUnicode(false)
              .HasColumnName("UNIDADDEMEDIDA");

            entity.Property(e => e.nombreunidaddemedida)
            .HasMaxLength(500)
            .IsUnicode(false)
            .HasColumnName("NOMBREUNIDADDEMEDIDA");

            entity.Property(e => e.numerodeempaques)
             .HasColumnName("NUMERODEEMPAQUES");

            entity.Property(e => e.unidaddeempaque)
                .IsUnicode(false)
                .HasColumnName("UNIDADDEEMPAQUE");

            entity.Property(e => e.nombreunidaddeempaque)
            .HasMaxLength(10)
            .IsUnicode(false)
            .HasColumnName("NOMBREUNIDADDEEMPAQUE");

            entity.Property(e => e.cantidadporempaque)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("CANTIDADPOREMPAQUE");

            entity.Property(e => e.cantidad)
               .HasColumnType("decimal(18, 5)")
                .HasColumnName("CANTIDAD");

            entity.Property(e => e.valorunitario)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("VALORUNITARIO");

            ////////////////////////////////
            /// SECCION COSTEO DEL REGISTRO
            /// ///////////////////////////

            entity.Property(e => e.costoultimoporunidad)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("COSTOULTIMOPORUNIDAD");

            entity.Property(e => e.costopromedioporunidad)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("COSTOPROMEDIOPORUNIDAD");

            entity.Property(e => e.costofleteporunidad)
                .HasColumnType("decimal(18, 2)")
                .HasColumnName("COSTOFLETEPORUNIDAD");

            //////////////////////////////////
            ///SECCION FLAGS
            /////////////////////////////////

            entity.Property(e => e.eldocumentoestacancelado)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("EL_DOCUMENTO_ESTA_CANCELADO");

            entity.Property(e => e.estadodelregistro)
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");

            entity.Property(e => e.fechadecreacion)
                .HasColumnType("datetime")
                .HasColumnName("FECHA_DE_CREACION");

            entity.Property(e => e.fechatrasladorecibidoyaprobado)

                .HasColumnType("datetime")
                .HasColumnName("FECHA_TRASLADO_RECIBIDO_Y_APROBADO");

            entity.Property(e => e.fechadeprogramaciondelpago)
                .HasColumnType("datetime")
                .HasColumnName("FECHADEPROGRAMACIONDELPAGO");

            entity.Property(e => e.lacantidadestadespachada)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("LA_CANTIDAD_ESTA_DESPACHADA");

            entity.Property(e => e.sumaorestaencartera)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("SUMA_O_RESTA_EN_CARTERA");

            entity.Property(e => e.sumaorestaeninventario)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("SUMA_O_RESTA_EN_INVENTARIO");

            entity.Property(e => e.trasladorecibidoyaprobadopor)
                .HasMaxLength(200)
                .IsUnicode(false)
                .HasColumnName("TRASLADO_RECIBIDO_Y_APROBADO_POR");

            entity.Property(e => e.consecutivousuario)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("CONSECUTIVOUSUARIO");

            entity.Property(e => e.idusuario).HasColumnName("IDUSUARIO");

            entity.Property(e => e.nombreusuario)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("nombreusuario");

            ////////////////////////////////
            /// LIQUIDACION DOCUMENTO
            /// ///////////////////////////

            entity.Property(e => e.subtotal)
                    .HasColumnType("decimal(18, 5)")
                    .HasColumnName("SUBTOTAL");

            entity.Property(e => e.codigodescuento1).HasColumnName("CODIGODESCUENTO1");

            entity.Property(e => e.nombrecodigodescuento1).HasColumnName("NOMBRECODIGODESCUENTO1");

            entity.Property(e => e.porcentajedescuento1).HasColumnType("decimal(18, 5)").HasColumnName("PORCENTAJEDESCUENTO1");

            entity.Property(e => e.valordescuento1).HasColumnName("VALORDESCUENTO1");

            entity.Property(e => e.codigoiva1).HasColumnName("CODIGOIVA1");

            entity.Property(e => e.nombrecodigoiva1).HasColumnName("NOMBRECODIGOIVA1");

            entity.Property(e => e.porcentajedeiva1).HasColumnType("decimal(18, 5)").HasColumnName("PORCENTAJEDEIVA1");

            entity.Property(e => e.valoriva1).HasColumnName("VALORIVA1");

            entity.Property(e => e.fletes).HasColumnName("FLETES");

            entity.Property(e => e.codigoretencion1).HasColumnName("CODIGORETENCION1");

            entity.Property(e => e.nombrecodigoretencion1).HasColumnName("NOMBRECODIGORETENCION1");

            entity.Property(e => e.porcentajederetencion1).HasColumnType("decimal(18, 5)").HasColumnName("PORCENTAJEDERETENCION1");

            entity.Property(e => e.valorretencion1).HasColumnName("VALORRETENCION1");

            entity.Property(e => e.valorneto)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("VALORNETO");
        });

        ////////////////////////////////////////////////////////////////////////////////////////////////
        ///                                                                                          ///
        /// MOVIMIENTO TEMPORAL                                                                      ///
        ///                                                                                          ///
        ////////////////////////////////////////////////////////////////////////////////////////////////

        modelBuilder.Entity<Movimientodeinventariostmp>(entity =>
        {
            entity.ToTable("MOVIMIENTODEINVENTARIOSTMP");

            entity.HasIndex(e => new { e.tipodedocumento, e.consecutivousuario }, "IX_MOVIMIENTODEINVENTARIOSTMP_1");

            entity.HasIndex(e => new { e.id }, "IX_MOVIMIENTODEINVENTARIOSTMP");

            /////////////////////
            ///// ENCABEZADO
            /////////////////////

            entity.Property(e => e.id)
                .ValueGeneratedOnAdd()
                .HasColumnName("ID");

            entity.Property(e => e.tipodedocumento).HasColumnName("TIPODEDOCUMENTO");

            entity.Property(e => e.nombretipodedocumento)
.HasMaxLength(100)
.IsUnicode(false)
.HasColumnName("NOMBRETIPODEDOCUMENTO");

            entity.Property(e => e.numerodeldocumento).HasColumnName("NUMERODELDOCUMENTO");

            entity.Property(e => e.despacha).HasColumnName("DESPACHA");

            entity.Property(e => e.nombredespacha)
                .HasMaxLength(500)
                .IsUnicode(false)
                .HasColumnName("NOMBREDESPACHA");

            entity.Property(e => e.recibe).HasColumnName("RECIBE");

            entity.Property(e => e.nombrerecibe)
                  .HasMaxLength(500)
                  .IsUnicode(false)
                 .HasColumnName("NOMBRERECIBE");

            entity.Property(e => e.fechadeldocumento)
                .HasComment("la fecha que tiene  impreso el documento")
                .HasColumnType("datetime")
                .HasColumnName("FECHADELDOCUMENTO");

            entity.Property(e => e.plazo).HasColumnName("PLAZO");

            entity.Property(e => e.fechadevencimientodeldocumento)
               .HasColumnType("datetime")
               .HasColumnName("FECHADEVENCIMIENTODELDOCUMENTO");

            entity.Property(e => e.programa).HasColumnName("PROGRAMA");

            entity.Property(e => e.nombreprograma)
                  .HasMaxLength(500)
                  .IsUnicode(false)
                 .HasColumnName("NOMBREPROGRAMA");

            entity.Property(e => e.vendedor).HasColumnName("VENDEDOR");

            entity.Property(e => e.nombrevendedor)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("NOMBREVENDEDOR");

            entity.Property(e => e.tipodedocumentoaafectar).HasColumnName("TIPODEDOCUMENTOAAFECTAR");

            entity.Property(e => e.nombretipodedocumentoaafectar)
                  .HasMaxLength(500)
                  .IsUnicode(false)
                 .HasColumnName("NOMBRETIPODEDOCUMENTOAAFECTAR");

            entity.Property(e => e.numerodeldocumentoaafectar).HasColumnName("NUMERODELDOCUMENTOAAFECTAR");

            entity.Property(e => e.recibeaafectar).HasColumnName("RECIBEAAFECTAR");

            entity.Property(e => e.nombrerecibeaafectar)
                  .HasMaxLength(500)
                  .IsUnicode(false)
                 .HasColumnName("NOMBRERECIBEAAFECTAR");

            entity.Property(e => e.despachaaafectar).HasColumnName("DESPACHAAAFECTAR");

            entity.Property(e => e.nombredespachaaafectar)
             .HasMaxLength(500)
             .IsUnicode(false)
             .HasColumnName("NOMBREDESPACHAAAFECTAR");

            /////////////////////
            ///CAPTURA CARTERA
            /////////////////////

            entity.Property(e => e.formadepago).HasColumnName("FORMADEPAGO");

            entity.Property(e => e.nombreformadepago)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("NOMBREFORMADEPAGO");

            entity.Property(e => e.numerodelpago)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("NUMERODELPAGO");

            entity.Property(e => e.banco).HasColumnName("BANCO");

            entity.Property(e => e.nombrebanco)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("NOMBREBANCO");

            entity.Property(e => e.codigoconceptonotadebitocredito).HasColumnName("CODIGOCONCEPTONOTADEBITOCREDITO");

            entity.Property(e => e.nombreconceptonotadebitocredito).HasColumnName("NOMBRECONCEPTONOTADEBITOCREDITO");

            entity.Property(e => e.observaciones)
                .HasMaxLength(3000)
                .IsUnicode(false)
                .HasColumnName("OBSERVACIONES");

            //////////////////////
            ///// CAPTURA PRODUCTO
            /////////////////////

            entity.Property(e => e.formula)
    .HasMaxLength(30)
    .IsUnicode(false)
    .HasColumnName("FORMULA");

            entity.Property(e => e.nombreformula)
            .HasMaxLength(500)
            .IsUnicode(false)
            .HasColumnName("NOMBREFORMULA");

            entity.Property(e => e.producto)
                .HasMaxLength(30)
                .IsUnicode(false)
                .HasColumnName("PRODUCTO");

            entity.Property(e => e.nombreproducto)
            .HasMaxLength(500)
            .IsUnicode(false)
            .HasColumnName("NOMBREPRODUCTO");

            entity.Property(e => e.unidaddemedida)
            .HasMaxLength(30)
            .IsUnicode(false)
            .HasColumnName("UNIDADDEMEDIDA");

            entity.Property(e => e.nombreunidaddemedida)
            .HasMaxLength(500)
            .IsUnicode(false)
            .HasColumnName("NOMBREUNIDADDEMEDIDA");

            entity.Property(e => e.numerodeempaques)
             .HasColumnName("NUMERODEEMPAQUES");

            entity.Property(e => e.unidaddeempaque)
                .IsUnicode(false)
                .HasColumnName("UNIDADDEEMPAQUE");

            entity.Property(e => e.nombreunidaddeempaque)
            .HasMaxLength(10)
            .IsUnicode(false)
            .HasColumnName("NOMBREUNIDADDEEMPAQUE");

            entity.Property(e => e.cantidadporempaque)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("CANTIDADPOREMPAQUE");

            entity.Property(e => e.cantidad)
               .HasColumnType("decimal(18, 5)")
                .HasColumnName("CANTIDAD");

            entity.Property(e => e.valorunitario)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("VALORUNITARIO");

            ////////////////////////////////
            /// SECCION COSTEO DEL REGISTRO
            /// ///////////////////////////

            entity.Property(e => e.costoultimoporunidad)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("COSTOULTIMOPORUNIDAD");

            entity.Property(e => e.costopromedioporunidad)
    .HasColumnType("decimal(18, 5)")
    .HasColumnName("COSTOPROMEDIOPORUNIDAD");

            entity.Property(e => e.costofleteporunidad)
                .HasColumnType("decimal(18, 2)")
                .HasColumnName("COSTOFLETEPORUNIDAD");

            //////////////////////////////////
            ///SECCION FLAGS
            /////////////////////////////////

            entity.Property(e => e.eldocumentoestacancelado)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("EL_DOCUMENTO_ESTA_CANCELADO");

            entity.Property(e => e.estadodelregistro)
                .IsUnicode(false)
                .HasColumnName("ESTADO_DEL_REGISTRO");

            entity.Property(e => e.fechadecreacion)
                .HasColumnType("datetime")
                .HasColumnName("FECHA_DE_CREACION");

            entity.Property(e => e.fechatrasladorecibidoyaprobado)

                .HasColumnType("datetime")
                .HasColumnName("FECHA_TRASLADO_RECIBIDO_Y_APROBADO");

            entity.Property(e => e.fechadeprogramaciondelpago)
                .HasColumnType("datetime")
                .HasColumnName("FECHADEPROGRAMACIONDELPAGO");

            entity.Property(e => e.lacantidadestadespachada)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("LA_CANTIDAD_ESTA_DESPACHADA");

            entity.Property(e => e.sumaorestaencartera)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("SUMA_O_RESTA_EN_CARTERA");

            entity.Property(e => e.sumaorestaeninventario)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("SUMA_O_RESTA_EN_INVENTARIO");

            entity.Property(e => e.trasladorecibidoyaprobadopor)
                .HasMaxLength(200)
                .IsUnicode(false)
                .HasColumnName("TRASLADO_RECIBIDO_Y_APROBADO_POR");

            entity.Property(e => e.consecutivousuario)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("CONSECUTIVOUSUARIO");

            entity.Property(e => e.idusuario).HasColumnName("IDUSUARIO");

            entity.Property(e => e.nombreusuario)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("nombreusuario");

            ////////////////////////////////
            /// LIQUIDACION DOCUMENTO
            /// ///////////////////////////

            entity.Property(e => e.subtotal)
                    .HasColumnType("decimal(18, 5)")
                    .HasColumnName("SUBTOTAL");

            entity.Property(e => e.codigodescuento1).HasColumnName("CODIGODESCUENTO1");

            entity.Property(e => e.nombrecodigodescuento1).HasColumnName("NOMBRECODIGODESCUENTO1");

            entity.Property(e => e.porcentajedescuento1).HasColumnType("decimal(18, 5)").HasColumnName("PORCENTAJEDESCUENTO1");

            entity.Property(e => e.valordescuento1).HasColumnName("VALORDESCUENTO1");

            entity.Property(e => e.codigoiva1).HasColumnName("CODIGOIVA1");

            entity.Property(e => e.nombrecodigoiva1).HasColumnName("NOMBRECODIGOIVA1");

            entity.Property(e => e.porcentajedeiva1).HasColumnType("decimal(18, 5)").HasColumnName("PORCENTAJEDEIVA1");

            entity.Property(e => e.valoriva1).HasColumnName("VALORIVA1");

            entity.Property(e => e.fletes).HasColumnName("FLETES");

            entity.Property(e => e.codigoretencion1).HasColumnName("CODIGORETENCION1");

            entity.Property(e => e.nombrecodigoretencion1).HasColumnName("NOMBRECODIGORETENCION1");

            entity.Property(e => e.porcentajederetencion1).HasColumnType("decimal(18, 5)").HasColumnName("PORCENTAJEDERETENCION1");

            entity.Property(e => e.valorretencion1).HasColumnName("VALORRETENCION1");

            entity.Property(e => e.valorneto)
                .HasColumnType("decimal(18, 5)")
                .HasColumnName("VALORNETO");
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