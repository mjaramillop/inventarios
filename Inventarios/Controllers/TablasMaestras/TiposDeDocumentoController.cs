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

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<TiposDeDocumento>? GetById(int id)
        {
            
            List<TiposDeDocumento> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetByIdIfHasAccess")]
        public List<TiposDeDocumento>? GetByIdIfHasAccess(int id)
        {
            List<TiposDeDocumento> list = new List<TiposDeDocumento> { };

          

            list = _service.GetById(id);
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

      
        [HttpGet()]
        [ActionName("GetListDocumentosPermisosUserLoged")]
        public List<TiposDeDocumentoPermisosDTO>? GetListDocumentosPermisosUserLoged()
        {
            


            List<TiposDeDocumentoPermisosDTO>? list = _service.ListDocumentosPermisos();
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetDarAccesoTotal")]
        public List<TiposDeDocumentoPermisosDTO>? GetDarAccesoTotal(int id)
        {
            

            List<TiposDeDocumentoPermisosDTO>? list = _service.DarAccesoTotal(id);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetDarRestriccionTotal")]
        public List<TiposDeDocumentoPermisosDTO>? GetDarRestriccionTotal(int id)
        {
            

            List<TiposDeDocumentoPermisosDTO>? list = _service.DarRestriccionTotal(id);
            return list;
        }
    }
}