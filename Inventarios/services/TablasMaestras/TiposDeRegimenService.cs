using Inventarios.DataAccess.TablasMaestras;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;

namespace Inventarios.services.TablasMaestras
{
    public class TiposDeRegimenService
    {
        private readonly TiposDeRegimenAccess _access;
        public List<TiposDeRegimenDTO>? list;

        public TiposDeRegimenService(TiposDeRegimenAccess access)
        {
            _access = access;
        }

        public List<TiposDeRegimenDTO>? Add(TiposDeRegimen obj)
        {
            list = _access.Add(obj);
            return list;
        }

        public List<TiposDeRegimenDTO>? Delete(int id)
        {
            list = _access.Delete(id);
            return list;
        }

        public List<TiposDeRegimenDTO>? Update(TiposDeRegimen obj)
        {
            list = _access.Update(obj);
            return list;
        }

        public List<TiposDeRegimen>? GetById(int id)
        {
            List<TiposDeRegimen> list = _access.GetById(id);

            return list;
        }

        public List<TiposDeRegimenDTO>? List(string filtro)
        {
            var list = _access.List(filtro);
            return list;
        }
    }
}