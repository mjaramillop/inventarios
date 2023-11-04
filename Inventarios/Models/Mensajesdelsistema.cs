using System;
using System.Collections.Generic;

namespace Inventarios.Models;

public partial class Mensajesdelsistema
{
    public int Id { get; set; }

    public DateTime? FechaDesde { get; set; }

    public DateTime? FechaHasta { get; set; }

    public string? Mensaje { get; set; }
}
