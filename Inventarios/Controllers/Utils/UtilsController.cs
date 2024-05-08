using Inventarios.DataAccess.Utils;
using Inventarios.services.Utils;
using Microsoft.AspNetCore.Mvc;
using System.Data;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Inventarios.Controllers.Utils
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class UtilsController : ControllerBase
    {
        private readonly UtilidadesService _service;

        public UtilsController(UtilidadesService service)
        {
            _service =service;
        }

        // GET api/<UtilsController>/5
        [HttpGet("{fecha}/{plazo}")]
        [ActionName("CalcularFechaDeVencimiento")]
        public List<string> CalcularFechaDeVencimiento(string fecha, int plazo)
        {
            return _service.CalcularFechaDeVencimiento(fecha, plazo);
        }


        // GET api/<UtilsController>/5
        [HttpGet("{valor}")]
        [ActionName("CalcularFechaDeVencimiento")]
        public string MontoEscrito(string valor)
        {

            return _service.MontoEscrito(valor);
        }


        [HttpGet("{fecha1}/{fecha2}")]
        [ActionName("CalcularFechaDeVencimiento")]
        public int restarfechas(DateTime fecha1, DateTime fecha2)
        {
            return _service.restarfechas(fecha1, fecha2);

        }







    }
}