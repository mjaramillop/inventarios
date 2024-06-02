using Inventarios.DataAccess;
using Inventarios.DTO.Seguridad;
using Inventarios.Models.Seguridad;
using Inventarios.Models.TablasMaestras;

namespace Inventarios.services.Seguridad
{
    public class PerfilesService
    {
        private readonly PerfilesAccess _access;
        public List<PerfilesDTO>? list;

        public PerfilesService(PerfilesAccess access)
        {
            _access = access;
        }

        public Mensaje Add(Perfiles obj)
        {
            Mensaje list = _access.Add(obj);
            return list;
        }

        public Mensaje Delete(int id)
        {
            Mensaje list = _access.Delete(id);
            return list;
        }

        public Mensaje Update(Perfiles obj)
        {
            Mensaje list = _access.Update(obj);
            return list;
        }

        public List<Perfiles> GetById(int id)
        {
            List<Perfiles> list = _access.GetById(id);

            return list;
        }

        public List<PerfilesDTO> List(string filtro)
        {
            var list = _access.List(filtro);
            return list;
        }

        public List<ProgramasPermisosDTO>? ListProgramasPermisos(int id)
        {
            var list = _access.ListProgramasPermisos(id);
            return list;
        }
    }
}