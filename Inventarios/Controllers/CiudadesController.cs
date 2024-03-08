using Inventarios.DTO;
using Inventarios.Models;
using Inventarios.ModelsParameter;
using Inventarios.services;
using Inventarios.Token;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers
{
    [Route("[controller]/[action]")]
    [ApiController]

    public class CiudadesController : ControllerBase
    {





        private readonly CiudadesService _service;
        private readonly JwtService _jwtservice;
        private List<CiudadesDTO>? list;

        public CiudadesController(CiudadesService service, JwtService jwtservice)
        {
            _service = service;
            _jwtservice = jwtservice;
        }

        [HttpPost]
        [ActionName("Add")]
        public List<CiudadesDTO>? Add(Ciudades obj)
        {
           if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}")]
        [ActionName("Delete")]
        public List<CiudadesDTO>? Delete(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public List<CiudadesDTO>? Update(Ciudades obj)
        {
           if (_jwtservice.UserAthenticated() == false) return null;

            list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<Ciudades>? GetById(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            List<Ciudades> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}")]
        [ActionName("GetAll")]
        public List<CiudadesDTO>? GetAll(string filtro = "")
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.List(filtro);
            return list;
        }

       

        [HttpPut]
        [ActionName("UpdateNiveles")]
        public List<CiudadesDTO>? UpdateNiveles(CiudadesUpdateNiveles obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            list = _service.UpdateNiveles(obj);
            return list;
        }


    }
}
