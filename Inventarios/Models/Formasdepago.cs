using Newtonsoft.Json;
using System;
using System.Collections.Generic;

namespace Inventarios.Models;

public partial class FormasDePago
{
    public int id { get; set; }

    public string? nombre { get; set; }

    public int? estadodelregistro { get; set; }


  
}
