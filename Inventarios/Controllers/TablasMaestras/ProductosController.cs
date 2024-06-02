using Inventarios.DTO;
using Inventarios.Models.TablasMaestras;
using Inventarios.ModelsParameter;
using Inventarios.ModelsParameter.TablasMaestras;
using Inventarios.services.TablasMaestras;

using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.TablasMaestras
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class ProductosController : ControllerBase
    {
        private readonly ProductosService _service;

        private List<ProductosDTO>? list;

        public ProductosController(ProductosService service)
        {
            _service = service;
        }

        [HttpPost]
        [ActionName("Add")]
        public Mensaje Add(Productos obj)
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
        public Mensaje Update(Productos obj)
        {
            Mensaje list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<ProductosDTO>? GetById(int id)
        {
            list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}")]
        [ActionName("GetAll")]
        public List<ProductosDTO>? GetAll(string filtro = "")
        {
            if (filtro == "undefined") filtro = "";

            list = _service.List(filtro);
            return list;
        }

        [HttpGet("{nivel}")]
        [ActionName("GetNivel")]
        public List<string>? GetNivel(int nivel)
        {
            List<string> list = _service.GetNivel(nivel);
            return list;
        }

        [HttpPut]
        [ActionName("UpdateNiveles")]
        public List<string>? UpdateNiveles(UpdateNiveles obj)
        {
            return _service.UpdateNiveles(obj);
        }

        [HttpPut]
        [ActionName("CambiarPrecios")]
        public List<string>? CambiarPrecios(CambiarPrecios obj)
        {
            return _service.CambiarPrecios(obj);
        }
    }
}