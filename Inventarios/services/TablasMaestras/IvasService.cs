using Inventarios.DataAccess;
using Inventarios.DTO;
using Inventarios.Models.TablasMaestras;

namespace Inventarios.services.TablasMaestras
{
    public class IvasService
    {
        private readonly IvasAccess _access;
        public List<IvasDTO>? list;

        public IvasService(IvasAccess access)
        {
            _access = access;
        }

        public Mensaje Add(Ivas obj)
        {
            Mensaje list = _access.Add(obj);
            return list;
        }

        public Mensaje Delete(int id)
        {
            Mensaje list = _access.Delete(id);
            return list;
        }

        public Mensaje Update(Ivas obj)
        {
            Mensaje list = _access.Update(obj);
            return list;
        }

        public List<Ivas>? GetById(int id)
        {
            List<Ivas> list = _access.GetById(id);

            return list;
        }

        public List<IvasDTO>? List(string filtro)
        {
            var list = _access.List(filtro);
            return list;
        }
    }
}