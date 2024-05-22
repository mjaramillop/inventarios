using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;
using Inventarios.services.TablasMaestras;

using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.TablasMaestras
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class SiNoController : ControllerBase
    {
        private readonly SiNoService _service;
        
        private List<SiNoDTO>? list;

        public SiNoController(SiNoService service)
        {
            _service = service;
            
        }

        [HttpPost]
        [ActionName("Add")]
        public List<SiNoDTO>? Add(SiNo obj)
        {
            
            list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}")]
        [ActionName("Delete")]
        public List<SiNoDTO>? Delete(string id)
        {
            

            list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public List<SiNoDTO>? Update(SiNo obj)
        {
            

            list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<SiNo>? GetById(string id)
        {
            
            List<SiNo> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}")]
        [ActionName("GetAll")]
        public List<SiNoDTO>? GetAll(string filtro = "")
        {
            if (filtro == "undefined") filtro = "";
            
            list = _service.List(filtro);
            return list;
        }
    }
}