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
    public class ConceptosNotaDebitoCreditoController : ControllerBase
    {


        private readonly ConceptosNotaDebitoCreditoService _service;
        private readonly JwtService _jwtservice;
        private List<ConceptosNotaDebitoCreditoDTO>? list;

        public ConceptosNotaDebitoCreditoController(ConceptosNotaDebitoCreditoService service, JwtService jwtservice)
        {
            _service = service;
            _jwtservice = jwtservice;
        }

        [HttpPost]
        [ActionName("Add")]
        public List<ConceptosNotaDebitoCreditoDTO>? Add(ConceptosNotaDebitoCredito obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}")]
        [ActionName("Delete")]
        public List<ConceptosNotaDebitoCreditoDTO>? Delete(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public List<ConceptosNotaDebitoCreditoDTO>? Update(ConceptosNotaDebitoCredito obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<ConceptosNotaDebitoCredito>? GetById(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            List<ConceptosNotaDebitoCredito> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}")]
      
        [ActionName("GetAll")]
        public List<ConceptosNotaDebitoCreditoDTO>? GetAll(string filtro = "")
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.List(filtro);
            return list;
        }


      



    }
}
