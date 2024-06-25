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
    public class MenuController : ControllerBase
    {
        private readonly MenuService _service;
        private Validaciones _validaciones;

        private List<MenuDTO>? list;

        public MenuController(MenuService service , Validaciones validaciones)
        {
            _service = service;
            _validaciones = validaciones;
        }

        [HttpPost]
        [ActionName("Add")]
        public Mensaje Add(Menu obj, int idusuario, string token)
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
        public Mensaje Update(Menu obj, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;

            Mensaje list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}/{idusuario}/{token}")]
        [ActionName("GetById")]
        public List<Menu>? GetById(int id, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;

            List<Menu> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}/{idusuario}/{token}")]
        [ActionName("GetAll")]
        public List<MenuDTO>? GetAll(string filtro, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;

            list = _service.List(filtro);
            return list;
        }
    }
}