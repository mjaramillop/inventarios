using Inventarios.DataAccess;
using Inventarios.DTO;
using Inventarios.Models;

namespace Inventarios.services
{
    public class ProveedoresService
    {

        private readonly ProveedoresAccess _access;
        public List<ProveedoresDTO>? list;

        public ProveedoresService(ProveedoresAccess access)
        {
            _access = access;

        }

        public List<ProveedoresDTO> Add(Proveedores obj)
        {
            list = _access.Add(obj);
            return list;
        }

        public List<ProveedoresDTO> Delete(int id)
        {
            list = _access.Delete(id);
            return list;
        }

        public List<ProveedoresDTO>? Update(Proveedores obj)
        {
            list = _access.Update(obj);
            return list;
        }

        public List<Proveedores>? GetById(int id)
        {
            List<Proveedores> list = _access.GetById(id);

            return list;
        }

        public List<ProveedoresDTO>? List(string filtro)
        {
            var list = _access.List(filtro);
            return list;
        }

        public List<ProveedoresDTO>? ListActive(string filtro)
        {
            var list = _access.ListActive(filtro);
            return list;
        }

    }
}
