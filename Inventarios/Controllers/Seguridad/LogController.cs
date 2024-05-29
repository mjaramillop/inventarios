using Inventarios.DTO;
using Inventarios.ModelsParameter.Seguridad;
using Inventarios.services.Seguridad;

using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.Seguridad
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class LogController : ControllerBase
    {
        private readonly LogService _service;

        private List<LogDTO>? list;

        public LogController(LogService service)
        {
            _service = service;
        }

        /// <summary>
        /// Trae el log del sistema basado en filtros
        /// </summary>

        [HttpPut]
        [ActionName("filtrar")]
        public List<LogDTO>? filtrar(LogConsultar obj)
        {
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
            List<string> list = _service.DeleteLog(fecha);
            return list;
        }
    }
}