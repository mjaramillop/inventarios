using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;
using Inventarios.services.TablasMaestras;

using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.TablasMaestras
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class TiposDeAgenteController : ControllerBase
    {
        private readonly TiposDeAgenteService _service;

        private List<TiposDeAgenteDTO>? list;

        public TiposDeAgenteController(TiposDeAgenteService service)
        {
            _service = service;
        }

        [HttpPost]
        [ActionName("Add")]
        public Mensaje Add(TiposDeAgente obj)
        {
            Mensaje list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}")]
        [ActionName("Delete")]
        public Mensaje Delete(int id)
        {
            Mensaje list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public Mensaje Update(TiposDeAgente obj)
        {
            Mensaje list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<TiposDeAgente>? GetById(int id)
        {
            List<TiposDeAgente> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}")]
        [ActionName("GetAll")]
        public List<TiposDeAgenteDTO>? GetAll(string filtro = "")
        {
            if (filtro == "undefined") filtro = "";

            list = _service.List(filtro);
            return list;
        }
    }
}