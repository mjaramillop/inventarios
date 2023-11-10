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

    public class PerfilesController : ControllerBase
    {





        private readonly PerfilesService _service;
        private readonly JwtService _jwtservice;
        private List<PerfilesDTO>? list;

        public PerfilesController(PerfilesService service, JwtService jwtservice)
        {
            _service = service;
            _jwtservice = jwtservice;
        }

        [HttpPost]
        [ActionName("Add")]
        public List<PerfilesDTO>? Add(Perfiles obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}")]
        [ActionName("Delete")]
        public List<PerfilesDTO>? Delete(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public List<PerfilesDTO>? Update(Perfiles obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<Perfiles>? GetById(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
           List<Perfiles> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}")]
        [ActionName("GetAll")]
        public List<PerfilesDTO>? GetAll(string filtro = "")
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.List(filtro);
            return list;
        }

        [HttpGet("{filtro}")]
        [ActionName("GetAllActive")]
        public List<PerfilesDTO>? GetAllActive(string filtro = "")
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.ListActive(filtro);
            return list;
        }


        [HttpGet("{id}")]
        [ActionName("GetListProgramasPermisos")]
        public List<ProgramasPermisosDTO>? GetListProgramasPermisos(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            List<ProgramasPermisosDTO>? list = _service.ListProgramasPermisos(id);
            return list;
        }



    }
}
