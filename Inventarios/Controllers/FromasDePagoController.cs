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
    public class FormasDePagoController : ControllerBase
    {


        private readonly FormasDePagoService _service;
        private readonly JwtService _jwtservice;
        private List<FormasDePagoDTO>? list;

        public FormasDePagoController(FormasDePagoService service, JwtService jwtservice)
        {
            _service = service;
            _jwtservice = jwtservice;
        }

        [HttpPost]
        [ActionName("Add")]
        public List<FormasDePagoDTO>? Add(FormasDePago obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}")]
        [ActionName("Delete")]
        public List<FormasDePagoDTO>? Delete(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public List<FormasDePagoDTO>? Update(FormasDePago obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<FormasDePago>? GetById(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            List<FormasDePago> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}")]

        [ActionName("GetAll")]
        public List<FormasDePagoDTO>? GetAll(string filtro = "")
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.List(filtro);
            return list;
        }


        [HttpGet("{filtro}")]

        [ActionName("GetAllActive")]
        public List<FormasDePagoDTO>? GetAllActive(string filtro = "")
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.ListActive(filtro);
            return list;
        }



    }

}
