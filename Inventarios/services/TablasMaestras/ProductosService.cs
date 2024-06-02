using Inventarios.DataAccess.TablasMaestras;
using Inventarios.DTO;
using Inventarios.Models.TablasMaestras;
using Inventarios.ModelsParameter;
using Inventarios.ModelsParameter.TablasMaestras;

namespace Inventarios.services.TablasMaestras
{
    public class ProductosService
    {
        private readonly ProductosAccess _access;
        public List<ProductosDTO>? list;

        public ProductosService(ProductosAccess access)
        {
            _access = access;
        }

        public Mensaje Add(Productos obj)
        {
            Mensaje list = _access.Add(obj);
            return list;
        }

        public Mensaje Delete(int id)
        {
            Mensaje list = _access.Delete(id);
            return list;
        }

        public Mensaje Update(Productos obj)
        {
            Mensaje list = _access.Update(obj);
            return list;
        }

        public List<ProductosDTO>? GetById(int id)
        {
            list = _access.GetById(id);

            return list;
        }

        public List<ProductosDTO>? List(string filtro)
        {
            list = _access.List(filtro);
            return list;
        }

        public List<string>? GetNivel(int nivel)
        {
            List<string>? list = new List<string>();

            list = _access.GetNivel(nivel);

            return list;
        }

        public List<string>? UpdateNiveles(UpdateNiveles obj)
        {
            return _access.UpdateNiveles(obj);
        }

        public List<string>? CambiarPrecios(CambiarPrecios obj)
        {
            return _access.CambiarPrecios(obj);
        }
    }
}