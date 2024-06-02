using Inventarios.DataAccess.TablasMaestras;
using Inventarios.DTO;
using Inventarios.Models.TablasMaestras;

namespace Inventarios.services.TablasMaestras
{
    public class ConceptosNotaDebitoCreditoService
    {
        private readonly ConceptosNotaDebitoCreditoAccess _access;
        public List<ConceptosNotaDebitoCreditoDTO>? list;

        public ConceptosNotaDebitoCreditoService(ConceptosNotaDebitoCreditoAccess access)
        {
            _access = access;
        }

        public Mensaje Add(ConceptosNotaDebitoCredito obj)
        {
            Mensaje list = _access.Add(obj);
            return list;
        }

        public Mensaje Delete(int id)
        {
            Mensaje list = _access.Delete(id);
            return list;
        }

        public Mensaje Update(ConceptosNotaDebitoCredito obj)
        {
            Mensaje list = _access.Update(obj);
            return list;
        }

        public List<ConceptosNotaDebitoCredito>? GetById(int id)
        {
            List<ConceptosNotaDebitoCredito> list = _access.GetById(id);

            return list;
        }

        public List<ConceptosNotaDebitoCreditoDTO>? List(string filtro)
        {
            var list = _access.List(filtro);
            return list;
        }
    }
}