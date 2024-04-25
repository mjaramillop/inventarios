using Inventarios.Data;
using Inventarios.DataAccess.Seguridad;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Map;
using Inventarios.Models.TablasMaestras;



namespace Inventarios.DataAccess.TablasMaestras
{
    public class ActividadesEconomicasAccess
    {
        private readonly InventariosContext _context;

        private readonly LogAccess _logacces;

        private readonly Mapping _mapping;

        private List<ActividadesEconomicas>? list;

        private readonly IConfiguration _iconfiguration;

        public ActividadesEconomicasAccess(InventariosContext context, LogAccess logacces, Mapping mapping, IConfiguration iconfiguration)
        {
            _context = context;

            _logacces = logacces;
            _mapping = mapping;
            _iconfiguration = iconfiguration;
        }

        public List<ActividadesEconomicasDTO>? Add(ActividadesEconomicas obj)
        {
            _context.ActividadesEconomicas.Add(obj);
            _context.SaveChanges();
            Log(obj, "Agrego Actividades Economicas");
            list = _context.ActividadesEconomicas.Where(a => a.id == obj.id).ToList();
            return _mapping.ListActividadeseconomicasToActividadeseconomicasDTO(list);
        }

        public List<ActividadesEconomicasDTO> Delete(int id)
        {
            var obj = _context.ActividadesEconomicas.FirstOrDefault(a => a.id == id);
            _context.ActividadesEconomicas.Remove(obj);
            _context.SaveChanges();
            Log(obj, "Borro Actividades Economicas");
            list = _context.ActividadesEconomicas.Where(a => a.id == obj.id).ToList();
            return _mapping.ListActividadeseconomicasToActividadeseconomicasDTO(list);
        }

        public List<ActividadesEconomicasDTO>? Update(ActividadesEconomicas? obj)
        {
            var obj_ = _context.ActividadesEconomicas.FirstOrDefault(a => a.id == obj.id);

            obj_.nombre = obj.nombre;

            obj_.estadodelregistro = obj.estadodelregistro;

            _context.SaveChanges();
            Log(obj, "Modifico Actividadeseconomicas");

            list = _context.ActividadesEconomicas.Where(a => a.id == obj.id).ToList();
            return _mapping.ListActividadeseconomicasToActividadeseconomicasDTO(list);
        }

        public List<ActividadesEconomicas> GetById(int id)
        {
            list = _context.ActividadesEconomicas.Where(a => a.id == id).ToList();
            return list;
        }

        public List<ActividadesEconomicasDTO>? List(string filtro)
        {
            string caracterdebusqueda = _iconfiguration.GetValue<string>("ParametrosDeLaEmpresa:caracterdebusqueda");
            filtro = filtro.Replace(caracterdebusqueda, "");
            list = _context.ActividadesEconomicas.ToList().OrderBy(a => a.nombre).Where(a => a.nombre.Contains(filtro.Trim(), StringComparison.OrdinalIgnoreCase)).ToList();
            return _mapping.ListActividadeseconomicasToActividadeseconomicasDTO(list);
        }

        public void Log(ActividadesEconomicas obj, string operacion)
        {
            string comando = "";
            comando = comando + "operacion " + operacion + "\n";

            comando = comando + "id = " + obj.id + "\n";

            comando = comando + "Nombre = " + obj.nombre + "\n";

            //
            comando = comando + "Estado del Registro = " + obj.estadodelregistro + "\n";

            _logacces.Add(comando);
        }
    }
}