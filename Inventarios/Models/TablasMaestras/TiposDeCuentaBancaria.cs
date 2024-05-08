namespace Inventarios.Models.TablasMaestras
{
    public class TiposDeCuentaBancaria
    {
        public TiposDeCuentaBancaria()
        {
            this.id = 0;
            this.nombre = "";
        }

        public int id { get; set; }

        public string nombre { get; set; }
    }
}