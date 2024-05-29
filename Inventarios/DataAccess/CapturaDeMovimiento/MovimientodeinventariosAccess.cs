using Inventarios.Data;
using Inventarios.DataAccess.Seguridad;
using Inventarios.DataAccess.Utils;
using Inventarios.Map;
using Inventarios.Models.CapturaDeMovimiento;
using Inventarios.Models.TablasMaestras;

namespace Inventarios.DataAccess.CapturaDeMovimiento
{
    public class MovimientodeinventariosAccess
    {
        private readonly InventariosContext _context;

        private readonly LogAccess _logacces;

        private readonly Mapping _mapping;

        private List<Movimientodeinventarios>? list;

        private readonly IConfiguration _iconfiguration;

        private readonly Validaciones _validaciones;

        private Utilidades _utlididades;

        private MovimientosDeInventarios _movimiento;

        public MovimientodeinventariosAccess(InventariosContext context, LogAccess logacces, Mapping mapping, IConfiguration iconfiguration, Validaciones validaciones, Utilidades utilidades, MovimientosDeInventarios movimiento)
        {
            _context = context;
            _logacces = logacces;
            _mapping = mapping;
            _iconfiguration = iconfiguration;
            _validaciones = validaciones;
            _utlididades = utilidades;
            _movimiento = movimiento;
        }

        public List<string> Add(Movimientodeinventarios obj)
        {
            int id = obj.idusuario;

            string mensajedeerror = "";
            var objusuario = _context.Usuarios.FirstOrDefault(a => a.id == id);
            obj.consecutivousuario = objusuario.id.ToString().Trim() + "-" + objusuario.consecutivo.ToString().Trim();
            obj.idusuario = id;
            obj.fechadeldocumento = _utlididades.DevolverFechaParaGrabarAlServidorDeLaBaseDeDatos(obj.diadeldocumento, obj.mesdeldocumento, obj.anodeldocumento);
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

            ProcesarLosCamposNumericosDeCadaFila(obj.tipodedocumento, obj.consecutivousuario);

            var report = new Movimientodeinventarios();

            /*
                        var s = list.Select(s =>
                        new { producto=s.producto,
                            talla=s.talla,color=s.color,
                            id = s.id, total_pedido = list.Sum(d => d.cantidad) }).GroupBy(a =>a.producto , a =>a.talla ).ToList();
            */

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
            obj.id = obj.numerodeldocumento;
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

                int idusuario = obj.idusuario;

                var objusuario = _context.Usuarios.FirstOrDefault(a => a.id == idusuario);
                obj_.consecutivousuario = objusuario.id.ToString().Trim() + "-" + objusuario.consecutivo.ToString().Trim();
                _context.SaveChanges();
            }
            catch (Exception ex)
            {
                mensajedeerror = "Error " + ex.Message.ToString();
            }

            int id = obj.idusuario;
            var objusuario_ = _context.Usuarios.FirstOrDefault(a => a.id == id);
            string consecutivousuario = id.ToString() + "-" + objusuario_.consecutivo.ToString().Trim();

            ProcesarLosCamposNumericosDeCadaFila(obj.tipodedocumento, consecutivousuario);

            if (mensajedeerror.Trim().Length == 0) mensajedeerror = "Registro modificado correctamente";

            return new List<string> { mensajedeerror };
        }

        public List<Movimientodeinventarios> GetById(int id)
        {
            list = _context.Movimientodeinventariostmp.Where(a => a.id == id).ToList();
            return list;
        }

        public List<Movimientodeinventarios>? List(int tipodedocumento, int idusuario)
        {
            var objusuario = _context.Usuarios.FirstOrDefault(a => a.id == idusuario);
            string consecutivousuario = objusuario.id.ToString().Trim() + "-" + objusuario.consecutivo.ToString().Trim();
            list = _context.Movimientodeinventariostmp.Where(a => a.tipodedocumento == tipodedocumento && a.consecutivousuario == consecutivousuario).OrderBy(a => a.id).ToList();
            return list;
        }

        public List<string> AnularDocumento(int tipodedocumento, int numerodedocumento, int despacha, int recibe)
        {
            string mensajedeerror = "";

            list = _context.Movimientodeinventariostmp.Where(a => a.tipodedocumento == tipodedocumento && a.numerodeldocumento == numerodedocumento && a.despacha == despacha && a.recibe == recibe).ToList();

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

        public List<string> DeleteDocument(int tipodedocumento, int idusuario)
        {
            var objusuario = _context.Usuarios.FirstOrDefault(a => a.id == idusuario);
            string consecutivousuario = objusuario.id.ToString().Trim() + "-" + objusuario.consecutivo.ToString().Trim();

            list = _context.Movimientodeinventariostmp.Where(a => a.tipodedocumento == tipodedocumento && a.consecutivousuario == consecutivousuario).ToList();

            string mensajedeerror = "";
            try
            {
                // borramos los registros en el movimiento temporal
                foreach (var item in list)
                {
                    var obj = _context.Movimientodeinventariostmp.FirstOrDefault(a => a.id == item.id);
                    _context.Movimientodeinventariostmp.Remove(obj);
                    _context.SaveChanges();
                }
            }
            catch (Exception ex)
            {
                mensajedeerror = mensajedeerror + "Error " + ex.Message;
                return new List<string> { mensajedeerror };
            }

            if (list.Count == 0) mensajedeerror = "No se encontraron registros temporales para borrar";

            if (mensajedeerror.Trim().Length == 0) mensajedeerror = "Documento temporal borrado exitosamente";
            return new List<string> { mensajedeerror };
        }

        public List<string> AddDocument(int tipodedocumento, int idusuario)
        {
            var objusuario = _context.Usuarios.FirstOrDefault(a => a.id == idusuario);
            string consecutivousuario = objusuario.id.ToString().Trim() + "-" + objusuario.consecutivo.ToString().Trim();

            string mensajedeerror = ValidarAntesDeCargarAlMovimiento(tipodedocumento, consecutivousuario);
            if (mensajedeerror.IndexOf("Error") >= 0) return new List<string> { mensajedeerror };

            // actuaizao el consecutivo
            TiposDeDocumento? objtipodedocumento = new TiposDeDocumento();
            objtipodedocumento = _context.TiposDeDocumento.FirstOrDefault(a => a.id == tipodedocumento);
            int consecutivo = Convert.ToInt32(objtipodedocumento.consecutivo);
            consecutivo = consecutivo + 1;

            list = _context.Movimientodeinventariostmp.Where(a => a.tipodedocumento == tipodedocumento && a.consecutivousuario == consecutivousuario).ToList();
            list.ForEach(c => { c.numerodeldocumento = consecutivo; });
            _context.SaveChanges();

            // cargamos documento temporal al movimiento de inventarios definitivo
            try
            {
                foreach (var item in list)
                {
                    _context.Movimientodeinventarios.Add(item);
                    _context.SaveChanges();
                }

                // borramos los registros en el movimieno temporal

                foreach (var item in list)
                {
                    var obj = _context.Movimientodeinventariostmp.FirstOrDefault(a => a.id == item.id);
                    _context.Movimientodeinventariostmp.Remove(obj);
                    _context.SaveChanges();
                }
            }
            catch (Exception ex)
            {
                mensajedeerror = mensajedeerror + "Error " + ex.Message;
                return new List<string> { mensajedeerror };
            }

            // actualizamos consecutivo en tipos de documento
            objtipodedocumento.consecutivo = objtipodedocumento.consecutivo + 1;
            _context.SaveChanges();

            // actualizamos consecutivo usuario
            objusuario.consecutivo = objusuario.consecutivo + 1;
            _context.SaveChanges();

            Log(list[0], "Agrego Movimiento de inventario");

            if (mensajedeerror.Trim().Length == 0) mensajedeerror = "Movimiento cargado correctamente";
            return new List<string> { mensajedeerror };
        }

        private void ProcesarLosCamposNumericosDeCadaFila(int tipodedocumento, string consecutivousuario)
        {
            TiposDeDocumento? objtipodedocumento = new TiposDeDocumento();
            objtipodedocumento = _context.TiposDeDocumento.FirstOrDefault(a => a.id == tipodedocumento);

            list = _context.Movimientodeinventariostmp.Where(a => a.tipodedocumento == tipodedocumento && a.consecutivousuario == consecutivousuario).OrderBy(a => a.id).ToList();
            int despacha = list[list.Count - 1].despacha;
            int recibe = list[list.Count - 1].recibe;
            DateTime fechadeldocumento = list[list.Count - 1].fechadeldocumento;
            int plazo = list[list.Count - 1].plazo;
            DateTime fechadevencimientodeldocumento = list[list.Count - 1].fechadevencimientodeldocumento;
            int programa = list[list.Count - 1].programa;
            int vendedor = list[list.Count - 1].vendedor;

            int contador = 0;

            foreach (var item in list)
            {
                // consulta cada item de cada documento para actulizarlo en la base de datos
                Movimientodeinventarios obj_ = _context.Movimientodeinventariostmp.FirstOrDefault(a => a.id == item.id);

                // aqui lo que estmoas haciendo es que el diugitador puede grabar 4 registros y el sistema se cae
                // pero puede contineuar mas tarde y que psa si de pronto le de una fecha de odcumento o vendedor o programa
                // o emisor o receptor diferente?puede quedar un mismo documento feabado con registros con fecha de odcumento diferenten o
                // emisro o receptor o vendedor diferente, pára evitar eso le asignamos a todos los regisros el encabezado del ultimo registro que
                // grabe
                // siempre que agregue uno nuevo por seguridad hacemos este procsos

                obj_.despacha = despacha;
                obj_.recibe = recibe;
                obj_.fechadeldocumento = fechadeldocumento;
                obj_.plazo = plazo;
                obj_.fechadevencimientodeldocumento = fechadevencimientodeldocumento;
                obj_.vendedor = vendedor;
                obj_.programa = programa;

                contador = contador + 1;
                _movimiento.ColocarDescripcionALasEntidades(obj_, objtipodedocumento);

                // calcula iva
                _movimiento.CalcularIva(obj_);

                // aplicamos retencion solo a un registro osea en un registro guardamos el valor de la retencion
                // no en todos
                if (contador == 1) _movimiento.CalcularRetencion(obj_);

                obj_.valorneto = obj_.subtotal - obj_.valordescuento1 + obj_.valoriva1 + obj_.fletes - obj_.valorretencion1;

                _context.SaveChanges();
            }
        }

        private string ValidarAntesDeCargarAlMovimiento(int tipodedocumento, string consecutivousuario)
        {
            //////////////////////////////////////
            /// valida detalle
            //////////////////////////////////////
            list = _context.Movimientodeinventariostmp.Where(a => a.tipodedocumento == tipodedocumento && a.consecutivousuario == consecutivousuario).ToList();
            string mensajedeerror = "";
            foreach (var item in list)
            {
                mensajedeerror = "";
                mensajedeerror = mensajedeerror + item.nombretipodedocumento;
                mensajedeerror = mensajedeerror + item.nombredespacha;
                mensajedeerror = mensajedeerror + item.nombrerecibe;
                mensajedeerror = mensajedeerror + item.nombretipodedocumentoaafectar;
                mensajedeerror = mensajedeerror + item.nombredespachaaafectar;
                mensajedeerror = mensajedeerror + item.nombrerecibeaafectar;
                mensajedeerror = mensajedeerror + item.nombreprograma;
                mensajedeerror = mensajedeerror + item.nombrevendedor;
                mensajedeerror = mensajedeerror + item.nombreformadepago;
                mensajedeerror = mensajedeerror + item.nombreconceptonotadebitocredito;
                mensajedeerror = mensajedeerror + item.nombrebanco;
                mensajedeerror = mensajedeerror + item.nombreproducto;
                mensajedeerror = mensajedeerror + item.nombreunidaddemedida;
                mensajedeerror = mensajedeerror + item.nombretalla;
                mensajedeerror = mensajedeerror + item.nombrecolor;
                mensajedeerror = mensajedeerror + item.nombreunidaddeempaque;

                if (mensajedeerror.IndexOf("Error") >= 0)
                {
                    break;
                }
            }

            return mensajedeerror;
        }

        public List<Movimientodeinventarios> TraerDocumentoTemporal(int tipodedocumento, int idusuario)
        {
            var objusuario = _context.Usuarios.FirstOrDefault(a => a.id == idusuario);
            string consecutivousuario = objusuario.id.ToString().Trim() + "-" + objusuario.consecutivo.ToString().Trim();
            list = _context.Movimientodeinventarios.Where(a => a.tipodedocumento == tipodedocumento && a.consecutivousuario == consecutivousuario).ToList();

            return list;
        }

        public void AplicarDescuentoPieDeFactura(int tipodedocumento, decimal porcentajededescuento, int idusuario)
        {
            TiposDeDocumento? objtipodedocumento = new TiposDeDocumento();
            objtipodedocumento = _context.TiposDeDocumento.FirstOrDefault(a => a.id == tipodedocumento);

            if ((objtipodedocumento.esunaventa == "S") || (objtipodedocumento.esunacompra == "S"))
            {
                var objusuario = _context.Usuarios.FirstOrDefault(a => a.id == idusuario);
                string consecutivousuario = objusuario.id.ToString().Trim() + "-" + objusuario.consecutivo.ToString().Trim();
                List<Movimientodeinventarios> list = _context.Movimientodeinventariostmp.Where(a => a.tipodedocumento == tipodedocumento && a.consecutivousuario == consecutivousuario).OrderBy(a => a.id).ToList();

                int cantidaddeelementosdelafactura = list.Count();

                decimal subtotal = list.Sum(a => a.subtotal);
                decimal valordescuentodelafactura = Convert.ToInt32(subtotal * (porcentajededescuento / 100));
                decimal valordescuentodecadaitem = valordescuentodelafactura / cantidaddeelementosdelafactura;
                decimal valordeajuste = valordescuentodelafactura - (valordescuentodecadaitem * cantidaddeelementosdelafactura);

                int contador = 0;
                foreach (var item in list)
                {
                    contador = contador + 1;
                    // consulta cada item de cada documento para actulizarlo en la base de datos
                    Movimientodeinventarios obj_ = _context.Movimientodeinventariostmp.FirstOrDefault(a => a.id == item.id);

                    obj_.porcentajedescuento1 = 0;
                    obj_.valordescuento1 = 0;

                    if (contador == 1) obj_.valordescuento1 = Convert.ToInt32(obj_.valordescuento1 + (valordescuentodecadaitem + valordeajuste));
                    if (contador > 1) obj_.valordescuento1 = Convert.ToInt32(obj_.valordescuento1 + (valordescuentodecadaitem));

                    obj_.porcentajedescuento1 = obj_.porcentajedescuento1 + (porcentajededescuento);

                    //calcula iva
                    _movimiento.CalcularIva(obj_);

                    // aplicamos retencion solo a un registro osea en un registro guardamos el valor de la retencion
                    // no en todos

                    if (contador == 1)
                    {
                        // calcula retencion
                        _movimiento.CalcularRetencion(obj_);
                    }

                    obj_.valorneto = obj_.subtotal - obj_.valordescuento1 + obj_.valoriva1 + obj_.fletes - obj_.valorretencion1;

                    _context.SaveChanges();
                }
            }
        }

        public void AplicarFletePieDeFactura(int tipodedocumento, int valorfletes, int idusuario)
        {
            TiposDeDocumento? objtipodedocumento = new TiposDeDocumento();
            objtipodedocumento = _context.TiposDeDocumento.FirstOrDefault(a => a.id == tipodedocumento);

            if ((objtipodedocumento.esunaventa == "S") || (objtipodedocumento.esunacompra == "S"))
            {
                var objusuario = _context.Usuarios.FirstOrDefault(a => a.id == idusuario);
                string consecutivousuario = objusuario.id.ToString().Trim() + "-" + objusuario.consecutivo.ToString().Trim();
                List<Movimientodeinventarios> list = _context.Movimientodeinventariostmp.Where(a => a.tipodedocumento == tipodedocumento && a.consecutivousuario == consecutivousuario).OrderBy(a => a.id).ToList();

                int cantidaddeelementosdelafactura = list.Count();

                int valorfletedecadaitem = valorfletes / cantidaddeelementosdelafactura;
                int valordeajuste = valorfletes - (valorfletedecadaitem * cantidaddeelementosdelafactura);

                int contador = 0;
                foreach (var item in list)
                {
                    contador = contador + 1;
                    // consulta cada item de cada documento para actulizarlo en la base de datos
                    Movimientodeinventarios obj_ = _context.Movimientodeinventariostmp.FirstOrDefault(a => a.id == item.id);

                    obj_.fletes = 0;

                    if (contador == 1) obj_.fletes = (valorfletedecadaitem + valordeajuste);
                    if (contador > 1) obj_.fletes = (valorfletedecadaitem);

                    //calcula iva
                    _movimiento.CalcularIva(obj_);

                    // aplicamos retencion solo a un registro osea en un registro guardamos el valor de la retencion
                    // no en todos

                    if (contador == 1)
                    {
                        // calcula retencion
                        _movimiento.CalcularRetencion(obj_);
                    }

                    obj_.valorneto = obj_.subtotal - obj_.valordescuento1 + obj_.valoriva1 + obj_.fletes - obj_.valorretencion1;

                    _context.SaveChanges();
                }
            }
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