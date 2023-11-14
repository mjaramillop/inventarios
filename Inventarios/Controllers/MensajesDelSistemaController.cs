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

    public class MensajesDelSistemaController : ControllerBase
    {


        private readonly MensajesDelSistemaService _service;
        private readonly JwtService _jwtservice;
        private List<MensajesDelSistemaDTO>? list;

        public MensajesDelSistemaController(MensajesDelSistemaService service, JwtService jwtservice)
        {
            _service = service;
            _jwtservice = jwtservice;
        }

        [HttpPost]
        [ActionName("Add")]
        public List<MensajesDelSistemaDTO>? Add(Mensajesdelsistema obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}")]
        [ActionName("Delete")]
        public List<MensajesDelSistemaDTO>? Delete(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            list = _service.Delete(id);
            return list;
        }



        [HttpPut]
        [ActionName("Update")]
        public List<MensajesDelSistemaDTO>? Update(Mensajesdelsistema obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            list = _service.Update(obj);
            return list;
        }



        [HttpGet("{filtro}")]
        [ActionName("GetAll")]
        public List<MensajesDelSistemaDTO>? GetAll(string filtro)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.List(filtro);
            return list;
        }


        [HttpGet]
        [ActionName("GetAllActive")]
        public List<MensajesDelSistemaDTO>? GetAllActive()
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.ListActive();
            return list;
        }




    }

}
