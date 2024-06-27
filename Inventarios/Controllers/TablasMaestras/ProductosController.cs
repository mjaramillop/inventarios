using Inventarios.DTO;
using Inventarios.Models.TablasMaestras;
using Inventarios.ModelsParameter;
using Inventarios.ModelsParameter.TablasMaestras;
using Inventarios.services.TablasMaestras;
using Inventarios.Utils;
using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.TablasMaestras
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class ProductosController : ControllerBase
    {
        private readonly ProductosService _service;
        private Validaciones _validaciones;


        private List<ProductosDTO>? list;

        public ProductosController(ProductosService service, Validaciones validaciones)
        {
            _service = service;
            _validaciones = validaciones;   
        }

        [HttpPost]
        [ActionName("Add")]
        public Mensaje Add(Productos obj, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            Mensaje list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}/{idusuario}/{token}")]
        [ActionName("Delete")]
        public Mensaje Delete(int id, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            Mensaje list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public Mensaje Update(Productos obj, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            Mensaje list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}/{idusuario}/{token}")]
        [ActionName("GetById")]
        public List<ProductosDTO>? GetById(int id, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}/{idusuario}/{token}")]
        [ActionName("GetAll")]
        public List<ProductosDTO>? GetAll(string filtro, int idusuario, string token)
        {

            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            list = _service.List(filtro);
            return list;
        }

        [HttpGet("{nivel}/{idusuario}/{token}")]
        [ActionName("GetNivel")]
        public List<string>? GetNivel(int nivel, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            List<string> list = _service.GetNivel(nivel);
            return list;
        }

        [HttpPut]
        [ActionName("UpdateNiveles")]
        public List<string>? UpdateNiveles(UpdateNiveles obj, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            return _service.UpdateNiveles(obj);
        }

        [HttpPut]
        [ActionName("CambiarPrecios")]
        public List<string>? CambiarPrecios(CambiarPrecios obj, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            return _service.CambiarPrecios(obj);
        }
    }
}