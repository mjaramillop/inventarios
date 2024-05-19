
using Inventarios.DataAccess.Utils;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.Utils
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class CorreoController : ControllerBase
    {

        private  Correo _service;

        public CorreoController(Correo service ) { 
        
            _service = service;
        }

        [HttpGet]
        [ActionName("enviarcorreo")]

        public List<string> enviarcorreo(DataAccess.Utils.Correo obj)
        {
            return new List<string> { _service.enviarcorreo(obj) };
        }


    }
}
