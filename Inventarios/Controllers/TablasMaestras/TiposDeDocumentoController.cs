using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;
using Inventarios.services.TablasMaestras;
using Inventarios.Utils;
using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.TablasMaestras
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class TiposDeDocumentoController : ControllerBase
    {
        private readonly TiposDeDocumentoService _service;

        private List<TiposDeDocumentoDTO>? list;
        private Validaciones _validaciones;


        public TiposDeDocumentoController(TiposDeDocumentoService service, Validaciones validaciones )
        {
            _service = service;
            _validaciones = validaciones;
        }

        [HttpPost]
        [ActionName("Add")]
        public Mensaje Add(TiposDeDocumento obj, int idusuario, string token)
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
        public Mensaje Update(TiposDeDocumento? obj, int idusuario, string token    )
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            Mensaje list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}/{idusuario}/{token}")]
        [ActionName("GetById")]
        public List<TiposDeDocumento>? GetById(int id, int idusuario , string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            List<TiposDeDocumento> list = _service.GetById(id, idusuario);
            return list;
        }

        [HttpGet("{filtro}/{idusuario}/{token}")]
        [ActionName("GetAll")]
        public List<TiposDeDocumentoDTO>? GetAll(string filtro, int idusuario, string token )
        {

            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            list = _service.List(filtro);
            return list;
        }

        [HttpGet("{filtro}/{idusuario}/{token}")]
        [ActionName("GetAllCodigoNombre")]
        public List<TiposDeDocumentoDTO>? GetAllCodigoNombre(string filtro, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            list = _service.ListCodigoNombre(filtro);
            return list;
        }

        [HttpGet("{id}/{idusuario}/{token}")]
        [ActionName("GetListDocumentosPermisos")]
        public List<TiposDeDocumentoPermisosDTO>? GetListDocumentosPermisos(int id,int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            List<TiposDeDocumentoPermisosDTO>? list = _service.ListDocumentosPermisos(idusuario);
            return list;
        }

        [HttpGet("{id}/{idusuario}/{token}")]
        [ActionName("GetDarAccesoTotal")]
        public List<TiposDeDocumentoPermisosDTO>? GetDarAccesoTotal(int id, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            List<TiposDeDocumentoPermisosDTO>? list = _service.DarAccesoTotal(id, idusuario);
            return list;
        }

        [HttpGet("{id}/{idusuario}/{token}")]
        [ActionName("GetDarRestriccionTotal")]
        public List<TiposDeDocumentoPermisosDTO>? GetDarRestriccionTotal(int id, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            List<TiposDeDocumentoPermisosDTO>? list = _service.DarRestriccionTotal(id, idusuario);
            return list;
        }
    }
}