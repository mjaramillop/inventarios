using Inventarios.Utils;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Inventarios.Controllers.Utils
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class UtilsController : ControllerBase
    {
        private readonly Utilidades _utils;

        public UtilsController(Utilidades utils)
        {
            _utils = utils;
        }

        // GET api/<UtilsController>/5
        [HttpGet("{fecha}/{plazo}")]
        [ActionName("CalcularFechaDeVencimiento")]
        public List<string> CalcularFechaDeVencimiento(string fecha, int plazo)
        {
            return _utils.CalcularFechaDeVencimiento(fecha, plazo);
        }
    }
}