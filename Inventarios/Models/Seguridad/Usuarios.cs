using NuGet.Protocol;

namespace Inventarios.Models.Seguridad;

public class Usuarios
{
    public Usuarios()
    {
        this.id = 0;
        this.area = "";
        this.nombre = "";
        this.cargo = "";
        this.direccion = "";
        this.telefono = "";
        this.correoelectronico = "";
        this.login = "";
        this.password = "";
        this.perfil = 0;
        this.tiposdedocumento = "";
       
        this.estadodelregistro = 0;
        this.consecutivo = 0;
        this.idusuario = 0;
        this.nombreusuario = "";
        this.tipodedocumentocargueinventariofisico = 0; 
        this.tipodedocumentocargueinventarioinicial = 0;
        this.token = "";

    }

    public int id { get; set; }

    public string area { get; set; }

    public string nombre { get; set; }

    public string cargo { get; set; }

    public string direccion { get; set; }

    public string telefono { get; set; }

    public string correoelectronico { get; set; }

    public string login { get; set; }

    public string password { get; set; }

    public int perfil { get; set; }

    public string tiposdedocumento { get; set; }


    public int estadodelregistro { get; set; }

    public int consecutivo { get; set; }

    public int idusuario { get; set; }

    public string nombreusuario { get; set; }

    public int tipodedocumentocargueinventarioinicial {get;set;}

    public int tipodedocumentocargueinventariofisico { get; set; }

    public string token {  get; set; }  



}