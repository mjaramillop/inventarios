using Inventarios.Data;
using Inventarios.DataAccess.Seguridad;
using Inventarios.DTO;
using Inventarios.Map;
using Inventarios.Models.TablasMaestras;
using Inventarios.Utils;

namespace Inventarios.DataAccess
{
    public class RetencionesAccess
    {
        private readonly InventariosContext _context;

        private readonly LogAccess _logacces;

        private readonly Mapping _mapping;

        private List<Retenciones>? list;

        private readonly IConfiguration _iconfiguration;

        private readonly Validaciones _validar;

        public RetencionesAccess(InventariosContext context, LogAccess logacces, Mapping mapping, IConfiguration iconfiguration, Validaciones validar)
        {
            _context = context;

            _logacces = logacces;
            _mapping = mapping;
            _iconfiguration = iconfiguration;
            _validar = validar;
        }

        public Mensaje Add(Retenciones obj)
        {
            if (this.ValidarRegistro(obj).IndexOf("Error.") >= 0) return new Mensaje() { mensaje = this.ValidarRegistro(obj) };

            _context.Retenciones.Add(obj);
            _context.SaveChanges();
            this.Log(obj, "Agrego Retencion");
            list = _context.Retenciones.Where(a => a.id == obj.id).ToList();
            return new Mensaje() { mensaje = "registro insertado ok " };
        }

        public Mensaje Delete(int id)
        {
            var obj = _context.Retenciones.FirstOrDefault(a => a.id == id);
            _context.Retenciones.Remove(obj);
            _context.SaveChanges();
            this.Log(obj, "Borro Retencion");
            list = _context.Retenciones.Where(a => a.id == obj.id).ToList();
            return new Mensaje() { mensaje = "registro borrado ok " };
        }

        public Mensaje Update(Retenciones? obj)
        {
            if (this.ValidarRegistro(obj).IndexOf("Error.") >= 0) return new Mensaje() { mensaje = this.ValidarRegistro(obj) };

            var obj_ = _context.Retenciones.FirstOrDefault(a => a.id == obj.id);

            obj_.nombre = obj.nombre;
            obj_.basedelaretencion = obj.basedelaretencion;
            obj_.idusuario = obj.idusuario;
            obj_.nombreusuario = obj.nombreusuario;
            obj_.estadodelregistro = obj.estadodelregistro;

            _context.SaveChanges();
            this.Log(obj, "Modifico Retencion");
            return new Mensaje() { mensaje = "registro modificado ok " };
        }

        public List<Retenciones> GetById(int id)
        {
            list = _context.Retenciones.Where(a => a.id == id).ToList();
            return list;
        }

        public List<RetencionesDTO>? List(string filtro)
        {
            string caracterdebusqueda = _iconfiguration.GetValue<string>("ParametrosDeLaEmpresa:caracterdebusqueda");
            filtro = filtro.Replace(caracterdebusqueda, "");
            list = _context.Retenciones.ToList().OrderBy(a => a.nombre).Where(a => a.nombre.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
            return _mapping.ListRetencionesToRetencionesDTO(list);
        }

        public void Log(Retenciones obj, string operacion)
        {
            string comando = "";
            comando = comando + "usuario " + obj.nombreusuario + "\n";
            comando = comando + "operacion " + operacion + "\n";
            comando = comando + "id = " + obj.id + "\n";
            comando = comando + "Nombre = " + obj.nombre + "\n";
            comando = comando + "Base de la retencion = " + obj.basedelaretencion + "\n";
            comando = comando + "Estado del Registro = " + obj.estadodelregistro + "\n";
            _logacces.Add(comando);
        }

        public string ValidarRegistro(Retenciones obj)
        {
            string mensajedeerror = "";
            mensajedeerror = mensajedeerror + _validar.ValidarEstadoDelRegistro(obj.estadodelregistro);
            mensajedeerror = mensajedeerror + _validar.Validarnombre("Nombre ", obj.nombre);
            return mensajedeerror;
        }
    }
}