using System.ComponentModel.DataAnnotations.Schema;
using System.Reflection.Metadata;
using System.Text.Json.Serialization;

namespace Inventarios.Models.CapturaDeMovimiento;

public class Movimientodeinventarios
{
    public Movimientodeinventarios()
    {
        this.id = 0;
        this.despacha = 0;
        this.nombredespacha = "";
        this.recibe = 0;
        this.nombrerecibe = "";
        this.tipodedocumento = 0;
        this.nombretipodedocumento = "";
        this.numerodeldocumento = 0;
        this.despachaaafectar = 0;
        this.nombredespachaaafectar = "";
        this.recibeaafectar = 0;
        this.nombrerecibeaafectar = "";
        this.tipodedocumentoaafectar = 0;
        this.nombretipodedocumentoaafectar = "";
        this.numerodeldocumentoaafectar = 0;
        this.fechadeldocumento = System.DateTime.Now;
        this.plazo = 0;
        this.fechadevencimientodeldocumento = System.DateTime.Now;
        this.programa = 0;
        this.nombreprograma = "";
        this.vendedor = 0;
        this.nombrevendedor = "";
        this.formadepago = 0;
        this.nombreformadepago = "";
        this.numerodelpago = "";
        this.banco = 0;
        this.nombrebanco = "";
        this.codigoconceptonotadebitocredito = 0;
        this.nombreconceptonotadebitocredito = "";
        this.observaciones = "";
        this.formula = 0;
        this.nombreformula = "";
        this.producto = 0;
        this.talla = 0;
        this.color = 0;
        this.nombreproducto = "";
        this.nombretalla = "";
        this.nombrecolor = "";
        this.nombreunidaddemedida = "";
        this.numerodeempaques = 0;
        this.unidaddeempaque = 0;
        this.nombreunidaddeempaque = "";
        this.cantidadporempaque = 0;
        this.cantidad = 0;
        this.valorunitario = 0;
        this.costoultimoporunidad = 0;
        this.costofleteporunidad = 0;
        this.subtotal = 0;
        this.codigodescuento1 = 0;
        this.nombrecodigodescuento1 = "";
        this.porcentajedescuento1 = 0;
        this.valordescuento1 = 0;
        this.codigoiva1 = 0;
        this.nombrecodigoiva1 = "";
        this.porcentajedeiva1 = 0;
        this.valoriva1 = 0;
        this.fletes = 0;
        this.codigoretencion1 = 0;
        this.nombrecodigoretencion1 = "";
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
        this.consecutivousuario = "";
        this.idusuario = 0;
        this.anodeldocumento = "";
        this.mesdeldocumento = "";
        this.diadeldocumento = "";
    }

    public int id { get; set; }

    public int despacha { get; set; }

    public string nombredespacha { get; set; }

    public int recibe { get; set; }

    public string nombrerecibe { get; set; }

    public int tipodedocumento { get; set; }

    public string nombretipodedocumento { get; set; }

    public int numerodeldocumento { get; set; }

    public int despachaaafectar { get; set; }

    public string nombredespachaaafectar { get; set; }

    public int recibeaafectar { get; set; }

    public string nombrerecibeaafectar { get; set; }

    public int tipodedocumentoaafectar { get; set; }

    public string nombretipodedocumentoaafectar { get; set; }

    public int numerodeldocumentoaafectar { get; set; }

    public DateTime fechadeldocumento { get; set; }

    public int plazo { get; set; }

    [JsonIgnore]
    public DateTime fechadevencimientodeldocumento { get; set; }

    public int programa { get; set; }
    public string nombreprograma { get; set; }

    public int vendedor { get; set; }

    public string nombrevendedor { get; set; }

    public int formadepago { get; set; }

    public string nombreformadepago { get; set; }
    public string numerodelpago { get; set; }

    public int banco { get; set; }

    public string nombrebanco { get; set; }

    public int codigoconceptonotadebitocredito { get; set; }

    public string nombreconceptonotadebitocredito { get; set; }

    public string observaciones { get; set; }

    public int formula { get; set; }

    public string nombreformula { get; set; }
    public int producto { get; set; }

    public int unidaddemedida { get; set; }

    public string nombreunidaddemedida { get; set; }
    public int talla { get; set; }
    public int color { get; set; }

    public string nombreproducto { get; set; }
    public string nombretalla { get; set; }
    public string nombrecolor { get; set; }

    public int numerodeempaques { get; set; }

    public int unidaddeempaque { get; set; }

    public string nombreunidaddeempaque { get; set; }

    public decimal cantidadporempaque { get; set; }

    public decimal cantidad { get; set; }

    public decimal valorunitario { get; set; }

    public decimal costoultimoporunidad { get; set; }

    public decimal costofleteporunidad { get; set; }

    public decimal subtotal { get; set; }

    public int codigodescuento1 { get; set; }

    public string nombrecodigodescuento1 { get; set; }

    public int porcentajedescuento1 { get; set; }

    public int valordescuento1 { get; set; }

    public int codigoiva1 { get; set; }

    public string nombrecodigoiva1 { get; set; }

    public int porcentajedeiva1 { get; set; }

    public int valoriva1 { get; set; }

    public int fletes { get; set; }

    public int codigoretencion1 { get; set; }

    public string nombrecodigoretencion1 { get; set; }

    public int porcentajederetencion1 { get; set; }

    public int valorretencion1 { get; set; }

    public decimal valorneto { get; set; }

    [JsonIgnore]
    public DateTime fechadeprogramaciondelpago { get; set; }

    [JsonIgnore]
    public string lacantidadestadespachada { get; set; }

    [JsonIgnore]
    public string eldocumentoestacancelado { get; set; }

    [JsonIgnore]
    public string sumaorestaeninventario { get; set; }

    [JsonIgnore]
    public string sumaorestaencartera { get; set; }

    [JsonIgnore]
    public int estadodelregistro { get; set; }

    [JsonIgnore]
    public string trasladorecibidoyaprobadopor { get; set; }

    [JsonIgnore]
    public DateTime fechatrasladorecibidoyaprobado { get; set; }

    [JsonIgnore]
    public DateTime fechadecreacion { get; set; }

    [JsonIgnore]
    public string usuarioqueactualizo { get; set; }

    [JsonIgnore]
    public string consecutivousuario { get; set; }

    [JsonIgnore]
    public int idusuario { get; set; }

    [NotMapped]
    public string anodeldocumento { get; set; }

    [NotMapped]
    public string mesdeldocumento { get; set; }

    [NotMapped]
    public string diadeldocumento { get; set; }
}