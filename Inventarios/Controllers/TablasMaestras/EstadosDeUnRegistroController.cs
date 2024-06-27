using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;
using Inventarios.services.TablasMaestras;
using Inventarios.Utils;
using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.TablasMaestras
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class EstadosDeUnRegistroController : ControllerBase
    {
        private readonly EstadosDeUnRegistroService _service;
        private Validaciones _validaciones;

        private List<EstadosDeUnRegistroDTO>? list;

        public EstadosDeUnRegistroController(EstadosDeUnRegistroService service, Validaciones validaciones)
        {
            _service = service;
            _validaciones = validaciones;
        }

        [HttpPost]
        [ActionName("Add")]
        public Mensaje Add(EstadosDeUnRegistro obj, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return new Mensaje();
            Mensaje list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}/{idusuario}/{token}")]
        [ActionName("Delete")]
        public Mensaje Delete(int id, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return new Mensaje();
            Mensaje list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public Mensaje Update(EstadosDeUnRegistro obj, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return new Mensaje();
            Mensaje list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}/{idusuario}/{token}")]
        [ActionName("GetById")]
        public List<EstadosDeUnRegistro>? GetById(int id, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            List<EstadosDeUnRegistro> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}/{idusuario}/{token}")]
        [ActionName("GetAll")]
        public List<EstadosDeUnRegistroDTO>? GetAll(string filtro, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
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