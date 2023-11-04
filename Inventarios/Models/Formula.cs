using Newtonsoft.Json;
using System;
using System.Collections.Generic;

namespace Inventarios.Models;

public partial class Formula
{
    public int Id { get; set; }

    public string Formula1 { get; set; } = null!;

    public string Componente { get; set; } = null!;

    public decimal? Cantidad { get; set; }

  
 
}
