﻿namespace Inventarios.Models
{

    public partial class Productos
    {
        public int id { get; set; }

        public string? nombre { get; set; }

    
        public int? unidaddemedida { get; set; }

        public decimal? precio1 { get; set; }

        public decimal? costoultimo { get; set; }

        public int? codigoiva1 { get; set; }

        public int? Clasificacion { get; set; }

        public string? estadodelregistro { get; set; }

        public string? secargalinventario { get; set; }



    }

}
