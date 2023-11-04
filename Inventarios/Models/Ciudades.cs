using Newtonsoft.Json;

namespace Inventarios.Models;

public partial class Ciudades
{
    public int? id { get; set; } = null!;

    public string? codigo1 { get; set; }
    public string? nivel1 { get; set; }

    public string? codigo2 { get; set; }
    public string? nivel2 { get; set; }
    public string? codigo3 { get; set; }
    public string? nivel3 { get; set; }
    public string? codigo4 { get; set; }
    public string? nivel4 { get; set; }
    public string? codigo5 { get; set; }
    public string? nivel5 { get; set; }

    public string? estadodelregistro { get; set; }

   
}