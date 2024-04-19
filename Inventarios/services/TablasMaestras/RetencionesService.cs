using Inventarios.DataAccess;
using Inventarios.DTO;
using Inventarios.Models.TablasMaestras;

namespace Inventarios.services.TablasMaestras
{
    public class RetencionesService
    {

        private readonly RetencionesAccess _access;
        public List<RetencionesDTO>? list;

        public RetencionesService(RetencionesAccess access)
        {
            _access = access;

        }

        public List<RetencionesDTO>? Add(Retenciones obj)
        {
            list = _access.Add(obj);
            return list;
        }

        public List<RetencionesDTO>? Delete(int id)
        {
            list = _access.Delete(id);
            return list;
        }

        public List<RetencionesDTO>? Update(Retenciones obj)
        {
            list = _access.Update(obj);
            return list;
        }

        public List<Retenciones>? GetById(int id)
        {
            List<Retenciones> list = _access.GetById(id);

            return list;
        }

        public List<RetencionesDTO>? List(string filtro)
        {
            var list = _access.List(filtro);
            return list;
        }





    }
}
