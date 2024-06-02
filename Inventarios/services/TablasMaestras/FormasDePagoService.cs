using Inventarios.DataAccess;
using Inventarios.DTO;
using Inventarios.Models.TablasMaestras;

namespace Inventarios.services.TablasMaestras
{
    public class FormasDePagoService
    {
        private readonly FormasDePagoAccess _access;
        public List<FormasDePagoDTO>? list;

        public FormasDePagoService(FormasDePagoAccess access)
        {
            _access = access;
        }

        public Mensaje Add(FormasDePago obj)
        {
            Mensaje list = _access.Add(obj);
            return list;
        }

        public Mensaje Delete(int id)
        {
            Mensaje list = _access.Delete(id);
            return list;
        }

        public Mensaje Update(FormasDePago obj)
        {
            Mensaje list = _access.Update(obj);
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