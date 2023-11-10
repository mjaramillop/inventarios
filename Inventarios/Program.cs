
using Inventarios.Data;
using Inventarios.DataAccess;
using Inventarios.services;
using Inventarios.Token;
using Inventarios.Tables;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection.Extensions;
using System;
using System.ComponentModel.Design;
using Inventarios.Models;
using Inventarios.ModelsParameter;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Scaffold-DbContext "Server=DESKTOP-56QVMV6\SQLEXPRESS;Database=inventarios;Trusted_Connection=True;TrustServerCertificate=true" Microsoft.EntityFrameworkCore.SqlServer -OutputDir Models


builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddDistributedMemoryCache();
builder.Services.AddSession( options => {     options.IdleTimeout= TimeSpan.FromSeconds(3600);

    options.Cookie.HttpOnly = true;
    options.Cookie.IsEssential = true;
});




//data access
builder.Services.AddScoped<LogAccess>(); 
builder.Services.AddScoped<MenuAccess>();
builder.Services.AddScoped<UserAccess>();
builder.Services.AddScoped<ActividadesEconomicasAccess>();
builder.Services.AddScoped<PerfilesAccess>();
builder.Services.AddScoped<TiposDeDocumentoAccess>();
builder.Services.AddScoped<ProveedoresAccess>();
builder.Services.AddScoped<CiudadesAccess>();




// services

builder.Services.AddScoped<MenuService>();
builder.Services.AddScoped<UserService>();
builder.Services.AddScoped<ActividadesEconomicasService>();
builder.Services.AddScoped<PerfilesService>();
builder.Services.AddScoped<TiposDeDocumentoService>();
builder.Services.AddScoped<ProveedoresService>();
builder.Services.AddScoped<CiudadesService>();




builder.Services.AddSingleton<JwtService>();
builder.Services.AddSingleton<StaticTables>();

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
