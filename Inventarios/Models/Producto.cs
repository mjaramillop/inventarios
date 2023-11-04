using Newtonsoft.Json;
using System;
using System.Collections.Generic;

namespace Inventarios.Models;

public partial class Producto
{
    public int Id { get; set; }

    public string? Nombre { get; set; }

    public string? Generico { get; set; }

    public string? Unidaddemedida { get; set; }

    public decimal? Precio1 { get; set; }

    public decimal? Costodeproduccion { get; set; }

    public decimal? Costoultimo { get; set; }

    public int? Codigoiva1 { get; set; }

    public int? Codigoiva2 { get; set; }

    public int? Codigoiva3 { get; set; }

    public int? Clasificacion { get; set; }

    public string? Codigodebarras { get; set; }

    public string? estadodelregistro { get; set; }


 
}
