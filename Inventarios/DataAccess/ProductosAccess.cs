using Inventarios.Data;
using Inventarios.DTO;
using Inventarios.Map;
using Inventarios.Models;

namespace Inventarios.DataAccess
{
    public class ProductosAccess
    {
        private readonly InventariosContext _context;

        private readonly LogAccess _logacces;

        private readonly Mapping _mapping;

        private List<Productos>? list;

        public ProductosAccess(InventariosContext context, LogAccess logacces, Mapping mapping)
        {
            _context = context;

            _logacces = logacces;
            _mapping = mapping;
        }

        public List<ProductosDTO>? Add(Productos obj)
        {
            obj.estadodelregistro = obj.estadodelregistro.ToUpper();
            _context.Productos.Add(obj);
            _context.SaveChanges();
            this.Log(obj, "Agrego Producto");
            list = _context.Productos.Where(a => a.id == obj.id).ToList();
            return _mapping.ListProductosToProductosDTO(list);
        }

        public List<ProductosDTO> Delete(int id)
        {
            var obj = _context.Productos.FirstOrDefault(a => a.id == id);
            _context.Productos.Remove(obj);
            _context.SaveChanges();
            this.Log(obj, "Borro Producto");
            list = _context.Productos.Where(a => a.id == obj.id).ToList();
            return _mapping.ListProductosToProductosDTO(list);
        }

        public List<ProductosDTO>? Update(Productos? obj)
        {
            obj.estadodelregistro = obj.estadodelregistro.ToUpper();
            var obj_ = _context.Productos.FirstOrDefault(a => a.id == obj.id);
            obj_.nombre = obj.nombre;
            obj_.unidaddemedida = obj.unidaddemedida;   
            obj_.secargalinventario = obj.secargalinventario;   
            obj_.precio1 = obj.precio1; 
            obj_.codigoiva1 = obj.codigoiva1;
            obj_.costoultimo = obj.costoultimo; 
            obj_.Clasificacion = obj.Clasificacion; 
            obj_.estadodelregistro = obj.estadodelregistro;

            _context.SaveChanges();
            this.Log(obj, "Modifico Productos");

            list = _context.Productos.Where(a => a.id == obj.id).ToList();
            return _mapping.ListProductosToProductosDTO(list);
        }

        public List<Productos> GetById(int id)
        {
            list = _context.Productos.Where(a => a.id == id).ToList();
            return list;
        }

        public List<ProductosDTO>? List(string filtro)
        {
            list = _context.Productos.ToList().OrderBy(a => a.nombre).Where(a => a.nombre.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
            return _mapping.ListProductosToProductosDTO(list);
        }

        public void Log(Productos obj, string operacion)
        {
            string comando = "";
            comando = comando + "operacion " + operacion + "\n";
            comando = comando + "id = " + obj.id + "\n";
            comando = comando + "Nombre = " + obj.nombre + "\n";
            comando = comando + "Unidad de medida = " + obj.unidaddemedida + "\n";
            comando = comando + "Precion1 = " + obj.precio1 + "\n";
            comando = comando + "Costo Ultimo = " + obj.costoultimo + "\n";
            comando = comando + "Se carga al inventario = " + obj.secargalinventario + "\n";
            comando = comando + "Clasificacion = " + obj.Clasificacion + "\n";
            comando = comando + "Codigo iva 1 = " + obj.codigoiva1 + "\n";


            //
            comando = comando + "Estado del Registro = " + obj.estadodelregistro + "\n";

            _logacces.Add(comando);
        }
    }
}
