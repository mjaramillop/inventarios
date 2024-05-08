using Inventarios.DataAccess.Utils;
using Inventarios.Models.Seguridad;
using Inventarios.Models.TablasMaestras;
using Microsoft.EntityFrameworkCore;

namespace Inventarios.services.Utils
{

 

    public class ValidacionesService
    {

        private ValidacionesAccess? _access;


        public ValidacionesService(ValidacionesAccess validaciones   ) { 
        
            _access = validaciones;
        
        }


        public string Validarvalormayorquecero(string campo, int? valor)
        {

            return _access.Validarvalormayorquecero(campo,valor);
         
        }

        public string Validarvalordiferentedecero(string campo, int? valor)
        {

            return _access.Validarvalordiferentedecero(campo, valor);

        }

        public string Validarvalormenorquecero(string campo, int? valor)
        {
            return _access.Validarvalormenorquecero(campo, valor);

        }


      
        public string ValidarTipoDeDocumento(int tipodedocumento)
        {

            return _access.ValidarTipoDeDocumento(tipodedocumento);


        }

        public string ValidarDespacha(int despacha)
        {
            return _access.ValidarDespacha(despacha);


        }


        public string ValidarRecibe(int recibe)
        {
            return _access.ValidarRecibe(recibe);


        }

        public string ValidarTipoDeDocumentoaAfectar(int tipodedocumentoaafectar)
        {
            return _access.ValidarTipoDeDocumentoaAfectar(tipodedocumentoaafectar);

        }

        public string ValidarDespachaaAfectar(int despachaaafectar)
        {
            return _access.ValidarDespachaaAfectar(despachaaafectar);

        }

        public string ValidarRecibeaAfectar(int recibeaafectar)
        {
            return _access.ValidarRecibeaAfectar(recibeaafectar);

        }

        public string ValidarPrograma(int programa)
        {
            return _access.ValidarPrograma(programa);

        }

        public string ValidarVendedor(int vendedor)
        {
            return _access.ValidarVendedor(vendedor);


        }



        public string ValidarFormaDePago(int formadepago)
        {
            return _access.ValidarFormaDePago(formadepago);

        }


        public string ValidarConceptoNotaDebitoCredito(int codigoconceptonotadebitocredito)
        {
            return _access.ValidarConceptoNotaDebitoCredito(codigoconceptonotadebitocredito);


        }


        public string ValidarBanco(int banco)
        {
            return _access.ValidarBanco(banco);

        }

        public string ValidarProducto(int producto)
        {

            return _access.ValidarProducto(producto);


        }


        public string ValidarUnidadDeMedida(int unidaddemedida)
        {

            return _access.ValidarUnidadDeMedida(unidaddemedida);


        }


        public string ValidarTalla(int talla)
        {
            return _access.ValidarTalla(talla);


        }


        public string ValidarColor(int color)
        {
            return _access.ValidarColor(color);

        }


        public string ValidarUnidadDeEmpaque(int unidaddeempaque)
        {
            return _access.ValidarUnidadDeEmpaque( unidaddeempaque);

        }


        public string ValidarPerfilDeUsuario(int perfil)
        {
            return _access.ValidarPerfilDeUsuario(perfil);

        }



        public string ValidarUsuario(int usuario)
        {
            return _access.ValidarUsuario(usuario);

        }





    }
}
