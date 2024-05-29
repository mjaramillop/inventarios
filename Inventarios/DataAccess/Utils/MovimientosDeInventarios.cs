using Inventarios.Data;
using Inventarios.Models.CapturaDeMovimiento;
using Inventarios.Models.TablasMaestras;

namespace Inventarios.DataAccess.Utils
{
    public class MovimientosDeInventarios
    {
        private readonly IConfiguration _iconfiguration;

        private readonly InventariosContext _context;
        private readonly Validaciones _validaciones;

        public MovimientosDeInventarios(IConfiguration configutarion, InventariosContext context, Validaciones valiaciones)
        {
            _iconfiguration = configutarion;
            _context = context;
            _validaciones = valiaciones;
        }

        public Movimientodeinventarios CalcularIva(Movimientodeinventarios obj)
        {
            TiposDeDocumento? objtipodedocumento = new TiposDeDocumento();
            objtipodedocumento = _context.TiposDeDocumento.FirstOrDefault(a => a.id == obj.tipodedocumento);

            obj.codigoiva1 = 0;
            obj.porcentajedeiva1 = 0;
            obj.valoriva1 = 0;
            obj.nombrecodigoiva1 = "";
            obj.nombreproducto = "";

            if ((objtipodedocumento.esunaventa == "S") || (objtipodedocumento.esunacompra == "S"))
            {
                Productos? objproducto = new Productos();
                objproducto = _context.Productos.FirstOrDefault(a => a.id == obj.producto);

                if (objproducto == null) obj.nombreproducto = "Codigo errado..";

                if (objproducto != null)
                {
                    Ivas? objivas = new Ivas();
                    objivas = _context.Ivas.FirstOrDefault(a => a.id == objproducto.codigoiva1);

                    obj.codigoiva1 = objivas.id;
                    obj.porcentajedeiva1 = objivas.porcentaje;
                    obj.valoriva1 = Convert.ToInt32((obj.subtotal - obj.valordescuento1 + obj.fletes) * (objivas.porcentaje / 100));
                    obj.nombrecodigoiva1 = objivas.nombre;
                    obj.nombreproducto = objproducto.nombre;
                }
            }

            return obj;
        }

        public void CalcularRetencion(Movimientodeinventarios obj)
        {
            TiposDeDocumento? objtipodedocumento = new TiposDeDocumento();
            objtipodedocumento = _context.TiposDeDocumento.FirstOrDefault(a => a.id == obj.tipodedocumento);

            obj.codigoretencion1 = 0;
            obj.porcentajederetencion1 = 0;
            obj.valorretencion1 = 0;
            obj.nombrecodigoretencion1 = "";

            if (objtipodedocumento.esunpago == "S")
            {
                Proveedores? objproveedores = new Proveedores();
                objproveedores = _context.Proveedores.FirstOrDefault(a => a.id == obj.recibe);

                if (objproveedores != null)
                {
                    Retenciones? objretenciones = new Retenciones();
                    objretenciones = _context.Retenciones.FirstOrDefault(a => a.id == objproveedores.codigoderetencionaaplicar);

                    if (objretenciones != null)
                    {
                        obj.codigoretencion1 = objretenciones.id;
                        obj.porcentajederetencion1 = objretenciones.porcentaje;
                        if ((obj.subtotal - obj.valordescuento1 + obj.fletes) >= objretenciones.basedelaretencion)
                        {
                            obj.valorretencion1 = Convert.ToInt32((obj.subtotal - obj.valordescuento1 + obj.fletes) * (objretenciones.porcentaje / 100));
                        }

                        obj.nombrecodigoretencion1 = objretenciones.nombre;
                    }
                }
            }
        }

        public Movimientodeinventarios ColocarDescripcionALasEntidades(Movimientodeinventarios obj, TiposDeDocumento objtipodedocumento)
        {
            obj.nombretipodedocumento = _validaciones.ValidarTipoDeDocumento(obj.tipodedocumento);
            obj.nombredespacha = _validaciones.ValidarDespacha(obj.despacha);
            obj.nombrerecibe = _validaciones.ValidarRecibe(obj.recibe);
            obj.nombretipodedocumentoaafectar = _validaciones.ValidarTipoDeDocumentoaAfectar(obj.tipodedocumentoaafectar);
            obj.nombredespachaaafectar = _validaciones.ValidarDespachaaAfectar(obj.despachaaafectar);
            obj.nombrerecibeaafectar = _validaciones.ValidarRecibeaAfectar(obj.recibeaafectar);
            obj.nombreprograma = _validaciones.ValidarPrograma(obj.programa);
            obj.nombrevendedor = _validaciones.ValidarVendedor(obj.vendedor);
            obj.nombreformadepago = _validaciones.ValidarFormaDePago(obj.formadepago);
            obj.nombreconceptonotadebitocredito = _validaciones.ValidarConceptoNotaDebitoCredito(obj.codigoconceptonotadebitocredito);
            obj.nombrebanco = _validaciones.ValidarBanco(obj.banco);
            obj.nombreproducto = _validaciones.ValidarProducto(obj.producto);
            obj.nombreunidaddemedida = _validaciones.ValidarUnidadDeMedida(obj.unidaddemedida);
            obj.nombretalla = _validaciones.ValidarTalla(obj.talla);
            obj.nombrecolor = _validaciones.ValidarColor(obj.color);
            obj.nombreunidaddeempaque = _validaciones.ValidarUnidadDeEmpaque(obj.unidaddeempaque);

            if (obj.numerodeempaques < 0) obj.numerodeempaques = 0;
            if (obj.cantidadporempaque < 0) obj.cantidadporempaque = 0;
            if (obj.cantidad < 0) obj.cantidad = 0;
            if (obj.porcentajedescuento1 < 0) obj.porcentajedescuento1 = 0;
            if (obj.valordescuento1 < 0) obj.valordescuento1 = 0;
            if (obj.porcentajedeiva1 < 0) obj.porcentajedeiva1 = 0;
            if (obj.valoriva1 < 0) obj.valoriva1 = 0;
            if (obj.fletes < 0) obj.fletes = 0;
            if (obj.plazo < 0) obj.plazo = 0;

            obj.fechadevencimientodeldocumento = obj.fechadeldocumento.AddDays(obj.plazo);

            if (objtipodedocumento.pidevalorunitario == "S")
            {
                if (objtipodedocumento.pidecantidad != "S")
                {
                    obj.cantidad = 1;
                    string codigotipodeempqueunidad = _iconfiguration.GetValue<string>("ParametrosDeLaEmpresa:codigotipodeempaqueunidad");
                    obj.numerodeempaques = 1;
                    obj.unidaddeempaque = Convert.ToInt32(codigotipodeempqueunidad);
                    obj.cantidadporempaque = obj.cantidad;
                }
            }

            if (objtipodedocumento.pideempaque != "S")
            {
                string codigotipodeempqueunidad = _iconfiguration.GetValue<string>("ParametrosDeLaEmpresa:codigotipodeempaqueunidad");
                obj.numerodeempaques = 1;
                obj.unidaddeempaque = Convert.ToInt32(codigotipodeempqueunidad);
                obj.cantidadporempaque = obj.cantidad;
            }

            obj.cantidad = obj.numerodeempaques * obj.cantidadporempaque;
            obj.subtotal = obj.valorunitario * obj.cantidad;
            obj.valordescuento1 = Convert.ToInt32(obj.subtotal * (obj.porcentajedescuento1 / 100));
            decimal valorbruto = obj.subtotal - obj.valordescuento1;
            obj.sumaorestaencartera = objtipodedocumento.sumarcartera;
            obj.sumaorestaeninventario = objtipodedocumento.sumainventario;

            return obj;
        }
    }
}