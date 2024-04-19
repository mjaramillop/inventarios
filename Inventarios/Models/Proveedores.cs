using Newtonsoft.Json;
using System;
using System.Collections.Generic;

namespace Inventarios.Models;

public partial class Proveedores
{
    public int id { get; set; }

    public string? nombre { get; set; }

    public string? direccion { get; set; }

     public string? telefono { get; set; }

    public string? celular1 { get; set; }

    public string? celular2 { get; set; }

    public string? email1 { get; set; }

    public string? email2 { get; set; }

    public string? nit { get; set; }

    public DateTime? fechadeingreso { get; set; }

    public string? observaciones { get; set; }

    public string? contactos { get; set; }

    public int? actividadcomercial { get; set; }

    public string? seleretienefuente { get; set; }

    public string? seleretieneiva { get; set; }

    public string? seleretieneica { get; set; }

    public string? puedecobrariva { get; set; }

    public string? espersonanaturalojuridica { get; set; }

    public string? declararenta { get; set; }

    public string? esgrancontribuyente { get; set; }

    public int? tipoderegimen { get; set; }

  
    public int? tipodeagente { get; set; }

    public string? cuentacontable { get; set; }

    public int? codigoderetencionaaplicar { get; set; }

    public int? estadodelregistro { get; set; }

    public string? cuentabancaria { get; set; }

    public string? tipodecuenta { get; set; }

    public string? nivel1 { get; set; }
    public string? nivel2 { get; set; }
    public string? nivel3 { get; set; }
    public string? nivel4 { get; set; }
    public string? nivel5 { get; set; }

}
