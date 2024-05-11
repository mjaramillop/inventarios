using Inventarios.Models.CapturaDeMovimiento;
using Inventarios.services.CapturaDeMovimiento;
using Inventarios.Token;
using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.CapturaDeMovimiento
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class MovimientodeinventariosController : ControllerBase
    {
        private readonly MovimientodeinventariosService _service;
        private readonly JwtService _jwtservice;
        private List<Movimientodeinventarios>? list;

        public MovimientodeinventariosController(MovimientodeinventariosService service, JwtService jwtservice)
        {
            _service = service;
            _jwtservice = jwtservice;
        }

        [HttpPost]
        [ActionName("Add")]
        public List<Movimientodeinventarios>? Add(Movimientodeinventarios obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}")]
        [ActionName("Delete")]
        public List<string>? Delete(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            List<string>? list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public List<string>? Update(Movimientodeinventarios obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            List<string>? list = _service.Update(obj);
            return list;
        }

        [HttpGet("{tipodedocumento}/{numerodedocumento}/{despacha}/{recibe}")]
        [ActionName("GetByNumeroDeDocumento")]
        public List<Movimientodeinventarios>? GetByNumeroDeDocumento(int tipodedocumento, int numerodedocumento, int despacha, int recibe)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.GetByNumeroDeDocumento(tipodedocumento, numerodedocumento, despacha, recibe);
            return list;
        }




        [HttpGet("{tipodedocumento}/{numerodedocumento}/{despacha}/{recibe}")]
        [ActionName("AnularDocumento")]

        public List<string> AnularDocumento(int tipodedocumento, int numerodedocumento, int despacha, int recibe)
        {
            List<string> list = _service.AnularDocumento(tipodedocumento, numerodedocumento, despacha, recibe);

            return list;
        }


        [HttpGet("{tipodedocumento}")]
        [ActionName("AddDocument")]

        public List<string> AddDocument(int tipodedocumento)
        {
            List<string> list = _service.AddDocument(tipodedocumento);
            return list;
        }



        [HttpGet("{tipodedocumento}")]
        [ActionName("TraerTipoDeDocumentoTemporal")]
        public List<Movimientodeinventarios> TraerDocumentoTemporal(int tipodedocumento)
        {
            list = _service.TraerDocumentoTemporal(tipodedocumento);
            return list;
        }




    }
}