using Inventarios.DataAccess;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;

namespace Inventarios.services.TablasMaestras
{
    public class ProgramasService
    {
        private readonly ProgramasAccess _access;
        public List<ProgramasDTO>? list;

        public ProgramasService(ProgramasAccess access)
        {
            _access = access;
        }

        public Mensaje Add(Programas obj)
        {
            Mensaje list = _access.Add(obj);
            return list;
        }

        public Mensaje Delete(int id)
        {
            Mensaje list = _access.Delete(id);
            return list;
        }

        public Mensaje Update(Programas obj)
        {
            Mensaje list = _access.Update(obj);
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