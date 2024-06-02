using Inventarios.DTO;
using Inventarios.DTO.Seguridad;
using Inventarios.Models.Seguridad;
using Inventarios.Models.TablasMaestras;
using Inventarios.services.Seguridad;
using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.Seguridad
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly UserService _service;

        private List<UsersDTO>? list;

        public UserController(UserService service)
        {
            _service = service;
        }

        [HttpPost]
        [ActionName("Add")]
        public Mensaje Add(Usuarios? obj)
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
        public Mensaje Update(Usuarios obj)
        {
            Mensaje list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<Usuarios>? GetById(int id)
        {
            List<Usuarios> obj = _service.GetById(id);

            return obj;
        }

        [HttpGet("{filtro}")]
        [ActionName("GetAll")]
        public List<UsersDTO>? GetAll(string filtro = "")
        {
            string programas = HttpContext.Session.GetString("programas");

            list = _service.List(filtro);
            return list;
        }

        [HttpGet("{login}/{password}")]
        [ActionName("ValidateAccess")]
        public List<MenuDTO> ValidateAccess(string login, string password)
        {
            List<MenuDTO> list = _service.ValidateAccess(login, password);
            return list;
        }

        [HttpGet]
        [ActionName("Logout")]
        public string Logout()
        {
            return new string("");
        }
    }
}