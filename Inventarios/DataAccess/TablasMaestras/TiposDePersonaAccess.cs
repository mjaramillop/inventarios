using Inventarios.Data;
using Inventarios.DataAccess.Seguridad;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Map;
using Inventarios.Models.TablasMaestras;
using Inventarios.Utils;

namespace Inventarios.DataAccess.TablasMaestras
{
    public class TiposDePersonaAccess
    {
        private readonly InventariosContext _context;

        private readonly LogAccess _logacces;

        private readonly Mapping _mapping;

        private List<TiposDePersona>? list;

        private readonly IConfiguration _iconfiguration;

        private readonly Validaciones _validar;

        public TiposDePersonaAccess(InventariosContext context, LogAccess logacces, Mapping mapping, IConfiguration iconfiguration, Validaciones validar)
        {
            _context = context;
            _logacces = logacces;
            _mapping = mapping;
            _iconfiguration = iconfiguration;
            _validar = validar;
        }

        public Mensaje Add(TiposDePersona obj)
        {
            if (this.ValidarRegistro(obj).IndexOf("Error.") >= 0) return new Mensaje() { mensaje = this.ValidarRegistro(obj) };

            _context.TiposDePersona.Add(obj);
            _context.SaveChanges();
            Log(obj, "Agrego Color");
            return new Mensaje() { mensaje = "registro insertado ok " };
        }

        public Mensaje Delete(string id)
        {
            var obj = _context.TiposDePersona.FirstOrDefault(a => a.id == id);
            _context.TiposDePersona.Remove(obj);
            _context.SaveChanges();
            Log(obj, "Borro TiposDePersona");
            return new Mensaje() { mensaje = "registro borrado ok " };
        }

        public Mensaje Update(TiposDePersona? obj)
        {
            if (this.ValidarRegistro(obj).IndexOf("Error.") >= 0) return new Mensaje() { mensaje = this.ValidarRegistro(obj) };

            var obj_ = _context.TiposDePersona.FirstOrDefault(a => a.id == obj.id);

            obj_.nombre = obj.nombre;
            obj_.idusuario = obj.idusuario;
            obj_.nombreusuario = obj.nombreusuario;
            obj_.estadodelregistro = obj.estadodelregistro;

            _context.SaveChanges();
            Log(obj, "Modifico Color");

            list = _context.TiposDePersona.Where(a => a.id == obj.id).ToList();

            return new Mensaje() { mensaje = "registro modificado ok " };
        }

        public List<TiposDePersona> GetById(string id)
        {
            list = _context.TiposDePersona.Where(a => a.id == id).ToList();
            return list;
        }

        public List<TiposDePersonaDTO>? List(string filtro)
        {
            string caracterdebusqueda = _iconfiguration.GetValue<string>("ParametrosDeLaEmpresa:caracterdebusqueda");
            filtro = filtro.Replace(caracterdebusqueda, "");
            list = _context.TiposDePersona.ToList().OrderBy(a => a.nombre).Where(a => a.nombre.Contains(filtro.Trim(), StringComparison.OrdinalIgnoreCase)).ToList();
            return _mapping.ListTiposDePersonaToTiposDePersonaDTO(list);
        }

        public void Log(TiposDePersona obj, string operacion)
        {
            string comando = "";
            comando = comando + "usuario " + obj.nombreusuario + "\n";
            comando = comando + "operacion " + operacion + "\n";
            comando = comando + "id = " + obj.id + "\n";
            comando = comando + "Nombre = " + obj.nombre + "\n";
            _logacces.Add(comando);
        }

        public string ValidarRegistro(TiposDePersona obj)
        {
            string mensajedeerror = "";
            mensajedeerror = mensajedeerror + _validar.Validarnombre("Nombre ", obj.nombre);
            return mensajedeerror;
        }
    }
}