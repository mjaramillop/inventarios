using Inventarios.DataAccess.TablasMaestras;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;

namespace Inventarios.services.TablasMaestras
{
    public class SaldosService
    {
        private readonly SaldosAccess _access;
        public List<SaldosDTO>? list;

        public SaldosService(SaldosAccess access)
        {
            _access = access;
        }

        public List<SaldosDTO>? Add(Saldos obj)
        {
            list = _access.Add(obj);
            return list;
        }

        public List<SaldosDTO>? Delete(int id)
        {
            list = _access.Delete(id);
            return list;
        }

        public List<SaldosDTO>? Update(Saldos obj)
        {
            list = _access.Update(obj);
            return list;
        }

        public List<Saldos>? GetById(int id)
        {
            List<Saldos> list = _access.GetById(id);

            return list;
        }

        public List<SaldosDTO>? List(string filtro, string bodega)
        {
            var list = _access.List(filtro, bodega);
            return list;
        }
    }
}