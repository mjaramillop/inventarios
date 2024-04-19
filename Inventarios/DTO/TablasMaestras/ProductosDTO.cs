namespace Inventarios.DTO
{
    public class ProductosDTO
    {

        public int id { get; set; }

        public string? nombre { get; set; }


        public int? unidaddemedida { get; set; }

        public string? nombreunidaddemedida { get; set; }

        public decimal? precio1 { get; set; }

        public decimal? costoultimo { get; set; }

        public int? codigoiva1 { get; set; }

    
        public int? estadodelregistro { get; set; }

        public string? secargalinventario { get; set; }

        public string? nivel1 { get; set; }
        public string? nivel2 { get; set; }
        public string? nivel3 { get; set; }
        public string? nivel4 { get; set; }
        public string? nivel5 { get; set; }

    }
}
