using Inventarios.Utils;
using Microsoft.AspNetCore.Mvc;
using Microsoft.CodeAnalysis.Elfie.Serialization;
using Microsoft.EntityFrameworkCore;
using System.Globalization;
using System.Text;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Inventarios.Controllers.Utils
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class UtilsController : ControllerBase
    {
        private readonly Utilidades _service;

        public UtilsController(Utilidades service)
        {
            _service = service;
        }

        [HttpGet("{fecha}/{plazo}")]
        [ActionName("CalcularFechaDeVencimiento")]
        public List<string> CalcularFechaDeVencimiento(string fecha, int plazo)
        {
            return _service.CalcularFechaDeVencimiento(fecha, plazo);
        }

        [HttpGet("{fecha1}/{fecha2}")]
        [ActionName("restarfechas")]
        public int restarfechas(DateTime fecha1, DateTime fecha2)
        {
            return _service.restarfechas(fecha1, fecha2);
        }

        [HttpGet("{valor}")]
        [ActionName("MontroEscrito")]
        public List<string> MontoEscrito(string valor)
        {
            return new List<string> { _service.MontoEscrito(valor) };
        }






    }
}