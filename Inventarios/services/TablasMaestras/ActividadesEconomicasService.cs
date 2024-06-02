using Inventarios.DataAccess.TablasMaestras;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;

namespace Inventarios.services.TablasMaestras
{
    public class ActividadesEconomicasService
    {
        private readonly ActividadesEconomicasAccess _access;
        public List<ActividadesEconomicasDTO>? list;

        public ActividadesEconomicasService(ActividadesEconomicasAccess access)
        {
            _access = access;
        }

        public Mensaje Add(ActividadesEconomicas obj)
        {
            Mensaje list = _access.Add(obj);
            return list;
        }

        public Mensaje Delete(int id)
        {
            Mensaje list = _access.Delete(id);
            return list;
        }

        public Mensaje Update(ActividadesEconomicas obj)
        {
            Mensaje list = _access.Update(obj);
            return list;
        }

        public List<ActividadesEconomicas>? GetById(int id)
        {
            List<ActividadesEconomicas> list = _access.GetById(id);

            return list;
        }

        public List<ActividadesEconomicasDTO>? List(string filtro)
        {
            var list = _access.List(filtro);
            return list;
        }
    }
}