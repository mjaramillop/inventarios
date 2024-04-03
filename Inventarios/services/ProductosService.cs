using Inventarios.DataAccess;
using Inventarios.DTO;
using Inventarios.Models;
using Inventarios.ModelsParameter;
using Microsoft.EntityFrameworkCore;

namespace Inventarios.services
{
    public class ProductosService
    {
        private readonly ProductosAccess _access;
        public List<ProductosDTO>? list;

        public ProductosService(ProductosAccess access)
        {
            _access = access;
        }

        public List<ProductosDTO>? Add(Productos obj)
        {
            list = _access.Add(obj);
            return list;
        }

        public List<ProductosDTO>? Delete(int id)
        {
            list = _access.Delete(id);
            return list;
        }

        public List<ProductosDTO>? Update(Productos obj)
        {
            list = _access.Update(obj);
            return list;
        }

        public List<Productos>? GetById(int id)
        {
            List<Productos> list = _access.GetById(id);

            return list;
        }

        public List<ProductosDTO>? List(string filtro)
        {
            var list = _access.List(filtro);
            return list;
        }

        public List<CodigoNombre>? GetNivel(int nivel)
        {
            List<CodigoNombre>? list = new List<CodigoNombre>();

            list = _access.GetNivel(nivel);

            return list;
        }

        public List<CodigoNombreDTO>? UpdateNiveles(UpdateNiveles obj)
        {
          
            return _access.UpdateNiveles(obj);
        }

        public List<CodigoNombreDTO>? CambiarPrecios(CambiarPrecios obj)
        {

            return _access.CambiarPrecios(obj);
        }

    }
}