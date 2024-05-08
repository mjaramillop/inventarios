namespace Inventarios.Models.TablasMaestras
{
    public class UnidadesDeMedida
    {
        public UnidadesDeMedida()
        {
            this.id = 0;
            this.nombre = "";
        }

        public int id { get; set; }

        public string nombre { get; set; }

        public int estadodelregistro { get; set; }
    }
}