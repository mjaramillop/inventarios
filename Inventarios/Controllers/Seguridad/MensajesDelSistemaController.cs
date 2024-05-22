using Inventarios.DTO.Seguridad;
using Inventarios.Models.Seguridad;
using Inventarios.services.Seguridad;

using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.Seguridad
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class MensajesDelSistemaController : ControllerBase
    {
        private readonly MensajesDelSistemaService _service;
        
        private List<MensajesDelSistemaDTO>? list;

        public MensajesDelSistemaController(MensajesDelSistemaService service)
        {
            _service = service;
            
        }

        [HttpPost]
        [ActionName("Add")]
        public List<MensajesDelSistemaDTO> Add(Mensajesdelsistema obj)
        {
            
            list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}")]
        [ActionName("Delete")]
        public List<MensajesDelSistemaDTO>? Delete(int id)
        {
            

            list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public List<MensajesDelSistemaDTO>? Update(Mensajesdelsistema obj)
        {
            

            list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<Mensajesdelsistema>? GetById(int id)
        {
            
            List<Mensajesdelsistema> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro?}")]
        [ActionName("GetAll")]
        public List<MensajesDelSistemaDTO>? GetAll(string filtro = "")
        {
            
            list = _service.List(filtro);
            return list;
        }

        [HttpGet]
        [ActionName("GetAllActive")]
        public List<MensajesDelSistemaDTO>? GetAllActive()
        {
            
            list = _service.ListActive();
            return list;
        }
    }
}