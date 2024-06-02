using Inventarios.DataAccess.TablasMaestras;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;

namespace Inventarios.services.TablasMaestras
{
    public class EstadosDeUnRegistroService
    {
        private readonly EstadosDeUnRegistroAccess _access;
        public List<EstadosDeUnRegistroDTO>? list;

        public EstadosDeUnRegistroService(EstadosDeUnRegistroAccess access)
        {
            _access = access;
        }

        public Mensaje Add(EstadosDeUnRegistro obj)
        {
            Mensaje list = _access.Add(obj);
            return list;
        }

        public Mensaje Delete(int id)
        {
            Mensaje list = _access.Delete(id);
            return list;
        }

        public Mensaje Update(EstadosDeUnRegistro obj)
        {
            Mensaje list = _access.Update(obj);
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