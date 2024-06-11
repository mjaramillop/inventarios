namespace Inventarios.DTO.TablasMaestras
{
    public class SaldosDTO
    {



        public string nivel1 { get; set; }
        public string nivel2 { get; set; }
        public string nivel3 { get; set; }
        public string nivel4 { get; set; }
        public string nivel5 { get; set; }

        public int id { get; set; }

        public int producto { get; set; }

        public string nombreproducto { get; set; }

        public int bodega { get; set; }

        public string nombrebodega { get; set; }

        public decimal saldoinicial { get; set; }

        public decimal entradas { get; set; }

        public decimal salidas { get; set; }

        public decimal saldo { get; set; }

        public decimal saldofisico { get; set; }

        public decimal diferencia_saldofisico_saldoteorico { get; set; }


        public decimal costopromedio { get; set; }

        public decimal valordiferencia { get; set; }

        public decimal valorinventario { get; set; }

        public DateTime fechadelaultimasalida { get; set; }

        public decimal stockminimo { get; set; }

        public decimal stockmaximo { get; set; }

        public decimal diassinrotar { get; set; }
    }
}