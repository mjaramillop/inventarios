namespace Inventarios.DTO
{
    public class RetencionesDTO
    {
        public int id { get; set; }

        public string? nombre { get; set; }

        public decimal porcentaje { get; set; } 

        public decimal? basedelaretencion { get; set; }

        public int? estadodelregistro { get; set; }
    }
}
