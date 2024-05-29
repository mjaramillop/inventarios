namespace Inventarios.Models.Seguridad;

public class Mensajesdelsistema
{
    public Mensajesdelsistema()
    {
        this.id = 0;
        this.fechahasta = DateTime.Now;
        this.fechadesde = DateTime.Now;
        this.idusuario = 0;
        this.nombreusuario = "";
    }

    public int id { get; set; }

    public DateTime fechadesde { get; set; }

    public DateTime fechahasta { get; set; }

    public string mensaje { get; set; }

    public int idusuario { get; set; }

    public string nombreusuario { get; set; }
}