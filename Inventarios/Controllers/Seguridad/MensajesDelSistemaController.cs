using Inventarios.DTO.Seguridad;
using Inventarios.Models.Seguridad;
using Inventarios.Models.TablasMaestras;
using Inventarios.services.Seguridad;
using Inventarios.Utils;
using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.Seguridad
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class MensajesDelSistemaController : ControllerBase
    {
        private readonly MensajesDelSistemaService _service;
        private Validaciones _validaciones;

        private List<MensajesDelSistemaDTO>? list;

        public MensajesDelSistemaController(MensajesDelSistemaService service , Validaciones validaciones )
        {
            _service = service;
            _validaciones = validaciones;   
        }

        [HttpPost]
        [ActionName("Add")]
        public Mensaje Add(Mensajesdelsistema obj, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;

            Mensaje list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}/{idusuario}/{token}")]
        [ActionName("Delete")]
        public Mensaje Delete(int id, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;

            Mensaje list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public Mensaje Update(Mensajesdelsistema obj, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;

            Mensaje list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}/{idusuario}/{token}")]
        [ActionName("GetById")]
        public List<Mensajesdelsistema>? GetById(int id, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;

            List<Mensajesdelsistema> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}/{idusuario}/{token}")]
        [ActionName("GetAll")]
        public List<MensajesDelSistemaDTO>? GetAll(string filtro, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;

            list = _service.List(filtro);
            return list;
        }

        [HttpGet("{idusuario}/{token}")]
        [ActionName("GetAllActive")]
        public List<MensajesDelSistemaDTO>? GetAllActive(int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;

            list = _service.ListActive();
            return list;
        }
    }
}