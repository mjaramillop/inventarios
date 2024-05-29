namespace Inventarios.Models.TablasMaestras
{
    public class TiposDePersona
    {
        public TiposDePersona()
        {
            this.id = "";
            this.nombre = "";

            this.idusuario = 0;
            this.nombreusuario = "";
        }

        public string id { get; set; }

        public string nombre { get; set; }
        public int idusuario { get; set; }
        public string nombreusuario { get; set; }
    }
}