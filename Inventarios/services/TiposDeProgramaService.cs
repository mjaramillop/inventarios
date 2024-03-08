using Inventarios.DataAccess;
using Inventarios.DTO;
using Inventarios.Models;

namespace Inventarios.services
{
    public class TiposDeProgramaService
    {
        private readonly TiposDeProgramaAccess _access;
        public List<TiposDeProgramaDTO>? list;

        public TiposDeProgramaService(TiposDeProgramaAccess access)
        {
            _access = access;

        }

        public List<TiposDeProgramaDTO>? Add(TiposDePrograma obj)
        {
            list = _access.Add(obj);
            return list;
        }

        public List<TiposDeProgramaDTO>? Delete(int id)
        {
            list = _access.Delete(id);
            return list;
        }

        public List<TiposDeProgramaDTO>? Update(TiposDePrograma obj)
        {
            list = _access.Update(obj);
            return list;
        }

        public List<TiposDePrograma>? GetById(int id)
        {
            List<TiposDePrograma> list = _access.GetById(id);

            return list;
        }

        public List<TiposDeProgramaDTO>? List(string filtro)
        {
            var list = _access.List(filtro);
            return list;
        }

      

    }
}
