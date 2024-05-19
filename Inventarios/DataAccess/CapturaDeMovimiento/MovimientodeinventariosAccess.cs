using Inventarios.Data;
using Inventarios.DataAccess.Seguridad;
using Inventarios.DataAccess.Utils;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Map;
using Inventarios.Models.CapturaDeMovimiento;
using Inventarios.Models.TablasMaestras;
using Inventarios.Token;

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

        private readonly Validaciones _validaciones;

        private Utilidades _utlididades;

        private MovimientosDeInventarios _movimiento;

        public MovimientodeinventariosAccess(InventariosContext context, LogAccess logacces, Mapping mapping, IConfiguration iconfiguration, JwtService jwtservice, Validaciones validaciones , Utilidades utilidades, MovimientosDeInventarios movimiento )
        {
            _context = context;
            _logacces = logacces;
            _mapping = mapping;
            _iconfiguration = iconfiguration;
            _jwtservice = jwtservice;
            _validaciones = validaciones;
            _utlididades = utilidades;
            _movimiento = movimiento;   
        }

        public List<string> Add(Movimientodeinventarios obj)
        {
            string mensajedeerror = "";
            var objusuario = _context.Usuarios.FirstOrDefault(a => a.id == _jwtservice.Id);
            obj.consecutivousuario = objusuario.id.ToString().Trim() + "-" + objusuario.consecutivo.ToString().Trim();
            obj.idusuario = _jwtservice.Id;
            obj.fechadeldocumento = _utlididades.DevolverFechaParaGrabarAlServidorDeLaBaseDeDatos(obj.diadeldocumento,obj.mesdeldocumento,obj.anodeldocumento);
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

/*
            var s = list.Select(s => 
            new { producto=s.producto, 
                talla=s.talla,color=s.color, 
                id = s.id, total_pedido = list.Sum(d => d.cantidad) }).GroupBy(a =>a.producto , a =>a.talla ).ToList();
*/


            return  new List<string> { mensajedeerror };
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


        public List<Movimientodeinventarios>? List(int tipodedocumento)
        {

            var objusuario = _context.Usuarios.FirstOrDefault(a => a.id == _jwtservice.Id);
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


        public List<string> DeleteDocument(int tipodedocumento)
        {
            var objusuario = _context.Usuarios.FirstOrDefault(a => a.id == _jwtservice.Id);
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

            if (mensajedeerror.Trim().Length== 0) mensajedeerror = "Documento temporal borrado exitosamente";
            return new List<string> { mensajedeerror };
        }



        public List<string> AddDocument(int tipodedocumento)
        {
            var objusuario = _context.Usuarios.FirstOrDefault(a => a.id == _jwtservice.Id);
            string consecutivousuario = objusuario.id.ToString().Trim() + "-" + objusuario.consecutivo.ToString().Trim();

            string mensajedeerror = "";
            mensajedeerror = ValidarAntesDeCargarAlMovimiento(tipodedocumento, consecutivousuario);
            if (mensajedeerror.Trim().Length > 0) return new List<string> { mensajedeerror };

            list = _context.Movimientodeinventariostmp.Where(a => a.tipodedocumento == tipodedocumento && a.consecutivousuario == consecutivousuario).ToList();

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
            TiposDeDocumento? objtipodedocumento = new TiposDeDocumento();
            objtipodedocumento = _context.TiposDeDocumento.FirstOrDefault(a => a.id == list[0].tipodedocumento);
            objtipodedocumento.consecutivo = objtipodedocumento.consecutivo + 1;
            _context.SaveChanges();

            // actualizamos consecutivo usuario
            objusuario.consecutivo = objusuario.consecutivo + 1;
            _context.SaveChanges();

            Log(list[0], "Agrego Movimiento de inventario");

            if (mensajedeerror.Trim().Length == 0) mensajedeerror = "Movimiento cargado correctamente";
            return new List<string> { mensajedeerror };
        }





        private string ValidarAntesDeCargarAlMovimiento(int tipodedocumento, string consecutivousuario)
        {
            _validaciones.mensajedeerror = "";
            // valida tipo de documento
            string nombretipodedocumento = _validaciones.ValidarTipoDeDocumento(tipodedocumento);
            if (_validaciones.mensajedeerror.Trim().Length > 0)
            {
                return _validaciones.mensajedeerror;
            }
            TiposDeDocumento? objtipodedocumento = new TiposDeDocumento();
            objtipodedocumento = _context.TiposDeDocumento.FirstOrDefault(a => a.id == tipodedocumento);
            int consecutivo = Convert.ToInt32(objtipodedocumento.consecutivo);
            consecutivo = consecutivo + 1;

            // trae datos de encabezado del documento
            Movimientodeinventarios obj = _context.Movimientodeinventariostmp.FirstOrDefault(a => a.tipodedocumento == tipodedocumento && a.consecutivousuario == consecutivousuario);
            string nombredespacha = _validaciones.ValidarDespacha(obj.despacha);
            string nombrerecibe = _validaciones.ValidarRecibe(obj.recibe);
            string nombretipodedocumentoaafectar = _validaciones.ValidarTipoDeDocumentoaAfectar(obj.tipodedocumentoaafectar);
            string nombredespachaaafectar = _validaciones.ValidarDespachaaAfectar(obj.despachaaafectar);
            string nombrerecibeaafectar = _validaciones.ValidarRecibeaAfectar(obj.recibeaafectar);
            string nombreprograma = _validaciones.ValidarPrograma(obj.programa);
            string nombrevendedor = _validaciones.ValidarVendedor(obj.vendedor);

            if (_validaciones.mensajedeerror.Trim().Length > 0)
            {
                return _validaciones.mensajedeerror;
            }

            //////////////////////////////////////
            /// detalle
            //////////////////////////////////////
            ///
            _validaciones.mensajedeerror = "";

            list = _context.Movimientodeinventariostmp.Where(a => a.tipodedocumento == obj.tipodedocumento && a.consecutivousuario == obj.consecutivousuario).ToList();

            foreach (var item in list)
            {
                _validaciones.mensajedeerror = "";

                _validaciones.Validarvalormenorquecero("Cantidad", Convert.ToInt32(item.cantidad));
                _validaciones.Validarvalormenorquecero("Valor unitario", Convert.ToInt32(item.valorunitario));
                _validaciones.Validarvalormenorquecero("Valor fletes", Convert.ToInt32(item.fletes));
                _validaciones.Validarvalormenorquecero("Valor descuento", Convert.ToInt32(item.valordescuento1));

                // consulta cada item de cada documento para actulizarlo en la base de datos
                Movimientodeinventarios obj_ = _context.Movimientodeinventariostmp.FirstOrDefault(a => a.id == item.id);

                obj_.numerodeldocumento = consecutivo;
                obj_.nombretipodedocumento = nombretipodedocumento;
                obj_.nombredespacha = nombredespacha;
                obj_.nombrerecibe = nombrerecibe;
                obj_.nombretipodedocumentoaafectar = nombretipodedocumentoaafectar;
                obj_.nombredespachaaafectar = nombredespachaaafectar;
                obj_.nombrerecibeaafectar = nombrerecibeaafectar;
                obj_.nombreprograma = nombreprograma;
                obj_.nombrevendedor = nombrevendedor;
                obj_.fechadevencimientodeldocumento = obj_.fechadeldocumento.AddDays(obj.plazo);

                obj_.nombreformadepago = _validaciones.ValidarFormaDePago(item.formadepago);
                obj_.nombreconceptonotadebitocredito = _validaciones.ValidarConceptoNotaDebitoCredito(item.codigoconceptonotadebitocredito);
                obj_.nombrebanco = _validaciones.ValidarBanco(item.banco);
                obj_.nombreproducto = _validaciones.ValidarProducto(item.producto);
                obj_.nombreunidaddemedida = _validaciones.ValidarUnidadDeMedida(item.unidaddemedida);
                obj_.nombretalla = _validaciones.ValidarTalla(item.talla);
                obj_.nombrecolor = _validaciones.ValidarColor(item.color);
                obj_.nombreunidaddeempaque = _validaciones.ValidarUnidadDeEmpaque(item.unidaddeempaque);

                obj_.sumaorestaencartera = objtipodedocumento.sumarcartera;
                obj_.sumaorestaeninventario = objtipodedocumento.sumainventario;

             
                if (_validaciones.mensajedeerror.Trim().Length == 0) Update(obj_);

                if (_validaciones.mensajedeerror.Trim().Length > 0)
                {
                    _validaciones.mensajedeerror = _validaciones.mensajedeerror + " Id No " + item.id.ToString();
                    break;
                }
            }

            return _validaciones.mensajedeerror;
        }


        private void ProcesarLosCamposNumericosDeCadaFila(int tipodedocumento, string consecutivousuario)
        {
           
          
            TiposDeDocumento? objtipodedocumento = new TiposDeDocumento();
            objtipodedocumento = _context.TiposDeDocumento.FirstOrDefault(a => a.id == tipodedocumento);
          

            list = _context.Movimientodeinventariostmp.Where(a => a.tipodedocumento == tipodedocumento && a.consecutivousuario == consecutivousuario).ToList();

            int contador = 0;

            foreach (var item in list)
            {
                // consulta cada item de cada documento para actulizarlo en la base de datos
                Movimientodeinventarios obj_ = _context.Movimientodeinventariostmp.FirstOrDefault(a => a.id == item.id);

                contador = contador + 1;
            


                if (obj_.numerodeempaques < 0) obj_.numerodeempaques = 0;
                if (obj_.cantidadporempaque < 0) obj_.cantidadporempaque = 0;
                if (obj_.cantidad < 0) obj_.cantidad = 0;
                if (obj_.porcentajedescuento1 < 0) obj_.porcentajedescuento1 = 0;
                if (obj_.valordescuento1 < 0) obj_.valordescuento1 = 0;
                if (obj_.porcentajedeiva1 < 0) obj_.porcentajedeiva1 = 0;
                if (obj_.valoriva1 < 0) obj_.valoriva1 = 0;
                if (obj_.fletes < 0) obj_.fletes = 0;


                if (objtipodedocumento.pidevalorunitario=="S")
                {
                    if (objtipodedocumento.pidecantidad != "S")
                    {
                        obj_.cantidad = 1;
                        string codigotipodeempqueunidad = _iconfiguration.GetValue<string>("ParametrosDeLaEmpresa:codigotipodeempaqueunidad");
                        obj_.numerodeempaques = 1;
                        obj_.unidaddeempaque = Convert.ToInt32(codigotipodeempqueunidad);
                        obj_.cantidadporempaque = obj_.cantidad;
                    }

                }

                if (objtipodedocumento.pideempaque != "S")
                {
                    string codigotipodeempqueunidad = _iconfiguration.GetValue<string>("ParametrosDeLaEmpresa:codigotipodeempaqueunidad");
                    obj_.numerodeempaques = 1;
                    obj_.unidaddeempaque = Convert.ToInt32(codigotipodeempqueunidad);
                    obj_.cantidadporempaque = obj_.cantidad;
                }


                obj_.cantidad = obj_.numerodeempaques * obj_.cantidadporempaque;
                obj_.subtotal = obj_.valorunitario * obj_.cantidad;
                obj_.valordescuento1 = Convert.ToInt32(obj_.subtotal *  (obj_.porcentajedescuento1 / 100));
                decimal valorbruto = obj_.subtotal - obj_.valordescuento1;


                // calcula iva
                _movimiento.CalcularIva(objtipodedocumento,  obj_.producto, valorbruto);
                obj_.porcentajedeiva1 =_movimiento.porcentajedeiva;
                obj_.codigoiva1 =  _movimiento.idiva;
                obj_.valoriva1 = _movimiento.valoriva;
                obj_.nombrecodigoiva1 = _movimiento.nombreiva;
                obj_.nombreproducto = _movimiento.nombreproducto;


                // aplicamos retencion solo a un registro osea en un registro guardamos el valor de la retencion 
                // no en todos
                if (contador == 1)
                {
                    // calcula retencion
                  _movimiento.CalcularRetencion(objtipodedocumento, obj_.recibe, valorbruto);
                    obj_.porcentajederetencion1 = _movimiento.porcentajederetencion;
                    obj_.codigoretencion1 =   _movimiento.idretencion;
                    obj_.valorretencion1 =   _movimiento.valorretencion;
                    obj_.nombrecodigoretencion1 = _movimiento.nombreretencion;
                }


                obj_.valorneto = obj_.subtotal - obj_.valordescuento1 + obj_.valoriva1 + obj_.fletes - obj_.valorretencion1;







                Update(obj_);

             
            }

          
        }




        public List<Movimientodeinventarios> TraerDocumentoTemporal(int tipodedocumento)
        {
            var objusuario = _context.Usuarios.FirstOrDefault(a => a.id == _jwtservice.Id);
            string consecutivousuario = objusuario.id.ToString().Trim() + "-" + objusuario.consecutivo.ToString().Trim();
            list = _context.Movimientodeinventarios.Where(a => a.tipodedocumento == tipodedocumento && a.consecutivousuario ==consecutivousuario).ToList();

            return list;
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