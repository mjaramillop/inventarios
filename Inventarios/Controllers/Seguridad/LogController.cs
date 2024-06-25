using Inventarios.DTO;
using Inventarios.Models.TablasMaestras;
using Inventarios.ModelsParameter.Seguridad;
using Inventarios.services.Seguridad;
using Inventarios.Utils;
using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.Seguridad
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class LogController : ControllerBase
    {
        private readonly LogService _service;
        private Validaciones _validaciones;

        private List<LogDTO>? list;

        public LogController(LogService service, Validaciones validaciones )
        {
            _service = service;
            _validaciones = validaciones;
        }

        /// <summary>
        /// Trae el log del sistema basado en filtros
        /// </summary>

        [HttpPut]
        [ActionName("filtrar")]
        public List<LogDTO> filtrar(LogConsultar obj, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;

            list = _service.List(obj);
            return list;
        }

        /// <summary>
        /// formato de fecha a-m-d
        /// </summary>
        /// <param name="fecha"></param>
        /// 
        /// <returns></returns>

        [HttpDelete("{fecha}/{idusuario}/{token}")]
        [ActionName("DeleteLog")]
        public Mensaje DeleteLog(string fecha, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;

            Mensaje list = _service.DeleteLog(fecha);
            return list;
        }
    }
}