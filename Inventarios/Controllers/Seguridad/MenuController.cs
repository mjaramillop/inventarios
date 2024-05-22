using Inventarios.DTO.Seguridad;
using Inventarios.Models.Seguridad;
using Inventarios.services.Seguridad;

using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.Seguridad
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class MenuController : ControllerBase
    {
        private readonly MenuService _service;
        
        private List<MenuDTO>? list;

        public MenuController(MenuService service)
        {
            _service = service;
            
        }

        [HttpPost]
        [ActionName("Add")]
        public List<MenuDTO>? Add(Menu obj)
        {
            
            list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}")]
        [ActionName("Delete")]
        public List<MenuDTO>? Delete(int id)
        {
            

            list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public List<MenuDTO>? Update(Menu obj)
        {
            

            list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<Menu>? GetById(int id)
        {
            
            List<Menu> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}")]
        [ActionName("GetAll")]
        public List<MenuDTO>? GetAll(string filtro = "")
        {
            
            list = _service.List(filtro);
            return list;
        }
    }
}