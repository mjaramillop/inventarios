using Inventarios.DataAccess.TablasMaestras;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;

namespace Inventarios.services.TablasMaestras
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

        public List<TiposDeDocumento>? GetById(int id, int idusuario)
        {
            List<TiposDeDocumento> list = _access.GetById(id , idusuario);

            return list;
        }

        public List<TiposDeDocumentoDTO>? List(string filtro)
        {
            var list = _access.List(filtro);
            return list;
        }

        public List<TiposDeDocumentoDTO>? ListCodigoNombre(string filtro)
        {
            var list = _access.ListCodigoNombre(filtro);
            return list;
        }

        public List<TiposDeDocumentoPermisosDTO>? ListDocumentosPermisos(int idusuario)
        {
            var list = _access.ListDocumentosPermisos(idusuario);
            return list;
        }

        public List<TiposDeDocumentoPermisosDTO>? DarAccesoTotal(int id, int idusuario)
        {
            var list = _access.DarAccesoTotal(id, idusuario );
            return list;
        }

        public List<TiposDeDocumentoPermisosDTO>? DarRestriccionTotal(int id, int idusuario)
        {
            var list = _access.DarRestriccionTotal(id,idusuario);
            return list;
        }
    }
}