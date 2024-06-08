using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;
using Inventarios.ModelsParameter;
using Inventarios.services.TablasMaestras;

using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.TablasMaestras
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class ProveedoresController : ControllerBase
    {
        private readonly ProveedoresService _service;

        private List<ProveedoresDTO>? list;

        public ProveedoresController(ProveedoresService service)
        {
            _service = service;
        }

        [HttpPost]
        [ActionName("Add")]
        public Mensaje Add(Proveedores obj)
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
        public Mensaje Update(Proveedores obj)
        {
            Mensaje list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<Proveedores>? GetById(int id)
        {
            List<Proveedores> list = _service.GetById(id);
            return list;
        }


        [HttpGet("{id}")]
        [ActionName("GenerarClave")]
        public List<Mensaje> GenerarClave(int id)
        {
            List<Mensaje> list = _service.GenerarClave(id);
            return list;
        }


        [HttpGet("{nivel}")]
        [ActionName("GetNivel")]
        public List<string>? GetNivel(int nivel)
        {
            List<string> list = _service.GetNivel(nivel);
            return list;
        }


        [HttpGet("{filtro}")]
        [ActionName("GetAll")]
        public List<ProveedoresDTO>? GetAll(string filtro = "")
        {
            if (filtro == "undefined") filtro = "";

            list = _service.List(filtro);
            return list;
        }

        [HttpPut]
        [ActionName("UpdateNiveles")]
        public List<ProveedoresDTO>? UpdateNiveles(UpdateNiveles obj)
        {
            list = _service.UpdateNiveles(obj);
            return list;
        }
    }
}