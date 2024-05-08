using Inventarios.DataAccess.TablasMaestras;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;

namespace Inventarios.services.TablasMaestras
{
    public class TallasService
    {
        private readonly TallasAccess _access;
        public List<TallasDTO>? list;

        public TallasService(TallasAccess access)
        {
            _access = access;
        }

        public List<TallasDTO>? Add(Tallas obj)
        {
            list = _access.Add(obj);
            return list;
        }

        public List<TallasDTO>? Delete(int id)
        {
            list = _access.Delete(id);
            return list;
        }

        public List<TallasDTO>? Update(Tallas obj)
        {
            list = _access.Update(obj);
            return list;
        }

        public List<Tallas>? GetById(int id)
        {
            List<Tallas> list = _access.GetById(id);

            return list;
        }

        public List<TallasDTO>? List(string filtro)
        {
            var list = _access.List(filtro);
            return list;
        }
    }
}