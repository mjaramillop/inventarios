using Inventarios.Data;
using Inventarios.DataAccess.Seguridad;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Map;
using Inventarios.Models.TablasMaestras;

namespace Inventarios.DataAccess.TablasMaestras
{
    public class FormulasAccess
    {
        private readonly InventariosContext _context;

        private readonly LogAccess _logacces;

        private readonly Mapping _mapping;

        private List<Formulas>? list;

        private readonly IConfiguration _iconfiguration;

        public FormulasAccess(InventariosContext context, LogAccess logacces, Mapping mapping, IConfiguration iconfiguration)
        {
            _context = context;

            _logacces = logacces;
            _mapping = mapping;
            _iconfiguration = iconfiguration;
        }

        public List<FormulasDTO>? Add(Formulas obj)
        {
            _context.Formulas.Add(obj);
            _context.SaveChanges();
            ActualizarCostoDeLaFormula(obj.formula);

            Log(obj, "Agrego Formula");
            list = _context.Formulas.Where(a => a.id == obj.id).ToList();
            return _mapping.ListFormulasToFormulasDTO(list);
        }

        public List<FormulasDTO> Delete(int id)
        {
            var obj = _context.Formulas.FirstOrDefault(a => a.id == id);
            _context.Formulas.Remove(obj);
            _context.SaveChanges();
            ActualizarCostoDeLaFormula(obj.formula);
            Log(obj, "Borro Formula");

            list = _context.Formulas.Where(a => a.id == obj.id).ToList();
            return _mapping.ListFormulasToFormulasDTO(list);
        }

        public List<FormulasDTO>? Update(Formulas? obj)
        {
            var obj_ = _context.Formulas.FirstOrDefault(a => a.id == obj.id);

            obj_.formula = obj.formula;
            obj_.componente = obj.componente;
            obj_.cantidad = obj.cantidad;
            obj_.idusuario = obj.idusuario;
            obj_.nombreusuario = obj.nombreusuario;

            _context.SaveChanges();
            ActualizarCostoDeLaFormula(obj.formula);
            Log(obj, "Modifico Formula");

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
            string caracterdebusqueda = _iconfiguration.GetValue<string>("ParametrosDeLaEmpresa:caracterdebusqueda");
            filtro = filtro.Replace(caracterdebusqueda, "");
            var list = (from p in _context.Productos
                        join c in _context.Formulas on p.id equals c.formula
                        where p.nombre.Contains(filtro.Trim())
                        select c).ToList();
            return _mapping.ListFormulasToFormulasDTO(list);
        }

        public void ActualizarCostoDeLaFormula(int formula)
        {
            List<Formulas> listformulas = new List<Formulas>();

            listformulas = _context.Formulas.Where(a => a.formula == formula).ToList();
            decimal totalcostodelaformula = 0;

            foreach (var s in listformulas)
            {
                Productos producto = new Productos();
                int idcomponente = s.componente;
                producto = _context.Productos.Find(idcomponente);
                decimal costodelcomponente = s.cantidad * producto.costoultimo;
                totalcostodelaformula = totalcostodelaformula + costodelcomponente;
            }

            Productos formulaaactualizar = new Productos();
            formulaaactualizar = _context.Productos.FirstOrDefault(a => a.id == formula);

            formulaaactualizar.costoultimo = totalcostodelaformula;

            _context.SaveChanges();
        }

        public void Log(Formulas obj, string operacion)
        {
            string comando = "";
            comando = comando + "usuario " + obj.nombreusuario + "\n";
            comando = comando + "operacion " + operacion + "\n";
            comando = comando + "id = " + obj.id + "\n";
            comando = comando + "Formula = " + obj.formula + "\n";
            comando = comando + "Componente = " + obj.componente + "\n";
            comando = comando + "Cantidad = " + obj.cantidad + "\n";

            _logacces.Add(comando);
        }
    }
}