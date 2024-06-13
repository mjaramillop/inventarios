using Inventarios.Data;
using Inventarios.DataAccess.Seguridad;
using Inventarios.Map;
using Inventarios.Models.CapturaDeMovimiento;
using Inventarios.Utils;

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

        private MovimientosDeInventarios _utilsmovimiento;

        public MovimientodeinventariosAccess(InventariosContext context, LogAccess logacces, Mapping mapping, IConfiguration iconfiguration, Validaciones validaciones, Utilidades utilidades, MovimientosDeInventarios utilsmovimiento)
        {
            _context = context;
            _logacces = logacces;
            _mapping = mapping;
            _iconfiguration = iconfiguration;
            _validaciones = validaciones;
            _utlididades = utilidades;
            _utilsmovimiento = utilsmovimiento;
        }

        public List<string> Add(Movimientodeinventariostmp obj)
        {
            string mensajedeerror = "";
            obj.consecutivousuario = _utilsmovimiento.TraerConsecutivoDelUsuario(obj.idusuario);
            obj.fechadeldocumento = _utlididades.DevolverFechaParaGrabarAlServidorDeLaBaseDeDatos(obj.diadeldocumento, obj.mesdeldocumento, obj.anodeldocumento);
            try
            {
                _context.Movimientodeinventariostmp.Add(obj);
                _context.SaveChanges();
            }
            catch (Exception ex)
            {
                mensajedeerror = "Error " + ex.Message.ToString();
                return new List<string> { mensajedeerror };
            }

            if (mensajedeerror.Trim().Length == 0) mensajedeerror = "Registro añadido correctamente";
            _utilsmovimiento.ProcesarLosCamposNumericosDeCadaFila(obj.tipodedocumento, obj.consecutivousuario);

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

        public List<string> Update(Movimientodeinventariostmp? obj)
        {
            obj.id = obj.numerodeldocumento;
            string mensajedeerror = "";
            try
            {
                var obj_ = _context.Movimientodeinventariostmp.FirstOrDefault(a => a.id == obj.id);
                _mapping.MovimientoTMPToMovimientoTMP(obj, obj_);
                _context.SaveChanges();
            }
            catch (Exception ex)
            {
                mensajedeerror = "Error " + ex.Message.ToString();
                return new List<string> { mensajedeerror };
            }
            _utilsmovimiento.ProcesarLosCamposNumericosDeCadaFila(obj.tipodedocumento, _utilsmovimiento.TraerConsecutivoDelUsuario(obj.idusuario));
            if (mensajedeerror.Trim().Length == 0) mensajedeerror = "Registro modificado correctamente";
            return new List<string> { mensajedeerror };
        }

        public List<Movimientodeinventariostmp> GetById(int id)
        {
            List<Movimientodeinventariostmp> list = _context.Movimientodeinventariostmp.Where(a => a.id == id).ToList();
            return list;
        }

        public List<Movimientodeinventariostmp>? List(int tipodedocumento, int idusuario)
        {
            List<Movimientodeinventariostmp> list = _context.Movimientodeinventariostmp.Where(a => a.tipodedocumento == tipodedocumento && a.consecutivousuario == _utilsmovimiento.TraerConsecutivoDelUsuario(idusuario)).OrderBy(a => a.id).ToList();
            return list;
        }

        public List<string> AnularDocumento(int tipodedocumento, int numerodedocumento, int despacha, int recibe)
        {
            string mensajedeerror = "";

            List<Movimientodeinventarios> list = _context.Movimientodeinventarios.Where(a => a.tipodedocumento == tipodedocumento && a.numerodeldocumento == numerodedocumento && a.despacha == despacha && a.recibe == recibe).ToList();

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

            Log(list[0].tipodedocumento, list[0].numerodeldocumento, "Anulo Movimiento de inventario");

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
            string mensajedeerror = "";
            try
            {
                _utilsmovimiento.BorrarLosRegistrosDelMovimientoTemporal(tipodedocumento, idusuario);
            }
            catch (Exception ex)
            {
                mensajedeerror = mensajedeerror + "Error " + ex.Message;
                return new List<string> { mensajedeerror };
            }

            if (mensajedeerror.Trim().Length == 0) mensajedeerror = "Documento temporal borrado exitosamente";
            return new List<string> { mensajedeerror };
        }

        public List<string> AddDocument(int tipodedocumento, int idusuario)
        {
            string mensajedeerror = _utilsmovimiento.ValidarAntesDeCargarAlMovimiento(tipodedocumento, idusuario);
            if (mensajedeerror.IndexOf("Error") >= 0) return new List<string> { mensajedeerror };
            // aqui paso validaciones ok

            mensajedeerror = "";

            using (var dbContextTransaction = _context.Database.BeginTransaction())
            {
                try
                {
                    // totalizamos movimiento temporal
                    List<Movimientodeinventariostmp> list = _utilsmovimiento.TotalizarDocumentoTemporal(tipodedocumento, idusuario);

                    // actualizamos inventario

                    list = _utilsmovimiento.ActualizarInventario(tipodedocumento, idusuario);


                    // Colocamos el consecutivo al movmiento temporal
                    list = _utilsmovimiento.ColocarConsecutivoAlMovimientoTemporal(tipodedocumento, idusuario);

                    // cargamos documento temporal totalizado  al movimiento de inventarios definitivo
                    _utilsmovimiento.CargarMovimientoTemporalAlDefinitivo(list, idusuario);

                    // actualizamos consecutivo en tipos de documento
                    _utilsmovimiento.ActualizarConsecutivoDeLaTransaccion(tipodedocumento);

                    // actualizamos consecutivo usuario
                    _utilsmovimiento.ActualizarConsecutivoDelUsuario(idusuario);

                    // generamos el log
                    Log(list[0].tipodedocumento, list[0].numerodeldocumento, "Agrego Movimiento de inventario ok ");

                    mensajedeerror = "Transaction Successful ";
                    // Once your Single/Multiple table insert /Update/Delete operation done all operation should commit to database
                    dbContextTransaction.Commit();
                }
                catch (Exception e)
                {
                    mensajedeerror = e.Message;
                    // If any operation getting error on the insert /Update/Delete operation all operation rollback. It should not commit to database
                    dbContextTransaction.Rollback();
                }
            }

            if (mensajedeerror.Trim().Length == 0) mensajedeerror = "Movimiento cargado correctamente";
            return new List<string> { mensajedeerror };
        }

        public List<Movimientodeinventarios> TraerDocumentoTemporal(int tipodedocumento, int idusuario)
        {
            list = _context.Movimientodeinventarios.Where(a => a.tipodedocumento == tipodedocumento && a.consecutivousuario == _utilsmovimiento.TraerConsecutivoDelUsuario(idusuario)).ToList();
            return list;
        }

        public void AplicarDescuentoPieDeFactura(int tipodedocumento, decimal porcentajededescuento, int idusuario)
        {
            _utilsmovimiento.AplicarDescuentoPieDeFactura(tipodedocumento, porcentajededescuento, idusuario);
        }

        public void AplicarFletePieDeFactura(int tipodedocumento, int valorfletes, int idusuario)
        {
            _utilsmovimiento.AplicarFletePieDeFactura(tipodedocumento, valorfletes, idusuario);
        }

        public void Log(int tipodedocumento, int numerodedocumento, string operacion)
        {
            var obj = _context.Movimientodeinventarios.FirstOrDefault(a => a.tipodedocumento == tipodedocumento && a.numerodeldocumento == numerodedocumento);

            string comando = "";
            comando = comando + "usuario " + obj.nombreusuario + "\n";

            comando = comando + "operacion " + operacion + "\n";

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