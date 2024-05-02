using Inventarios.DataAccess.TablasMaestras;
using Inventarios.DTO;
using Inventarios.Models;
using Inventarios.Models.TablasMaestras;
using Inventarios.ModelsParameter;
using Inventarios.ModelsParameter.TablasMaestras;
using Microsoft.EntityFrameworkCore;

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