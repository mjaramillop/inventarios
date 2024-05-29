namespace Inventarios.Models.TablasMaestras
{
    public class TiposDeCuentaBancaria
    {
        public TiposDeCuentaBancaria()
        {
            this.id = 0;
            this.nombre = "";

            this.idusuario = 0;
            this.nombreusuario = "";
        }

        public int id { get; set; }

        public string nombre { get; set; }

        public int idusuario { get; set; }
        public string nombreusuario { get; set; }
    }
}