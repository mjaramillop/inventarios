using Inventarios.DTO;
using Inventarios.Models;
using Inventarios.services;
using Inventarios.Token;
using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly UserService _service;
        private readonly JwtService _jwtservice;
        private List<UsersDTO>? list;

        public UserController(UserService service, JwtService jwtService)
        {
            _service = service;
            _jwtservice = jwtService;
        }

        [HttpPost]
        [ActionName("Add")]
        public List<UsersDTO>? Add(Usuarios obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}")]
        [ActionName("Delete")]
        public List<UsersDTO>? Delete(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public List<UsersDTO>? Update(Usuarios obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<Usuarios>? GetById(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            List<Usuarios> obj = _service.GetById(id);

            return obj;
        }

        [HttpGet("{filtro}")]
        [ActionName("GetAll")]
        public List<UsersDTO>? GetAll(string filtro = "")
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.List(filtro);
            return list;
        }

        [HttpGet("{login}/{password}")]
        [ActionName("ValidateAccess")]
        public List<TokenDTO> ValidateAccess(string login, string password)
        {
            List<TokenDTO> list = _service.ValidateAccess(login, password);

            return list;
        }

        [HttpGet("{token}")]
        [ActionName("ValidateToken")]
        public List<MenuDTO>? ValidateToken(string token)
        {
        
            List<MenuDTO>? list = _service.ValidateToken(token);

            return list;
        }

      

        [HttpGet]
        [ActionName("GetId")]
        public List<UserIdDTO>? GetId()
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            UserIdDTO userIdDTO = new UserIdDTO();
            userIdDTO.id = _jwtservice.Id;
            List<UserIdDTO> list = new List<UserIdDTO> { userIdDTO };

            return list;
        }

        [HttpGet]
        [ActionName("Logout")]
        public TokenDTO Logout()
        {
            _jwtservice.jwt = "";
            _jwtservice.login = "";
            _jwtservice.password = "";
            _jwtservice.Id = 0;
            _jwtservice.username = "";

            return new TokenDTO() { token = "" };
        }
    }
}