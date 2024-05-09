using Inventarios.services.Utils;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.Utils
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class ValidacionesController : ControllerBase
    {
        private readonly ValidacionesService _service;

        public ValidacionesController(ValidacionesService service)
        {
            _service = service;
        }

        [HttpGet("{campo}/{valor}")]
        [ActionName("Validarvalormayorquecero")]
        public List<string> Validarvalormayorquecero(string campo, int? valor)
        {
            return new List<string> { _service.Validarvalormayorquecero(campo, valor) };
        }

        [HttpGet("{campo}/{valor}")]
        [ActionName("Validarvalordiferentedecero")]
        public List<string> Validarvalordiferentedecero(string campo, int? valor)
        {
              return new List<string> { _service.Validarvalordiferentedecero(campo, valor) };
        }

        [HttpGet("{campo}/{valor}")]
        [ActionName("Validarvalormenorquecero")]
        public List<string> Validarvalormenorquecero(string campo, int? valor)
        {
              return new List<string> { _service.Validarvalormenorquecero(campo, valor) };
        }

        [HttpGet("{tipodedocumento}")]
        [ActionName("ValidarTipoDeDocumento")]
        public List<string> ValidarTipoDeDocumento(int tipodedocumento)
        {
              return new List<string> { _service.ValidarTipoDeDocumento(tipodedocumento) };
        }

        [HttpGet("{despacha}")]
        [ActionName("ValidarDespacha")]
        public List<string> ValidarDespacha(int despacha)
        {
              return new List<string> { _service.ValidarDespacha(despacha) };
        }

        [HttpGet("{recibe}")]
        [ActionName("ValidarRecibe")]
        public List<string> ValidarRecibe(int recibe)
        {
              return new List<string> { _service.ValidarRecibe(recibe) };
        }

        [HttpGet("{tipodedocumentoaafectar}")]
        [ActionName("tipodedocumentoaafectar")]
        public List<string> ValidarTipoDeDocumentoaAfectar(int tipodedocumentoaafectar)
        {
              return new List<string> { _service.ValidarTipoDeDocumentoaAfectar(tipodedocumentoaafectar) };
        }

        [HttpGet("{despachaaafectar}")]
        [ActionName("ValidarDespachaaAfectar")]
        public List<string> ValidarDespachaaAfectar(int despachaaafectar)
        {
              return new List<string> { _service.ValidarDespachaaAfectar(despachaaafectar) };
        }

        [HttpGet("{recibeaafectar}")]
        [ActionName("ValidarRecibeaAfectar")]
        public List<string> ValidarRecibeaAfectar(int recibeaafectar)
        {
              return new List<string> { _service.ValidarRecibeaAfectar(recibeaafectar) };
        }

        [HttpGet("{programa}")]
        [ActionName("ValidarPrograma")]
        public List<string> ValidarPrograma(int programa)
        {
              return new List<string> { _service.ValidarPrograma(programa) };
        }

        [HttpGet("{vendedor}")]
        [ActionName("ValidarVendedor")]
        public List<string> ValidarVendedor(int vendedor)
        {
              return new List<string> { _service.ValidarVendedor(vendedor) };
        }

        [HttpGet("{formadepago}")]
        [ActionName("ValidarFormaDePago")]
        public List<string> ValidarFormaDePago(int formadepago)
        {
              return new List<string> { _service.ValidarFormaDePago(formadepago) };
        }

        [HttpGet("{codigoconceptonotadebitocredito}")]
        [ActionName("ValidarConceptoNotaDebitoCredito")]
        public List<string> ValidarConceptoNotaDebitoCredito(int codigoconceptonotadebitocredito)
        {
              return new List<string> { _service.ValidarConceptoNotaDebitoCredito(codigoconceptonotadebitocredito) };
        }


        [HttpGet("{banco}")]
        [ActionName("ValidarBanco")]
        public List<string> ValidarBanco(int banco)
        {
              return new List<string> { _service.ValidarBanco(banco) };
        }

        [HttpGet("{producto}")]
        [ActionName("ValidarProducto")]
        public List<string> ValidarProducto(int producto)
        {
              return new List<string> { _service.ValidarProducto(producto) };
        }


        [HttpGet("{unidaddemedida}")]
        [ActionName("ValidarUnidadDeMedida")]

        public List<string> ValidarUnidadDeMedida(int unidaddemedida)
        {
              return new List<string> { _service.ValidarUnidadDeMedida(unidaddemedida) };
        }


        [HttpGet("{talla}")]
        [ActionName("ValidarTalla")]

        public List<string> ValidarTalla(int talla)
        {
              return new List<string> { _service.ValidarTalla(talla) };
        }


        [HttpGet("{color}")]
        [ActionName("ValidarColor")]
        public List<string> ValidarColor(int color)
        {
              return new List<string> { _service.ValidarColor(color) };
        }



        [HttpGet("{unidaddeempaque}")]
        [ActionName("ValidarUnidadDeEmpaque")]
        public List<string> ValidarUnidadDeEmpaque(int unidaddeempaque)
        {
              return new List<string> { _service.ValidarUnidadDeEmpaque(unidaddeempaque) };
        }

        [HttpGet("{perfil}")]
        [ActionName("ValidarPerfilDeUsuario")]
        public List<string> ValidarPerfilDeUsuario(int perfil)
        {
              return new List<string> { _service.ValidarPerfilDeUsuario(perfil) };
        }


        [HttpGet("{usuario}")]
        [ActionName("ValidarUsuario")]
        public List<string> ValidarUsuario(int usuario)
        {
              return new List<string> { _service.ValidarUsuario(usuario) };
        }





        [HttpGet("{tipodeagente}")]
        [ActionName("ValidarTipoDeagente")]
        public List<string> ValidarTipoDeAgente(int tipodeagente)
        {
            return new List<string> { _service.ValidarTipoDeAgente(tipodeagente) };
        }




        [HttpGet("{tipodecuentabancaria}")]
        [ActionName("ValidarTipoDeCuentaBancaria")]
        public List<string> ValidarTipoDeDuentaBancaria(int tipodecuentabancaria)
        {
            return new List<string> { _service.ValidarTipoDeCuentaBancaria(tipodecuentabancaria) };

        }




        [HttpGet("{tipodepersona}")]
        [ActionName("ValidarTipoDePerona")]

        public List<string> ValidarTipoDePersona(string tipodepersona)
        {
            return new List<string> { _service.ValidarTipoDePersona(tipodepersona) };
        }



        [HttpGet("{tipoderegimen}")]
        [ActionName("ValidarTipoDeRegimen")]

        public List<string> ValidarTipoDeRegimen(int tipoderegimen)
        {
            return new List<string> { _service.ValidarTipoDeRegimen(tipoderegimen) };
        }









    }
}