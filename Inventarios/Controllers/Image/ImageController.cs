using Inventarios.ModelsParameter.CapturaDeMovimiento;
using Inventarios.services.CapturaDeMovimiento;
using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.Image
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class ImageController : ControllerBase
    {
        private readonly MovimientodeinventariosService _service;

        public ImageController(MovimientodeinventariosService service)
        {
            _service = service;
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
        public async Task<IActionResult> UploadProducts(IFormFile file, int idusuario = 0)
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
        public async Task<IActionResult> UploadUsers(IFormFile file, int idusuario = 0)
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

        // upload files csv

        [HttpPost]
        public async Task< List<String>> UploadInventarioInicial(IFormFile file, int idusuario = 0)
        {
            List<string> list = new List<string>();

            var uploads = Path.Combine(Directory.GetCurrentDirectory(), "UploadInventarioInicial");
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
                    fileStream.Dispose();

                    list = _service.AddDocumentFromFileCSV(idusuario);
                }
            }
            return list;
        }


    }
}