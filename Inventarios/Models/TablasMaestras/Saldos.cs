using System;
using System.Collections.Generic;

namespace Inventarios.Models.TablasMaestras;

public class Saldos
{
    public int id { get; set; }

    public int? producto { get; set; }

    public int? bodega { get; set; }

    public decimal? saldoinicial { get; set; }

    public decimal? entradas { get; set; }

    public decimal? salidas { get; set; }

    public decimal? saldo { get; set; }

    public decimal? saldofisico { get; set; }

    public decimal? costopromedio { get; set; }

    public DateTime? fechadelaultimaentrada { get; set; }

    public DateTime? fechadelaultimasalida { get; set; }

    public decimal? stockminimo { get; set; }

    public decimal? stockmaximo { get; set; }


}
