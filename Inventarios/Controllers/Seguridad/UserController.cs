using Inventarios.DTO;
using Inventarios.DTO.Seguridad;
using Inventarios.Models;
using Inventarios.Models.Seguridad;
using Inventarios.Models.TablasMaestras;
using Inventarios.services.Seguridad;
using Inventarios.Utils;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;

namespace Inventarios.Controllers.Seguridad
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly UserService _service;
        private Validaciones _validaciones; 
      
     
        private List<UsersDTO>? list;

        public UserController(UserService service , Validaciones validaciones  )
        {
            _service = service;
            _validaciones = validaciones;
          
         
        }

        [HttpPost]
        [ActionName("Add")]
        public Mensaje Add(Usuarios? obj, int idusuario, string token )
        {

            if (_validaciones.ValidarToken(idusuario, token)==false) return new Mensaje();


            Mensaje list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}/{idusuario}/{token}")]
        [ActionName("Delete")]
        public Mensaje Delete(int id,int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;

            Mensaje list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public Mensaje Update(Usuarios obj, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;

            Mensaje list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}/{idusuario}/{token}")]
        [ActionName("GetById")]
        public List<Usuarios>? GetById(int id, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;

            List<Usuarios> obj = _service.GetById(id);

            return obj;
        }

        [HttpGet("{filtro}/{idusuario}/{token}")]
        [ActionName("GetAll")]
        public List<UsersDTO>? GetAll(string filtro ,  int idusuario , string token )
        {

            if (_validaciones.ValidarToken(idusuario, token) == false) return null;

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