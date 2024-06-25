using Inventarios.Data;
using Inventarios.DataAccess;
using Inventarios.DataAccess.CapturaDeMovimiento;
using Inventarios.DataAccess.Seguridad;
using Inventarios.DataAccess.TablasMaestras;
using Inventarios.Map;
using Inventarios.Models;
using Inventarios.services.CapturaDeMovimiento;
using Inventarios.services.Seguridad;
using Inventarios.services.TablasMaestras;
using Inventarios.Utils;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;
using System.Reflection;

var builder = WebApplication.CreateBuilder(args);


// permite transmitir archivos mayores de 512 megas
builder.WebHost.ConfigureKestrel(options => {

    options.Limits.MaxRequestBodySize = 256 * 1024 * 1024;
});

// Add services to the container.
// Scaffold-DbContext "Server=DESKTOP-56QVMV6\SQLEXPRESS;Database=inventarios;Trusted_Connection=True;TrustServerCertificate=true" Microsoft.EntityFrameworkCore.SqlServer -OutputDir Models
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1",
        new OpenApiInfo
        {
            Title = "Mi aplicacion de inventarios",
            Version = "v2.0",
            Description = "hola",
            TermsOfService = new Uri("https://example.com/terms"),
            Contact = new OpenApiContact
            {
                Name = "John Walkner",
                Email = "John.Walkner@gmail.com",
                Url = new Uri("https://twitter.com/jwalkner"),
            },
            License = new OpenApiLicense
            {
                Name = "Employee API LICX",
                Url = new Uri("https://example.com/license"),
            }
        });

    var xmlFile = $"{Assembly.GetExecutingAssembly().GetName().Name}.xml";
    var xmlPath = Path.Combine(AppContext.BaseDirectory, xmlFile);
    c.IncludeXmlComments(xmlPath);
});

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddDistributedMemoryCache();
builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromSeconds(3600);

    options.Cookie.HttpOnly = true;
    options.Cookie.IsEssential = true;
});
builder.Services.AddHttpContextAccessor();  

//data access

// captura de movimiento
builder.Services.AddScoped<MovimientodeinventariosAccess>();

// seguridad
builder.Services.AddScoped<LogAccess>();
builder.Services.AddScoped<MenuAccess>();
builder.Services.AddScoped<UserAccess>();
builder.Services.AddScoped<PerfilesAccess>();

// tablas maestras
builder.Services.AddScoped<ConceptosNotaDebitoCreditoAccess>();
builder.Services.AddScoped<ActividadesEconomicasAccess>();
builder.Services.AddScoped<TiposDeDocumentoAccess>();
builder.Services.AddScoped<ProveedoresAccess>();
builder.Services.AddScoped<MensajesDelSistemaAccess>();
builder.Services.AddScoped<FormasDePagoAccess>();
builder.Services.AddScoped<ProgramasAccess>();
builder.Services.AddScoped<FormulasAccess>();
builder.Services.AddScoped<UnidadesDeMedidaAccess>();
builder.Services.AddScoped<IvasAccess>();
builder.Services.AddScoped<ProductosAccess>();
builder.Services.AddScoped<EstadosDeUnRegistroAccess>();
builder.Services.AddScoped<ColoresAccess>();
builder.Services.AddScoped<SiNoAccess>();
builder.Services.AddScoped<SaldosAccess>();
builder.Services.AddScoped<TallasAccess>();
builder.Services.AddScoped<TiposDeAgenteAccess>();
builder.Services.AddScoped<TiposDeCuentaBancariaAccess>();
builder.Services.AddScoped<TiposDePersonaAccess>();
builder.Services.AddScoped<TiposDeRegimenAccess>();
builder.Services.AddScoped<RetencionesAccess>();


// utils
builder.Services.AddScoped<Utilidades>();
builder.Services.AddScoped<Validaciones>();
builder.Services.AddScoped<MovimientosDeInventarios>();
builder.Services.AddScoped<Correo>();


//-----------------------------------------------------------------------------
// services
//-----------------------------------------------------------------------------
// captura de movimiento
builder.Services.AddScoped<MovimientodeinventariosService>();

// seguridad

builder.Services.AddScoped<LogService>();
builder.Services.AddScoped<MenuService>();
builder.Services.AddScoped<UserService>();
builder.Services.AddScoped<PerfilesService>();

// tablas maestras
builder.Services.AddScoped<ConceptosNotaDebitoCreditoService>();
builder.Services.AddScoped<ActividadesEconomicasService>();
builder.Services.AddScoped<PerfilesService>();
builder.Services.AddScoped<TiposDeDocumentoService>();
builder.Services.AddScoped<ProveedoresService>();
builder.Services.AddScoped<MensajesDelSistemaService>();
builder.Services.AddScoped<FormasDePagoService>();
builder.Services.AddScoped<ProgramasService>();
builder.Services.AddScoped<FormulasService>();
builder.Services.AddScoped<UnidadesDeMedidaService>();
builder.Services.AddScoped<IvasService>();
builder.Services.AddScoped<ProductosService>();
builder.Services.AddScoped<EstadosDeUnRegistroService>();
builder.Services.AddScoped<ColoresService>();
builder.Services.AddScoped<SiNoService>();
builder.Services.AddScoped<SaldosService>();
builder.Services.AddScoped<TallasService>();
builder.Services.AddScoped<TiposDeAgenteService>();
builder.Services.AddScoped<TiposDeCuentaBancariaService>();
builder.Services.AddScoped<TiposDePersonaService>();
builder.Services.AddScoped<TiposDeRegimenService>();
builder.Services.AddScoped<RetencionesService>();




//mapping
builder.Services.AddScoped<Mapping>();
builder.Services.AddSingleton<IHttpContextAccessor, HttpContextAccessor>();

// conexion de datos

builder.Services.AddDbContext<InventariosContext>(options => options.UseSqlServer(builder.Configuration.GetConnectionString("connectionstring")));

builder.Services.AddCors(options =>
{
    options.AddPolicy("ReactJSDomain", policy => policy.AllowAnyOrigin()
    .AllowAnyHeader()
    .AllowAnyMethod()
    .AllowAnyOrigin()
    .WithExposedHeaders("content-disposition")
    );
});

var app = builder.Build();

app.UseSession();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}
app.UseSwagger();
// Enable middleware to serve swagger-ui (HTML, JS, CSS, etc.),
// specifying the Swagger JSON endpoint.
app.UseSwaggerUI(c =>
{
    c.SwaggerEndpoint("/swagger/v1/swagger.json", "My inventarios api v2.0");
});
app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();
app.UseStaticFiles();
app.UseAuthentication();
app.UseSession();

app.UseCors("ReactJSDomain");

app.UseCors(builder => builder
       .AllowAnyHeader()
       .AllowAnyMethod()
       .AllowAnyOrigin()
    );

app.Run();