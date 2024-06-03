namespace Inventarios.Models.Seguridad;

public class Log
{
    public Log()
    {
        this.id = 0;
        this.descripciondelaoperacion = "";
        this.fechadeactualizacion = DateTime.Now;
        this.idusuario = 0;
        this.nombreusuario = "";
    }

    public int id { get; set; }

    public string descripciondelaoperacion { get; set; }

    public DateTime fechadeactualizacion { get; set; }

    public int idusuario { get; set; }

    public string nombreusuario { get; set; }
}