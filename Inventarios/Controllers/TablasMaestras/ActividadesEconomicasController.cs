using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;
using Inventarios.services.TablasMaestras;

using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.TablasMaestras
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class ActividadesEconomicasController : ControllerBase
    {
        private readonly ActividadesEconomicasService _service;

        private List<ActividadesEconomicasDTO>? list;

        public ActividadesEconomicasController(ActividadesEconomicasService service)
        {
            _service = service;
        }

        [HttpPost]
        [ActionName("Add")]
        public Mensaje Add(ActividadesEconomicas obj)
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
        public Mensaje Update(ActividadesEconomicas obj)
        {
            Mensaje list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<ActividadesEconomicas>? GetById(int id)
        {
            List<ActividadesEconomicas> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}")]
        [ActionName("GetAll")]
        public List<ActividadesEconomicasDTO>? GetAll(string filtro = "")
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