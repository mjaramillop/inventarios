namespace Inventarios.Models.TablasMaestras;

public partial class FormasDePago
{

    public FormasDePago() {

        this.id = 0;
        this.nombre = "";
        this.estadodelregistro = 1;
        this.idusuario = 0;
        this.nombreusuario = "";

    }

    public int id { get; set; }

    public string? nombre { get; set; }

    public int? estadodelregistro { get; set; }

    public int idusuario { get; set; }

    public string nombreusuario { get; set; }

}