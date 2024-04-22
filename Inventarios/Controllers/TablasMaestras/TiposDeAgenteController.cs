using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;
using Inventarios.services.TablasMaestras;
using Inventarios.Token;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;


namespace Inventarios.Controllers.TablasMaestras
{
    [Route("[controller]/[action]")]
    [ApiController]



    public class TiposDeAgenteController : ControllerBase
    {


        private readonly TiposDeAgenteService _service;
        private readonly JwtService _jwtservice;
        private List<TiposDeAgenteDTO>? list;

        public TiposDeAgenteController(TiposDeAgenteService service, JwtService jwtservice)
        {
            _service = service;
            _jwtservice = jwtservice;
        }

        [HttpPost]
        [ActionName("Add")]
        public List<TiposDeAgenteDTO>? Add(TiposDeAgente obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}")]
        [ActionName("Delete")]
        public List<TiposDeAgenteDTO>? Delete(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public List<TiposDeAgenteDTO>? Update(TiposDeAgente obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<TiposDeAgente>? GetById(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            List<TiposDeAgente> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}")]
        [ActionName("GetAll")]
        public List<TiposDeAgenteDTO>? GetAll(string filtro = "")
        {
            if (filtro == "undefined") filtro = "";

            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.List(filtro);
            return list;
        }



    }




}
