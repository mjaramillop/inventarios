using System;
using System.Collections.Generic;

namespace Inventarios.Models.TablasMaestras;

public class Saldos
{


    public Saldos() {

        this.id = 0;
        this.producto = 0;
      

        this.bodega = 0;
        this.saldoinicial = 0;
        this.entradas = 0;
        this.salidas = 0;
        this.saldo = 0;
        this.saldofisico = 0;
        this.costopromedio = 0;
        this.fechadelaultimaentrada = DateTime.Now;
        this.fechadelaultimasalida =  DateTime.Now;
        this.stockminimo =0;
        this.stockmaximo =0;
   
    
    }


public int id { get; set; }

    public int producto { get; set; }
   

    public int bodega { get; set; }

    public decimal saldoinicial { get; set; }

    public decimal entradas { get; set; }

    public decimal salidas { get; set; }

    public decimal saldo { get; set; }

    public decimal saldofisico { get; set; }

    public decimal costopromedio { get; set; }

    public DateTime fechadelaultimaentrada { get; set; }

    public DateTime fechadelaultimasalida { get; set; }

    public decimal stockminimo { get; set; }

    public decimal stockmaximo { get; set; }


}
