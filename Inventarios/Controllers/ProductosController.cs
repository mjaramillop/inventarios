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



    public class ProductosController : ControllerBase
    {


        private readonly ProductosService _service;
        private readonly JwtService _jwtservice;
        private List<ProductosDTO>? list;

        public ProductosController(ProductosService service, JwtService jwtservice)
        {
            _service = service;
            _jwtservice = jwtservice;
        }

        [HttpPost]
        [ActionName("Add")]
        public List<ProductosDTO>? Add(Productos obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}")]
        [ActionName("Delete")]
        public List<ProductosDTO>? Delete(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public List<ProductosDTO>? Update(Productos obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<Productos>? GetById(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            List<Productos> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}")]
        [ActionName("GetAll")]
        public List<ProductosDTO>? GetAll(string filtro = "")
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.List(filtro);
            return list;
        }




        [HttpGet("{nivel}")]
        [ActionName("GetNivel")]
        public List<CodigoNombre>? GetNivel(int nivel)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            List<CodigoNombre> list = _service.GetNivel(nivel);
            return list;
        }



        [HttpPut]
        [ActionName("UpdateNiveles")]
        public List<string>? UpdateNiveles(UpdateNiveles obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;


            return _service.UpdateNiveles(obj);
        }



        [HttpPut]
        [ActionName("CambiarPrecios")]
        public List<string>? CambiarPrecios( CambiarPrecios obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;


            return _service.CambiarPrecios(obj);
        }




    }

}
