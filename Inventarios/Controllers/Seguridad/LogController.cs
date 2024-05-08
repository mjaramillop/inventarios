using Inventarios.DTO;
using Inventarios.ModelsParameter.Seguridad;
using Inventarios.services.Seguridad;
using Inventarios.Token;
using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.Seguridad
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

        /// <summary>
        /// Trae el log del sistema basado en filtros
        /// </summary>

        [HttpPut]
        [ActionName("filtrar")]
        public List<LogDTO>? filtrar(LogConsultar obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.List(obj);
            return list;
        }

        /// <summary>
        /// formato de fecha a-m-d
        /// </summary>
        /// <param name="fecha"></param>
        /// <returns></returns>

        [HttpDelete("{fecha}")]
        [ActionName("DeleteLog")]
        public List<string>? DeleteLog(string fecha)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            List<string> list = _service.DeleteLog(fecha);
            return list;
        }
    }
}