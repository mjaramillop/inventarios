using Newtonsoft.Json;
using System;
using System.Collections.Generic;

namespace Inventarios.Models;

public class Movimientodeinventario
{
    public decimal id { get; set; }

    public int despacha { get; set; }

    public int recibe { get; set; }

    public int tipodedocumento { get; set; }

    public int numerodeldocumento { get; set; }

    public int? despachaaafectar { get; set; }

    public int? recibeaafectar { get; set; }

    public int? tipodedocumentoaafectar { get; set; }

    public int? numerodeldocumentoaafectar { get; set; }

    /// <summary>
    /// la fecha que tiene  impreso el documento
    /// </summary>
    public DateTime? fechadeldocumento { get; set; }

    public DateTime? fechadevencimientodeldocumento { get; set; }

    public int? programa { get; set; }

    public int? vendedor { get; set; }

    public int? formadepago { get; set; }

    public string? numerodelpago { get; set; }

    public int? banco { get; set; }

    public int? codigoconceptonotadebitocredito { get; set; }

    public string? observaciones { get; set; }

    public string? formula { get; set; }

    public string? producto { get; set; }

    public string? detalleDelProducto { get; set; }

    public decimal? numerodeempaques { get; set; }

    public string? unidaddeempaque { get; set; }

    public decimal? cantidadporempaque { get; set; }

    public decimal? cantidad { get; set; }

    public decimal? valorunitario { get; set; }

    public decimal? costodeproduccionporunidad { get; set; }

    public decimal? costoultimoporunidad { get; set; }

    public decimal? costopromedioporunidad { get; set; }

    public decimal? costofleteporunidad { get; set; }

    public decimal? subtotal { get; set; }

    public int? codigodescuento1 { get; set; }

    public decimal? porcentajedescuento1 { get; set; }

    public int? valordescuento1 { get; set; }

  
    public int? codigoiva1 { get; set; }

    public decimal? porcentajedeiva1 { get; set; }

    public int? valoriva1 { get; set; }

 

    public int? fletes { get; set; }

    public int? codigoretencion1 { get; set; }

    public decimal? porcentajederetencion1 { get; set; }

    public int? valorretencion1 { get; set; }

 
    public decimal? valorneto { get; set; }

    public DateTime? fechadeprogramaciondelpago { get; set; }

    public string? lacantidadestadespachada { get; set; }

    public string? eldocumentoestacancelado { get; set; }

    public string? sumaorestaeninventario { get; set; }

    public string? sumaorestaencartera { get; set; }

    public int? estadodelregistro { get; set; }

   
    public string? trasladorecibidoyaprobadopor { get; set; }

    public DateTime? fechatrasladorecibidoyaprobado { get; set; }


   
    public DateTime? fechadecreacion { get; set; }
  

  
    public string? usuarioqueactualizo { get; set; }
}
