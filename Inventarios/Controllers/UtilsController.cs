using Inventarios.services;
using Inventarios.Token;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Inventarios.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UtilsController : ControllerBase
    {
        private readonly  Inventarios.Utils.Utils _utils;


        public UtilsController(Inventarios.Utils.Utils utils)
        {
          
            _utils = utils;

        }


        // GET api/<UtilsController>/5
        [HttpGet("{fecha}/{id}")]
        public List<string>  CalcularFechaDeVencimiento(string fecha , int plazo)
        {

          return    _utils.CalcularFechaDeVencimiento(fecha , plazo);

          
        }


    }
}
