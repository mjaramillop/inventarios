namespace Inventarios.DTO
{
    public class UsersDTO
    {
        public int id { get; set; }

        public string? area { get; set; }

        public string? nombre { get; set; }

        public string? cargo { get; set; }


        public int? estadodelregistro { get; set; }



    }


    public class UserIdDTO
    {
        public int?id { get; set; }
     

    }

    public class UserProgramasDTO
    {
        public string?programa { get; set; }


    }
    public class UserTiposDeDocumentoDTO
    {
        public string?tipodedocumento { get; set; }


    }



}
