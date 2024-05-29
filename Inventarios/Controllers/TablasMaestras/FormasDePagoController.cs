using Inventarios.DTO;
using Inventarios.Models.TablasMaestras;
using Inventarios.services.TablasMaestras;

using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.TablasMaestras
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class FormasDePagoController : ControllerBase
    {
        private readonly FormasDePagoService _service;

        private List<FormasDePagoDTO>? list;

        public FormasDePagoController(FormasDePagoService service)
        {
            _service = service;
        }

        [HttpPost]
        [ActionName("Add")]
        public List<FormasDePagoDTO>? Add(FormasDePago obj)
        {
            list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}")]
        [ActionName("Delete")]
        public List<FormasDePagoDTO>? Delete(int id)
        {
            list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public List<FormasDePagoDTO>? Update(FormasDePago obj)
        {
            list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<FormasDePago>? GetById(int id)
        {
            List<FormasDePago> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}")]
        [ActionName("GetAll")]
        public List<FormasDePagoDTO>? GetAll(string filtro = "")
        {
            if (filtro == "undefined") filtro = "";

            list = _service.List(filtro);
            return list;
        }
    }
}