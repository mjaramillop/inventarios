using Inventarios.Data;
using Inventarios.DataAccess.Seguridad;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Map;
using Inventarios.Models.TablasMaestras;
using Inventarios.Utils;

namespace Inventarios.DataAccess.TablasMaestras
{
    public class EstadosDeUnRegistroAccess
    {
        private readonly InventariosContext _context;

        private readonly LogAccess _logacces;

        private readonly Mapping _mapping;

        private List<EstadosDeUnRegistro>? list;

        private readonly IConfiguration _iconfiguration;

        private readonly Validaciones _validar;

        public EstadosDeUnRegistroAccess(InventariosContext context, LogAccess logacces, Mapping mapping, IConfiguration iconfiguration, Validaciones validar)
        {
            _context = context;

            _logacces = logacces;
            _mapping = mapping;
            _iconfiguration = iconfiguration;
            _validar = validar;
        }

        public Mensaje Add(EstadosDeUnRegistro obj)
        {
            if (this.ValidarRegistro(obj).IndexOf("Error.") >= 0) return new Mensaje() { mensaje = this.ValidarRegistro(obj) };

            _context.EstadosDeUnRegistro.Add(obj);
            _context.SaveChanges();
            Log(obj, "Agrego Estado de un registro");
            return new Mensaje() { mensaje = "registro insertado ok " };
        }

        public Mensaje Delete(int id)
        {
            var obj = _context.EstadosDeUnRegistro.FirstOrDefault(a => a.id == id);
            _context.EstadosDeUnRegistro.Remove(obj);
            _context.SaveChanges();
            Log(obj, "Borro Estado de un registro");
            return new Mensaje() { mensaje = "registro borrado ok " };
        }

        public Mensaje Update(EstadosDeUnRegistro? obj)
        {
            if (this.ValidarRegistro(obj).IndexOf("Error.") >= 0) return new Mensaje() { mensaje = this.ValidarRegistro(obj) };

            var obj_ = _context.EstadosDeUnRegistro.FirstOrDefault(a => a.id == obj.id);

            obj_.idusuario = obj.idusuario;
            obj_.nombreusuario = obj.nombreusuario;
            obj_.nombre = obj.nombre;

            _context.SaveChanges();
            Log(obj, "Modifico EstadosDeUnRegistro");

            return new Mensaje() { mensaje = "registro modificado ok " };
        }

        public List<EstadosDeUnRegistro> GetById(int id)
        {
            list = _context.EstadosDeUnRegistro.Where(a => a.id == id).ToList();
            return list;
        }

        public List<EstadosDeUnRegistroDTO>? List(string filtro)
        {
            string caracterdebusqueda = _iconfiguration.GetValue<string>("ParametrosDeLaEmpresa:caracterdebusqueda");
            filtro = filtro.Replace(caracterdebusqueda, "");
            list = _context.EstadosDeUnRegistro.ToList().OrderBy(a => a.nombre).Where(a => a.nombre.Contains(filtro.Trim(), StringComparison.OrdinalIgnoreCase)).ToList();
            return _mapping.ListEstadosDeUnRegistroToEstadosDeUnRegistroDTO(list);
        }

        public void Log(EstadosDeUnRegistro obj, string operacion)
        {
            string comando = "";
            comando = comando + "operacion " + operacion + "\n";
            comando = comando + "id = " + obj.id + "\n";
            comando = comando + "Nombre = " + obj.nombre + "\n";
            _logacces.Add(comando);
        }

        public string ValidarRegistro(EstadosDeUnRegistro obj)
        {
            string mensajedeerror = "";
            mensajedeerror = mensajedeerror + _validar.Validarnombre("Nombre ", obj.nombre);

            return mensajedeerror;
        }
    }
}