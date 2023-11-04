using Newtonsoft.Json;
using System;
using System.Collections.Generic;

namespace Inventarios.Models;

public partial class Iva
{
    public int Id { get; set; }

    public string? Nombre { get; set; }

    public decimal? Porcentaje { get; set; }

    public string? estadodelregistro { get; set; }


}
