using Inventarios.DataAccess;
using Inventarios.DTO;
using Inventarios.Models;

namespace Inventarios.services
{
    public class MensajesDelSistemaService
    {

        private readonly MensajesDelSistemaAccess _access;
        public List<MensajesDelSistemaDTO>? list;

        public MensajesDelSistemaService(MensajesDelSistemaAccess access)
        {
            _access = access;

        }

        public List<MensajesDelSistemaDTO>? Add(Mensajesdelsistema obj)
        {
            list = _access.Add(obj);
            return list;
        }

        public List<MensajesDelSistemaDTO>? Delete(int id)
        {
            list = _access.Delete(id);
            return list;
        }

        public List<MensajesDelSistemaDTO>? Update(Mensajesdelsistema obj)
        {
            list = _access.Update(obj);
            return list;
        }


        public List<MensajesDelSistemaDTO>? List(string filtro)
        {
            var list = _access.List(filtro);
            return list;
        }
        public List<MensajesDelSistemaDTO>? ListActive()
        {
            var list = _access.ListActive();
            return list;
        }



    }
}
