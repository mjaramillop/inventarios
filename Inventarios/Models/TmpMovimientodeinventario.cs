using Newtonsoft.Json;
using System;
using System.Collections.Generic;

namespace Inventarios.Models;

public partial class TmpMovimientodeinventario
{
    public decimal Id { get; set; }

    public int Despacha { get; set; }

    public int Recibe { get; set; }

    public int Tipodedocumento { get; set; }

    public int Numerodeldocumento { get; set; }

    public int? Despachaaafectar { get; set; }

    public int? Recibeaafectar { get; set; }

    public int? Tipodedocumentoaafectar { get; set; }

    public int? Numerodeldocumentoaafectar { get; set; }

    public DateTime? Fechadeldocumento { get; set; }

    public DateTime? Fechadevencimientodeldocumento { get; set; }

    public int? Programa { get; set; }

    public int? Vendedor { get; set; }

    public int? Formadepago { get; set; }

    public string? Numerodelpago { get; set; }

    public int? Banco { get; set; }

    public int? Codigoconceptonotadebitocredito { get; set; }

    public string? Observaciones { get; set; }

    public string? Formula { get; set; }

    public string? Producto { get; set; }

    public string? DetalleDelProducto { get; set; }

    public decimal? Numerodeempaques { get; set; }

    public string? Unidaddeempaque { get; set; }

    public decimal? Cantidadporempaque { get; set; }

    public decimal? Cantidad { get; set; }

    public decimal? Valorunitario { get; set; }

    public decimal? Costodeproduccionporunidad { get; set; }

    public decimal? Costoultimoporunidad { get; set; }

    public decimal? Costopromedioporunidad { get; set; }

    public decimal? Costofleteporunidad { get; set; }

    public decimal? Subtotal { get; set; }

    public int? Codigodescuento1 { get; set; }

    public decimal? Porcentajedescuento1 { get; set; }

    public int? Valordescuento1 { get; set; }

    public int? Codigodescuento2 { get; set; }

    public decimal? Porcentajedescuento2 { get; set; }

    public int? Valordescuento2 { get; set; }

    public int? Codigoiva1 { get; set; }

    public decimal? Porcentajedeiva1 { get; set; }

    public int? Valoriva1 { get; set; }

    public int? Codigoiva2 { get; set; }

    public decimal? Porcentajedeiva2 { get; set; }

    public int? Valoriva2 { get; set; }

    public int? Fletes { get; set; }

    public int? Codigoretencion1 { get; set; }

    public decimal? Porcentajederetencion1 { get; set; }

    public int? Valorretencion1 { get; set; }

    public int? Codigoretencion2 { get; set; }

    public decimal? Porcentajederetencion2 { get; set; }

    public int? Valorretencion2 { get; set; }

    public decimal? Valorneto { get; set; }

    public DateTime? Fechadeprogramaciondelpago { get; set; }

    public string? LaCantidadEstaDespachada { get; set; }

    public string? ElDocumentoEstaCancelado { get; set; }

    public string? SumaORestaEnInventario { get; set; }

    public string? SumaORestaEnCartera { get; set; }

    public string? estadodelregistro { get; set; }

       public string? TrasladoRecibidoYAprobadoPor { get; set; }

    public DateTime? FechaTrasladoRecibidoYAprobado { get; set; }



  
    public DateTime? fechadecreacion { get; set; }

  
    public DateTime? fechadeactualizacion { get; set; }

  
    public string? usuarioqueactualizo { get; set; }

}
