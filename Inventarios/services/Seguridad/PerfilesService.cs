using Inventarios.DataAccess;
using Inventarios.DTO.Seguridad;
using Inventarios.Models.Seguridad;

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

        public List<PerfilesDTO> Add(Perfiles obj)
        {
            list = _access.Add(obj);
            return list;
        }

        public List<PerfilesDTO> Delete(int id)
        {
            list = _access.Delete(id);
            return list;
        }

        public List<PerfilesDTO> Update(Perfiles obj)
        {
            list = _access.Update(obj);
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