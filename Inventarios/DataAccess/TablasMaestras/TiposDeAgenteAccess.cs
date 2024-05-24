using Inventarios.Data;
using Inventarios.DataAccess.Seguridad;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Map;
using Inventarios.Models.TablasMaestras;

namespace Inventarios.DataAccess.TablasMaestras
{
    public class TiposDeAgenteAccess
    {
        private readonly InventariosContext _context;

        private readonly LogAccess _logacces;

        private readonly Mapping _mapping;

        private List<TiposDeAgente>? list;

        private readonly IConfiguration _iconfiguration;

        public TiposDeAgenteAccess(InventariosContext context, LogAccess logacces, Mapping mapping, IConfiguration iconfiguration)
        {
            _context = context;

            _logacces = logacces;
            _mapping = mapping;
            _iconfiguration = iconfiguration;
        }

        public List<TiposDeAgenteDTO>? Add(TiposDeAgente obj)
        {
            _context.TiposDeAgente.Add(obj);
            _context.SaveChanges();
            Log(obj, "Agrego Tipo de agente");
            list = _context.TiposDeAgente.Where(a => a.id == obj.id).ToList();
            return _mapping.ListTiposDeAgenteToTiposDeAgenteDTO(list);
        }

        public List<TiposDeAgenteDTO> Delete(int id)
        {
            var obj = _context.TiposDeAgente.FirstOrDefault(a => a.id == id);
            _context.TiposDeAgente.Remove(obj);
            _context.SaveChanges();
            Log(obj, "Borro Tipo de agente");
            list = _context.TiposDeAgente.Where(a => a.id == obj.id).ToList();
            return _mapping.ListTiposDeAgenteToTiposDeAgenteDTO(list);
        }

        public List<TiposDeAgenteDTO>? Update(TiposDeAgente? obj)
        {
            var obj_ = _context.TiposDeAgente.FirstOrDefault(a => a.id == obj.id);

            obj_.nombre = obj.nombre;

            _context.SaveChanges();
            Log(obj, "Modifico Tipo de agente");

            list = _context.TiposDeAgente.Where(a => a.id == obj.id).ToList();
            return _mapping.ListTiposDeAgenteToTiposDeAgenteDTO(list);
        }

        public List<TiposDeAgente> GetById(int id)
        {
            list = _context.TiposDeAgente.Where(a => a.id == id).ToList();
            return list;
        }

        public List<TiposDeAgenteDTO>? List(string filtro)
        {
            string caracterdebusqueda = _iconfiguration.GetValue<string>("ParametrosDeLaEmpresa:caracterdebusqueda");
            filtro = filtro.Replace(caracterdebusqueda, "");
            list = _context.TiposDeAgente.ToList().OrderBy(a => a.nombre).Where(a => a.nombre.Contains(filtro.Trim(), StringComparison.OrdinalIgnoreCase)).ToList();
            return _mapping.ListTiposDeAgenteToTiposDeAgenteDTO(list);
        }

        public void Log(TiposDeAgente obj, string operacion)
        {
            string comando = "";
            comando = comando + "usuario " + obj.nombreusuario + "\n";

            comando = comando + "operacion " + operacion + "\n";

            comando = comando + "id = " + obj.id + "\n";

            comando = comando + "Nombre = " + obj.nombre + "\n";


            //

            _logacces.Add(comando);
        }
    }
}