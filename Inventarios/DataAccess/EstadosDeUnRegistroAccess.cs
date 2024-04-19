using Inventarios.Data;
using Inventarios.DTO;
using Inventarios.Map;
using Inventarios.Models;

namespace Inventarios.DataAccess
{
    public class EstadosDeUnRegistroAccess
    {
        private readonly InventariosContext _context;

        private readonly LogAccess _logacces;

        private readonly Mapping _mapping;

        private List<EstadosDeUnRegistro>? list;

        private readonly IConfiguration _iconfiguration;

        public EstadosDeUnRegistroAccess(InventariosContext context, LogAccess logacces, Mapping mapping, IConfiguration iconfiguration)
        {
            _context = context;

            _logacces = logacces;
            _mapping = mapping;
            _iconfiguration = iconfiguration;
        }

        public List<EstadosDeUnRegistroDTO>? Add(EstadosDeUnRegistro obj)
        {
            _context.EstadosDeUnRegistro.Add(obj);
            _context.SaveChanges();
            this.Log(obj, "Agrego Estado de un registro");
            list = _context.EstadosDeUnRegistro.Where(a => a.id == obj.id).ToList();
            return _mapping.ListEstadosDeUnRegistroToEstadosDeUnRegistroDTO(list);
        }

        public List<EstadosDeUnRegistroDTO> Delete(int id)
        {
            var obj = _context.EstadosDeUnRegistro.FirstOrDefault(a => a.id == id);
            _context.EstadosDeUnRegistro.Remove(obj);
            _context.SaveChanges();
            this.Log(obj, "Borro Estado de un registro");
            list = _context.EstadosDeUnRegistro.Where(a => a.id == obj.id).ToList();
            return _mapping.ListEstadosDeUnRegistroToEstadosDeUnRegistroDTO(list);
        }

        public List<EstadosDeUnRegistroDTO>? Update(EstadosDeUnRegistro? obj)
        {
            var obj_ = _context.EstadosDeUnRegistro.FirstOrDefault(a => a.id == obj.id);

            obj_.nombre = obj.nombre;

            _context.SaveChanges();
            this.Log(obj, "Modifico EstadosDeUnRegistro");

            list = _context.EstadosDeUnRegistro.Where(a => a.id == obj.id).ToList();
            return _mapping.ListEstadosDeUnRegistroToEstadosDeUnRegistroDTO(list);
        }

        public List<EstadosDeUnRegistro> GetById(int id)
        {
            list = _context.EstadosDeUnRegistro.Where(a => a.id == id).ToList();
            return list;
        }

        public List<EstadosDeUnRegistroDTO>? List(string filtro)
        {
            string caracterdebusqueda = _iconfiguration.GetValue<string>("ParametrosDeLaEmpresa:caracterdebusqueda");
            filtro = filtro.Replace(caracterdebusqueda, "");
            list = _context.EstadosDeUnRegistro.ToList().OrderBy(a => a.nombre).Where(a => a.nombre.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
            return _mapping.ListEstadosDeUnRegistroToEstadosDeUnRegistroDTO(list);
        }

        public void Log(EstadosDeUnRegistro obj, string operacion)
        {
            string comando = "";
            comando = comando + "operacion " + operacion + "\n";

            comando = comando + "id = " + obj.id + "\n";

            comando = comando + "Nombre = " + obj.nombre + "\n";

          

            _logacces.Add(comando);
        }
    }
}