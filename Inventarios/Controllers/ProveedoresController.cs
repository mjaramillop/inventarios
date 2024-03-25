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
    public class ProveedoresController : ControllerBase
    {


        private readonly ProveedoresService _service;
        private readonly JwtService _jwtservice;
        private List<ProveedoresDTO>? list;

        public ProveedoresController(ProveedoresService service, JwtService jwtservice)
        {
            _service = service;
            _jwtservice = jwtservice;
        }

        [HttpPost]
        [ActionName("Add")]
        public List<ProveedoresDTO>? Add(Proveedores obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}")]
        [ActionName("Delete")]
        public List<ProveedoresDTO>? Delete(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public List<ProveedoresDTO>? Update(Proveedores obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<Proveedores>? GetById(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            List<Proveedores> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}")]
        [ActionName("GetAll")]
        public List<ProveedoresDTO>? GetAll(string filtro = "")
        {
          if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.List(filtro);
            return list;
        }



        [HttpPut]
        [ActionName("UpdateNiveles")]
        public List<ProveedoresDTO>? UpdateNiveles(UpdateNiveles obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            list = _service.UpdateNiveles(obj);
            return list;
        }




    }
}
