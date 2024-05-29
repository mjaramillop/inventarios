using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;
using Inventarios.services.TablasMaestras;

using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.TablasMaestras
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class EstadosDeUnRegistroController : ControllerBase
    {
        private readonly EstadosDeUnRegistroService _service;

        private List<EstadosDeUnRegistroDTO>? list;

        public EstadosDeUnRegistroController(EstadosDeUnRegistroService service)
        {
            _service = service;
        }

        [HttpPost]
        [ActionName("Add")]
        public List<EstadosDeUnRegistroDTO>? Add(EstadosDeUnRegistro obj)
        {
            list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}")]
        [ActionName("Delete")]
        public List<EstadosDeUnRegistroDTO>? Delete(int id)
        {
            list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public List<EstadosDeUnRegistroDTO>? Update(EstadosDeUnRegistro obj)
        {
            list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<EstadosDeUnRegistro>? GetById(int id)
        {
            List<EstadosDeUnRegistro> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}")]
        [ActionName("GetAll")]
        public List<EstadosDeUnRegistroDTO>? GetAll(string filtro = "")
        {
            if (filtro == "undefined") filtro = "";

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