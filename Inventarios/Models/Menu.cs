using Newtonsoft.Json;
using System;
using System.Collections.Generic;

namespace Inventarios.Models;

public partial class Menu
{
    public int id { get; set; }

    public string orden { get; set; } = null!;

    public string? nombre { get; set; }

    public string? paginaweb { get; set; }

    public string? estadodelregistro { get; set; }


 
}
