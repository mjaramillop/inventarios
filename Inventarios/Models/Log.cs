using System;
using System.Collections.Generic;

namespace Inventarios.Models;

public partial class Log
{
    public int Id { get; set; }

    public string? DescripcionDeLaOperacion { get; set; }

    public DateTime? fechadeactualizacion { get; set; }
}
