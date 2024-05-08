using Inventarios.Data;
using Inventarios.DataAccess.Seguridad;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Map;
using Inventarios.Models.TablasMaestras;

namespace Inventarios.DataAccess.TablasMaestras
{
    public class TiposDePersonaAccess
    {
        private readonly InventariosContext _context;

        private readonly LogAccess _logacces;

        private readonly Mapping _mapping;

        private List<TiposDePersona>? list;

        private readonly IConfiguration _iconfiguration;

        public TiposDePersonaAccess(InventariosContext context, LogAccess logacces, Mapping mapping, IConfiguration iconfiguration)
        {
            _context = context;

            _logacces = logacces;
            _mapping = mapping;
            _iconfiguration = iconfiguration;
        }

        public List<TiposDePersonaDTO>? Add(TiposDePersona obj)
        {
            _context.TiposDePersona.Add(obj);
            _context.SaveChanges();
            Log(obj, "Agrego Color");
            list = _context.TiposDePersona.Where(a => a.id == obj.id).ToList();
            return _mapping.ListTiposDePersonaToTiposDePersonaDTO(list);
        }

        public List<TiposDePersonaDTO> Delete(string id)
        {
            var obj = _context.TiposDePersona.FirstOrDefault(a => a.id == id);
            _context.TiposDePersona.Remove(obj);
            _context.SaveChanges();
            Log(obj, "Borro TiposDePersona");
            list = _context.TiposDePersona.Where(a => a.id == obj.id).ToList();
            return _mapping.ListTiposDePersonaToTiposDePersonaDTO(list);
        }

        public List<TiposDePersonaDTO>? Update(TiposDePersona? obj)
        {
            var obj_ = _context.TiposDePersona.FirstOrDefault(a => a.id == obj.id);

            obj_.nombre = obj.nombre;

            _context.SaveChanges();
            Log(obj, "Modifico Color");

            list = _context.TiposDePersona.Where(a => a.id == obj.id).ToList();
            return _mapping.ListTiposDePersonaToTiposDePersonaDTO(list);
        }

        public List<TiposDePersona> GetById(string id)
        {
            list = _context.TiposDePersona.Where(a => a.id == id).ToList();
            return list;
        }

        public List<TiposDePersonaDTO>? List(string filtro)
        {
            string caracterdebusqueda = _iconfiguration.GetValue<string>("ParametrosDeLaEmpresa:caracterdebusqueda");
            filtro = filtro.Replace(caracterdebusqueda, "");
            list = _context.TiposDePersona.ToList().OrderBy(a => a.nombre).Where(a => a.nombre.Contains(filtro.Trim(), StringComparison.OrdinalIgnoreCase)).ToList();
            return _mapping.ListTiposDePersonaToTiposDePersonaDTO(list);
        }

        public void Log(TiposDePersona obj, string operacion)
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