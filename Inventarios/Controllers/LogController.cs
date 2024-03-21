using Inventarios.DTO;
using Inventarios.Models;
using Inventarios.ModelsParameter;
using Inventarios.services;
using Inventarios.Token;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using NSwag.Annotations;
using Swashbuckle.AspNetCore.Annotations;
using System.Runtime.InteropServices;

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
    

        public List<Mensaje> ? DeleteLog(string fecha)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
           List<Mensaje> list = _service.DeleteLog(fecha);
            return list;
        }




    }
}
