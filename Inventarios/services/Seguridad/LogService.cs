using Inventarios.DataAccess.Seguridad;
using Inventarios.DTO;
using Inventarios.Models.TablasMaestras;
using Inventarios.ModelsParameter.Seguridad;

namespace Inventarios.services.Seguridad
{
    public class LogService
    {
        private readonly LogAccess _access;
        public List<LogDTO>? list;

        public LogService(LogAccess access)
        {
            _access = access;
        }

        public List<LogDTO>? List(LogConsultar obj)
        {
            var list = _access.List(obj);
            return list;
        }

        public Mensaje DeleteLog(string fecha)
        {
            Mensaje list = _access.DeleteLog(fecha);
            return list;
        }
    }
}