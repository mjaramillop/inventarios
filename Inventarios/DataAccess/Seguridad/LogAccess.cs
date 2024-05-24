using Inventarios.Data;
using Inventarios.DataAccess.Utils;
using Inventarios.DTO;
using Inventarios.Map;
using Inventarios.Models.Seguridad;
using Inventarios.ModelsParameter.Seguridad;

using System.Data;
using System.Linq.Dynamic.Core;

namespace Inventarios.DataAccess.Seguridad
{
    public class LogAccess
    {
        private readonly InventariosContext _context;
        
        private readonly IConfiguration _iconfiguration;
        private readonly Mapping _mapping;
       

        public LogAccess(InventariosContext context, IConfiguration iconfigutarion, Mapping mapping, IConfiguration iconfiguration)
        {
            _context = context;
            
            _iconfiguration = iconfigutarion;
            _mapping = mapping;
          
        }

        public void Add(string registro)
        {

          
            Log log = new Log();
            log.fechadeactualizacion = DateTime.Now;
            log.descripciondelaoperacion = registro;

            _context.Logs.Add(log);
            _context.SaveChanges();
        }

        public List<LogDTO> List(LogConsultar? obj)
        {
            string? comando = " a => a.id >0  ";
            if (obj.fechadesde != null) comando = comando + " && a.fechadeactualizacion>=DateTime(\"" + obj.fechadesde.Value.ToString(_iconfiguration.GetValue<string>("ParametrosDeLaEmpresa:formatodefechaparalasconsultassql")) + "\") ";
            if (obj.fechahasta != null) comando = comando + " && a.fechadeactualizacion<DateTime(\"" + obj.fechahasta.Value.AddDays(1).ToString(_iconfiguration.GetValue<string>("ParametrosDeLaEmpresa:formatodefechaparalasconsultassql")) + "\") ";
            if (obj.filtro1.Trim().Length > 0) comando = comando + " && a.descripciondelaoperacion.Contains(\"" + obj.filtro1 + "\")";
            if (obj.filtro2.Trim().Length > 0) comando = comando + " && a.descripciondelaoperacion.Contains(\"" + obj.filtro2 + "\")";
            if (obj.filtro3.Trim().Length > 0) comando = comando + " && a.descripciondelaoperacion.Contains(\"" + obj.filtro3 + "\")";
            if (obj.filtro4.Trim().Length > 0) comando = comando + " && a.descripciondelaoperacion.Contains(\"" + obj.filtro4 + "\")";
            if (obj.filtro5.Trim().Length > 0) comando = comando + " && a.descripciondelaoperacion.Contains(\"" + obj.filtro5 + "\")";

            var list = _context.Logs.OrderByDescending(a => a.fechadeactualizacion).Where(comando).ToList();

            return _mapping.ListLogToLogDTO(list);
        }

        public List<string> DeleteLog(string fecha)
        {
            string? comando = "  ";

            comando = "DELETE  FROM LOG WHERE FECHA_DE_ACTUALIZACION <" + "'" + fecha + "'";

            Utilidades ru = new(_iconfiguration);

            string mensaje = ru.ejecutarsql(comando);
            if (mensaje.Trim().Length == 0) mensaje = "Registros eliminados correctamente antes del " + fecha;

            return new List<string>() { mensaje };
        }
    }
}