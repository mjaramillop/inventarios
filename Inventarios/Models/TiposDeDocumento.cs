using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace Inventarios.Models;

public partial class TiposDeDocumento
{
    public int id { get; set; }

    public string? nombre { get; set; }

    public string? abreviatura { get; set; }

    public decimal? consecutivo { get; set; }

    public string? cuentacontabledebito { get; set; }

    public string? cuentacontablecredito { get; set; }

    public string? despacha { get; set; }

    public string? recibe { get; set; }

   

    public string? pidefechadevencimiento { get; set; }

    public string? pideprograma { get; set; }

    public string? pideconceptonotadebitocredito { get; set; }

    public string? pidevendedor { get; set; }

    public string? pidetipodedocumentoaafectar { get; set; }

    public string? pideproducto { get; set; }

    public string? pidetalla { get; set; }

    public string? pidecolor { get; set; }

    public string? pideempaque { get; set; }

    public string? pidecantidad { get; set; }

    public string? pidevalorunitario { get; set; }

    public string? pidesubtotal { get; set; }

    public string? pidedescuentodetalle { get; set; }

    public string? pideivadetalle { get; set; }

    public string? pidetipodedocumentoaafectardetalle { get; set; }

    public string? pideconsecutivoautomatico { get; set; }

    public string? eldocumentoseimprime { get; set; }

    public string? esunacompra { get; set; }

    public string? esunaventa { get; set; }

    public string? esunpago { get; set; }

    public string? restarcartera { get; set; }

    public string? sumarcartera { get; set; }

    public string? restainventario { get; set; }

    public string? sumainventario { get; set; }

    public string? saldarcantidadesdeldocumentollamado { get; set; }

    public string? leyendaimpresaeneldocumento { get; set; }

    public string? pidefisico { get; set; }

    public string? tipoagentedespacha { get; set; }

    public string? tipoagenterecibe { get; set; }

    public string? eldocumentoallamarsolosepuedellamarunavez { get; set; }

    public string? eldocumentoseimprimeanombrededespachaorecibe { get; set; }

    public string? esunanota { get; set; }

    public string? esuninventarioinicial { get; set; }

    public int? estadodelregistro { get; set; }

  
    public string? titulodespacha { get; set; }

    public string? titulorecibe { get; set; }

    public string? transaccionesquepuedellamar { get; set; }


    [NotMapped]
    public string nombredespacha { get; set; }
    [NotMapped]
    public string nombrerecibe { get; set; }





}
