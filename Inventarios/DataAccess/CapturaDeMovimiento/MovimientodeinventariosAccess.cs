using Inventarios.Data;
using Inventarios.DataAccess.Seguridad;
using Inventarios.Map;
using Inventarios.Models.CapturaDeMovimiento;
using Inventarios.Models.TablasMaestras;
using Inventarios.ModelsParameter.CapturaDeMovimiento;
using Inventarios.Utils;
using Microsoft.CodeAnalysis.Elfie.Serialization;
using System.Globalization;
using CsvHelper;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Mvc.Filters;

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

        private Utilidades _utilidades;

        private MovimientosDeInventarios _utilsmovimiento;

        public MovimientodeinventariosAccess(InventariosContext context, LogAccess logacces, Mapping mapping, IConfiguration iconfiguration, Validaciones validaciones, Utilidades utilidades, MovimientosDeInventarios utilsmovimiento)
        {
            _context = context;
            _logacces = logacces;
            _mapping = mapping;
            _iconfiguration = iconfiguration;
            _validaciones = validaciones;
            _utilidades = utilidades;
            _utilsmovimiento = utilsmovimiento;
        }

        public List<string> Add(Movimientodeinventariostmp obj)
        {
            string mensajedeerror = "";
            obj.consecutivousuario = _utilsmovimiento.TraerConsecutivoDelUsuario(obj.idusuario);
            obj.fechadeldocumento = _utilidades.DevolverFechaParaGrabarAlServidorDeLaBaseDeDatos(obj.diadeldocumento, obj.mesdeldocumento, obj.anodeldocumento);
            try
            {
                obj.estadodelregistro = 1;
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

        public List<string> AnularDocumento(CargueDeMovimiento obj)
        {
            string mensajedeerror = "";

            List<Movimientodeinventarios> list = _context.Movimientodeinventarios.Where(a => a.tipodedocumento == obj.tipodedocumento && a.numerodeldocumento == obj.numerodeldocumento && a.despacha == obj.despacha && a.recibe == obj.recibe).ToList();
            DateTime fechadeldocumentograbado = list[0].fechadecreacion;
            int estadodelregistro = list[0].estadodelregistro;
            int idusuario = list[0].idusuario;

            if (idusuario != obj.idusuario)
            {
                mensajedeerror = mensajedeerror + "Error No puedes anular un documento que es de otro usuario ";
                return new List<string> { mensajedeerror };
            }

            if (estadodelregistro == Convert.ToInt16(_utilidades.traerparametrowebconfig("codigoestadoinactivo")))
            {
                mensajedeerror = mensajedeerror + "Error Ya fue anulado este documento ";
                return new List<string> { mensajedeerror };
            }

            List<FechaDeCierre> listfechadecierre = _context.FechaDeCierre.ToList();

            DateTime fechadecierre = listfechadecierre[0].fechadecierre;

            if (fechadeldocumentograbado <= fechadecierre)
            {
                mensajedeerror = mensajedeerror + "Error No puede anular un documento de un periodo que ya se cerro: fecha del documento " + fechadeldocumentograbado.ToString();
                return new List<string> { mensajedeerror };
            }

            using (var dbContextTransaction = _context.Database.BeginTransaction())
            {
                try
                {
                    list.ForEach(c => { c.cantidad = c.cantidad * -1; });
                    _context.SaveChanges();
                    _utilsmovimiento.ActualizarInventario(obj);

                    foreach (var item in list)
                    {
                        var obj_ = _context.Movimientodeinventarios.FirstOrDefault(a => a.id == item.id);
                        obj_.despacha = obj.despacha;
                        obj_.recibe = obj.recibe;
                        obj_.estadodelregistro = 2;
                        obj_.cantidadporempaque = 0;
                        obj_.numerodeempaques = 0;
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
                        obj_.costofleteporunidad = 0;
                        obj_.costopromedioporunidad = 0;
                        obj_.costoultimoporunidad = 0;
                        obj_.fletes = 0;
                        _context.SaveChanges();
                    }

                    dbContextTransaction.Commit();
                }
                catch (Exception ex)
                {
                    mensajedeerror = mensajedeerror + "Error " + ex.Message;
                    dbContextTransaction.Rollback();
                    return new List<string> { mensajedeerror };
                }
            }

            Log(obj, "Anulo Movimiento de inventario");

            if (mensajedeerror.Trim().Length == 0) mensajedeerror = "Documento anulado correctamente";
            return new List<string> { mensajedeerror };
        }

        public List<Movimientodeinventarios> GetByNumeroDeDocumento(int tipodedocumento, int numerodedocumento, int despacha, int recibe)
        {
            list = _context.Movimientodeinventarios.Where(a => a.tipodedocumento == tipodedocumento && a.numerodeldocumento == numerodedocumento && a.despacha == despacha && a.recibe == recibe).ToList();
            return list;
        }

        public List<Movimientodeinventariostmp> GetByNumeroDeDocumentoYPasarloAlTemporal(int tipodedocumento, int numerodedocumento, int despacha, int recibe)
        {

            List<Movimientodeinventariostmp> result = new List<Movimientodeinventariostmp>();
            list = _context.Movimientodeinventarios.Where(a => a.tipodedocumento == tipodedocumento && a.numerodeldocumento == numerodedocumento && a.despacha == despacha && a.recibe == recibe).ToList();

            if (list.Count == 0) return result;

            _context.Movimientodeinventariostmp.Where(x => x.tipodedocumento == list[0].tipodedocumento && x.idusuario == list[0].idusuario).ExecuteDelete();

       
            foreach (var obj in list)
            {
                Movimientodeinventariostmp obj_ = new Movimientodeinventariostmp();
                obj_ = _mapping.MovimientoToMovimientoTMP(obj);
                obj_.id = 0;
                _context.Movimientodeinventariostmp.Add(obj_);
                _context.SaveChanges();
               
            }

            result  = _context.Movimientodeinventariostmp.Where(a => a.tipodedocumento == list[0].tipodedocumento && a.idusuario == list[0].idusuario).OrderBy(a => a.id).ToList();

            return result;
        }

        public List<string> DeleteDocument(int tipodedocumento, int idusuario)
        {
            string mensajedeerror = "";

            mensajedeerror = _utilsmovimiento.BorrarLosRegistrosDelMovimientoTemporal(tipodedocumento, idusuario)[0];

            return new List<string> { mensajedeerror };
        }

        public List<string> AddDocumentFromFileCSV(string nombredelarchivo, string directorio, int idusuario, int tipodedocumento)
        {
            string mensajedeerror = "";
            var uploads = Path.Combine(Directory.GetCurrentDirectory(), directorio);
            var filePath = Path.Combine(uploads, nombredelarchivo);

            TiposDeDocumento? objtipodedocumento = new TiposDeDocumento();
            objtipodedocumento = _context.TiposDeDocumento.FirstOrDefault(a => a.id == tipodedocumento);

            if (objtipodedocumento.pidefisico != "S" && objtipodedocumento.esuninventarioinicial != "S")
            {
                mensajedeerror = "la transaccion seleccionada no es de cargue de invetario fisico  o inicial";
                return new List<string> { mensajedeerror };
            }

            CargueDeMovimiento obj = new CargueDeMovimiento();
            var objusuario = _context.Usuarios.FirstOrDefault(a => a.id == idusuario);
            string consecutivousuario = objusuario.id.ToString().Trim() + "-" + objusuario.consecutivo.ToString().Trim();
            obj.tipodedocumento = tipodedocumento;
            obj.despacha = Convert.ToInt32(objtipodedocumento.despacha);
            obj.recibe = Convert.ToInt32(objtipodedocumento.recibe);
            obj.idusuario = idusuario;
            obj.consecutivousuario = consecutivousuario;
            obj.numerodeldocumento = 0;

            using (var dbContextTransaction = _context.Database.BeginTransaction())
            {
                try
                {
                    var reader = new StreamReader(filePath);

                    using (var csv = new CsvHelper.CsvReader(reader, CultureInfo.InvariantCulture))
                    {
                        var records = csv.GetRecords<MovimientoFromFileCSV>();

                        foreach (var record in records)
                        {
                            Movimientodeinventariostmp movtmp = new Movimientodeinventariostmp();

                            movtmp.tipodedocumento = tipodedocumento;
                            movtmp.despacha = obj.despacha;
                            movtmp.recibe = obj.recibe;
                            movtmp.numerodeldocumento = obj.numerodeldocumento;
                            movtmp.producto = record.producto;
                            movtmp.cantidad = 1;
                            movtmp.unidaddeempaque = 0;
                            movtmp.cantidadporempaque = 1;
                            movtmp.numerodeempaques = 1;
                            movtmp.idusuario = obj.idusuario;
                            movtmp.nombreusuario = objusuario.nombre;

                            Add(movtmp);
                        }
                    }

                    System.IO.File.Delete(filePath);

                    mensajedeerror = "Transaction Successful ";

                    dbContextTransaction.Commit();
                }
                catch (Exception e)
                {
                    mensajedeerror = e.Message;
                    dbContextTransaction.Rollback();
                }
            }

            AddDocument(obj);

            return new List<string> { mensajedeerror };
        }

        public List<string> AddDocument(CargueDeMovimiento obj)
        {
            int tipodedocumento = obj.tipodedocumento;
            int idusuario = obj.idusuario;
            _utilsmovimiento.ProcesarLosCamposNumericosDeCadaFila(tipodedocumento, _utilsmovimiento.TraerConsecutivoDelUsuario(idusuario));

            string mensajedeerror = _utilsmovimiento.ValidarAntesDeCargarAlMovimiento(tipodedocumento, idusuario);
            if (mensajedeerror.IndexOf("Error") >= 0) return new List<string> { mensajedeerror };
            // aqui paso validaciones ok

            // totalizamos movimiento temporal
            _utilsmovimiento.TotalizarDocumentoTemporal(tipodedocumento, idusuario);

            // validamos saldo
            mensajedeerror = _utilsmovimiento.ValidarSaldo(tipodedocumento, idusuario);
            if (mensajedeerror.IndexOf("Error") >= 0) return new List<string> { mensajedeerror };

            mensajedeerror = "";

            using (var dbContextTransaction = _context.Database.BeginTransaction())
            {
                try
                {
                    // Colocamos el consecutivo al movimiento temporal
                    _utilsmovimiento.ColocarConsecutivoAlMovimientoTemporal(tipodedocumento, idusuario);

                    // cargamos documento temporal totalizado  al movimiento de inventarios definitivo
                    _utilsmovimiento.CargarMovimientoTemporalAlDefinitivo(tipodedocumento, idusuario);

                    // actualizamos consecutivo en tipos de documento
                    obj.numerodeldocumento = _utilsmovimiento.ActualizarConsecutivoDeLaTransaccion(tipodedocumento);

                    // actualizamos consecutivo usuario
                    _utilsmovimiento.ActualizarConsecutivoDelUsuario(idusuario);

                    // actualizamos inventario
                    _utilsmovimiento.ActualizarInventario(obj);

                    // borrramos el documento temporal
                    DeleteDocument(tipodedocumento, idusuario);

                    // generamos el log
                    Log(obj, "Agrego Movimiento de inventario ok ");

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

        public void AplicarDescuentoPieDeFactura(int tipodedocumento, decimal porcentajededescuento, int idusuario)
        {
            _utilsmovimiento.AplicarDescuentoPieDeFactura(tipodedocumento, porcentajededescuento, idusuario);
        }

        public void AplicarFletePieDeFactura(int tipodedocumento, int valorfletes, int idusuario)
        {
            _utilsmovimiento.AplicarFletePieDeFactura(tipodedocumento, valorfletes, idusuario);
        }

        public void Log(CargueDeMovimiento obj, string operacion)
        {
            var obj_ = _context.Movimientodeinventarios.FirstOrDefault(a => a.despacha == obj.despacha && a.recibe == obj.recibe && a.tipodedocumento == obj.tipodedocumento && a.numerodeldocumento == obj.numerodeldocumento);

            string comando = "";
            comando = comando + "usuario " + obj_.nombreusuario + "\n";
            comando = comando + "operacion " + operacion + "\n";
            comando = comando + "tipo de documento = " + obj_.tipodedocumento + "\n";
            comando = comando + "Nombre de documento = " + obj_.nombretipodedocumento + "\n";
            comando = comando + "numero del documento  = " + obj_.numerodeldocumento + "\n";
            comando = comando + "emisor  = " + obj_.despacha + "\n";
            comando = comando + "emisor  = " + obj_.nombredespacha + "\n";
            comando = comando + "receptor  = " + obj_.recibe + "\n";
            comando = comando + "nombrereceptor  = " + obj_.nombrerecibe + "\n";

            _logacces.Add(comando);
        }
    }
}