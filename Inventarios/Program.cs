
using Inventarios.Data;
using Inventarios.DataAccess;
using Inventarios.Token;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection.Extensions;
using System;
using System.ComponentModel.Design;
using Inventarios.Models;
using Inventarios.ModelsParameter;
using System.Reflection;
using Microsoft.OpenApi.Models;
using Inventarios.Map;
using Inventarios.Utils;
using Inventarios.DataAccess.TablasMaestras;
using Inventarios.DataAccess.Seguridad;
using Inventarios.services.TablasMaestras;
using Inventarios.services.Seguridad;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Scaffold-DbContext "Server=DESKTOP-56QVMV6\SQLEXPRESS;Database=inventarios;Trusted_Connection=True;TrustServerCertificate=true" Microsoft.EntityFrameworkCore.SqlServer -OutputDir Models
builder.Services.AddSwaggerGen(c =>
{

  

    c.SwaggerDoc("v1", 
        new OpenApiInfo 
        { Title = "Mi aplicacion de inventarios", 
            Version = "v2.0" ,
            Description="hola",
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
builder.Services.AddSession( options => {     options.IdleTimeout= TimeSpan.FromSeconds(3600);

    options.Cookie.HttpOnly = true;
    options.Cookie.IsEssential = true;
});







//data access
builder.Services.AddScoped<ConceptosNotaDebitoCreditoAccess>();
builder.Services.AddScoped<LogAccess>(); 
builder.Services.AddScoped<MenuAccess>();
builder.Services.AddScoped<UserAccess>();
builder.Services.AddScoped<ActividadesEconomicasAccess>();
builder.Services.AddScoped<PerfilesAccess>();
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











// services
builder.Services.AddScoped<ConceptosNotaDebitoCreditoService>();
builder.Services.AddScoped<LogService>();
builder.Services.AddScoped<MenuService>();
builder.Services.AddScoped<UserService>();
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









//mapping
builder.Services.AddScoped<Mapping>();

//utils
builder.Services.AddSingleton<JwtService>();
builder.Services.AddScoped<Validaciones>();
builder.Services.AddScoped<Utilidades>();



// conexion de datos

builder.Services.AddDbContext<InventariosContext>(options => options.UseSqlServer(builder.Configuration.GetConnectionString("connectionstring")));
//builder.Services.AddHttpContextAccessor();


builder.Services.AddCors(options =>
{
    options.AddPolicy("ReactJSDomain", policy => policy.AllowAnyOrigin()
    .AllowAnyHeader()
    .AllowAnyMethod()
    .AllowAnyOrigin()
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

app.UseCors("ReactJSDomain");

app.UseCors(builder => builder
       .AllowAnyHeader()
       .AllowAnyMethod()
       .AllowAnyOrigin()
    );

app.Run();
