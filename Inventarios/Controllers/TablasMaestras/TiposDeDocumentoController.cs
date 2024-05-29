using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;
using Inventarios.services.TablasMaestras;

using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.TablasMaestras
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class TiposDeDocumentoController : ControllerBase
    {
        private readonly TiposDeDocumentoService _service;

        private List<TiposDeDocumentoDTO>? list;

        public TiposDeDocumentoController(TiposDeDocumentoService service)
        {
            _service = service;
        }

        [HttpPost]
        [ActionName("Add")]
        public List<TiposDeDocumentoDTO>? Add(TiposDeDocumento obj)
        {
            list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}")]
        [ActionName("Delete")]
        public List<TiposDeDocumentoDTO>? Delete(int id)
        {
            list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public List<TiposDeDocumentoDTO>? Update(TiposDeDocumento? obj)
        {
            list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}/{idusuario}")]
        [ActionName("GetById")]
        public List<TiposDeDocumento>? GetById(int id, int idusuario = 0)
        {
            List<TiposDeDocumento> list = _service.GetById(id, idusuario);
            return list;
        }

        [HttpGet("{filtro}")]
        [ActionName("GetAll")]
        public List<TiposDeDocumentoDTO>? GetAll(string filtro = "")
        {
            if (filtro == "undefined") filtro = "";

            list = _service.List(filtro);
            return list;
        }

        [HttpGet("{filtro}")]
        [ActionName("GetAllCodigoNombre")]
        public List<TiposDeDocumentoDTO>? GetAllCodigoNombre(string filtro = "")
        {
            list = _service.ListCodigoNombre(filtro);
            return list;
        }

        [HttpGet("{idusuario}")]
        [ActionName("GetListDocumentosPermisos")]
        public List<TiposDeDocumentoPermisosDTO>? GetListDocumentosPermisos(int idusuario)
        {
            List<TiposDeDocumentoPermisosDTO>? list = _service.ListDocumentosPermisos(idusuario);
            return list;
        }

        [HttpGet("{id}/{idusuario}")]
        [ActionName("GetDarAccesoTotal")]
        public List<TiposDeDocumentoPermisosDTO>? GetDarAccesoTotal(int id, int idusuario)
        {
            List<TiposDeDocumentoPermisosDTO>? list = _service.DarAccesoTotal(id, idusuario);
            return list;
        }

        [HttpGet("{id}/{idusuario}")]
        [ActionName("GetDarRestriccionTotal")]
        public List<TiposDeDocumentoPermisosDTO>? GetDarRestriccionTotal(int id, int idusuario)
        {
            List<TiposDeDocumentoPermisosDTO>? list = _service.DarRestriccionTotal(id, idusuario);
            return list;
        }
    }
}