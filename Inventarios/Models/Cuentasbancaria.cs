using Newtonsoft.Json;
using System;
using System.Collections.Generic;

namespace Inventarios.Models;

public partial class Cuentasbancaria
{
    public int Id { get; set; }

    public int Banco { get; set; }

    public string Cuenta { get; set; } = null!;

    public string? TipoDeCuenta { get; set; }

    public string? estadodelregistro { get; set; }


   
}
