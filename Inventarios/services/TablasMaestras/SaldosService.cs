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

        public Mensaje Add(Saldos obj)
        {
            Mensaje list = _access.Add(obj);
            return list;
        }

        public Mensaje Delete(int id)
        {
            Mensaje list = _access.Delete(id);
            return list;
        }

        public Mensaje Update(Saldos obj)
        {
            Mensaje list = _access.Update(obj);
            return list;
        }

        public List<Saldos>? GetById(int id)
        {
            List<Saldos> list = _access.GetById(id);

            return list;
        }

        public List<SaldosDTO>? List(string filtro, string bodega, int opcion, int diassinrotar)
        {
            var list = _access.List(filtro, bodega,opcion,diassinrotar);
            return list;
        }
    }
}