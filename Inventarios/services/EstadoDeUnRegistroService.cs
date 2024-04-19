

using Inventarios.DataAccess;
using Inventarios.DTO;
using Inventarios.Models;

namespace Inventarios.services
{
    public class EstadosDeUnRegistroService
    {

        private readonly EstadosDeUnRegistroAccess _access;
        public List<EstadosDeUnRegistroDTO>? list;

        public EstadosDeUnRegistroService(EstadosDeUnRegistroAccess access)
        {
            _access = access;

        }

        public List<EstadosDeUnRegistroDTO>? Add(EstadosDeUnRegistro obj)
        {
            list = _access.Add(obj);
            return list;
        }

        public List<EstadosDeUnRegistroDTO>? Delete(int id)
        {
            list = _access.Delete(id);
            return list;
        }

        public List<EstadosDeUnRegistroDTO>? Update(EstadosDeUnRegistro obj)
        {
            list = _access.Update(obj);
            return list;
        }

        public List<EstadosDeUnRegistro>? GetById(int id)
        {
            List<EstadosDeUnRegistro> list = _access.GetById(id);

            return list;
        }

        public List<EstadosDeUnRegistroDTO>? List(string filtro)
        {
            var list = _access.List(filtro);
            return list;
        }





    }
}
