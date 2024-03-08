using Inventarios.DataAccess;
using Inventarios.DTO;
using Inventarios.Models;
using Inventarios.ModelsParameter;

namespace Inventarios.services
{
    public class CiudadesService
    {
        private readonly CiudadesAccess _access;
        public List<CiudadesDTO>? list;

        public CiudadesService(CiudadesAccess access)
        {
            _access = access;

        }

        public List<CiudadesDTO>? Add(Ciudades obj)
        {
            list = _access.Add(obj);
            return list;
        }

        public List<CiudadesDTO>? Delete(int id)
        {
            list = _access.Delete(id);
            return list;
        }

        public List<CiudadesDTO>? Update(Ciudades obj)
        {
            list = _access.Update(obj);
            return list;
        }


        public List<Ciudades>? GetById(int id)
        {
            List<Ciudades> list = _access.GetById(id);

            return list;
        }

        public List<CiudadesDTO>? List(string filtro)
        {
            var list = _access.List(filtro);
            return list;
        }

     

        public List<CiudadesDTO>? UpdateNiveles(CiudadesUpdateNiveles obj)
        {
            list = _access.UpdateNiveles(obj);
            return list;
        }



    }
}
