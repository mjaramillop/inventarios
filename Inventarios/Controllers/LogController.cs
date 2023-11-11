using Inventarios.DTO;
using Inventarios.ModelsParameter;
using Inventarios.services;
using Inventarios.Token;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class LogController : ControllerBase
    {

        private readonly LogService _service;
        private readonly JwtService _jwtservice;
        private List<LogDTO>? list;

        public LogController(LogService service, JwtService jwtservice)
        {
            _service = service;
            _jwtservice = jwtservice;
        }



        [HttpGet("{filtro}")]
        [ActionName("GetAll")]
        public List<LogDTO>? GetAll(LogConsultar obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.List(obj);
            return list;
        }

    }
}
