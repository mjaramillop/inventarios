namespace Inventarios.Models.Seguridad;

public class Perfiles
{
    public Perfiles()
    {
        this.id = 0;
        this.nombre = "";
        this.estadodelregistro = 0;
        this.programas = "";
        this.idusuario = 0;
        this.nombreusuario = "";
        this.tiposdedocumento = "";
    }

    public int id { get; set; }

    public string nombre { get; set; }

    public int estadodelregistro { get; set; }

    public string programas { get; set; }

    public string tiposdedocumento { get; set; }



    public int idusuario { get; set; }

    public string nombreusuario { get; set; }
}