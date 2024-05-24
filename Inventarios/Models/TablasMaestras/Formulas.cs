namespace Inventarios.Models.TablasMaestras
{
    public class Formulas
    {
        public Formulas()
        {
            this.id = 0;
            this.formula = 0;
            this.componente = 0;
            this.cantidad = 0;
            this.idusuario = 0;
            this.nombreusuario = "";


        }

        public int id { get; set; }

        public int formula { get; set; }

        public int componente { get; set; }

        public decimal cantidad { get; set; }

        public int idusuario { get; set; }

        public string nombreusuario { get; set; }

    }
}