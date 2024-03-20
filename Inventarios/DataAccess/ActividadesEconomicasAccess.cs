using Inventarios.Data;
using Inventarios.DTO;
using Inventarios.Map;
using Inventarios.Models;
using Inventarios.Token;

namespace Inventarios.DataAccess
{
    public class ActividadesEconomicasAccess
    {
        private readonly InventariosContext _context;

        private readonly LogAccess _logacces;

        private readonly Mapping _mapping;

        private List<ActividadesEconomicas>? list;

        public ActividadesEconomicasAccess(InventariosContext context, LogAccess logacces, Mapping mapping)
        {
            _context = context;

            _logacces = logacces;
            _mapping = mapping;
        }

        public List<ActividadesEconomicasDTO>? Add(ActividadesEconomicas obj)
        {
            obj.estadodelregistro = obj.estadodelregistro.ToUpper();
            _context.Actividadeseconomicas.Add(obj);
            _context.SaveChanges();
            this.Log(obj, "Agrego Actividades Economicas");
            list = _context.Actividadeseconomicas.Where(a => a.id == obj.id).ToList();
            return _mapping.ListActividadeseconomicasToActividadeseconomicasDTO(list);
        }

        public List<ActividadesEconomicasDTO> Delete(int id)
        {
            var obj = _context.Actividadeseconomicas.FirstOrDefault(a => a.id == id);
            _context.Actividadeseconomicas.Remove(obj);
            _context.SaveChanges();
            this.Log(obj, "Borro Actividades Economicas");
            list = _context.Actividadeseconomicas.Where(a => a.id == obj.id).ToList();
            return _mapping.ListActividadeseconomicasToActividadeseconomicasDTO(list);
        }

        public List<ActividadesEconomicasDTO>? Update(ActividadesEconomicas? obj)
        {
            obj.estadodelregistro = obj.estadodelregistro.ToUpper();
            var obj_ = _context.Actividadeseconomicas.FirstOrDefault(a => a.id == obj.id);

            obj_.nombre = obj.nombre;

            //
            obj_.estadodelregistro = obj.estadodelregistro;

            _context.SaveChanges();
            this.Log(obj, "Modifico Actividadeseconomicas");

            list = _context.Actividadeseconomicas.Where(a => a.id == obj.id).ToList();
            return _mapping.ListActividadeseconomicasToActividadeseconomicasDTO(list);
        }

        public List<ActividadesEconomicas> GetById(int id)
        {
            list = _context.Actividadeseconomicas.Where(a => a.id == id).ToList();
            return list;
        }

        public List<ActividadesEconomicasDTO>? List(string filtro)
        {
            list = _context.Actividadeseconomicas.ToList().OrderBy(a => a.nombre).Where(a => a.nombre.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
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