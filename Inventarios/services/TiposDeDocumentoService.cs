using Inventarios.DataAccess;
using Inventarios.DTO;
using Inventarios.Models;
using Microsoft.EntityFrameworkCore;

namespace Inventarios.services
{
    public class TiposDeDocumentoService
    {

        private readonly TiposDeDocumentoAccess _access;
        public List<TiposDeDocumentoDTO>? list;

        public TiposDeDocumentoService(TiposDeDocumentoAccess access)
        {
            _access = access;

        }

        public List<TiposDeDocumentoDTO> Add(TiposDeDocumento obj)
        {
            list = _access.Add(obj);
            return list;
        }

        public List<TiposDeDocumentoDTO>? Delete(int id)
        {
            list = _access.Delete(id);
            return list;
        }

        public List<TiposDeDocumentoDTO>? Update(TiposDeDocumento obj)
        {
            list = _access.Update(obj);
            return list;
        }

        public List<TiposDeDocumento>? GetById(int id)
        {
            List<TiposDeDocumento> list = _access.GetById(id);

            return list;
        }

        public List<TiposDeDocumentoDTO>? List(string filtro)
        {
            var list = _access.List(filtro);
            return list;
        }

        public List<TiposDeDocumentoDTO>? ListActive(string filtro)
        {
            var list = _access.ListActive(filtro);
            return list;
        }

        public List<TiposDeDocumentoDTO>? ListCodigoNombre(string filtro)
        {

            var list = _access.ListCodigoNombre(filtro);
            return list;


        }

        public List<TiposDeDocumentoPermisosDTO>? ListDocumentosPermisos(int id)
        {



            var list = _access.ListDocumentosPermisos(id);
            return list;

        }
    }
}
