namespace Inventarios.Models.CapturaDeMovimiento;

public class Movimientodeinventario
{
    public Movimientodeinventario()
    {
        this.id = 0;
        this.despacha = 0;
        this.recibe = 0;
        this.tipodedocumento = 0;
        this.numerodeldocumento = 0;
        this.despachaaafectar = 0;
        this.recibeaafectar = 0;
        this.numerodeldocumentoaafectar = 0;
        this.tipodedocumentoaafectar = 0;
        this.fechadeldocumento = System.DateTime.Now;
        this.fechadevencimientodeldocumento = System.DateTime.Now;
        this.programa = 0;
        this.vendedor = 0;
        this.formadepago = 0;
        this.numerodelpago = "";
        this.banco = 0;
        this.codigoconceptonotadebitocredito = 0;
        this.observaciones = "";
        this.formula = 0;
        this.producto = 0;
        this.detalledelproducto = "";
        this.numerodeempaques = 0;
        this.unidaddeempaque = 0;
        this.cantidadporempaque = 0;
        this.cantidad = 0;
        this.valorunitario = 0;
        this.costodeproduccionporunidad = 0;
        this.costoultimoporunidad = 0;
        this.costopromedioporunidad = 0;
        this.costofleteporunidad = 0;
        this.subtotal = 0;
        this.codigodescuento1 = 0;
        this.porcentajedescuento1 = 0;
        this.valordescuento1 = 0;
        this.codigoiva1 = 0;
        this.porcentajedeiva1 = 0;
        this.valoriva1 = 0;
        this.fletes = 0;
        this.codigoretencion1 = 0;
        this.porcentajederetencion1 = 0;
        this.valorretencion1 = 0;
        this.valorneto = 0;
        this.fechadeprogramaciondelpago = System.DateTime.Now;
        this.lacantidadestadespachada = "";
        this.eldocumentoestacancelado = "";
        this.sumaorestaeninventario = "";
        this.sumaorestaencartera = "";
        this.estadodelregistro = 0;
        this.trasladorecibidoyaprobadopor = "";
        this.fechatrasladorecibidoyaprobado = System.DateTime.Now;
        this.fechadecreacion = System.DateTime.Now;
        this.usuarioqueactualizo = "";
    }

    public decimal id { get; set; }

    public int despacha { get; set; }

    public int recibe { get; set; }

    public int tipodedocumento { get; set; }

    public int numerodeldocumento { get; set; }

    public int despachaaafectar { get; set; }

    public int recibeaafectar { get; set; }

    public int tipodedocumentoaafectar { get; set; }

    public int numerodeldocumentoaafectar { get; set; }

    /// <summary>
    /// la fecha que tiene  impreso el documento
    /// </summary>
    public DateTime fechadeldocumento { get; set; }

    public DateTime fechadevencimientodeldocumento { get; set; }

    public int programa { get; set; }

    public int vendedor { get; set; }

    public int formadepago { get; set; }

    public string numerodelpago { get; set; }

    public int banco { get; set; }

    public int codigoconceptonotadebitocredito { get; set; }

    public string observaciones { get; set; }

    public int formula { get; set; }

    public int producto { get; set; }

    public string detalledelproducto { get; set; }

    public decimal numerodeempaques { get; set; }

    public int unidaddeempaque { get; set; }

    public decimal cantidadporempaque { get; set; }

    public decimal cantidad { get; set; }

    public decimal valorunitario { get; set; }

    public decimal costodeproduccionporunidad { get; set; }

    public decimal costoultimoporunidad { get; set; }

    public decimal costopromedioporunidad { get; set; }

    public decimal costofleteporunidad { get; set; }

    public decimal subtotal { get; set; }

    public int codigodescuento1 { get; set; }

    public decimal porcentajedescuento1 { get; set; }

    public int valordescuento1 { get; set; }

    public int codigoiva1 { get; set; }

    public decimal porcentajedeiva1 { get; set; }

    public int valoriva1 { get; set; }

    public int fletes { get; set; }

    public int codigoretencion1 { get; set; }

    public decimal porcentajederetencion1 { get; set; }

    public int valorretencion1 { get; set; }

    public decimal valorneto { get; set; }

    public DateTime fechadeprogramaciondelpago { get; set; }

    public string lacantidadestadespachada { get; set; }

    public string eldocumentoestacancelado { get; set; }

    public string sumaorestaeninventario { get; set; }

    public string sumaorestaencartera { get; set; }

    public int estadodelregistro { get; set; }

    public string trasladorecibidoyaprobadopor { get; set; }

    public DateTime fechatrasladorecibidoyaprobado { get; set; }

    public DateTime fechadecreacion { get; set; }

    public string usuarioqueactualizo { get; set; }
}