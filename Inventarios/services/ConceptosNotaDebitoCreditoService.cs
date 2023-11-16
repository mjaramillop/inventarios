using Inventarios.DataAccess;
using Inventarios.DTO;
using Inventarios.Models;

namespace Inventarios.services
{
    public class ConceptosNotaDebitoCreditoService
    {
        private readonly ConceptosNotaDebitoCreditoAccess _access;
        public List<ConceptosNotaDebitoCreditoDTO>? list;

        public ConceptosNotaDebitoCreditoService(ConceptosNotaDebitoCreditoAccess access)
        {
            _access = access;

        }

        public List<ConceptosNotaDebitoCreditoDTO>? Add(ConceptosNotaDebitoCredito obj)
        {
            list = _access.Add(obj);
            return list;
        }

        public List<ConceptosNotaDebitoCreditoDTO>? Delete(int id)
        {
            list = _access.Delete(id);
            return list;
        }

        public List<ConceptosNotaDebitoCreditoDTO>? Update(ConceptosNotaDebitoCredito obj)
        {
            list = _access.Update(obj);
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

        public List<ConceptosNotaDebitoCreditoDTO>? ListActive(string filtro)
        {
            var list = _access.ListActive(filtro);
            return list;
        }

    }
}
