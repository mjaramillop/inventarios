using Inventarios.Data;
using Inventarios.DataAccess.Seguridad;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Map;
using Inventarios.Models.TablasMaestras;

namespace Inventarios.DataAccess.TablasMaestras
{
    public class TiposDeRegimenAccess
    {
        private readonly InventariosContext _context;

        private readonly LogAccess _logacces;

        private readonly Mapping _mapping;

        private List<TiposDeRegimen>? list;

        private readonly IConfiguration _iconfiguration;

        public TiposDeRegimenAccess(InventariosContext context, LogAccess logacces, Mapping mapping, IConfiguration iconfiguration)
        {
            _context = context;

            _logacces = logacces;
            _mapping = mapping;
            _iconfiguration = iconfiguration;
        }

        public List<TiposDeRegimenDTO>? Add(TiposDeRegimen obj)
        {
            _context.TiposDeRegimen.Add(obj);
            _context.SaveChanges();
            Log(obj, "Agrego Tipo de regimen");
            list = _context.TiposDeRegimen.Where(a => a.id == obj.id).ToList();
            return _mapping.ListTiposDeRegimenToTiposDeRegimenDTO(list);
        }

        public List<TiposDeRegimenDTO> Delete(int id)
        {
            var obj = _context.TiposDeRegimen.FirstOrDefault(a => a.id == id);
            _context.TiposDeRegimen.Remove(obj);
            _context.SaveChanges();
            Log(obj, "Borro Tipo de regimen");
            list = _context.TiposDeRegimen.Where(a => a.id == obj.id).ToList();
            return _mapping.ListTiposDeRegimenToTiposDeRegimenDTO(list);
        }

        public List<TiposDeRegimenDTO>? Update(TiposDeRegimen? obj)
        {
            var obj_ = _context.TiposDeRegimen.FirstOrDefault(a => a.id == obj.id);

            obj_.nombre = obj.nombre;



            _context.SaveChanges();
            Log(obj, "Modifico Tipo de regimen");

            list = _context.TiposDeRegimen.Where(a => a.id == obj.id).ToList();
            return _mapping.ListTiposDeRegimenToTiposDeRegimenDTO(list);
        }

        public List<TiposDeRegimen> GetById(int id)
        {

            list = _context.TiposDeRegimen.Where(a => a.id == id).ToList();
            return list;
        }

        public List<TiposDeRegimenDTO>? List(string filtro)
        {
            string caracterdebusqueda = _iconfiguration.GetValue<string>("ParametrosDeLaEmpresa:caracterdebusqueda");
            filtro = filtro.Replace(caracterdebusqueda, "");
            list = _context.TiposDeRegimen.ToList().OrderBy(a => a.nombre).Where(a => a.nombre.Contains(filtro.Trim(), StringComparison.OrdinalIgnoreCase)).ToList();
            return _mapping.ListTiposDeRegimenToTiposDeRegimenDTO(list);
        }

        public void Log(TiposDeRegimen obj, string operacion)
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

