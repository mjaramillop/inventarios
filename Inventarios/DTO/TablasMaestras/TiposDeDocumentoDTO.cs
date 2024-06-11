namespace Inventarios.DTO.TablasMaestras
{
    public class TiposDeDocumentoDTO
    {
        public int id { get; set; }

        public string nombre { get; set; }

        public int estadodelregistro { get; set; }
    }

    public class TiposDeDocumentoPermisosDTO
    {
        public int id { get; set; }

        public string? nombre { get; set; }

        public int? estadodelregistro { get; set; }
        public bool? agregar { get; set; }

        public bool? borrar { get; set; }

        public bool? modificar { get; set; }

        public bool? imprimir { get; set; }

        public bool? anular { get; set; }
    }
}