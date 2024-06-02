namespace Inventarios.ModelsParameter.TablasMaestras
{
    public class CambiarPrecios
    {
        public CambiarPrecios()
        {
            this.nivel1 = "";
            this.nivel2 = "";
            this.nivel3 = "";
            this.nivel4 = "";
            this.porcentajedeincremento = 0;
        }

        public string nivel1 { get; set; }

        public string nivel2 { get; set; }

        public string nivel3 { get; set; }

        public string nivel4 { get; set; }
        public string nivel5 { get; set; }

        public decimal porcentajedeincremento { get; set; }
    }
}