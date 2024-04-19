using System;
using System.Collections.Generic;

namespace Inventarios.Models.Seguridad;

public class Log
{
    public int id { get; set; }

    public string? descripciondelaoperacion { get; set; }

    public DateTime? fechadeactualizacion { get; set; }
}
