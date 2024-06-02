using Inventarios.Data;
using Inventarios.DataAccess.Seguridad;
using Inventarios.DTO;
using Inventarios.Map;
using Inventarios.Models.TablasMaestras;
using Inventarios.Utils;

namespace Inventarios.DataAccess.TablasMaestras
{
    public class ConceptosNotaDebitoCreditoAccess
    {
        private readonly InventariosContext _context;

        private readonly LogAccess _logacces;

        private readonly Mapping _mapping;

        private List<ConceptosNotaDebitoCredito>? list;

        private readonly IConfiguration _iconfiguration;

        private readonly Validaciones _validar;

        public ConceptosNotaDebitoCreditoAccess(InventariosContext context, LogAccess logacces, Mapping mapping, IConfiguration iconfiguration, Validaciones validar)
        {
            _context = context;

            _logacces = logacces;
            _mapping = mapping;
            _iconfiguration = iconfiguration;
            _validar = validar;
        }

        public Mensaje Add(ConceptosNotaDebitoCredito obj)
        {
            if (this.ValidarRegistro(obj).IndexOf("Error.") >= 0) return new Mensaje() { mensaje = this.ValidarRegistro(obj) };

            _context.ConceptosNotaDebitoCredito.Add(obj);
            _context.SaveChanges();
            Log(obj, "Agrego Conceptos Nota debito credito");

            return new Mensaje() { mensaje = "registro insertado ok " };
        }

        public Mensaje Delete(int id)
        {
            var obj = _context.ConceptosNotaDebitoCredito.FirstOrDefault(a => a.id == id);
            _context.ConceptosNotaDebitoCredito.Remove(obj);
            _context.SaveChanges();
            Log(obj, "Borro Conceptos nota debito credito");

            return new Mensaje() { mensaje = "registro insertado ok " };
        }

        public Mensaje Update(ConceptosNotaDebitoCredito? obj)
        {
            if (this.ValidarRegistro(obj).IndexOf("Error.") >= 0) return new Mensaje() { mensaje = this.ValidarRegistro(obj) };

            var obj_ = _context.ConceptosNotaDebitoCredito.FirstOrDefault(a => a.id == obj.id);

            obj_.nombre = obj.nombre;
            obj_.idusuario = obj.idusuario;
            obj_.nombreusuario = obj.nombreusuario;

            obj_.estadodelregistro = obj.estadodelregistro;

            _context.SaveChanges();
            Log(obj, "Modifico Conceptos Nota Debito Credito");
            return new Mensaje() { mensaje = "registro modificado ok " };
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
            list = _context.ConceptosNotaDebitoCredito.ToList().OrderBy(a => a.nombre).Where(a => a.nombre.Contains(filtro.Trim(), StringComparison.OrdinalIgnoreCase)).ToList();
            return _mapping.ListConceptosNotaDebitoCreditoToConceptosNotaDebitoCreditoDTO(list);
        }

        public void Log(ConceptosNotaDebitoCredito obj, string operacion)
        {
            string comando = "";
            comando = comando + "usuario " + obj.nombreusuario + "\n";
            comando = comando + "operacion " + operacion + "\n";
            comando = comando + "id = " + obj.id + "\n";
            comando = comando + "Nombre = " + obj.nombre + "\n";
            comando = comando + "Estado del Registro = " + obj.estadodelregistro + "\n";
            _logacces.Add(comando);
        }

        public string ValidarRegistro(ConceptosNotaDebitoCredito obj)
        {
            string mensajedeerror = "";
            mensajedeerror = mensajedeerror + _validar.ValidarEstadoDelRegistro(obj.estadodelregistro);
            mensajedeerror = mensajedeerror + _validar.Validarnombre("Nombre ", obj.nombre);

            return mensajedeerror;
        }
    }
}