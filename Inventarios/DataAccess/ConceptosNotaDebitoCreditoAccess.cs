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

        private readonly Mapping _mapping;

        private List<ConceptosNotaDebitoCredito>? list;

        private readonly IConfiguration _iconfiguration;

        public ConceptosNotaDebitoCreditoAccess(InventariosContext context, LogAccess logacces, Mapping mapping, IConfiguration iconfiguration)
        {
            _context = context;

            _logacces = logacces;
            _mapping = mapping;
            _iconfiguration = iconfiguration;
        }

        public List<ConceptosNotaDebitoCreditoDTO>? Add(ConceptosNotaDebitoCredito obj)
        {
          
            _context.ConceptosNotaDebitoCredito.Add(obj);
            _context.SaveChanges();
            this.Log(obj, "Agrego Conceptos Nota debito credito");
            list = _context.ConceptosNotaDebitoCredito.Where(a => a.id == obj.id).ToList();
            return _mapping.ListConceptosNotaDebitoCreditoToConceptosNotaDebitoCreditoDTO(list);
        }

        public List<ConceptosNotaDebitoCreditoDTO> Delete(int id)
        {
            var obj = _context.ConceptosNotaDebitoCredito.FirstOrDefault(a => a.id == id);
            _context.ConceptosNotaDebitoCredito.Remove(obj);
            _context.SaveChanges();
            this.Log(obj, "Borro Conceptos nota debito credito");
            list = _context.ConceptosNotaDebitoCredito.Where(a => a.id == obj.id).ToList();
            return _mapping.ListConceptosNotaDebitoCreditoToConceptosNotaDebitoCreditoDTO(list);
        }

        public List<ConceptosNotaDebitoCreditoDTO>? Update(ConceptosNotaDebitoCredito? obj)
        {
          
            var obj_ = _context.ConceptosNotaDebitoCredito.FirstOrDefault(a => a.id == obj.id);

            obj_.nombre = obj.nombre;

            //
            obj_.estadodelregistro = obj.estadodelregistro;

            _context.SaveChanges();
            this.Log(obj, "Modifico Conceptos Nota Debito Credito");

            list = _context.ConceptosNotaDebitoCredito.Where(a => a.id == obj.id).ToList();
            return _mapping.ListConceptosNotaDebitoCreditoToConceptosNotaDebitoCreditoDTO(list);
        }

        public List<ConceptosNotaDebitoCredito> GetById(int id)
        {
            list = _context.ConceptosNotaDebitoCredito.Where(a => a.id == id).ToList();
            return list;
        }

        public List<ConceptosNotaDebitoCreditoDTO>? List(string filtro)
        {
            string caracterdebusqueda = _iconfiguration.GetValue<string>("ParametrosDeLaEmpresa:caracterdebusqueda");
            filtro = filtro.Replace(caracterdebusqueda, "");
            list = _context.ConceptosNotaDebitoCredito.ToList().OrderBy(a => a.nombre).Where(a => a.nombre.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
            return _mapping.ListConceptosNotaDebitoCreditoToConceptosNotaDebitoCreditoDTO(list);
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