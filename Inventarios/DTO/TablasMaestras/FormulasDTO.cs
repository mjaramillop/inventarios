namespace Inventarios.DTO.TablasMaestras
{
    public class FormulasDTO
    {

        public int id { get; set; }

        public int formula { get; set; }

        public string nombreformula { get; set; }

        public int componente { get; set; }

        public string nombrecomponente { get; set; }

        public int? unidaddemedida { get; set; }

        public string nombreunidaddemedida { get; set; }

        public decimal? cantidad { get; set; }

    }
}
