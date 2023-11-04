using System;
using System.Collections.Generic;

namespace Inventarios.Models;

public partial class Saldos
{
    public int Id { get; set; }

    public string? Producto { get; set; }

    public int? Bodega { get; set; }

    public decimal? Saldoinicial { get; set; }

    public decimal? Entradas { get; set; }

    public decimal? Salidas { get; set; }

    public decimal? saldo { get; set; }

    public decimal? Saldofisico { get; set; }

    public decimal? Costoultimo { get; set; }

    public decimal? Costopromedio { get; set; }

    public DateTime? Fechadelaultimaentrada { get; set; }

    public DateTime? Fechadelaultimasalida { get; set; }

    public decimal? Stockminimo { get; set; }

    public decimal? Stockmaximo { get; set; }

   
}
