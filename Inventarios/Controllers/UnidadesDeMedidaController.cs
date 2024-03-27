using Inventarios.DTO;
using Inventarios.Models;
using Inventarios.services;
using Inventarios.Token;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers
{


    [Route("[controller]/[action]")]
    [ApiController]



    public class UnidadesDeMedidaController : ControllerBase
    {


        private readonly UnidadesDeMedidaService _service;
        private readonly JwtService _jwtservice;
        private List<UnidadesDeMedidaDTO>? list;

        public UnidadesDeMedidaController(UnidadesDeMedidaService service, JwtService jwtservice)
        {
            _service = service;
            _jwtservice = jwtservice;
        }

        [HttpPost]
        [ActionName("Add")]
        public List<UnidadesDeMedidaDTO>? Add(UnidadesDeMedida obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}")]
        [ActionName("Delete")]
        public List<UnidadesDeMedidaDTO>? Delete(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public List<UnidadesDeMedidaDTO>? Update(UnidadesDeMedida obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<UnidadesDeMedida>? GetById(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            List<UnidadesDeMedida> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}")]
        [ActionName("GetAll")]
        public List<UnidadesDeMedidaDTO>? GetAll(string filtro = "")
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.List(filtro);
            return list;
        }






    }


}
