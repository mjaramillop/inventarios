using Inventarios.Data;
using Inventarios.DTO;
using Inventarios.Map;
using Inventarios.Models;

namespace Inventarios.DataAccess
{
    public class ConceptosNotaDebitoCreditoAccess
    {
        private readonly InventariosContext _context;

        private readonly LogAccess _logacces;

        private List<ConceptosNotaDebitoCredito>? list;

        public ConceptosNotaDebitoCreditoAccess(InventariosContext context, LogAccess logacces)
        {
            _context = context;

            _logacces = logacces;
        }

        public List<ConceptosNotaDebitoCreditoDTO>? Add(ConceptosNotaDebitoCredito obj)
        {
            obj.estadodelregistro = obj.estadodelregistro.ToUpper();
            _context.ConceptosNotaDebitoCredito.Add(obj);
            _context.SaveChanges();
            this.Log(obj, "Agrego Conceptos Nota debito credito");
            list = _context.ConceptosNotaDebitoCredito.Where(a => a.id == obj.id).ToList();
            return Mapping.ListConceptosNotaDebitoCreditoToConceptosNotaDebitoCreditoDTO(list);
        }

        public List<ConceptosNotaDebitoCreditoDTO> Delete(int id)
        {
            var obj = _context.ConceptosNotaDebitoCredito.FirstOrDefault(a => a.id == id);
            _context.ConceptosNotaDebitoCredito.Remove(obj);
            _context.SaveChanges();
            this.Log(obj, "Borro Conceptos nota debito credito");
            obj.nombre = "Registro borrado satisfactoriamente";
            list = _context.ConceptosNotaDebitoCredito.Where(a => a.id == obj.id).ToList();
            return Mapping.ListConceptosNotaDebitoCreditoToConceptosNotaDebitoCreditoDTO(list);
        }

        public List<ConceptosNotaDebitoCreditoDTO>? Update(ConceptosNotaDebitoCredito? obj)
        {
            obj.estadodelregistro = obj.estadodelregistro.ToUpper();
            var obj_ = _context.ConceptosNotaDebitoCredito.FirstOrDefault(a => a.id == obj.id);
            if (obj_ != null)
            {
                obj_.nombre = obj.nombre;

                //
                obj_.estadodelregistro = obj.estadodelregistro;

                _context.SaveChanges();
                this.Log(obj, "Modifico Conceptos Nota Debito Credito");
            }
            list = _context.ConceptosNotaDebitoCredito.Where(a => a.id == obj.id).ToList();
            return Mapping.ListConceptosNotaDebitoCreditoToConceptosNotaDebitoCreditoDTO(list);
        }

        public List<ConceptosNotaDebitoCredito> GetById(int id)
        {
            list = _context.ConceptosNotaDebitoCredito.Where(a => a.id == id).ToList();
            return list;
        }

        public List<ConceptosNotaDebitoCreditoDTO>? List(string filtro)
        {
            list = _context.ConceptosNotaDebitoCredito.ToList().OrderBy(a => a.nombre).Where(a => a.nombre.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
            return Mapping.ListConceptosNotaDebitoCreditoToConceptosNotaDebitoCreditoDTO(list);
        }

        public List<ConceptosNotaDebitoCreditoDTO>? ListActive(string filtro)
        {
            list = _context.ConceptosNotaDebitoCredito.ToList().OrderBy(a => a.nombre).Where(a => a.estadodelregistro != "I").Where(a => a.nombre.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
            return Mapping.ListConceptosNotaDebitoCreditoToConceptosNotaDebitoCreditoDTO(list);
        }

        public void Log(ConceptosNotaDebitoCredito obj, string operacion)
        {
            string comando = "";
            comando = comando + "operacion " + operacion + "\n";

            comando = comando + "id = " + obj.id + "\n";

            comando = comando + "Nombre = " + obj.nombre + "\n";

            //
            comando = comando + "Estado del Registro = " + obj.estadodelregistro + "\n";

            _logacces.Add(comando);
        }
    }
}
