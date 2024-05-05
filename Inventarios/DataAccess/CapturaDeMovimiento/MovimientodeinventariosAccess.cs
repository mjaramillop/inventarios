using Inventarios.Data;
using Inventarios.DataAccess.Seguridad;
using Inventarios.Map;
using Inventarios.Models.CapturaDeMovimiento;
using Inventarios.Models.TablasMaestras;
using Inventarios.Token;
using Microsoft.OpenApi.Models;

namespace Inventarios.DataAccess.CapturaDeMovimiento
{
    public class MovimientodeinventariosAccess
    {
        private readonly InventariosContext _context;

        private readonly LogAccess _logacces;

        private readonly Mapping _mapping;

        private List<Movimientodeinventarios>? list;

        private readonly IConfiguration _iconfiguration;

        private readonly JwtService _jwtservice;

        public MovimientodeinventariosAccess(InventariosContext context, LogAccess logacces, Mapping mapping, IConfiguration iconfiguration , JwtService jwtservice)
        {
            _context = context;

            _logacces = logacces;
            _mapping = mapping;
            _iconfiguration = iconfiguration;
            _jwtservice = jwtservice;
        }

        public List<string> Add(Movimientodeinventarios obj)
        {
            string mensajedeerror = "";
            try
            {
                var objusuario = _context.Usuarios.FirstOrDefault(a => a.id == obj.idusuario);

                obj.consecutivousuario = objusuario.id.ToString().Trim() + "-" + objusuario.consecutivo.ToString().Trim();
                obj.idusuario = _jwtservice.Id;
                _context.Movimientodeinventariostmp.Add(obj);
                _context.SaveChanges();
            }
            catch (Exception ex)
            {
                mensajedeerror = "Error " + ex.Message.ToString();
            }

            if (mensajedeerror.Trim().Length == 0) mensajedeerror = "Registro añadido correctamente";

            return new List<string> { mensajedeerror };
        }

        public List<string> Delete(int id)
        {
            string mensajedeerror = "";
            try
            {
                var obj = _context.Movimientodeinventariostmp.FirstOrDefault(a => a.id == id);
                _context.Movimientodeinventariostmp.Remove(obj);
                _context.SaveChanges();
            }
            catch (Exception ex)
            {
                mensajedeerror = "Error " + ex.Message.ToString();
            }

            if (mensajedeerror.Trim().Length == 0) mensajedeerror = "Registro borrado correctamente";

            return new List<string> { mensajedeerror };
        }

        public List<string> Update(Movimientodeinventarios? obj)
        {
            string mensajedeerror = "";
            try
            {
                var obj_ = _context.Movimientodeinventariostmp.FirstOrDefault(a => a.id == obj.id);

                obj_.despacha = obj.despacha;
                obj_.nombredespacha = obj.nombredespacha;
                obj_.recibe = obj.recibe;
                obj_.nombrerecibe = obj.nombrerecibe;
                obj_.tipodedocumento = obj.tipodedocumento;
                obj_.nombretipodedocumento = obj.nombretipodedocumento;
                obj_.numerodeldocumento = obj.numerodeldocumento;
                obj_.despachaaafectar = obj.despachaaafectar;
                obj_.nombredespachaaafectar = obj.nombredespachaaafectar;
                obj_.recibeaafectar = obj.recibeaafectar;
                obj_.nombrerecibeaafectar = obj.nombrerecibeaafectar;
                obj_.tipodedocumentoaafectar = obj.tipodedocumentoaafectar;
                obj_.nombretipodedocumentoaafectar = obj.nombretipodedocumentoaafectar;
                obj_.numerodeldocumentoaafectar = obj.numerodeldocumentoaafectar;
                obj_.fechadeldocumento = obj.fechadeldocumento;
                obj_.fechadevencimientodeldocumento = obj.fechadevencimientodeldocumento;
                obj_.programa = obj.programa;
                obj_.nombreprograma = obj.nombreprograma;
                obj_.vendedor = obj.vendedor;
                obj_.nombrevendedor = obj.nombrevendedor;
                obj_.formadepago = obj.formadepago;
                obj_.nombreformadepago = obj.nombreformadepago;
                obj_.numerodelpago = obj.numerodelpago;
                obj_.banco = obj.banco;
                obj_.nombrebanco = obj.nombrebanco;
                obj_.codigoconceptonotadebitocredito = obj.codigoconceptonotadebitocredito;
                obj_.nombreconceptonotadebitocredito = obj.nombreconceptonotadebitocredito;
                obj_.observaciones = obj.observaciones;
                obj_.formula = obj.formula;
                obj_.nombreformula = obj.nombreformula;
                obj_.producto = obj.producto;
                obj_.talla = obj.talla;
                obj_.color = obj.color;
                obj_.nombreproducto = obj.nombreproducto;
                obj_.nombretalla = obj.nombretalla;
                obj_.nombrecolor = obj.nombrecolor;
                obj_.nombreunidaddemedida = obj.nombreunidaddemedida;
                obj_.numerodeempaques = obj.numerodeempaques;
                obj_.unidaddeempaque = obj.unidaddeempaque;
                obj_.nombreunidaddeempaque = obj.nombreunidaddeempaque;
                obj_.cantidadporempaque = obj.cantidadporempaque;
                obj_.cantidad = obj.cantidad;
                obj_.valorunitario = obj.valorunitario;
                obj_.costoultimoporunidad = obj.costoultimoporunidad;
                obj_.costofleteporunidad = obj.costofleteporunidad;
                obj_.subtotal = obj.subtotal;
                obj_.codigodescuento1 = obj.codigodescuento1;
                obj_.nombrecodigodescuento1 = obj.nombrecodigodescuento1;
                obj_.porcentajedescuento1 = obj.porcentajedescuento1;
                obj_.valordescuento1 = obj.valordescuento1;
                obj_.codigoiva1 = obj.codigoiva1;
                obj_.nombrecodigoiva1 = obj.nombrecodigoiva1;
                obj_.porcentajedeiva1 = obj.porcentajedeiva1;
                obj_.valoriva1 = obj.valoriva1;
                obj_.fletes = obj.fletes;
                obj_.codigoretencion1 = obj.codigoretencion1;
                obj_.nombrecodigoretencion1 = obj.nombrecodigoretencion1;
                obj_.porcentajederetencion1 = obj.porcentajederetencion1;
                obj_.valorretencion1 = obj.valorretencion1;
                obj_.valorneto = obj.valorneto;
            

                _context.SaveChanges();
            }
            catch (Exception ex)
            {
                mensajedeerror = "Error " + ex.Message.ToString();
            }

            if (mensajedeerror.Trim().Length == 0) mensajedeerror = "Registro modificado correctamente";
            return new List<string> { mensajedeerror };
        }
        public List<string> AddDocument(Movimientodeinventarios obj)
        {
            string mensajedeerror = "";
            mensajedeerror = ValidarAntesDeCargarAlMovimiento(obj);
            if (mensajedeerror.Trim().Length > 0) return new List<string> { mensajedeerror };

            var objusuario = _context.Usuarios.FirstOrDefault(a => a.id == _jwtservice.Id);
            string consecutivousuario = objusuario.id.ToString().Trim() + "-" + objusuario.consecutivo.ToString().Trim();

            list = _context.Movimientodeinventariostmp.Where(a => a.tipodedocumento == obj.tipodedocumento && a.consecutivousuario == consecutivousuario).ToList();

            // cargamos documento temporal al movimiento de inventarios definitivo
            try
            {
                foreach (var item in list)
                {
                    
                    _context.Movimientodeinventarios.Add(item);
                    _context.SaveChanges();
                }
            }
            catch (Exception ex)
            {
                mensajedeerror = mensajedeerror + "Error " + ex.Message;
                return new List<string> { mensajedeerror };
            }

            // actualizamos consecutivo en tipos de documento
            TiposDeDocumento? objtipodedocumento = new TiposDeDocumento();
            objtipodedocumento = _context.TiposDeDocumento.FirstOrDefault(a => a.id == list[0].tipodedocumento);
            objtipodedocumento.consecutivo = objtipodedocumento.consecutivo+1;
            _context.SaveChanges();

            // actualizamos consecutivo usuario
            objusuario.consecutivo = objusuario.consecutivo + 1;
            _context.SaveChanges();




            Log(list[0], "Agrego Movimiento de inventario");

            if (mensajedeerror.Trim().Length == 0) mensajedeerror = "Movimiento cargado correctamente";
            return new List<string> { mensajedeerror };
        }

        public List<string> AnularDocumento(int tipodedocumento, int numerodeldocumento, int despacha, int recibe)
        {
            string mensajedeerror = "";

            list = _context.Movimientodeinventariostmp.Where(a => a.tipodedocumento == tipodedocumento && a.numerodeldocumento == numerodeldocumento && a.despacha == despacha && a.recibe == recibe).ToList();

            try
            {
                foreach (var item in list)
                {
                    var obj_ = _context.Movimientodeinventarios.FirstOrDefault(a => a.id == item.id);
                    obj_.estadodelregistro = 2;
                    obj_.cantidad = 0;
                    obj_.valordescuento1 = 0;
                    obj_.codigodescuento1 = 0;
                    obj_.nombrecodigodescuento1 = "";
                    obj_.valoriva1 = 0;
                    obj_.codigoiva1 = 0;
                    obj_.nombrecodigoiva1 = "";
                    obj_.valorretencion1 = 0;
                    obj_.codigoretencion1 = 0;
                    obj_.nombrecodigoretencion1 = "";
                    obj_.valorunitario = 0;
                    obj_.valorneto = 0;
                    obj_.subtotal = 0;
                    obj_.cantidadporempaque = 0;
                    obj_.fletes = 0;
                    _context.SaveChanges();
                }
            }
            catch (Exception ex)
            {
                mensajedeerror = mensajedeerror + "Error " + ex.Message;
                return new List<string> { mensajedeerror };
            }

            Log(list[0], "Anulo Movimiento de inventario");

            if (mensajedeerror.Trim().Length == 0) mensajedeerror = "Documento anulado correctamente";
            return new List<string> { mensajedeerror };
        }

      

        public List<Movimientodeinventarios> GetByNumeroDeDocumento(int tipodedocumento, int numerodedocumento, int despacha, int recibe)
        {
            list = _context.Movimientodeinventarios.Where(a => a.tipodedocumento == tipodedocumento && a.numerodeldocumento == numerodedocumento && a.despacha == despacha && a.recibe == recibe).ToList();
            return list;
        }

        private string ValidarAntesDeCargarAlMovimiento(Movimientodeinventarios obj)
        {
            string mensajedeerror = "";
            list = _context.Movimientodeinventariostmp.Where(a => a.tipodedocumento == obj.tipodedocumento && a.numerodeldocumento == obj.numerodeldocumento).ToList();

            // valida tipo de documento
            TiposDeDocumento? objtipodedocumento = new TiposDeDocumento();
            objtipodedocumento = _context.TiposDeDocumento.FirstOrDefault(a => a.id == list[0].tipodedocumento);
            int consecutivo = Convert.ToInt32(objtipodedocumento.consecutivo);
            consecutivo = consecutivo + 1;

            if (objtipodedocumento == null) mensajedeerror = mensajedeerror + "El tipo de documento esta errado" + "\n";

            // trae el nombre despacha
            Proveedores? objdespacha = new Proveedores();
            objdespacha = _context.Proveedores.FirstOrDefault(a => a.id == list[0].despacha);
            if (objdespacha == null) mensajedeerror = mensajedeerror + "La entidasd emisora esta errada" + "\n";

            Proveedores? objrecibe = new Proveedores();
            objrecibe = _context.Proveedores.FirstOrDefault(a => a.id == list[0].recibe);
            if (objrecibe == null) mensajedeerror = mensajedeerror + "La entidasd receptora esta errada" + "\n";

            // tipodedocumento a afectar
            TiposDeDocumento? objtipodedocumentoaafectar = new TiposDeDocumento();
            objtipodedocumentoaafectar = _context.TiposDeDocumento.FirstOrDefault(a => a.id == list[0].tipodedocumentoaafectar);
            if (objtipodedocumentoaafectar == null) mensajedeerror = mensajedeerror + "El tipo de documento a afectar esta errado" + "\n";

            // trae el nombre despacha a  afectar
            Proveedores? objdespachaaafectar = new Proveedores();
            objdespachaaafectar = _context.Proveedores.FirstOrDefault(a => a.id == list[0].despachaaafectar);
            if (objdespachaaafectar == null) mensajedeerror = mensajedeerror + "El emisor a afectar esta errado" + "\n";

            // trae el nombre recibe a afectar
            Proveedores? objrecibeaafectar = new Proveedores();
            objrecibeaafectar = _context.Proveedores.FirstOrDefault(a => a.id == list[0].recibeaafectar);
            if (objrecibeaafectar == null) mensajedeerror = mensajedeerror + "El receptor a afectar esta errado" + "\n";

            // programa
            Programas? objprogramas = new Programas();
            objprogramas = _context.Programas.FirstOrDefault(a => a.id == list[0].programa);
            if (objprogramas == null) mensajedeerror = mensajedeerror + "El programa esta errado" + "\n";

            // vendedor
            Proveedores? objvendedor = new Proveedores();
            objvendedor = _context.Proveedores.FirstOrDefault(a => a.id == list[0].vendedor);
            if (objvendedor == null) mensajedeerror = mensajedeerror + "El vendedor esta errado" + "\n";

            //////////////////////////////////////
            /// detalle
            //////////////////////////////////////

            foreach (var item in list)
            {
                mensajedeerror = "";

                if (objtipodedocumento == null) mensajedeerror = mensajedeerror + "El tipo de documento esta errado" + "\n";
                if (objdespacha == null) mensajedeerror = mensajedeerror + "La entidad emisora esta errada" + "\n";
                if (objrecibe == null) mensajedeerror = mensajedeerror + "La entidad receptora esta errada" + "\n";
                if (objtipodedocumentoaafectar == null) mensajedeerror = mensajedeerror + "El tipo de documento a afectar esta errado" + "\n";
                if (objdespachaaafectar == null) mensajedeerror = mensajedeerror + "El emisor a afectar esta errado" + "\n";
                if (objrecibeaafectar == null) mensajedeerror = mensajedeerror + "El receptor a afectar esta errado" + "\n";
                if (objprogramas == null) mensajedeerror = mensajedeerror + "El programa esta errado" + "\n";
                if (objvendedor == null) mensajedeerror = mensajedeerror + "El vendedor esta errado" + "\n";

                // formas de pago
                FormasDePago? objformasdepago = new FormasDePago();
                objformasdepago = _context.FormasDePago.FirstOrDefault(a => a.id == item.formadepago);
                if (objformasdepago == null) mensajedeerror = mensajedeerror + "El codigo de forma de pago es invalido , Item No  " + item.id.ToString() + "\n";

                //  Concepto nota debito credito
                ConceptosNotaDebitoCredito? objconceptosnotadebitocredito = new ConceptosNotaDebitoCredito();
                objconceptosnotadebitocredito = _context.ConceptosNotaDebitoCredito.FirstOrDefault(a => a.id == item.codigoconceptonotadebitocredito);
                if (objconceptosnotadebitocredito == null) mensajedeerror = mensajedeerror + "El codigo del concepto nota debito y credito es invalido , Item No  " + item.id.ToString() + "\n";

                //  Banco
                Proveedores? objbanco = new Proveedores();
                objbanco = _context.Proveedores.FirstOrDefault(a => a.id == item.banco);
                if (objbanco == null) mensajedeerror = mensajedeerror + "El codigo del banco es invalido , Item No  " + item.id.ToString() + "\n";

                //  Producto
                Productos? objproducto = new Productos();
                objproducto = _context.Productos.FirstOrDefault(a => a.id == item.producto);
                if (objproducto == null) mensajedeerror = mensajedeerror + "El codigo del producto es invalido , Item No  " + item.id.ToString() + "\n";

                //  Unidad de medida
                UnidadesDeMedida? objunidaddemedida = new UnidadesDeMedida();
                objunidaddemedida = _context.UnidadesDeMedida.FirstOrDefault(a => a.id == objproducto.unidaddemedida);
                if (objunidaddemedida == null) mensajedeerror = mensajedeerror + "El codigo de la unidad de medida es invalido , Item No  " + item.id.ToString() + "\n";

                //  Talla
                Tallas? objtallas = new Tallas();
                objtallas = _context.Tallas.FirstOrDefault(a => a.id == item.talla);
                if (objtallas == null) mensajedeerror = mensajedeerror + "El codigo de la talla es invalido , Item No  " + item.id.ToString() + "\n";

                //  Colores
                Colores? objcolores = new Colores();
                objcolores = _context.Colores.FirstOrDefault(a => a.id == item.color);
                if (objcolores == null) mensajedeerror = mensajedeerror + "El codigo del color es invalido , Item No  " + item.id.ToString() + "\n";

                //  Unidad de empaque
                UnidadesDeMedida? objunidaddeempaque = new UnidadesDeMedida();
                objunidaddeempaque = _context.UnidadesDeMedida.FirstOrDefault(a => a.id == item.unidaddeempaque);
                if (objunidaddeempaque == null) mensajedeerror = mensajedeerror + "El codigo de la unidad de empaque  es invalido , Item No  " + item.id.ToString() + "\n";


                // valores
                if (item.cantidad < 0) mensajedeerror = mensajedeerror + "La cantidad no puede ser menor a cero, Item No  " + item.id.ToString() + "\n";
                if (item.valorunitario < 0) mensajedeerror = mensajedeerror + "El valor unitario no puede ser menor a cero, Item No  " + item.id.ToString() + "\n";
                if (item.fletes < 0) mensajedeerror = mensajedeerror + "El flete no puede ser menor a cero, Item No  " + item.id.ToString() + "\n";
                if (item.valordescuento1 < 0) mensajedeerror = mensajedeerror + "El descuento no puede ser menor a cero, Item No  " + item.id.ToString() + "\n";


                obj.numerodeldocumento = consecutivo;
                obj.nombretipodedocumento = objtipodedocumento.nombre;
                obj.nombredespacha = objdespacha.nombre;
                obj.nombrerecibe = objrecibe.nombre;
                obj.nombretipodedocumentoaafectar = objtipodedocumentoaafectar.nombre;
                obj.nombredespachaaafectar = objdespachaaafectar.nombre;
                obj.nombrerecibeaafectar = objrecibeaafectar.nombre;
                obj.nombreprograma = objprogramas.nombre;
                obj.nombrevendedor = objvendedor.nombre;
                obj.fechadeldocumento = obj.fechadeldocumento.AddDays(obj.plazo);
                obj.nombreformadepago = objformasdepago.nombre;
                obj.nombreconceptonotadebitocredito = objconceptosnotadebitocredito.nombre;
                obj.nombrebanco = objbanco.nombre;
                obj.nombreproducto = objproducto.nombre;
                obj.nombreunidaddemedida = objunidaddemedida.nombre;
                obj.nombretalla = objtallas.nombre;
                obj.nombrecolor = objcolores.nombre;
                obj.nombreunidaddeempaque = objunidaddeempaque.nombre;
                obj.sumaorestaencartera = objtipodedocumento.sumarcartera;
                obj.sumaorestaeninventario = objtipodedocumento.sumainventario;

                if (objtipodedocumento.pideempaque != "S")
                {
                    string codigotipodeempqueunidad = _iconfiguration.GetValue<string>("ParametrosDeLaEmpresa:codigotipodeempaqueunidad");
                    obj.numerodeempaques = 1;
                    obj.unidaddeempaque = Convert.ToInt32(codigotipodeempqueunidad);
                    obj.cantidadporempaque = obj.cantidad;
                }

                obj.cantidad = obj.numerodeempaques * obj.cantidadporempaque;

                obj.subtotal = obj.valorunitario * obj.cantidad;
                obj.valorneto = obj.subtotal - obj.valordescuento1 + obj.valoriva1 + obj.fletes - obj.valorretencion1;

                if (mensajedeerror.Trim().Length == 0) Update(obj);

                if (mensajedeerror.Trim().Length > 0) break;
            }

            return mensajedeerror;
        }

        public void Log(Movimientodeinventarios obj, string operacion)
        {
            string comando = "";
            comando = comando + "operacion " + operacion + "\n";

            comando = comando + "id = " + obj.id + "\n";

            comando = comando + "tipo de documento = " + obj.tipodedocumento + "\n";
            comando = comando + "Nombre de odcumento = " + obj.nombretipodedocumento + "\n";
            comando = comando + "numero del documento  = " + obj.numerodeldocumento + "\n";
            comando = comando + "emisor  = " + obj.despacha + "\n";
            comando = comando + "emisor  = " + obj.nombredespacha + "\n";
            comando = comando + "receptor  = " + obj.recibe + "\n";
            comando = comando + "nombrereceptor  = " + obj.nombrerecibe + "\n";

            _logacces.Add(comando);
        }
    }
}