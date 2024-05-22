using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;
using Inventarios.services.TablasMaestras;

using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.TablasMaestras
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class TiposDeRegimenController : ControllerBase
    {
        private readonly TiposDeRegimenService _service;
        
        private List<TiposDeRegimenDTO>? list;

        public TiposDeRegimenController(TiposDeRegimenService service)
        {
            _service = service;
            
        }

        [HttpPost]
        [ActionName("Add")]
        public List<TiposDeRegimenDTO>? Add(TiposDeRegimen obj)
        {
            
            list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}")]
        [ActionName("Delete")]
        public List<TiposDeRegimenDTO>? Delete(int id)
        {
            

            list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public List<TiposDeRegimenDTO>? Update(TiposDeRegimen obj)
        {
            

            list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<TiposDeRegimen>? GetById(int id)
        {
            
            List<TiposDeRegimen> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}")]
        [ActionName("GetAll")]
        public List<TiposDeRegimenDTO>? GetAll(string filtro = "")
        {
            if (filtro == "undefined") filtro = "";

            
            list = _service.List(filtro);
            return list;
        }
    }
}