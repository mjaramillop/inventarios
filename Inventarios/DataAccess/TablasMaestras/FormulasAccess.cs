using Inventarios.Data;
using Inventarios.DataAccess.Seguridad;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Map;
using Inventarios.Models.TablasMaestras;
using Inventarios.Utils;

namespace Inventarios.DataAccess.TablasMaestras
{
    public class FormulasAccess
    {
        private readonly InventariosContext _context;

        private readonly LogAccess _logacces;

        private readonly Mapping _mapping;

        private List<Formulas>? list;

        private readonly IConfiguration _iconfiguration;

        private readonly Validaciones _validar;

        public FormulasAccess(InventariosContext context, LogAccess logacces, Mapping mapping, IConfiguration iconfiguration, Validaciones validar)
        {
            _context = context;

            _logacces = logacces;
            _mapping = mapping;
            _iconfiguration = iconfiguration;
            _validar = validar;
        }

        public Mensaje Add(Formulas obj)
        {
            if (this.ValidarRegistro(obj).IndexOf("Error.") >= 0) return new Mensaje() { mensaje = this.ValidarRegistro(obj) };

            _context.Formulas.Add(obj);
            _context.SaveChanges();
            ActualizarCostoDeLaFormula(obj.formula);

            Log(obj, "Agrego Formula");
            return new Mensaje() { mensaje = "registro insertado ok " };
        }

        public Mensaje Delete(int id)
        {
            var obj = _context.Formulas.FirstOrDefault(a => a.id == id);
            _context.Formulas.Remove(obj);
            _context.SaveChanges();
            ActualizarCostoDeLaFormula(obj.formula);
            Log(obj, "Borro Formula");

            return new Mensaje() { mensaje = "registro borrado ok " };
        }

        public Mensaje Update(Formulas? obj)
        {
            if (this.ValidarRegistro(obj).IndexOf("Error.") >= 0) return new Mensaje() { mensaje = this.ValidarRegistro(obj) };

            var obj_ = _context.Formulas.FirstOrDefault(a => a.id == obj.id);

            obj_.formula = obj.formula;
            obj_.componente = obj.componente;
            obj_.cantidad = obj.cantidad;
            obj_.idusuario = obj.idusuario;
            obj_.nombreusuario = obj.nombreusuario;
            obj_.estadodelregistro = obj.estadodelregistro;

            _context.SaveChanges();
            ActualizarCostoDeLaFormula(obj.formula);
            Log(obj, "Modifico Formula");

            return new Mensaje() { mensaje = "registro modificado ok " };
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

        public string ValidarRegistro(Formulas obj)
        {
            string mensajedeerror = "";
            mensajedeerror = mensajedeerror + _validar.ValidarProducto(obj.formula);
            mensajedeerror = mensajedeerror + _validar.ValidarProducto(obj.componente);
            mensajedeerror = mensajedeerror + _validar.Validarvalormayorquecero("cantidad", obj.cantidad);

            if (mensajedeerror.IndexOf("Error.") >= 0)
            {
                int posicioninicial = mensajedeerror.IndexOf("Error.");
                int posicionfinial = mensajedeerror.IndexOf(",");

                mensajedeerror = mensajedeerror.Substring(posicioninicial, posicionfinial - posicioninicial);


            }
            return mensajedeerror;
        }
    }
}