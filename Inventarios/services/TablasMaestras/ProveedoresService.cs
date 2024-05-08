using Inventarios.DataAccess.TablasMaestras;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;
using Inventarios.ModelsParameter;

namespace Inventarios.services.TablasMaestras
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

        public List<ProveedoresDTO>? UpdateNiveles(UpdateNiveles obj)
        {
            list = _access.UpdateNiveles(obj);
            return list;
        }
    }
}