using Inventarios.DTO;
using Inventarios.Models.TablasMaestras;
using Inventarios.services.TablasMaestras;

using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.TablasMaestras
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class RetencionesController : ControllerBase
    {
        private readonly RetencionesService _service;
        
        private List<RetencionesDTO>? list;

        public RetencionesController(RetencionesService service)
        {
            _service = service;
            
        }

        [HttpPost]
        [ActionName("Add")]
        public List<RetencionesDTO>? Add(Retenciones obj)
        {
            
            list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}")]
        [ActionName("Delete")]
        public List<RetencionesDTO>? Delete(int id)
        {
            

            list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public List<RetencionesDTO>? Update(Retenciones obj)
        {
            

            list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<Retenciones>? GetById(int id)
        {
            
            List<Retenciones> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}")]
        [ActionName("GetAll")]
        public List<RetencionesDTO>? GetAll(string filtro = "")
        {
            if (filtro == "undefined") filtro = "";

            
            list = _service.List(filtro);
            return list;
        }
    }
}