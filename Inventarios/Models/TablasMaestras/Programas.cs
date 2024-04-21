namespace Inventarios.Models.TablasMaestras
{
    public class Programas
    {
        public Programas() {

            this.id = 0;
            this.nombre = "";
            this.estadodelregistro = 0;
        }  
        public int id { get; set; }

        public string? nombre { get; set; }

        public int? estadodelregistro { get; set; }
    }
}
