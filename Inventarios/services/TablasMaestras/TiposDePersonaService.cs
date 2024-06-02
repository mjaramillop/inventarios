using Inventarios.DataAccess.TablasMaestras;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;

namespace Inventarios.services.TablasMaestras
{
    public class TiposDePersonaService
    {
        private readonly TiposDePersonaAccess _access;
        public List<TiposDePersonaDTO>? list;

        public TiposDePersonaService(TiposDePersonaAccess access)
        {
            _access = access;
        }

        public Mensaje Add(TiposDePersona obj)
        {
            Mensaje list = _access.Add(obj);
            return list;
        }

        public Mensaje Delete(string id)
        {
            Mensaje list = _access.Delete(id);
            return list;
        }

        public Mensaje Update(TiposDePersona obj)
        {
            Mensaje list = _access.Update(obj);
            return list;
        }

        public List<TiposDePersona>? GetById(string id)
        {
            List<TiposDePersona> list = _access.GetById(id);

            return list;
        }

        public List<TiposDePersonaDTO>? List(string? filtro)
        {
            var list = _access.List(filtro);
            return list;
        }
    }
}