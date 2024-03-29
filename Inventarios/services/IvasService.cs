using Inventarios.DataAccess;
using Inventarios.DTO;
using Inventarios.Models;

namespace Inventarios.services
{

    public class IvasService
    {

        private readonly IvasAccess _access;
        public List<IvasDTO>? list;

        public IvasService(IvasAccess access)
        {
            _access = access;

        }

        public List<IvasDTO>? Add(Ivas obj)
        {
            list = _access.Add(obj);
            return list;
        }

        public List<IvasDTO>? Delete(int id)
        {
            list = _access.Delete(id);
            return list;
        }

        public List<IvasDTO>? Update(Ivas obj)
        {
            list = _access.Update(obj);
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
