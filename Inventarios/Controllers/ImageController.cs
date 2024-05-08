using Microsoft.AspNetCore.Mvc;

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

            route = route + "\\fondo.jpg";

            var image = System.IO.File.OpenRead(route);
            return File(image, "image/jpeg");
        }

        [HttpGet("{id}")]
        public IActionResult GetImageUser(int id)
        {
            string route = Path.Combine(Directory.GetCurrentDirectory(), "ImagesUsers");

            string routefinal = route + "\\" + id.ToString() + ".jpg";

            if (!System.IO.File.Exists(routefinal))
            {
                routefinal = route + "\\" + "0.jpg";
            }

            var image = System.IO.File.OpenRead(routefinal);
            return File(image, "image/jpeg");
        }

        [HttpGet("{id}")]
        public IActionResult GetImageProduct(int id)
        {
            string route = Path.Combine(Directory.GetCurrentDirectory(), "ImagesProducts");

            string routefinal = route + "\\" + id.ToString() + ".jpg";

            if (!System.IO.File.Exists(routefinal))
            {
                routefinal = route + "\\" + "0.jpg";
            }

            var image = System.IO.File.OpenRead(routefinal);
            return File(image, "image/jpeg");
        }

        [HttpPost]
        public async Task<IActionResult> UploadProducts(IFormFile file)
        {
            var uploads = Path.Combine(Directory.GetCurrentDirectory(), "ImagesProducts");
            if (!Directory.Exists(uploads))
            {
                Directory.CreateDirectory(uploads);
            }
            if (file.Length > 0)
            {
                var filePath = Path.Combine(uploads, file.FileName);
                using (var fileStream = new FileStream(filePath, FileMode.Create))
                {
                    await file.CopyToAsync(fileStream);
                }
            }
            return Ok();
        }

        [HttpPost]
        public async Task<IActionResult> UploadUsers(IFormFile file)
        {
            var uploads = Path.Combine(Directory.GetCurrentDirectory(), "ImagesUsers");
            if (!Directory.Exists(uploads))
            {
                Directory.CreateDirectory(uploads);
            }
            if (file.Length > 0)
            {
                var filePath = Path.Combine(uploads, file.FileName);
                using (var fileStream = new FileStream(filePath, FileMode.Create))
                {
                    await file.CopyToAsync(fileStream);
                }
            }
            return Ok();
        }

        [HttpGet("{id}")]
        public IActionResult Download(int id)
        {
            var uploads = Path.Combine(Directory.GetCurrentDirectory(), "ImagesProducts");
            var filepath = Path.Combine(uploads, id.ToString() + ".jpg");
            return File(System.IO.File.ReadAllBytes(filepath), "image/jpg", System.IO.Path.GetFileName(filepath));
        }
    }
}