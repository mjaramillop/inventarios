using Inventarios.ModelsParameter.CapturaDeMovimiento;
using Inventarios.services.CapturaDeMovimiento;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;

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


        [HttpGet("{id}/{directorio}")]
        public IActionResult GetImage(int id, string directorio)
        {
            string route = Path.Combine(Directory.GetCurrentDirectory(), directorio);

            string routefinal = route + "\\" + id.ToString() + ".jpg";

            if (!System.IO.File.Exists(routefinal))
            {
                routefinal = route + "\\" + "0.jpg";
            }

            var image = System.IO.File.OpenRead(routefinal);
            return File(image, "image/jpeg");
        }

        [HttpPost]
        public async Task<List<string>> Upload(IFormFile file , string directorio , int idusuario=0 , int tipodedocumento=0 )
        {


            string nombredelarchivo = file.FileName;
            string mensajedeerror = "";
            List<string> list = new List<string>();

            try
            {
                var uploads = Path.Combine(Directory.GetCurrentDirectory(), directorio);
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
                    }
                }

                if (directorio== "UploadInventarioInicial")  list = _service.AddDocumentFromFileCSV(nombredelarchivo,directorio,idusuario,tipodedocumento);
                if (directorio == "UploadInventarioFisico") list = _service.AddDocumentFromFileCSV(nombredelarchivo,directorio,idusuario,tipodedocumento);


                mensajedeerror = "Archivo cargado existosamente";
            }
            catch (Exception ee) 
            {
                mensajedeerror = "Error " + ee.Message.ToString();
            
            }


            return  new List<string>(){ mensajedeerror };
        }





    }
}