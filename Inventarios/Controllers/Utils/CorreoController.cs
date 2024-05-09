using Inventarios.Models.Uitls;
using Inventarios.services.Utils;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.Utils
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class CorreoController : ControllerBase
    {

        private CorreoService _service;

        public CorreoController(CorreoService service ) { 
        
            _service = service;
        }

        [HttpGet]
        [ActionName("enviarcorreo")]

        public List<string> enviarcorreo(Correo obj)
        {
            return new List<string> { _service.enviarcorreo(obj) };
        }


    }
}
