using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.CapturaDeMovimiento;
using Inventarios.Models.TablasMaestras;
using Inventarios.services.CapturaDeMovimiento;
using Inventarios.services.TablasMaestras;
using Inventarios.Token;
using Microsoft.AspNetCore.Http;
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
        public List<string>? Add(Movimientodeinventarios obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            List<string>? list = _service.Add(obj);
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

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<Movimientodeinventarios>? GetByNumeroDeDocumento(int tipodedocumento, int numerodedocumento, int despacha, int recibe)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.GetByNumeroDeDocumento(tipodedocumento,numerodedocumento,despacha,recibe );
            return list;
        }



    }

}
