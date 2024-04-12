using Inventarios.DataAccess;
using Inventarios.DTO;
using Inventarios.Models;

namespace Inventarios.services
{
    public class ProgramasService
    {

        private readonly ProgramasAccess _access;
        public List<ProgramasDTO>? list;

        public ProgramasService(ProgramasAccess access)
        {
            _access = access;

        }

        public List<ProgramasDTO>? Add(Programas obj)
        {
            list = _access.Add(obj);
            return list;
        }

        public List<ProgramasDTO>? Delete(int id)
        {
            list = _access.Delete(id);
            return list;
        }

        public List<ProgramasDTO>? Update(Programas obj)
        {
            list = _access.Update(obj);
            return list;
        }

        public List<Programas>? GetById(int id)
        {
            List<Programas> list = _access.GetById(id);

            return list;
        }

        public List<ProgramasDTO>? List(string filtro)
        {
            var list = _access.List(filtro);
            return list;
        }





    }
}
