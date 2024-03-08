using Inventarios.DataAccess;
using Inventarios.DTO;
using Inventarios.Models;

namespace Inventarios.services
{

    public class FormasDePagoService
    {
        private readonly FormasDePagoAccess _access;
        public List<FormasDePagoDTO>? list;

        public FormasDePagoService(FormasDePagoAccess access)
        {
            _access = access;

        }

        public List<FormasDePagoDTO>? Add(FormasDePago obj)
        {
            list = _access.Add(obj);
            return list;
        }

        public List<FormasDePagoDTO>? Delete(int id)
        {
            list = _access.Delete(id);
            return list;
        }

        public List<FormasDePagoDTO>? Update(FormasDePago obj)
        {
            list = _access.Update(obj);
            return list;
        }

        public List<FormasDePago>? GetById(int id)
        {
            List<FormasDePago> list = _access.GetById(id);

            return list;
        }

        public List<FormasDePagoDTO>? List(string filtro)
        {
            var list = _access.List(filtro);
            return list;
        }

       
    }
}
