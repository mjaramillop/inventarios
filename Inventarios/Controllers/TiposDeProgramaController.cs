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
    public class TiposDeProgramaController : ControllerBase
    {


        private readonly TiposDeProgramaService _service;
        private readonly JwtService _jwtservice;
        private List<TiposDeProgramaDTO>? list;

        public TiposDeProgramaController(TiposDeProgramaService service, JwtService jwtservice)
        {
            _service = service;
            _jwtservice = jwtservice;
        }

        [HttpPost]
        [ActionName("Add")]
        public List<TiposDeProgramaDTO>? Add(TiposDePrograma obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}")]
        [ActionName("Delete")]
        public List<TiposDeProgramaDTO>? Delete(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public List<TiposDeProgramaDTO>? Update(TiposDePrograma obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<TiposDePrograma>? GetById(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            List<TiposDePrograma> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}")]

        [ActionName("GetAll")]
        public List<TiposDeProgramaDTO>? GetAll(string filtro = "")
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.List(filtro);
            return list;
        }


        [HttpGet("{filtro}")]

        [ActionName("GetAllActive")]
        public List<TiposDeProgramaDTO>? GetAllActive(string filtro = "")
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.ListActive(filtro);
            return list;
        }



    }
}
