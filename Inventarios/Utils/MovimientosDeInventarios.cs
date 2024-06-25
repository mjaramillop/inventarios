using Inventarios.Data;
using Inventarios.Map;
using Inventarios.Models.CapturaDeMovimiento;
using Inventarios.Models.TablasMaestras;
using Inventarios.ModelsParameter.CapturaDeMovimiento;

namespace Inventarios.Utils
{
    public class MovimientosDeInventarios
    {
        private readonly IConfiguration _iconfiguration;

        private readonly InventariosContext _context;
        private readonly Validaciones _validaciones;
        private readonly Mapping _mapping;

        public MovimientosDeInventarios(IConfiguration configutarion, InventariosContext context, Validaciones valiaciones, Mapping mapping)
        {
            _iconfiguration = configutarion;
            _context = context;
            _validaciones = valiaciones;
            _mapping = mapping;
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

        public Movimientodeinventariostmp ColocarDescripcionALasEntidades(Movimientodeinventariostmp obj, TiposDeDocumento objtipodedocumento)
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

        public void ActualizarInventario(CargueDeMovimiento obj)
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

                        if ( (objtipodedocumento.esuninventarioinicial == "S") || (objtipodedocumento.pidefisico=="S" ))
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
                        if (totalsubtotal>0)   item.porcentajedescuento1 = totaldescuento / totalsubtotal * 100;
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

        public void ProcesarLosCamposNumericosDeCadaFila(int tipodedocumento, string consecutivousuario)
        {
            TiposDeDocumento? objtipodedocumento = new TiposDeDocumento();
            objtipodedocumento = _context.TiposDeDocumento.FirstOrDefault(a => a.id == tipodedocumento);

            List<Movimientodeinventariostmp> list = _context.Movimientodeinventariostmp.Where(a => a.tipodedocumento == tipodedocumento && a.consecutivousuario == consecutivousuario).OrderBy(a => a.id).ToList();
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
                Movimientodeinventariostmp obj_ = _context.Movimientodeinventariostmp.FirstOrDefault(a => a.id == item.id);

                // aqui lo que estmoas haciendo es que el digitador puede grabar 4 registros y el sistema se cae
                // pero puede contineuar mas tarde y que pasa si de pronto le da una fecha de documento o vendedor o programa
                // o emisor o receptor diferente?puede quedar un mismo documento grabado con registros con fecha de documento diferente o
                // emisor o receptor o vendedor diferente, pára evitar eso le asignamos a todos los regisros el encabezado del ultimo registro que
                // grabe
                // siempre que agregue uno nuevo por seguridad hacemos este proceso

                obj_.despacha = despacha;
                obj_.recibe = recibe;
                obj_.fechadeldocumento = fechadeldocumento;
                obj_.plazo = plazo;
                obj_.fechadevencimientodeldocumento = fechadevencimientodeldocumento;
                obj_.vendedor = vendedor;
                obj_.programa = programa;

                contador = contador + 1;
                ColocarDescripcionALasEntidades(obj_, objtipodedocumento);

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
    }
}