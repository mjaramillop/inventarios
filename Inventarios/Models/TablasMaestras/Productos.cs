namespace Inventarios.Models.TablasMaestras
{
    public class Productos
    {
        public Productos()
        {
            this.id = 0;
            this.nombre = "";
            this.unidaddemedida = 0;
            this.precio1 = 0;
            this.costoultimo = 0;
            this.codigoiva1 = 0;
            this.estadodelregistro = 1;
            this.secargalinventario = "";
            this.nivel1 = "";
            this.nivel2 = "";
            this.nivel3 = "";
            this.nivel4 = "";
            this.nivel5 = "";
            this.idusuario = 0;
            this.nombreusuario = "";


        }

        public int id { get; set; }

        public string nombre { get; set; }

        public int unidaddemedida { get; set; }

        public decimal precio1 { get; set; }

        public decimal costoultimo { get; set; }

        public int codigoiva1 { get; set; }

        public int estadodelregistro { get; set; }

        public string secargalinventario { get; set; }

        public string nivel1 { get; set; }
        public string nivel2 { get; set; }
        public string nivel3 { get; set; }
        public string nivel4 { get; set; }
        public string nivel5 { get; set; }

        public int idusuario { get; set; }

        public string nombreusuario { get; set; }

    }
}