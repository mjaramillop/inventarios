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



    public class EstadosDeUnRegistroController : ControllerBase
    {


        private readonly EstadosDeUnRegistroService _service;
        private readonly JwtService _jwtservice;
        private List<EstadosDeUnRegistroDTO>? list;

        public EstadosDeUnRegistroController(EstadosDeUnRegistroService service, JwtService jwtservice)
        {
            _service = service;
            _jwtservice = jwtservice;
        }

        [HttpPost]
        [ActionName("Add")]
        public List<EstadosDeUnRegistroDTO>? Add(EstadosDeUnRegistro obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}")]
        [ActionName("Delete")]
        public List<EstadosDeUnRegistroDTO>? Delete(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public List<EstadosDeUnRegistroDTO>? Update(EstadosDeUnRegistro obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<EstadosDeUnRegistro>? GetById(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            List<EstadosDeUnRegistro> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}")]
        [ActionName("GetAll")]
        public List<EstadosDeUnRegistroDTO>? GetAll(string filtro = "")
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.List(filtro);
            return list;
        }


        [HttpGet]
        public ContentResult Index()
        {
            var html = "<p>Welcome to Code Maze</p>";
            return new ContentResult
            {
                Content = html,
                ContentType = "text/html"
            };
        }



    }




}