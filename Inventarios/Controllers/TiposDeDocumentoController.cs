using Inventarios.DTO;
using Inventarios.Models;
using Inventarios.services;
using Inventarios.Token;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class TiposDeDocumentoController : ControllerBase
    {
        private readonly TiposDeDocumentoService _service;
        private readonly JwtService _jwtservice;
        private List<TiposDeDocumentoDTO>? list;

        public TiposDeDocumentoController(TiposDeDocumentoService service, JwtService jwtservice)
        {
            _service = service;
            _jwtservice = jwtservice;
        }

        [HttpPost]
        [ActionName("Add")]
        public List<TiposDeDocumentoDTO>? Add(TiposDeDocumento obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}")]
        [ActionName("Delete")]
        public List<TiposDeDocumentoDTO>? Delete(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public List<TiposDeDocumentoDTO>? Update(TiposDeDocumento obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<TiposDeDocumento>? GetById(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            List<TiposDeDocumento> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetByIdIfHasAccess")]
        public List<TiposDeDocumento>? GetByIdIfHasAccess(int id)
        {
            List<TiposDeDocumento> list = new List<TiposDeDocumento> { };

            if (_jwtservice.UserAthenticated() == false) return null;

            if (_jwtservice.tiposdedocumento.IndexOf("," + id + "=") < 0)
            {
                return list;
            }

            list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}")]
        [ActionName("GetAll")]
        public List<TiposDeDocumentoDTO>? GetAll(string filtro = "")
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.List(filtro);
            return list;
        }

      

        [HttpGet("{filtro}")]
        [ActionName("GetAllCodigoNombre")]
        public List<TiposDeDocumentoDTO>? GetAllCodigoNombre(string filtro = "")
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.ListCodigoNombre(filtro);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetListDocumentosPermisos")]
        public List<TiposDeDocumentoPermisosDTO>? GetListDocumentosPermisos(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            List<TiposDeDocumentoPermisosDTO>? list = _service.ListDocumentosPermisos(id);
            return list;
        }

        [HttpGet()]
        [ActionName("GetListDocumentosPermisosUserLoged")]
        public List<TiposDeDocumentoPermisosDTO>? GetListDocumentosPermisosUserLoged()
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            int id = _jwtservice.Id;

            List<TiposDeDocumentoPermisosDTO>? list = _service.ListDocumentosPermisos(id);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetDarAccesoTotal")]
        public List<TiposDeDocumentoPermisosDTO>? GetDarAccesoTotal(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            List<TiposDeDocumentoPermisosDTO>? list = _service.DarAccesoTotal(id);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetDarRestriccionTotal")]
        public List<TiposDeDocumentoPermisosDTO>? GetDarRestriccionTotal(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            List<TiposDeDocumentoPermisosDTO>? list = _service.DarRestriccionTotal(id);
            return list;
        }
    }
}