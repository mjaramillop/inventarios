using Inventarios.Data;
using Inventarios.DataAccess.Seguridad;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Map;
using Inventarios.Models.TablasMaestras;

namespace Inventarios.DataAccess.TablasMaestras
{
    public class TallasAccess
    {
        private readonly InventariosContext _context;

        private readonly LogAccess _logacces;

        private readonly Mapping _mapping;

        private List<Tallas>? list;

        private readonly IConfiguration _iconfiguration;

        public TallasAccess(InventariosContext context, LogAccess logacces, Mapping mapping, IConfiguration iconfiguration)
        {
            _context = context;

            _logacces = logacces;
            _mapping = mapping;
            _iconfiguration = iconfiguration;
        }

        public List<TallasDTO>? Add(Tallas obj)
        {
            _context.Tallas.Add(obj);
            _context.SaveChanges();
            Log(obj, "Agrego Talla");
            list = _context.Tallas.Where(a => a.id == obj.id).ToList();
            return _mapping.ListTallasToTallasDTO(list);
        }

        public List<TallasDTO> Delete(int id)
        {
            var obj = _context.Tallas.FirstOrDefault(a => a.id == id);
            _context.Tallas.Remove(obj);
            _context.SaveChanges();
            Log(obj, "Borro Talla");
            list = _context.Tallas.Where(a => a.id == obj.id).ToList();
            return _mapping.ListTallasToTallasDTO(list);
        }

        public List<TallasDTO>? Update(Tallas? obj)
        {
            var obj_ = _context.Tallas.FirstOrDefault(a => a.id == obj.id);

            obj_.nombre = obj.nombre;

            _context.SaveChanges();
            Log(obj, "Modifico Talla");

            list = _context.Tallas.Where(a => a.id == obj.id).ToList();
            return _mapping.ListTallasToTallasDTO(list);
        }

        public List<Tallas> GetById(int id)
        {
            list = _context.Tallas.Where(a => a.id == id).ToList();
            return list;
        }

        public List<TallasDTO>? List(string filtro)
        {
            string caracterdebusqueda = _iconfiguration.GetValue<string>("ParametrosDeLaEmpresa:caracterdebusqueda");
            filtro = filtro.Replace(caracterdebusqueda, "");
            list = _context.Tallas.ToList().OrderBy(a => a.nombre).Where(a => a.nombre.Contains(filtro.Trim(), StringComparison.OrdinalIgnoreCase)).ToList();
            return _mapping.ListTallasToTallasDTO(list);
        }

        public void Log(Tallas obj, string operacion)
        {
            string comando = "";
            comando = comando + "operacion " + operacion + "\n";

            comando = comando + "id = " + obj.id + "\n";

            comando = comando + "Nombre = " + obj.nombre + "\n";

            //

            _logacces.Add(comando);
        }
    }
}