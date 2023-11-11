using Inventarios.DataAccess;
using Inventarios.DTO;
using Inventarios.Models;
using Inventarios.ModelsParameter;

namespace Inventarios.services
{
    public class LogService
    {


        private readonly LogAccess _access;
        public List<LogDTO>? list;

        public LogService(LogAccess access)
        {
            _access = access;

        }

     

        public List<LogDTO>? List( LogConsultar obj)
        {
            var list = _access.List(obj);
            return list;
        }

    }
}
