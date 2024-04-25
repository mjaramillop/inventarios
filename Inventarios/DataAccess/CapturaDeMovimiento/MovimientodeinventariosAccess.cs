using Inventarios.Data;
using Inventarios.DataAccess.Seguridad;
using Inventarios.Map;
using Inventarios.Models.CapturaDeMovimiento;
using Inventarios.Models.TablasMaestras;
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

        public MovimientodeinventariosAccess(InventariosContext context, LogAccess logacces, Mapping mapping, IConfiguration iconfiguration)
        {
            _context = context;

            _logacces = logacces;
            _mapping = mapping;
            _iconfiguration = iconfiguration;
        }

        public List<string> Add(Movimientodeinventarios obj)
        {
            string mensajedeerror = "";
            try
            {
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



        public List<string> AddDocument(int tipodedocumento, int numerodeldocumento)
        {
            string mensajedeerror = "";
            mensajedeerror = ValidarAntesDeCargarAlMovimiento(tipodedocumento, numerodeldocumento);
            if (mensajedeerror.Trim().Length > 0) return new List<string> { mensajedeerror };

            TiposDeDocumento? objtipodedocumento = new TiposDeDocumento();
            objtipodedocumento = _context.TiposDeDocumento.FirstOrDefault(a => a.id == list[0].tipodedocumento);
            int consecutivo = Convert.ToInt32(objtipodedocumento.consecutivo);
            consecutivo = consecutivo + 1;

            list = _context.Movimientodeinventariostmp.Where(a => a.tipodedocumento == tipodedocumento && a.numerodeldocumento == numerodeldocumento).ToList();

            try
            {
                foreach (var item in list)
                {
                    item.numerodeldocumento = consecutivo;
                    _context.Movimientodeinventarios.Add(item);
                    _context.SaveChanges();
                }
            }
            catch (Exception ex)
            {
                mensajedeerror = mensajedeerror + "Error " + ex.Message;
                return new List<string> { mensajedeerror };
            }

            objtipodedocumento.consecutivo = consecutivo;
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

        public List<string> Delete(int id)
        {
            string mensajedeerror = "";
            try
            {
                var obj = _context.Movimientodeinventariostmp.FirstOrDefault(a => a.id == id);
                _context.Movimientodeinventarios.Remove(obj);
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
                _context.SaveChanges();
            }
            catch (Exception ex)
            {
                mensajedeerror = "Error " + ex.Message.ToString();
            }

            if (mensajedeerror.Trim().Length == 0) mensajedeerror = "Registro modificado correctamente";
            return new List<string> { mensajedeerror };
        }

        public List<Movimientodeinventarios> GetByNumeroDeDocumento(int tipodedocumento, int numerodedocumento, int despacha, int recibe)
        {
            list = _context.Movimientodeinventarios.Where(a => a.tipodedocumento == tipodedocumento && a.numerodeldocumento == numerodedocumento && a.despacha == despacha && a.recibe == recibe).ToList();
            return list;
        }

        private string ValidarAntesDeCargarAlMovimiento(int tipodedocumento, int numerodeldocumento)
        {
            string mensajedeerror = "";
            list = _context.Movimientodeinventariostmp.Where(a => a.tipodedocumento == tipodedocumento && a.numerodeldocumento == numerodeldocumento).ToList();

            /////////////////////////////////////////////////////////////////////////
            // encabezado
            ////////////////////////////////////////////////////////////////////////
            // valida tipo de documento
            TiposDeDocumento? objtipodedocumento = new TiposDeDocumento();
            objtipodedocumento = _context.TiposDeDocumento.FirstOrDefault(a => a.id == list[0].tipodedocumento);
            int consecutivo = Convert.ToInt32(objtipodedocumento.consecutivo);
            consecutivo = consecutivo + 1;

            // trae el nombre despacha
            Proveedores? objdespacha = new Proveedores();
            objdespacha = _context.Proveedores.FirstOrDefault(a => a.id == list[0].despacha);

            // trae el nombre recibe
            Proveedores? objrecibe = new Proveedores();
            objdespacha = _context.Proveedores.FirstOrDefault(a => a.id == list[0].recibe);

            // tipodedocumento a afectar
            TiposDeDocumento? objtipodedocumentoaafectar = new TiposDeDocumento();
            objtipodedocumentoaafectar = _context.TiposDeDocumento.FirstOrDefault(a => a.id == list[0].tipodedocumentoaafectar);

            // trae el nombre despacha a  afectar
            Proveedores? objdespachaaafectar = new Proveedores();
            objdespachaaafectar = _context.Proveedores.FirstOrDefault(a => a.id == list[0].despachaaafectar);

            // trae el nombre recibe a afectar
            Proveedores? objrecibeaafectar = new Proveedores();
            objrecibeaafectar = _context.Proveedores.FirstOrDefault(a => a.id == list[0].recibeaafectar);

            // programa
            Programas? objprogramas = new Programas();
            objprogramas = _context.Programas.FirstOrDefault(a => a.id == list[0].programa);

            // vendedor
            Proveedores? objvendedor = new Proveedores();
            objvendedor = _context.Proveedores.FirstOrDefault(a => a.id == list[0].vendedor);

            //////////////////////////////////////
            /// detalle
            //////////////////////////////////////

            foreach (var item in list)
            {
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

                if (item.cantidad < 0) mensajedeerror = mensajedeerror + "La cantidad no puede ser menor a cero, Item No  " + item.id.ToString() + "\n";

                if (item.valorunitario < 0) mensajedeerror = mensajedeerror + "El valor unitario no puede ser menor a cero, Item No  " + item.id.ToString() + "\n";

                if (item.fletes < 0) mensajedeerror = mensajedeerror + "El flete no puede ser menor a cero, Item No  " + item.id.ToString() + "\n";
            }

            return mensajedeerror;
        }

        public void Log(Movimientodeinventarios obj, string operacion)
        {
            string comando = "";
            comando = comando + "operacion " + operacion + "\n";

            comando = comando + "id = " + obj.id + "\n";

            comando = comando + "tipo de documento = " + obj.tipodedocumento + "\n";
            comando = comando + "Nombre de odcumento = " + obj.nombretipoddedocumennto + "\n";
            comando = comando + "numero del documento  = " + obj.numerodeldocumento + "\n";
            comando = comando + "emisor  = " + obj.despacha + "\n";
            comando = comando + "emisor  = " + obj.nombredespacha + "\n";
            comando = comando + "receptor  = " + obj.recibe + "\n";
            comando = comando + "nombrereceptor  = " + obj.nombrerecibe + "\n";

            _logacces.Add(comando);
        }
    }
}