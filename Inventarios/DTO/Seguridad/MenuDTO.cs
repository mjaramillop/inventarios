namespace Inventarios.DTO.Seguridad
{
    public class MenuDTO
    {
        public MenuDTO()
        {
            this.id = 0;
            this.orden = "";
            this.paginaweb = "";
            this.estadodelregistro = 0;
            this.permisos = "";
            this.idusuario = 0;
            this.username = "";
            this.login = "";
            this.password = "";
        }

        public int id { get; set; }

        public string orden { get; set; }
        public string nombre { get; set; }

        public string paginaweb { get; set; }

        public int estadodelregistro { get; set; }

        public string permisos { get; set; }

        public int idusuario { get; set; }

        public string username { get; set; }

        public string login { get; set; }

        public string password { get; set; }
    }
}