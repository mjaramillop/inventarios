namespace Inventarios.Models.TablasMaestras
{
    public class SiNo
    {
        public SiNo()
        {
            this.id = "";
            this.nombre = "";
            this.estadodelregistro = 1;
            this.idusuario = 0;
            this.nombreusuario = "";
        }

        public string id { get; set; }

        public string nombre { get; set; }

        public int estadodelregistro { get; set; }
        public int idusuario { get; set; }
        public string nombreusuario { get; set; }
    }
}