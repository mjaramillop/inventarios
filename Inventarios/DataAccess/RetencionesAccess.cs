using Inventarios.Data;
using Inventarios.DTO;
using Inventarios.Map;
using Inventarios.Models;

namespace Inventarios.DataAccess
{
    public class RetencionesAccess
    {
        private readonly InventariosContext _context;

        private readonly LogAccess _logacces;

        private readonly Mapping _mapping;

        private List<Retenciones>? list;

        private readonly IConfiguration _iconfiguration;

        public RetencionesAccess(InventariosContext context, LogAccess logacces, Mapping mapping, IConfiguration iconfiguration)
        {
            _context = context;

            _logacces = logacces;
            _mapping = mapping;
            _iconfiguration = iconfiguration;
        }

        public List<RetencionesDTO>? Add(Retenciones obj)
        {
          
            _context.Retenciones.Add(obj);
            _context.SaveChanges();
            this.Log(obj, "Agrego Retencion");
            list = _context.Retenciones.Where(a => a.id == obj.id).ToList();
            return _mapping.ListRetencionesToRetencionesDTO(list);
        }

        public List<RetencionesDTO> Delete(int id)
        {
            var obj = _context.Retenciones.FirstOrDefault(a => a.id == id);
            _context.Retenciones.Remove(obj);
            _context.SaveChanges();
            this.Log(obj, "Borro Retencion");
            list = _context.Retenciones.Where(a => a.id == obj.id).ToList();
            return _mapping.ListRetencionesToRetencionesDTO(list);
        }

        public List<RetencionesDTO>? Update(Retenciones? obj)
        {
           
            var obj_ = _context.Retenciones.FirstOrDefault(a => a.id == obj.id);

            obj_.nombre = obj.nombre;
            obj_.basedelaretencion = obj.basedelaretencion;

            //
            obj_.estadodelregistro = obj.estadodelregistro;

            _context.SaveChanges();
            this.Log(obj, "Modifico Retencion");

            list = _context.Retenciones.Where(a => a.id == obj.id).ToList();
            return _mapping.ListRetencionesToRetencionesDTO(list);
        }

        public List<Retenciones> GetById(int id)
        {
            list = _context.Retenciones.Where(a => a.id == id).ToList();
            return list;
        }

        public List<RetencionesDTO>? List(string filtro)
        {
            string caracterdebusqueda = _iconfiguration.GetValue<string>("ParametrosDeLaEmpresa:caracterdebusqueda");
            filtro = filtro.Replace(caracterdebusqueda, "");
            list = _context.Retenciones.ToList().OrderBy(a => a.nombre).Where(a => a.nombre.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
            return _mapping.ListRetencionesToRetencionesDTO(list);
        }

        public void Log(Retenciones obj, string operacion)
        {
            string comando = "";
            comando = comando + "operacion " + operacion + "\n";
            comando = comando + "id = " + obj.id + "\n";
            comando = comando + "Nombre = " + obj.nombre + "\n";
            comando = comando + "Base de la retencion = " + obj.basedelaretencion + "\n";
            //
            comando = comando + "Estado del Registro = " + obj.estadodelregistro + "\n";

            _logacces.Add(comando);
        }
    }
}
