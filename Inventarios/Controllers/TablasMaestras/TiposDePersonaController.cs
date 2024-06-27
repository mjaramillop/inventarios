using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;
using Inventarios.services.TablasMaestras;
using Inventarios.Utils;
using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.TablasMaestras
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class TiposDePersonaController : ControllerBase
    {
        private readonly TiposDePersonaService _service;
        private Validaciones _validaciones;

        private List<TiposDePersonaDTO>? list;

        public TiposDePersonaController(TiposDePersonaService service,Validaciones validaciones)
        {
            _service = service;
            _validaciones = validaciones;
        }

        [HttpPost]
        [ActionName("Add")]
        public Mensaje Add(TiposDePersona obj, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            Mensaje list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}")]
        [ActionName("Delete")]
        public Mensaje Delete(string id, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            Mensaje list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public Mensaje Update(TiposDePersona obj, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            Mensaje list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<TiposDePersona>? GetById(string id, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            List<TiposDePersona> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}")]
        [ActionName("GetAll")]
        public List<TiposDePersonaDTO>? GetAll(string filtro, int idusuario, string token   )
        {

            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            list = _service.List(filtro);
            return list;
        }
    }
}