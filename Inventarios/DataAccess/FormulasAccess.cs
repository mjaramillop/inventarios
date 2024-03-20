using Inventarios.Data;
using Inventarios.DTO;
using Inventarios.Map;
using Inventarios.Models;

namespace Inventarios.DataAccess
{
    public class FormulasAccess
    {
        private readonly InventariosContext _context;

        private readonly LogAccess _logacces;

        private readonly Mapping _mapping;

        private List<Formulas>? list;

        public FormulasAccess(InventariosContext context, LogAccess logacces, Mapping mapping)
        {
            _context = context;

            _logacces = logacces;
            _mapping = mapping;
        }

        public List<FormulasDTO>? Add(Formulas obj)
        {
            _context.Formulas.Add(obj);
            _context.SaveChanges();
            this.Log(obj, "Agrego Formula");
            list = _context.Formulas.Where(a => a.id == obj.id).ToList();
            return _mapping.ListFormulasToFormulasDTO(list);
        }

        public List<FormulasDTO> Delete(int id)
        {
            var obj = _context.Formulas.FirstOrDefault(a => a.id == id);
            _context.Formulas.Remove(obj);
            _context.SaveChanges();
            this.Log(obj, "Borro Formula");

            list = _context.Formulas.Where(a => a.id == obj.id).ToList();
            return _mapping.ListFormulasToFormulasDTO(list);
        }

        public List<FormulasDTO>? Update(Formulas? obj)
        {
            var obj_ = _context.Formulas.FirstOrDefault(a => a.id == obj.id);

            obj_.formula = obj.formula;
            obj_.componente = obj.componente;
            obj_.cantidad = obj.cantidad;
            _context.SaveChanges();
            this.Log(obj, "Modifico Formula");

            list = _context.Formulas.Where(a => a.id == obj.id).ToList();
            return _mapping.ListFormulasToFormulasDTO(list);
        }

        public List<Formulas> GetById(int id)
        {
            list = _context.Formulas.Where(a => a.id == id).ToList();
            return list;
        }

        public List<FormulasDTO>? List(string filtro)
        {
           List<Formulas> list = (from p in _context.Productos
                        join c in _context.Formulas on p.Id equals c.formula
                        where p.Nombre.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase)
                        select new Formulas { id = c.id, formula = c.formula, componente = c.componente, cantidad = c.cantidad }).ToList();
            return _mapping.ListFormulasToFormulasDTO(list);
        }

        public void Log(Formulas obj, string operacion)
        {
            string comando = "";
            comando = comando + "operacion " + operacion + "\n";
            comando = comando + "id = " + obj.id + "\n";
            comando = comando + "Formula = " + obj.formula + "\n";
            comando = comando + "Componente = " + obj.componente + "\n";
            comando = comando + "Cantidad = " + obj.cantidad + "\n";

            _logacces.Add(comando);
        }
    }
}