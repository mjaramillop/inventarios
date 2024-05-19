using System.Drawing;
using Inventarios.Models.TablasMaestras;
using Inventarios.Data;
using Inventarios.DataAccess.Seguridad;
using Inventarios.Map;
using Inventarios.Token;
using Inventarios.Models.Seguridad;

namespace Inventarios.DataAccess.Utils
{
    public class Validaciones
    {
        private readonly InventariosContext _context;

        public Validaciones(InventariosContext context)
        {
            _context = context;
        }

        public string mensajedeerror { get; set; }

        public Validaciones()
        {
            this.mensajedeerror = "";
        }

        public string Validarvalormayorquecero(string campo, int? valor)
        {
            if (valor <= 0)
            {
                this.mensajedeerror = this.mensajedeerror + campo + "Error. no puede ser menor que cero " + '\n';
                return this.mensajedeerror; 
            }
            return "";
        }

        public string Validarvalordiferentedecero(string campo, int? valor)
        {
            if (valor == 0)
            {
                this.mensajedeerror = this.mensajedeerror + campo + "Error. no puede ser  cero " + '\n';
                return this.mensajedeerror;
                
            }
            return "";
        }

        public string Validarvalormenorquecero(string campo, int? valor)
        {
            if (valor < 0)
            {
                this.mensajedeerror = this.mensajedeerror + campo + "Error. no puede ser  menor que cero " + '\n';
                return this.mensajedeerror;
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
                mensajedeerror = mensajedeerror + "Error. El tipo de documento esta errado" + "\n";
                return mensajedeerror;
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
                mensajedeerror = mensajedeerror + "Error. La entidasd emisora esta errada" + "\n";
                return mensajedeerror;
            }

            return objdespacha.nombre;

        }


        public string ValidarRecibe(int recibe)
        {
            Proveedores? objrecibe = new Proveedores();
            objrecibe = _context.Proveedores.FirstOrDefault(a => a.id == recibe);
            if (objrecibe == null)
            {

                mensajedeerror = mensajedeerror + "Error. La entidasd receptora esta errada" + "\n";
                return mensajedeerror;
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
                mensajedeerror = mensajedeerror + "Error. El tipo de documento a afectar esta errado" + "\n";
                return mensajedeerror;
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
                mensajedeerror = mensajedeerror + "Error. El emisor a afectar esta errado" + "\n";
                return mensajedeerror;

            }
            return objdespachaaafectar.nombre;

        }

        public string  ValidarRecibeaAfectar(int recibeaafectar)
        {
            // trae el nombre recibe a afectar
            Proveedores? objrecibeaafectar = new Proveedores();
            objrecibeaafectar = _context.Proveedores.FirstOrDefault(a => a.id == recibeaafectar);
            if (objrecibeaafectar == null)
            {
                mensajedeerror = mensajedeerror + "Error. El receptor a afectar esta errado" + "\n";
                return mensajedeerror;

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
                mensajedeerror = mensajedeerror + "Error. El programa esta errado" + "\n";
                return mensajedeerror;
            }

            return objprogramas.nombre;
        }

        public string ValidarVendedor(int vendedor)
        {
            // vendedor
            Proveedores? objvendedor = new Proveedores();
            objvendedor = _context.Proveedores.FirstOrDefault(a => a.id == vendedor);
            if (objvendedor == null)
            {
                mensajedeerror = mensajedeerror + "Error. El vendedor esta errado" + "\n";
                return mensajedeerror;

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
                mensajedeerror = mensajedeerror + "Error. El codigo de forma de pago es invalido " + "\n";
                return mensajedeerror;
            }

            return objformasdepago.nombre;
        }


        public  string ValidarConceptoNotaDebitoCredito(int codigoconceptonotadebitocredito)
        {
            //  Concepto nota debito credito
            ConceptosNotaDebitoCredito? objconceptosnotadebitocredito = new ConceptosNotaDebitoCredito();
            objconceptosnotadebitocredito = _context.ConceptosNotaDebitoCredito.FirstOrDefault(a => a.id == codigoconceptonotadebitocredito);
            if (objconceptosnotadebitocredito == null)
            {
                mensajedeerror = mensajedeerror + "Error. El codigo del concepto nota debito y credito es invalido  " + "\n";
                return mensajedeerror;
            }

            return objconceptosnotadebitocredito.nombre;

        }


        public string ValidarBanco (int banco)
        {
            //  Banco
            Proveedores? objbanco = new Proveedores();
            objbanco = _context.Proveedores.FirstOrDefault(a => a.id == banco);
            if (objbanco == null)
            {

                mensajedeerror = mensajedeerror + "Error. El codigo del banco es invalido  " + "\n";
                return mensajedeerror;
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

                mensajedeerror = mensajedeerror + "Error. El codigo del producto es invalido  " + "\n";
                return mensajedeerror;
            }

            return objproducto.nombre;

        }


        public string ValidarUnidadDeMedida(int unidaddemedida)
        {

            //  Unidad de medida
            UnidadesDeMedida? objunidaddemedida = new UnidadesDeMedida();
            objunidaddemedida = _context.UnidadesDeMedida.FirstOrDefault(a => a.id == unidaddemedida);
            if (objunidaddemedida == null)
            {
                mensajedeerror = mensajedeerror + "Error. El codigo de la unidad de medida es invalido " + "\n";
                return mensajedeerror;
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
                mensajedeerror = mensajedeerror + "Error. El codigo de la talla es invalido  " + "\n";
                return mensajedeerror;
            }

            return objtallas.nombre;

        }


        public string ValidarColor(int color)
        {
            //  Colores
            Colores? objcolores = new Colores();
            objcolores = _context.Colores.FirstOrDefault(a => a.id == color);
            {
                if (objcolores == null) mensajedeerror = mensajedeerror + "Error. El codigo del color es invalido " + "\n";
                return mensajedeerror;
            }

        }


        public string ValidarUnidadDeEmpaque(int unidaddeempaque)
        {
            //  Unidad de empaque
            UnidadesDeMedida? objunidaddeempaque = new UnidadesDeMedida();
            objunidaddeempaque = _context.UnidadesDeMedida.FirstOrDefault(a => a.id == unidaddeempaque);
            if (objunidaddeempaque == null)
            {
                mensajedeerror = mensajedeerror + "Error. El codigo de la unidad de empaque  es invalido  " + "\n";
                return mensajedeerror;
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
                mensajedeerror = mensajedeerror + "Error. El codigo del perfil de usuario es invalido  " + "\n";
                return mensajedeerror;
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
                mensajedeerror = mensajedeerror + "Error. El codigo del usuario es invalido  " + "\n";
                return mensajedeerror;
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
                mensajedeerror = mensajedeerror + "Error. El codigo del tipo de agente es invalido  " + "\n";
                return mensajedeerror;
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
                mensajedeerror = mensajedeerror + "Error. El codigo del tipo de cuenta bancaria es invalido  " + "\n";
                return mensajedeerror;
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
                mensajedeerror = mensajedeerror + "Error. El codigo del tipo de persona es invalido  " + "\n";
                return mensajedeerror;
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
                mensajedeerror = mensajedeerror + "Error. El codigo del tipo de regimen es invalido  " + "\n";
                return mensajedeerror;
            }

            return objtipoderegimen.nombre;
        }






    }
}