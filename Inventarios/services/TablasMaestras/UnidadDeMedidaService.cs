using Inventarios.DataAccess.TablasMaestras;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;

namespace Inventarios.services.TablasMaestras
{
    public class UnidadesDeMedidaService
    {
        private readonly UnidadesDeMedidaAccess _access;
        public List<UnidadesDeMedidaDTO>? list;

        public UnidadesDeMedidaService(UnidadesDeMedidaAccess access)
        {
            _access = access;
        }

        public Mensaje Add(UnidadesDeMedida obj)
        {
            Mensaje list = _access.Add(obj);
            return list;
        }

        public Mensaje Delete(int id)
        {
            Mensaje list = _access.Delete(id);
            return list;
        }

        public Mensaje Update(UnidadesDeMedida obj)
        {
            Mensaje list = _access.Update(obj);
            return list;
        }

        public List<UnidadesDeMedida>? GetById(int id)
        {
            List<UnidadesDeMedida> list = _access.GetById(id);

            return list;
        }

        public List<UnidadesDeMedidaDTO>? List(string filtro)
        {
            var list = _access.List(filtro);
            return list;
        }
    }
}