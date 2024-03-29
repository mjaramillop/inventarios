using Inventarios.Data;
using Inventarios.DTO;
using Inventarios.Map;
using Inventarios.Models;

namespace Inventarios.DataAccess
{
    public class IvasAccess
    {
        private readonly InventariosContext _context;

        private readonly LogAccess _logacces;

        private readonly Mapping _mapping;

        private List<Ivas>? list;

        public IvasAccess(InventariosContext context, LogAccess logacces, Mapping mapping)
        {
            _context = context;

            _logacces = logacces;
            _mapping = mapping;
        }

        public List<IvasDTO>? Add(Ivas obj)
        {
            obj.estadodelregistro = obj.estadodelregistro.ToUpper();
            _context.Ivas.Add(obj);
            _context.SaveChanges();
            this.Log(obj, "Agrego Iva");
            list = _context.Ivas.Where(a => a.id == obj.id).ToList();
            return _mapping.ListIvasToIvasDTO(list);
        }

        public List<IvasDTO> Delete(int id)
        {
            var obj = _context.Ivas.FirstOrDefault(a => a.id == id);
            _context.Ivas.Remove(obj);
            _context.SaveChanges();
            this.Log(obj, "Borro Iva");
            list = _context.Ivas.Where(a => a.id == obj.id).ToList();
            return _mapping.ListIvasToIvasDTO(list);
        }

        public List<IvasDTO>? Update(Ivas? obj)
        {
            obj.estadodelregistro = obj.estadodelregistro.ToUpper();
            var obj_ = _context.Ivas.FirstOrDefault(a => a.id == obj.id);

            obj_.nombre = obj.nombre;
            obj_.porcentaje=obj.porcentaje;

            //
            obj_.estadodelregistro = obj.estadodelregistro;

            _context.SaveChanges();
            this.Log(obj, "Modifico Iva");

            list = _context.Ivas.Where(a => a.id == obj.id).ToList();
            return _mapping.ListIvasToIvasDTO(list);
        }

        public List<Ivas> GetById(int id)
        {
            list = _context.Ivas.Where(a => a.id == id).ToList();
            return list;
        }

        public List<IvasDTO>? List(string filtro)
        {
            list = _context.Ivas.ToList().OrderBy(a => a.nombre).Where(a => a.nombre.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
            return _mapping.ListIvasToIvasDTO(list);
        }

        public void Log(Ivas obj, string operacion)
        {
            string comando = "";
            comando = comando + "operacion " + operacion + "\n";
            comando = comando + "id = " + obj.id + "\n";
            comando = comando + "Nombre = " + obj.nombre + "\n";
            comando = comando + "Porcentaje = " + obj.porcentaje + "\n";
            //
            comando = comando + "Estado del Registro = " + obj.estadodelregistro + "\n";

            _logacces.Add(comando);
        }
    }
}
