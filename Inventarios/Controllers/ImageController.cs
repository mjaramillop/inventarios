using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Hosting;
using System.Drawing;

namespace Inventarios.Controllers
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class ImageController : ControllerBase
    {

        

        public ImageController()
        {
           
        }



        [HttpGet]
    
        public IActionResult GetFondo()
        {


            string route = Path.Combine(Directory.GetCurrentDirectory(), "images");


            route = route+ "\\fondo.jpg";

            var image = System.IO.File.OpenRead(route);
            return File(image, "image/jpeg");
        }


        [HttpGet("{id}")]

        public IActionResult GetImageUser(int id)
        {


            string route = Path.Combine(Directory.GetCurrentDirectory(), "imagesusers");


            route = route + "\\" + id.ToString()  +".jpg";

            var image = System.IO.File.OpenRead(route);
            return File(image, "image/jpeg");
        }




    }
}
