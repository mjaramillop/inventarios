using Inventarios.Data;
using Inventarios.Models.Seguridad;
using Inventarios.Models.TablasMaestras;

namespace Inventarios.Utils
{
    public class Validaciones
    {
        private readonly InventariosContext _context;

        public Validaciones(InventariosContext context)
        {
            _context = context;
        }

        public Validaciones()
        {
        }

        public string Validarvalor1menorquevalor2(string campo, decimal valor1, decimal valor2)
        {
            if (valor1>=valor2)
            {
                return "Error." + campo + " el primer valor debe ser menor al segundo valor ," + '\n';
            }
            return "";
        }





        public string Validarnombre(string campo, string valor)
        {
            if (valor.Trim().Length <= 0)
            {
                return "Error." + campo + " no puede ser vacio ," + '\n';
            }
            return "";
        }

        public string Validarvalormayorquecero(string campo, decimal valor)
        {
            if (valor <= 0)
            {
                return "Error." + campo + " no puede ser menor o igual a  cero ," + '\n';
            }
            return "";
        }

        public string Validarvalormayoroigualacero(string campo, decimal valor)
        {
            if (valor < 0)
            {
                return "Error." + campo + " no puede ser menor que cero ," + '\n';
            }
            return "";
        }

        public string Validarvalordiferentedecero(string campo, decimal valor)
        {
            if (valor == 0)
            {
                return "Error." + campo + " no puede ser  cero ," + '\n';
            }
            return "";
        }

        public string Validarvalormenorquecero(string campo, decimal valor)
        {
            if (valor < 0)
            {
                return "Error." + campo + " no puede ser  menor que cero ," + '\n';
            }
            return "";
        }


        /// <summary>
        /// la fecha1 debe ser menor que la fecha2
        /// </summary>
        /// <param name="fecha1"></param>
        /// <param name="fecha2"></param>
        /// <returns></returns>
        public string Validarfechaddesdemenofechahasta(string campo,DateTime fecha1 , DateTime fecha2)
        {
            if (fecha1>fecha2)
            {
                return "Error." + campo +  " no puede ser mayor que la 2a fecha ," + '\n';
            }
            return "";
        }



        // valida tipo de documento
        public string ValidarTipoDeDocumento(int tipodedocumento)
        {
            TiposDeDocumento? objtipodedocumento = new TiposDeDocumento();
            objtipodedocumento = _context.TiposDeDocumento.FirstOrDefault(a => a.id == tipodedocumento);
            if (objtipodedocumento == null)
            {
                return "Error. El tipo de documento esta errado , " + "\n";
            }

            return objtipodedocumento.nombre;
        }

        public string ValidarDespacha(int despacha)
        {
            // trae el nombre despacha
            Proveedores? objdespacha = new Proveedores();
            objdespacha = _context.Proveedores.FirstOrDefault(a => a.id == despacha);
            if (objdespacha == null)
            {
                return "Error. La entidad emisora esta errada ," + "\n";
            }

            return objdespacha.nombre;
        }

        public string ValidarRecibe(int recibe)
        {
            Proveedores? objrecibe = new Proveedores();
            objrecibe = _context.Proveedores.FirstOrDefault(a => a.id == recibe);
            if (objrecibe == null)
            {
                return "Error. La entidasd receptora esta errada ," + "\n";
                ;
            }
            return objrecibe.nombre;
        }

        public string ValidarTipoDeDocumentoaAfectar(int tipodedocumentoaafectar)
        {
            // tipodedocumento a afectar
            TiposDeDocumento? objtipodedocumentoaafectar = new TiposDeDocumento();
            objtipodedocumentoaafectar = _context.TiposDeDocumento.FirstOrDefault(a => a.id == tipodedocumentoaafectar);
            if (objtipodedocumentoaafectar == null)
            {
                return "Error. El tipo de documento a afectar esta errado ," + "\n";
            }

            return objtipodedocumentoaafectar.nombre;
        }

        public string ValidarDespachaaAfectar(int despachaaafectar)
        {
            // trae el nombre despacha a  afectar
            Proveedores? objdespachaaafectar = new Proveedores();
            objdespachaaafectar = _context.Proveedores.FirstOrDefault(a => a.id == despachaaafectar);
            if (objdespachaaafectar == null)
            {
                return "Error. El emisor a afectar esta errado ," + "\n";
            }
            return objdespachaaafectar.nombre;
        }

        public string ValidarRecibeaAfectar(int recibeaafectar)
        {
            // trae el nombre recibe a afectar
            Proveedores? objrecibeaafectar = new Proveedores();
            objrecibeaafectar = _context.Proveedores.FirstOrDefault(a => a.id == recibeaafectar);
            if (objrecibeaafectar == null)
            {
                return "Error. El receptor a afectar esta errado ," + "\n";
            }
            return objrecibeaafectar.nombre;
        }
        public string ValidarPrograma(int programa)
        {
            // programa
            Programas? objprogramas = new Programas();
            objprogramas = _context.Programas.FirstOrDefault(a => a.id == programa);
            if (objprogramas == null)
            {
                return "Error. El programa esta errado ," + "\n";
            }

            return objprogramas.nombre;
        }


        public string ValidarRetencion(int retencion)
        {
          
            Retenciones? objretenciones = new Retenciones();
            objretenciones = _context.Retenciones.FirstOrDefault(a => a.id == retencion);
            if (objretenciones == null)
            {
                return "Error. El codigo de retencion esta errado ," + "\n";
            }

            return objretenciones.nombre;
        }

        public string ValidarActividadComercial(int actividadcomercial)
        {
          

            ActividadesEconomicas? objactividadeseconomicas = new  ActividadesEconomicas();
            objactividadeseconomicas = _context.ActividadesEconomicas.FirstOrDefault(a => a.id == actividadcomercial);
            if (objactividadeseconomicas == null)
            {
                return "Error. El codigo de la actividad comercial  esta errada ," + "\n";
            }

            return objactividadeseconomicas.nombre;
        }


        public string ValidarVendedor(int vendedor)
        {
            // vendedor
            Proveedores? objvendedor = new Proveedores();
            objvendedor = _context.Proveedores.FirstOrDefault(a => a.id == vendedor);
            if (objvendedor == null)
            {
                return "Error. El vendedor esta errado ," + "\n";
            }

            return objvendedor.nombre;
        }

        public string ValidarFormaDePago(int formadepago)
        {
            // formas de pago
            FormasDePago? objformasdepago = new FormasDePago();
            objformasdepago = _context.FormasDePago.FirstOrDefault(a => a.id == formadepago);
            if (objformasdepago == null)
            {
                return "Error. El codigo de forma de pago es invalido ," + "\n";
            }

            return objformasdepago.nombre;
        }

        public string ValidarConceptoNotaDebitoCredito(int codigoconceptonotadebitocredito)
        {
            //  Concepto nota debito credito
            ConceptosNotaDebitoCredito? objconceptosnotadebitocredito = new ConceptosNotaDebitoCredito();
            objconceptosnotadebitocredito = _context.ConceptosNotaDebitoCredito.FirstOrDefault(a => a.id == codigoconceptonotadebitocredito);
            if (objconceptosnotadebitocredito == null)
            {
                return "Error. El codigo del concepto nota debito y credito es invalido  ," + "\n";
            }

            return objconceptosnotadebitocredito.nombre;
        }

        public string ValidarBanco(int banco)
        {
            //  Banco
            Proveedores? objbanco = new Proveedores();
            objbanco = _context.Proveedores.FirstOrDefault(a => a.id == banco);
            if (objbanco == null)
            {
                return "Error. El codigo del banco es invalido , " + "\n";
            }

            return objbanco.nombre;
        }

        public string ValidarProducto(int producto)
        {
            //  Producto
            Productos? objproducto = new Productos();
            objproducto = _context.Productos.FirstOrDefault(a => a.id == producto);
            if (objproducto == null)
            {
                return "Error. El codigo del producto es invalido , " + "\n";
            }

            return objproducto.nombre;
        }

        public string ValidarIva(int producto)
        {
            //  Producto
            Ivas? objiva = new Ivas();
            objiva = _context.Ivas.FirstOrDefault(a => a.id == producto);
            if (objiva == null)
            {
                return "Error. El codigo del iva es invalido , " + "\n";
            }

            return objiva.nombre;
        }

        public string ValidarUnidadDeMedida(int unidaddemedida)
        {
            //  Unidad de medida
            UnidadesDeMedida? objunidaddemedida = new UnidadesDeMedida();
            objunidaddemedida = _context.UnidadesDeMedida.FirstOrDefault(a => a.id == unidaddemedida);
            if (objunidaddemedida == null)
            {
                return "Error. El codigo de la unidad de medida es invalido ," + "\n";
            }

            return objunidaddemedida.nombre;
        }

        public string ValidarTalla(int talla)
        {
            //  Talla
            Tallas? objtallas = new Tallas();
            objtallas = _context.Tallas.FirstOrDefault(a => a.id == talla);
            if (objtallas == null)
            {
                return "Error. El codigo de la talla es invalido , " + "\n";
            }

            return objtallas.nombre;
        }

        public string ValidarColor(int color)
        {
            //  Colores
            Colores? objcolores = new Colores();
            objcolores = _context.Colores.FirstOrDefault(a => a.id == color);
            {
                if (objcolores == null) return "Error. El codigo del color es invalido, " + "\n";
            }
            return objcolores.nombre;
        }

        public string ValidarUnidadDeEmpaque(int unidaddeempaque)
        {
            //  Unidad de empaque
            UnidadesDeMedida? objunidaddeempaque = new UnidadesDeMedida();
            objunidaddeempaque = _context.UnidadesDeMedida.FirstOrDefault(a => a.id == unidaddeempaque);
            if (objunidaddeempaque == null)
            {
                return "Error. El codigo de la unidad de empaque  es invalido,  " + "\n";
            }

            return objunidaddeempaque.nombre;
        }

        public string ValidarPerfilDeUsuario(int perfil)
        {
            //  Perfil
            Perfiles? objperfiles = new Perfiles();
            objperfiles = _context.Perfiles.FirstOrDefault(a => a.id == perfil);
            if (objperfiles == null)
            {
                return "Error. El codigo del perfil de usuario es invalido , " + "\n";
            }

            return objperfiles.nombre;
        }

        public string ValidarUsuario(int usuario)
        {
            // Usuario
            Usuarios? objusuarios = new Usuarios();
            objusuarios = _context.Usuarios.FirstOrDefault(a => a.id == usuario);
            if (objusuarios == null)
            {
                return "Error. El codigo del usuario es invalido , " + "\n";
            }

            return objusuarios.nombre;
        }

        public string ValidarTipoDeAgente(int tipodeagente)
        {
            // tipo de agente
            TiposDeAgente? objtipodeagente = new TiposDeAgente();
            objtipodeagente = _context.TiposDeAgente.FirstOrDefault(a => a.id == tipodeagente);
            if (objtipodeagente == null)
            {
                return "Error. El codigo del tipo de agente es invalido , " + "\n";
            }

            return objtipodeagente.nombre;
        }

        public string ValidarTipoDeCuentaBancaria(int tipodecuentabancaria)
        {
            // tipo de agente
            TiposDeCuentaBancaria? objtipodecuentabancaria = new TiposDeCuentaBancaria();
            objtipodecuentabancaria = _context.TiposDeCuentaBancaria.FirstOrDefault(a => a.id == tipodecuentabancaria);
            if (objtipodecuentabancaria == null)
            {
                return "Error. El codigo del tipo de cuenta bancaria es invalido , " + "\n";
            }

            return objtipodecuentabancaria.nombre;
        }

        public string ValidarTipoDePersona(string tipodepersona)
        {
            // tipo de agente
            TiposDePersona? objtipodepersona = new TiposDePersona();
            objtipodepersona = _context.TiposDePersona.FirstOrDefault(a => a.id == tipodepersona);
            if (objtipodepersona == null)
            {
                return "Error. El codigo del tipo de persona es invalido , " + "\n";
            }

            return objtipodepersona.nombre;
        }

        public string ValidarTipoDeRegimen(int tipoderegimen)
        {
            // tipo de agente
            TiposDeRegimen? objtipoderegimen = new TiposDeRegimen();
            objtipoderegimen = _context.TiposDeRegimen.FirstOrDefault(a => a.id == tipoderegimen);
            if (objtipoderegimen == null)
            {
                return "Error. El codigo del tipo de regimen es invalido , " + "\n";
            }

            return objtipoderegimen.nombre;
        }

        public string ValidarEstadoDelRegistro(int estadodelregistro)
        {
            // tipo de agente
            EstadosDeUnRegistro? objestadodelregistro = new EstadosDeUnRegistro();
            objestadodelregistro = _context.EstadosDeUnRegistro.FirstOrDefault(a => a.id == estadodelregistro);
            if (objestadodelregistro == null)
            {
                return "Error. El codigo del estado del registro es invalido , " + "\n";
            }

            return objestadodelregistro.nombre;
        }
    }
}