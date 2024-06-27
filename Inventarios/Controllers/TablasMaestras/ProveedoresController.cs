using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;
using Inventarios.ModelsParameter;
using Inventarios.services.TablasMaestras;
using Inventarios.Utils;
using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.TablasMaestras
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class ProveedoresController : ControllerBase
    {
        private readonly ProveedoresService _service;
        private Validaciones _validaciones;

        private List<ProveedoresDTO>? list;

        public ProveedoresController(ProveedoresService service, Validaciones validaciones)
        {
            _service = service;
            _validaciones = validaciones;   
        }

        [HttpPost]
        [ActionName("Add")]
        public Mensaje Add(Proveedores obj, int idusuario, string token)
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
        public Mensaje Update(Proveedores obj, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            Mensaje list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}/{idusuario}/{token}")]
        [ActionName("GetById")]
        public List<Proveedores>? GetById(int id, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            List<Proveedores> list = _service.GetById(id);
            return list;
        }


        [HttpGet("{id}/{idusuario}/{token}")]
        [ActionName("GenerarClave")]
        public List<Mensaje> GenerarClave(int id, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            List<Mensaje> list = _service.GenerarClave(id);
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


        [HttpGet("{filtro}/{idusuario}/{token}/{tipodeagente}")]
        [ActionName("GetAll")]
        public List<ProveedoresDTO>? GetAll(string filtro , int idusuario, string token , int tipodeagente=0)
        {

            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            list = _service.List(filtro , tipodeagente );
            return list;
        }

        [HttpPut]
        [ActionName("UpdateNiveles")]
        public List<ProveedoresDTO>? UpdateNiveles(UpdateNiveles obj, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            list = _service.UpdateNiveles(obj);
            return list;
        }
    }
}