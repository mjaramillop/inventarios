using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;
using Inventarios.services.TablasMaestras;

using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.TablasMaestras
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class TiposDePersonaController : ControllerBase
    {
        private readonly TiposDePersonaService _service;

        private List<TiposDePersonaDTO>? list;

        public TiposDePersonaController(TiposDePersonaService service)
        {
            _service = service;
        }

        [HttpPost]
        [ActionName("Add")]
        public List<TiposDePersonaDTO>? Add(TiposDePersona obj)
        {
            list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}")]
        [ActionName("Delete")]
        public List<TiposDePersonaDTO>? Delete(string id)
        {
            list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public List<TiposDePersonaDTO>? Update(TiposDePersona obj)
        {
            list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<TiposDePersona>? GetById(string id)
        {
            List<TiposDePersona> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}")]
        [ActionName("GetAll")]
        public List<TiposDePersonaDTO>? GetAll(string filtro = "")
        {
            if (filtro == "undefined") filtro = "";

            list = _service.List(filtro);
            return list;
        }
    }
}