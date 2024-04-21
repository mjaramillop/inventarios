namespace Inventarios.Models.TablasMaestras
{
    public class Retenciones
    {

        public Retenciones() {

            this.id = 0;
            this.nombre = "";
            this.estadodelregistro = 0;
            this.basedelaretencion = 0;
        }
        public int id { get; set; }

        public string nombre { get; set; }

        public decimal basedelaretencion { get; set; }

        public int estadodelregistro { get; set; }
    }
}
