using Inventarios.DTO;
using Inventarios.DTO.Seguridad;
using Inventarios.Models.Seguridad;
using Inventarios.Models.TablasMaestras;
using Inventarios.services.Seguridad;

using Microsoft.AspNetCore.Http;
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
        public List<UsersDTO>? Add(Usuarios? obj)
        {
            
            list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}")]
        [ActionName("Delete")]
        public List<UsersDTO>? Delete(int id)
        {
            
            list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public List<UsersDTO>? Update(Usuarios obj)
        {
            
            list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<Usuarios>? GetById(int id)
        {
            
            List<Usuarios> obj = _service.GetById(id);

            return obj;
        }


        [HttpGet]
        [ActionName("GetId")]
        public List<Usuarios>? GetId()
        {
           
            List<Usuarios> list = _service.GetId();

            return list;
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

          List<MenuDTO>  list = _service.ValidateAccess(login, password);
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