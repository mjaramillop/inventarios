using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;
using Inventarios.services.TablasMaestras;

using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.TablasMaestras
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class UnidadesDeMedidaController : ControllerBase
    {
        private readonly UnidadesDeMedidaService _service;

        private List<UnidadesDeMedidaDTO>? list;

        public UnidadesDeMedidaController(UnidadesDeMedidaService service)
        {
            _service = service;
        }

        [HttpPost]
        [ActionName("Add")]
        public List<UnidadesDeMedidaDTO>? Add(UnidadesDeMedida obj)
        {
            list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}")]
        [ActionName("Delete")]
        public List<UnidadesDeMedidaDTO>? Delete(int id)
        {
            list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public List<UnidadesDeMedidaDTO>? Update(UnidadesDeMedida obj)
        {
            list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<UnidadesDeMedida>? GetById(int id)
        {
            List<UnidadesDeMedida> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}")]
        [ActionName("GetAll")]
        public List<UnidadesDeMedidaDTO>? GetAll(string filtro = "")
        {
            if (filtro == "undefined") filtro = "";

            list = _service.List(filtro);
            return list;
        }
    }
}