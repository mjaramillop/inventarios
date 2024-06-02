using Inventarios.DataAccess.TablasMaestras;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;

namespace Inventarios.services.TablasMaestras
{
    public class ColoresService
    {
        private readonly ColoresAccess _access;
        public List<ColoresDTO>? list;

        public ColoresService(ColoresAccess access)
        {
            _access = access;
        }

        public Mensaje Add(Colores obj)
        {
            Mensaje list = _access.Add(obj);
            return list;
        }

        public Mensaje Delete(int id)
        {
            Mensaje list = _access.Delete(id);
            return list;
        }

        public Mensaje Update(Colores obj)
        {
            Mensaje list = _access.Update(obj);
            return list;
        }

        public List<Colores>? GetById(int id)
        {
            List<Colores> list = _access.GetById(id);

            return list;
        }

        public List<ColoresDTO>? List(string filtro)
        {
            var list = _access.List(filtro);
            return list;
        }
    }
}