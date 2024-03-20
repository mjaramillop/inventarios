namespace Inventarios.DTO
{
    public class FormulasDTO
    {

        public int id { get; set; }

        public int formula { get; set; } 

        public string nombreformula { get; set; } = null!;

        public int componente { get; set; } 

        public string nombrecomponente { get; set; } = null!;

        public decimal? cantidad { get; set; }

    }
}
