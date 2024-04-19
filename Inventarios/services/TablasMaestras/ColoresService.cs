



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

        public List<ColoresDTO>? Add(Colores obj)
        {
            list = _access.Add(obj);
            return list;
        }

        public List<ColoresDTO>? Delete(int id)
        {
            list = _access.Delete(id);
            return list;
        }

        public List<ColoresDTO>? Update(Colores obj)
        {
            list = _access.Update(obj);
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