namespace Inventarios.Models
{
    public class Formulas
    {
        public int id { get; set; }

        public string formula { get; set; } = null!;

        public string componente { get; set; } = null!;

        public decimal? Cantidad { get; set; }
    }
}
