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
using Humanizer;
using System.Collections.Generic;

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

        public MovimientodeinventariosAccess(InventariosContext context, LogAccess logacces, Mapping mapping, IConfiguration iconfiguration, Validaciones validaciones, Utilidades utilidades)
        {
            _context = context;
            _logacces = logacces;
            _mapping = mapping;
            _iconfiguration = iconfiguration;
            _validaciones = validaciones;
            _utilidades = utilidades;
        }

        public List<string> Add(Movimientodeinventariostmp obj)
        {
            string mensajedeerror = "";
            obj.consecutivousuario = TraerConsecutivoDelUsuario(obj.idusuario);
            obj.fechadeldocumento = _utilidades.DevolverFechaParaGrabarAlServidorDeLaBaseDeDatos(obj.diadeldocumento, obj.mesdeldocumento, obj.anodeldocumento);


           
                using (var dbContextTransaction = _context.Database.BeginTransaction())
                {

                    try
                    {

                //    _context.Database.ExecuteSqlRaw("SET IDENTITY_INSERT dbo.movimientodeinventariostmp ON;");

                        obj.estadodelregistro = Convert.ToInt16(_utilidades.traerparametrowebconfig("codigoestadoactivo"));
                        _context.Movimientodeinventariostmp.Add(obj);
                        _context.SaveChanges();
                        dbContextTransaction.Commit();
                    }
                    catch (Exception ex)
                    {

                        mensajedeerror = "Error " + ex.Message.ToString();
                        dbContextTransaction.Rollback();
                        return new List<string> { mensajedeerror };
                    }

                }

           

            if (mensajedeerror.Trim().Length == 0) mensajedeerror = "Registro añadido correctamente";

            ProcesarLosCamposNumericosDeCadaFila(obj);

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

            ProcesarLosCamposNumericosDeCadaFila(obj);
            if (mensajedeerror.Trim().Length == 0) mensajedeerror = "Registro modificado correctamente";
            return new List<string> { mensajedeerror };
        }

        public List<Movimientodeinventariostmp> GetById(int id)
        {
            List<Movimientodeinventariostmp> list = _context.Movimientodeinventariostmp.Where(a => a.id == id).ToList();
            return list;
        }

        public List<Movimientodeinventarios> GetByNumeroDeDocumento(int tipodedocumento, int numerodedocumento, int despacha, int recibe)
        {
            list = _context.Movimientodeinventarios.Where(a => a.tipodedocumento == tipodedocumento && a.numerodeldocumento == numerodedocumento && a.despacha == despacha && a.recibe == recibe).ToList();

            if (list.Count == 0) return new List<Movimientodeinventarios>();

            TiposDeDocumento? objtipodedocumento = new TiposDeDocumento();
            objtipodedocumento = _context.TiposDeDocumento.FirstOrDefault(a => a.id == list[0].tipodedocumento);

            foreach (var obj in list)
            {
                List<Detalle> detalle = new List<Detalle>();

                if (objtipodedocumento.pidetipodedocumentoaafectar == "S")
                {
                    detalle.Add(new Detalle { id = 0, detalle = obj.nombretipodedocumentoaafectar });
                    detalle.Add(new Detalle { id = 1, detalle = obj.numerodeldocumentoaafectar.ToString() });
                }

                if (objtipodedocumento.esunpago == "S")
                {
                    detalle.Add(new Detalle { id = 2, detalle = obj.nombreformadepago });
                    detalle.Add(new Detalle { id = 3, detalle = obj.numerodelpago });
                    detalle.Add(new Detalle { id = 4, detalle = obj.nombrebanco });
                }

                if (objtipodedocumento.pideconceptonotadebitocredito == "S")
                {
                    detalle.Add(new Detalle { id = 5, detalle = obj.nombreconceptonotadebitocredito });
                }

                if (objtipodedocumento.pideproducto == "S")
                {
                    detalle.Add(new Detalle { id = 6, detalle = obj.producto + "-" + obj.nombreproducto + "-" + obj.nombreunidaddemedida });
                }

                if (objtipodedocumento.pidetalla == "S")
                {
                    detalle.Add(new Detalle { id = 7, detalle = obj.nombretalla });
                }

                if (objtipodedocumento.pidecolor == "S")
                {
                    detalle.Add(new Detalle { id = 8, detalle = obj.nombrecolor });
                }

                if (objtipodedocumento.pideempaque == "S")
                {
                    detalle.Add(new Detalle { id = 9, detalle = obj.numerodeempaques.ToString() + "-" + obj.nombreunidaddeempaque });

                    detalle.Add(new Detalle { id = 10, detalle = obj.cantidadporempaque.ToString("C2", CultureInfo.CreateSpecificCulture("en-US")) });
                }

                if (objtipodedocumento.pidecantidad == "S")
                {
                    detalle.Add(new Detalle { id = 11, detalle = obj.cantidad.ToString("C2", CultureInfo.CreateSpecificCulture("en-US")) });
                }

                if (objtipodedocumento.pidevalorunitario == "S")
                {
                    detalle.Add(new Detalle { id = 12, detalle = obj.valorunitario.ToString("C2", CultureInfo.CreateSpecificCulture("en-US")) });
                }

                detalle.Add(new Detalle { id = 13, detalle = obj.subtotal.ToString("C2", CultureInfo.CreateSpecificCulture("en-US")) });

                if (objtipodedocumento.pidedescuentodetalle == "S")
                {
                    detalle.Add(new Detalle { id = 14, detalle = obj.porcentajedescuento1.ToString() + "%" + obj.valordescuento1.ToString("C2", CultureInfo.CreateSpecificCulture("en-US")) });

                    detalle.Add(new Detalle { id = 15, detalle = (obj.subtotal - obj.valordescuento1).ToString() });
                }

                if (objtipodedocumento.esunaventa == "S" || objtipodedocumento.esunacompra == "S")
                {
                    detalle.Add(new Detalle { id = 16, detalle = obj.fletes.ToString("C2", CultureInfo.CreateSpecificCulture("en-US")) });
                }

                if (objtipodedocumento.pideivadetalle == "S")
                {
                    detalle.Add(new Detalle { id = 17, detalle = obj.porcentajedeiva1.ToString() + "%" + obj.valoriva1.ToString("C2", CultureInfo.CreateSpecificCulture("en-US")) });
                }

                if (objtipodedocumento.esunpago == "S")
                {
                    detalle.Add(new Detalle { id = 18, detalle = obj.valorretencion1.ToString("C2", CultureInfo.CreateSpecificCulture("en-US")) });
                }

                detalle.Add(new Detalle { id = 19, detalle = obj.valorneto.ToString("C2", CultureInfo.CreateSpecificCulture("en-US")) });

                obj.detalle = detalle;
            }

            return list;
        }

        public List<Movimientodeinventariostmp>? TraerDocumentoTemporal(int tipodedocumento, int idusuario)
        {
            List<Movimientodeinventariostmp> list = _context.Movimientodeinventariostmp.Where(a => a.tipodedocumento == tipodedocumento && a.consecutivousuario == TraerConsecutivoDelUsuario(idusuario)).OrderBy(a => a.id).ToList();

            if (list.Count == 0) return new List<Movimientodeinventariostmp>();

            TiposDeDocumento? objtipodedocumento = new TiposDeDocumento();
            objtipodedocumento = _context.TiposDeDocumento.FirstOrDefault(a => a.id == list[0].tipodedocumento);

            foreach (var obj in list)
            {
                List<Detalle> detalle = new List<Detalle>();

                if (objtipodedocumento.pidetipodedocumentoaafectar == "S")
                {
                    detalle.Add(new Detalle { id = 0, detalle = obj.nombretipodedocumentoaafectar });
                    detalle.Add(new Detalle { id = 1, detalle = obj.numerodeldocumentoaafectar.ToString() });
                }

                if (objtipodedocumento.esunpago == "S")
                {
                    detalle.Add(new Detalle { id = 2, detalle = obj.nombreformadepago });
                    detalle.Add(new Detalle { id = 3, detalle = obj.numerodelpago });
                    detalle.Add(new Detalle { id = 4, detalle = obj.nombrebanco });
                }

                if (objtipodedocumento.pideconceptonotadebitocredito == "S")
                {
                    detalle.Add(new Detalle { id = 5, detalle = obj.nombreconceptonotadebitocredito });
                }

                if (objtipodedocumento.pideproducto == "S")
                {
                    detalle.Add(new Detalle { id = 6, detalle = obj.producto + "-" + obj.nombreproducto + "-" + obj.nombreunidaddemedida });
                }

                if (objtipodedocumento.pidetalla == "S")
                {
                    detalle.Add(new Detalle { id = 7, detalle = obj.nombretalla });
                }

                if (objtipodedocumento.pidecolor == "S")
                {
                    detalle.Add(new Detalle { id = 8, detalle = obj.nombrecolor });
                }

                if (objtipodedocumento.pideempaque == "S")
                {
                    detalle.Add(new Detalle { id = 9, detalle = obj.numerodeempaques.ToString() + "-" + obj.nombreunidaddeempaque });

                    detalle.Add(new Detalle { id = 10, detalle = obj.cantidadporempaque.ToString("C2", CultureInfo.CreateSpecificCulture("en-US")) });
                }

                if (objtipodedocumento.pidecantidad == "S")
                {
                    detalle.Add(new Detalle { id = 11, detalle = obj.cantidad.ToString("C2", CultureInfo.CreateSpecificCulture("en-US")) });
                }

                if (objtipodedocumento.pidevalorunitario == "S")
                {
                    detalle.Add(new Detalle { id = 12, detalle = obj.valorunitario.ToString("C2", CultureInfo.CreateSpecificCulture("en-US")) });
                }

                detalle.Add(new Detalle { id = 13, detalle = obj.subtotal.ToString("C2", CultureInfo.CreateSpecificCulture("en-US")) });

                if (objtipodedocumento.pidedescuentodetalle == "S")
                {
                    detalle.Add(new Detalle { id = 14, detalle = obj.porcentajedescuento1.ToString() + "%" + obj.valordescuento1.ToString("C2", CultureInfo.CreateSpecificCulture("en-US")) });

                    detalle.Add(new Detalle { id = 15, detalle = (obj.subtotal - obj.valordescuento1).ToString() });
                }

                if (objtipodedocumento.esunaventa == "S" || objtipodedocumento.esunacompra == "S")
                {
                    detalle.Add(new Detalle { id = 16, detalle = obj.fletes.ToString("C2", CultureInfo.CreateSpecificCulture("en-US")) });
                }

                if (objtipodedocumento.pideivadetalle == "S")
                {
                    detalle.Add(new Detalle { id = 17, detalle = obj.porcentajedeiva1.ToString() + "%" + obj.valoriva1.ToString("C2", CultureInfo.CreateSpecificCulture("en-US")) });
                }

                if (objtipodedocumento.esunpago == "S")
                {
                    detalle.Add(new Detalle { id = 18, detalle = obj.valorretencion1.ToString("C2", CultureInfo.CreateSpecificCulture("en-US")) });
                }

                detalle.Add(new Detalle { id = 19, detalle = obj.valorneto.ToString("C2", CultureInfo.CreateSpecificCulture("en-US")) });

                obj.detalle = detalle;
            }

            return list;
        }

        public List<string> AnularDocumento(Movimientodeinventariostmp obj)
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
                    ActualizarInventario(obj);

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

        public List<Movimientodeinventariostmp> GetByNumeroDeDocumentoYPasarloAlTemporal(int tipodedocumento, int numerodedocumento, int despacha, int recibe)
        {
            List<Movimientodeinventariostmp> result = new List<Movimientodeinventariostmp>();
            list = _context.Movimientodeinventarios.Where(a => a.tipodedocumento == tipodedocumento && a.numerodeldocumento == numerodedocumento && a.despacha == despacha && a.recibe == recibe).ToList();

            if (list.Count == 0) return result;

            result = _context.Movimientodeinventariostmp.Where(x => x.tipodedocumento == list[0].tipodedocumento && x.idusuario == list[0].idusuario).ToList();

            foreach (var s in result)
            {
                Delete(s.id);
            }

            foreach (var obj in list)
            {
                Movimientodeinventariostmp obj_ = new Movimientodeinventariostmp();
                obj_ = _mapping.MovimientoToMovimientoTMP(obj);
                obj_.id = 0;
                obj_.consecutivousuario = TraerConsecutivoDelUsuario(obj_.idusuario);
                obj_.numerodeldocumento = TraerConsecutivoDeLaTransaccion(obj_.tipodedocumento) + 1;
                _context.Movimientodeinventariostmp.Add(obj_);
                _context.SaveChanges();
            }

            result = _context.Movimientodeinventariostmp.Where(a => a.tipodedocumento == list[0].tipodedocumento && a.idusuario == list[0].idusuario).OrderBy(a => a.id).ToList();

            return result;
        }

        public List<string> DeleteDocument(int tipodedocumento, int idusuario)
        {
            string mensajedeerror = "";

            mensajedeerror = BorrarLosRegistrosDelMovimientoTemporal(tipodedocumento, idusuario)[0];

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

            Movimientodeinventariostmp obj = new Movimientodeinventariostmp();
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

        public List<string> AddDocument(Movimientodeinventariostmp obj)
        {
            ProcesarLosCamposNumericosDeCadaFila(obj);

            string mensajedeerror = ValidarAntesDeCargarAlMovimiento(obj.tipodedocumento, obj.idusuario);
            if (mensajedeerror.IndexOf("Error") >= 0) return new List<string> { mensajedeerror };
            // aqui paso validaciones ok

            // totalizamos movimiento temporal
            TotalizarDocumentoTemporal(obj.tipodedocumento, obj.idusuario);

            // validamos saldo
            mensajedeerror = ValidarSaldo(obj.tipodedocumento, obj.idusuario);
            if (mensajedeerror.IndexOf("Error") >= 0) return new List<string> { mensajedeerror };

            mensajedeerror = "";

            using (var dbContextTransaction = _context.Database.BeginTransaction())
            {
                try
                {
                    // Colocamos el consecutivo al movimiento temporal
                    ColocarConsecutivoAlMovimientoTemporal(obj.tipodedocumento, obj.idusuario);

                    // cargamos documento temporal totalizado  al movimiento de inventarios definitivo
                    CargarMovimientoTemporalAlDefinitivo(obj.tipodedocumento, obj.idusuario);

                    // actualizamos consecutivo en tipos de documento
                    obj.numerodeldocumento = ActualizarConsecutivoDeLaTransaccion(obj.tipodedocumento);

                    // actualizamos consecutivo usuario
                    ActualizarConsecutivoDelUsuario(obj.idusuario);

                    // actualizamos inventario
                    ActualizarInventario(obj);

                    // borrramos el documento temporal
                    DeleteDocument(obj.tipodedocumento, obj.idusuario);

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

        public Movimientodeinventariostmp CalcularIva(Movimientodeinventariostmp obj)
        {
            TiposDeDocumento? objtipodedocumento = new TiposDeDocumento();
            objtipodedocumento = _context.TiposDeDocumento.FirstOrDefault(a => a.id == obj.tipodedocumento);

            obj.codigoiva1 = 0;
            obj.porcentajedeiva1 = 0;
            obj.valoriva1 = 0;
            obj.nombrecodigoiva1 = "";

            if (objtipodedocumento.esunaventa == "S" || objtipodedocumento.esunacompra == "S")
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
                }
            }

            return obj;
        }

        public void CalcularRetencion(Movimientodeinventariostmp obj)
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
                        if (obj.subtotal - obj.valordescuento1 + obj.fletes >= objretenciones.basedelaretencion)
                        {
                            obj.valorretencion1 = Convert.ToInt32((obj.subtotal - obj.valordescuento1 + obj.fletes) * (objretenciones.porcentaje / 100));
                        }

                        obj.nombrecodigoretencion1 = objretenciones.nombre;
                    }
                }
            }
        }

        public Movimientodeinventariostmp ColocarDescripcionALasEntidades(Movimientodeinventariostmp obj)
        {
            TiposDeDocumento objtipodedocumento = _context.TiposDeDocumento.FirstOrDefault(a => a.id == obj.tipodedocumento);

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

        public List<Movimientodeinventariostmp> ColocarConsecutivoAlMovimientoTemporal(int tipodedocumento, int idusuario)
        {
            // extraigo  el consecutivo que se asignara
            TiposDeDocumento? objtipodedocumento = new TiposDeDocumento();
            objtipodedocumento = _context.TiposDeDocumento.FirstOrDefault(a => a.id == tipodedocumento);

            var objusuario = _context.Usuarios.FirstOrDefault(a => a.id == idusuario);
            string consecutivousuario = objusuario.id.ToString().Trim() + "-" + objusuario.consecutivo.ToString().Trim();

            List<Movimientodeinventariostmp> list = _context.Movimientodeinventariostmp.Where(a => a.tipodedocumento == tipodedocumento && a.consecutivousuario == consecutivousuario).ToList();

            if (objtipodedocumento.pideconsecutivoautomatico != "S") return list;

            list.ForEach(c => { c.numerodeldocumento = objtipodedocumento.consecutivo + 1; });
            _context.SaveChanges();
            return list;
        }

        public string ValidarSaldo(int tipodedocumento, int idusuario)
        {
            // extraigo  el consecutivo que se asignara
            TiposDeDocumento? objtipodedocumento = new TiposDeDocumento();
            objtipodedocumento = _context.TiposDeDocumento.FirstOrDefault(a => a.id == tipodedocumento);

            var objusuario = _context.Usuarios.FirstOrDefault(a => a.id == idusuario);
            string consecutivousuario = objusuario.id.ToString().Trim() + "-" + objusuario.consecutivo.ToString().Trim();
            if (objtipodedocumento.sumainventario == "N" && objtipodedocumento.restainventario == "N") return "";

            List<Movimientodeinventariostmp> list = _context.Movimientodeinventariostmp.Where(a => a.tipodedocumento == tipodedocumento && a.consecutivousuario == consecutivousuario).ToList();

            string mensajedeerror = "";

            foreach (var obj in list)
            {
                Proveedores objproveedores = new Proveedores();
                objproveedores = _context.Proveedores.FirstOrDefault(a => a.id == obj.despacha);
                string cargainventariosdespacha = objproveedores.secargainventario;
                Productos objproducto = new Productos();
                objproducto = _context.Productos.FirstOrDefault(a => a.id == obj.producto);
                Saldos objsaldos = new Saldos();

                //-------------------------------------------------------------------
                // procesa despacha a restar inventario
                //------------------------------------------------------------------
                if (cargainventariosdespacha == "S")
                {
                    if (objproducto.secargalinventario == "S")
                    {
                        objsaldos = _context.Saldos.FirstOrDefault(a => a.producto == obj.producto && a.bodega == obj.despacha);

                        if (obj.cantidad > objsaldos.saldo)
                        {
                            Movimientodeinventariostmp objmovimiento = _context.Movimientodeinventariostmp.FirstOrDefault(a => a.id == obj.id);

                            objmovimiento.nombreproducto = objmovimiento.nombreproducto + "|Error, disponible:" + objsaldos.saldo.ToString() + "|";
                            _context.Movimientodeinventariostmp.Update(objmovimiento);
                            _context.SaveChanges();
                            mensajedeerror = "Error No hay saldo suficiente para despachar id=" + obj.id.ToString() + "\n";
                        }
                    }
                }
                //----------------------------------------------------------------------------------------------//
            }

            return mensajedeerror;
        }

        public void ActualizarInventario(Movimientodeinventariostmp obj)
        {
            // extraigo  el consecutivo que se asignara
            TiposDeDocumento? objtipodedocumento = new TiposDeDocumento();
            objtipodedocumento = _context.TiposDeDocumento.FirstOrDefault(a => a.id == obj.tipodedocumento);

            List<Movimientodeinventarios> list = _context.Movimientodeinventarios.Where(a => a.tipodedocumento == obj.tipodedocumento && a.numerodeldocumento == obj.numerodeldocumento && a.despacha == obj.despacha && a.recibe == obj.recibe).ToList();
            if (objtipodedocumento.sumainventario == "N" && objtipodedocumento.restainventario == "N") return;

            foreach (var obj_ in list)
            {
                // valoriza el registro de entrada
                Movimientodeinventarios? objmovimiento = _context.Movimientodeinventarios.FirstOrDefault(a => a.id == obj_.id);

                Proveedores objproveedores = new Proveedores();
                objproveedores = _context.Proveedores.FirstOrDefault(a => a.id == obj_.despacha);
                string cargainventariosdespacha = objproveedores.secargainventario;
                objproveedores = _context.Proveedores.FirstOrDefault(a => a.id == obj_.recibe);
                string cargainventariosrecibe = objproveedores.secargainventario;

                Productos objproducto = new Productos();
                objproducto = _context.Productos.FirstOrDefault(a => a.id == obj_.producto);

                if (objtipodedocumento.esunacompra == "S")
                {
                    objproducto.costoultimo = obj_.valorunitario;
                    _context.Productos.Update(objproducto);
                    _context.SaveChanges();
                }

                Saldos objsaldos = new Saldos();

                //-------------------------------------------------------------------
                // procesa despacha a restar inventario
                //------------------------------------------------------------------
                if (cargainventariosdespacha == "S")
                {
                    if (objproducto.secargalinventario == "S")
                    {
                        objsaldos = _context.Saldos.FirstOrDefault(a => a.producto == obj_.producto && a.bodega == obj_.despacha);

                        objsaldos.salidas = objsaldos.salidas + obj_.cantidad;
                        objsaldos.saldo = objsaldos.saldoinicial + objsaldos.entradas - objsaldos.salidas;

                        if (objtipodedocumento.esunaventa == "S")
                        {
                            objsaldos.fechadelaultimasalida = obj_.fechadecreacion;
                        }

                        _context.Saldos.Update(objsaldos);
                        _context.SaveChanges();

                        if ((objtipodedocumento.esunaventa != "S") && (objtipodedocumento.esunacompra != "S"))
                        {
                            // valoriza el registro de salida
                            objmovimiento.valorunitario = objsaldos.costopromedio;
                            objmovimiento.subtotal = objmovimiento.cantidad * objmovimiento.valorunitario;
                            objmovimiento.valorneto = objmovimiento.subtotal;
                        }
                        objmovimiento.costopromedioporunidad = objsaldos.costopromedio;
                        objmovimiento.costoultimoporunidad = objproducto.costoultimo;
                    }
                }
                //----------------------------------------------------------------------------------------------//

                //-------------------------------------------------------------------------------------------------
                // procesa recibe sumar inventario
                //-------------------------------------------------------------------------------------------------
                if (cargainventariosrecibe == "S")
                {
                    if (objproducto.secargalinventario == "S")
                    {
                        Saldos objverificarproductobodega = _context.Saldos.FirstOrDefault(a => a.producto == obj_.producto && a.bodega == obj_.recibe);
                        objsaldos = new Saldos();
                        if (objverificarproductobodega != null) objsaldos = objverificarproductobodega;

                        objsaldos.producto = obj_.producto;
                        objsaldos.bodega = obj_.recibe;

                        if (objtipodedocumento.esunacompra == "S")
                        {
                            objproducto.costoultimo = objmovimiento.valorunitario;
                            _context.Productos.Update(objproducto);
                            _context.SaveChanges();
                        }

                        if (objtipodedocumento.esuninventarioinicial == "S")
                        {
                            objsaldos.fechadelaultimasalida = obj_.fechadecreacion;
                            // valoriza el saldo inicial
                            objsaldos.costopromedio = objproducto.costoultimo;
                        }

                        if ((objtipodedocumento.esuninventarioinicial == "S") || (objtipodedocumento.pidefisico == "S"))
                        {
                            // valoriza el movimiento
                            objmovimiento.valorunitario = objsaldos.costopromedio;
                            objmovimiento.subtotal = objmovimiento.cantidad * objmovimiento.valorunitario;
                            objmovimiento.valorneto = objmovimiento.subtotal;
                            _context.Movimientodeinventarios.Update(objmovimiento);
                            _context.SaveChanges();
                        }

                        if (objtipodedocumento.pidefisico != "S")
                        {
                            if ((objsaldos.saldo + objmovimiento.cantidad) != 0)
                            {
                                objsaldos.costopromedio = ((objsaldos.saldo * objsaldos.costopromedio) + (objmovimiento.cantidad * objmovimiento.valorunitario)) / (objsaldos.saldo + objmovimiento.cantidad);
                            }
                            objsaldos.entradas = objsaldos.entradas + obj_.cantidad;
                            objsaldos.saldo = objsaldos.saldoinicial + objsaldos.entradas - objsaldos.salidas;
                        }
                        if (objtipodedocumento.pidefisico == "S")
                        {
                            objsaldos.saldofisico = objsaldos.saldofisico + obj_.cantidad;
                        }

                        if (objverificarproductobodega == null)
                        {
                            _context.Saldos.Add(objsaldos);
                            _context.SaveChanges();
                        }

                        if (objverificarproductobodega != null)
                        {
                            _context.Saldos.Update(objsaldos);
                            _context.SaveChanges();
                        }
                    }
                }

                // actualiza campos del registro de movimiento
                if (objtipodedocumento.sumainventario == "S") objmovimiento.sumaorestaeninventario = "+";
                if (objtipodedocumento.restarcartera == "S") objmovimiento.sumaorestaeninventario = "-";
                if (objtipodedocumento.sumarcartera == "S") objmovimiento.sumaorestaencartera = "+";
                if (objtipodedocumento.restarcartera == "S") objmovimiento.sumaorestaencartera = "-";

                objmovimiento.costopromedioporunidad = objsaldos.costopromedio;
                objmovimiento.costoultimoporunidad = objproducto.costoultimo;

                _context.Movimientodeinventarios.Update(objmovimiento);
                _context.SaveChanges();
            }
        }

        public void TotalizarDocumentoTemporal(int tipodedocumento, int idusuario)
        {
            TiposDeDocumento? objtipodedocumento = new TiposDeDocumento();
            objtipodedocumento = _context.TiposDeDocumento.FirstOrDefault(a => a.id == tipodedocumento);

            var objusuario = _context.Usuarios.FirstOrDefault(a => a.id == idusuario);

            string consecutivousuario = objusuario.id.ToString().Trim() + "-" + objusuario.consecutivo.ToString().Trim();
            List<Movimientodeinventariostmp> list = _context.Movimientodeinventariostmp.Where(a => a.tipodedocumento == tipodedocumento && a.consecutivousuario == consecutivousuario)
                .OrderBy(a => a.color)
                .OrderBy(a => a.talla)
                .OrderBy(a => a.producto).ToList();

            // si no es un pedido u orden de  compran no totalizo
            // recuerde que cada vez que despachamos un pedido o recibimos
            // mercancia de una orden de compra esos dos documentos no pueden
            // tener el producto repetido porque quedaria muy jodido
            // saldar las cantidad que queda por despachar o lo de la orden de
            // compra que falta por recibir.
            if (objtipodedocumento.saldarcantidadesdeldocumentollamado != "S")
            {
                return;
            }

            string llave1 = "xxxxxx";
            decimal totalcantidadporempaque = 0;
            decimal totalcantidad = 0;
            decimal totalsubtotal = 0;
            int totaldescuento = 0;
            int totaliva = 0;
            int totalfletes = 0;
            int totalretencion = 0;
            decimal totalneto = 0;

            string llave2 = "";

            int contador = -1;

            List<Movimientodeinventariostmp> listatotales = new List<Movimientodeinventariostmp>();

            Movimientodeinventarios objetofinal = new Movimientodeinventarios();

            foreach (var item in list)
            {
                contador = contador + 1;
                totalcantidadporempaque = totalcantidadporempaque + item.cantidadporempaque;
                totalcantidad = totalcantidad + item.cantidad;
                totalsubtotal = totalsubtotal + item.subtotal;
                totaldescuento = totaldescuento + item.valordescuento1;
                totaliva = totaliva + item.valoriva1;
                totalfletes = totalfletes + item.fletes;
                totalretencion = totalretencion + item.valorretencion1;

                llave1 = list[contador].producto.ToString() + "-" + list[contador].talla.ToString() + "-" + list[contador].color.ToString();

                if (contador <= list.Count)
                {
                    if (contador < list.Count - 1) llave2 = list[contador + 1].producto.ToString() + "-" + list[contador + 1].talla.ToString() + "-" + list[contador + 1].color.ToString();
                    if (contador == list.Count - 1) llave2 = "XXXXXX";

                    if (llave2 != llave1)
                    {
                        item.cantidadporempaque = totalcantidadporempaque;
                        item.numerodeempaques = Convert.ToInt32(totalcantidad / totalcantidadporempaque);
                        item.cantidad = totalcantidad;
                        item.subtotal = totalsubtotal;
                        item.valorunitario = totalsubtotal / totalcantidad;
                        item.valordescuento1 = totaldescuento;
                        if (totalsubtotal > 0) item.porcentajedescuento1 = totaldescuento / totalsubtotal * 100;
                        item.valoriva1 = Convert.ToInt32((totalsubtotal - totaldescuento + totalfletes) * (item.porcentajedeiva1 / 100));
                        item.valorretencion1 = totalretencion;
                        item.fletes = totalfletes;
                        item.valorneto = item.subtotal - item.valordescuento1 + item.valoriva1 + item.fletes;

                        listatotales.Add(item);

                        totalcantidadporempaque = 0;
                        totalcantidad = 0;
                        totalsubtotal = 0;
                        totaldescuento = 0;
                        totaliva = 0;
                        totalfletes = 0;
                        totalretencion = 0;
                    }
                }
            }

            foreach (var item in list)
            {
                var obj = _context.Movimientodeinventariostmp.FirstOrDefault(a => a.id == item.id);
                _context.Movimientodeinventariostmp.Remove(obj);
                _context.SaveChanges();
            }

            foreach (var obj in listatotales)
            {
                obj.id = 0;
                _context.Movimientodeinventariostmp.Add(obj);
                _context.SaveChanges();
            }
        }

        public void CargarMovimientoTemporalAlDefinitivo(int tipodedocumento, int idusuario)
        {
            var objusuario = _context.Usuarios.FirstOrDefault(a => a.id == idusuario);
            string consecutivousuario = objusuario.id.ToString().Trim() + "-" + objusuario.consecutivo.ToString().Trim();

            List<Movimientodeinventariostmp> list = _context.Movimientodeinventariostmp.Where(a => a.tipodedocumento == tipodedocumento && a.consecutivousuario == consecutivousuario).ToList();

            // cargamos documento temporal al movimiento de inventarios definitivo
            Movimientodeinventarios objetodestino = new Movimientodeinventarios();

            foreach (var item in list)
            {
                objetodestino = new Movimientodeinventarios();
                objetodestino = _mapping.MovimientoTMPToMovimiento(item);
                objetodestino.id = 0;
                _context.Movimientodeinventarios.Add(objetodestino);
                _context.SaveChanges();
            }

            // borramos los registros en el movimieno temporal
            BorrarLosRegistrosDelMovimientoTemporal(list[0].tipodedocumento, idusuario);
        }

        public int TraerConsecutivoDeLaTransaccion(int tipodedocumento)
        {
            // actualizamos consecutivo en tipos de documento
            TiposDeDocumento? objtipodedocumento = new TiposDeDocumento();
            objtipodedocumento = _context.TiposDeDocumento.FirstOrDefault(a => a.id == tipodedocumento);
            return objtipodedocumento.consecutivo;
        }

        public int ActualizarConsecutivoDeLaTransaccion(int tipodedocumento)
        {
            // actualizamos consecutivo en tipos de documento
            TiposDeDocumento? objtipodedocumento = new TiposDeDocumento();
            objtipodedocumento = _context.TiposDeDocumento.FirstOrDefault(a => a.id == tipodedocumento);
            objtipodedocumento.consecutivo = objtipodedocumento.consecutivo + 1;
            _context.SaveChanges();
            return objtipodedocumento.consecutivo;
        }

        public void ActualizarConsecutivoDelUsuario(int idusuario)
        {
            var objusuario = _context.Usuarios.FirstOrDefault(a => a.id == idusuario);
            objusuario.consecutivo = objusuario.consecutivo + 1;
            _context.SaveChanges();
        }

        public string TraerConsecutivoDelUsuario(int idusuario)
        {
            var objusuario = _context.Usuarios.FirstOrDefault(a => a.id == idusuario);
            string consecutivousuario = idusuario.ToString() + "-" + objusuario.consecutivo.ToString().Trim();
            return consecutivousuario;
        }

        public void AplicarDescuentoPieDeFactura(int tipodedocumento, decimal porcentajededescuento, int idusuario)
        {
            TiposDeDocumento? objtipodedocumento = new TiposDeDocumento();
            objtipodedocumento = _context.TiposDeDocumento.FirstOrDefault(a => a.id == tipodedocumento);

            if (objtipodedocumento.esunaventa == "S" || objtipodedocumento.esunacompra == "S")
            {
                var objusuario = _context.Usuarios.FirstOrDefault(a => a.id == idusuario);
                string consecutivousuario = objusuario.id.ToString().Trim() + "-" + objusuario.consecutivo.ToString().Trim();
                List<Movimientodeinventariostmp> list = _context.Movimientodeinventariostmp.Where(a => a.tipodedocumento == tipodedocumento && a.consecutivousuario == consecutivousuario).OrderBy(a => a.id).ToList();

                int cantidaddeelementosdelafactura = list.Count();

                decimal subtotal = list.Sum(a => a.subtotal);
                decimal valordescuentodelafactura = Convert.ToInt32(subtotal * (porcentajededescuento / 100));
                decimal valordescuentodecadaitem = valordescuentodelafactura / cantidaddeelementosdelafactura;
                decimal valordeajuste = valordescuentodelafactura - valordescuentodecadaitem * cantidaddeelementosdelafactura;

                int contador = 0;
                foreach (var item in list)
                {
                    contador = contador + 1;
                    // consulta cada item de cada documento para actulizarlo en la base de datos
                    Movimientodeinventariostmp obj_ = _context.Movimientodeinventariostmp.FirstOrDefault(a => a.id == item.id);

                    obj_.porcentajedescuento1 = 0;
                    obj_.valordescuento1 = 0;

                    if (contador == 1) obj_.valordescuento1 = Convert.ToInt32(obj_.valordescuento1 + (valordescuentodecadaitem + valordeajuste));
                    if (contador > 1) obj_.valordescuento1 = Convert.ToInt32(obj_.valordescuento1 + valordescuentodecadaitem);

                    obj_.porcentajedescuento1 = obj_.valordescuento1 / obj_.subtotal * 100;

                    //calcula iva
                    CalcularIva(obj_);

                    // aplicamos retencion solo a un registro osea en un registro guardamos el valor de la retencion
                    // no en todos

                    if (contador == 1)
                    {
                        // calcula retencion
                        CalcularRetencion(obj_);
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

            if (objtipodedocumento.esunaventa == "S" || objtipodedocumento.esunacompra == "S")
            {
                var objusuario = _context.Usuarios.FirstOrDefault(a => a.id == idusuario);
                string consecutivousuario = objusuario.id.ToString().Trim() + "-" + objusuario.consecutivo.ToString().Trim();
                List<Movimientodeinventariostmp> list = _context.Movimientodeinventariostmp.Where(a => a.tipodedocumento == tipodedocumento && a.consecutivousuario == consecutivousuario).OrderBy(a => a.id).ToList();

                int cantidaddeelementosdelafactura = list.Count();

                int valorfletedecadaitem = valorfletes / cantidaddeelementosdelafactura;
                int valordeajuste = valorfletes - valorfletedecadaitem * cantidaddeelementosdelafactura;

                int contador = 0;
                foreach (var item in list)
                {
                    contador = contador + 1;
                    // consulta cada item de cada documento para actulizarlo en la base de datos
                    Movimientodeinventariostmp obj_ = _context.Movimientodeinventariostmp.FirstOrDefault(a => a.id == item.id);

                    obj_.fletes = 0;

                    if (contador == 1) obj_.fletes = valorfletedecadaitem + valordeajuste;
                    if (contador > 1) obj_.fletes = valorfletedecadaitem;
                    if (obj_.cantidad > 0) obj_.costofleteporunidad = obj_.fletes / obj_.cantidad;

                    //calcula iva
                    CalcularIva(obj_);

                    // aplicamos retencion solo a un registro osea en un registro guardamos el valor de la retencion
                    // no en todos

                    if (contador == 1)
                    {
                        // calcula retencion
                        CalcularRetencion(obj_);
                    }

                    obj_.valorneto = obj_.subtotal - obj_.valordescuento1 + obj_.valoriva1 + obj_.fletes - obj_.valorretencion1;

                    _context.SaveChanges();
                }
            }
        }

        public string ValidarAntesDeCargarAlMovimiento(int tipodedocumento, int idusuario)
        {
            var objusuario = _context.Usuarios.FirstOrDefault(a => a.id == idusuario);
            string consecutivousuario = objusuario.id.ToString().Trim() + "-" + objusuario.consecutivo.ToString().Trim();

            //////////////////////////////////////
            /// valida detalle
            //////////////////////////////////////
            List<Movimientodeinventariostmp> list = _context.Movimientodeinventariostmp.Where(a => a.tipodedocumento == tipodedocumento && a.consecutivousuario == consecutivousuario).ToList();
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

        public void ProcesarLosCamposNumericosDeCadaFila(Movimientodeinventariostmp obj)
        {
            string consecutivousuario = TraerConsecutivoDelUsuario(obj.idusuario);

            List<Movimientodeinventariostmp> list = _context.Movimientodeinventariostmp.Where(a => a.tipodedocumento == obj.tipodedocumento && a.idusuario == obj.idusuario).OrderBy(a => a.id).ToList();

            int contador = 0;

            foreach (var item in list)
            {
                // consulta cada item de cada documento para actulizarlo en la base de datos
                Movimientodeinventariostmp obj_ = _context.Movimientodeinventariostmp.FirstOrDefault(a => a.id == item.id);

                obj_.despacha = obj.despacha;
                obj_.recibe = obj.recibe;
                obj_.fechadeldocumento = obj.fechadeldocumento;
                obj_.plazo = obj.plazo;
                obj_.fechadevencimientodeldocumento = obj.fechadevencimientodeldocumento;
                obj_.vendedor = obj.vendedor;
                obj_.programa = obj.programa;
                obj_.consecutivousuario = consecutivousuario;

                contador = contador + 1;
                ColocarDescripcionALasEntidades(obj_);

                // calcula iva
                CalcularIva(obj_);

                // aplicamos retencion solo a un registro osea en un registro guardamos el valor de la retencion, no en todos
                if (contador == 1) CalcularRetencion(obj_);

                obj_.valorneto = obj_.subtotal - obj_.valordescuento1 + obj_.valoriva1 + obj_.fletes - obj_.valorretencion1;

                _context.SaveChanges();
            }
        }

        public List<string> BorrarLosRegistrosDelMovimientoTemporal(int tipodedocumento, int idusuario)
        {
            List<Movimientodeinventariostmp> listatemporal = _context.Movimientodeinventariostmp.Where(a => a.tipodedocumento == tipodedocumento && a.consecutivousuario == TraerConsecutivoDelUsuario(idusuario)).ToList();

            string mensaje = "No hay registros temporales para borrar";
            foreach (var s in listatemporal)
            {
                var obj = _context.Movimientodeinventariostmp.FirstOrDefault(a => a.id == s.id);
                _context.Movimientodeinventariostmp.Remove(obj);
                _context.SaveChanges();
                mensaje = "Registro temporales borrados exitosamente";
            }

            return new List<string> { mensaje };
        }

        public void Log(Movimientodeinventariostmp obj, string operacion)
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