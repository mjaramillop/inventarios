using Inventarios.Data;
using Inventarios.DataAccess.Seguridad;
using Inventarios.DTO.Seguridad;
using Inventarios.Map;
using Inventarios.Models.Seguridad;
using Inventarios.Models.TablasMaestras;
using Inventarios.Utils;

namespace Inventarios.DataAccess
{
    public class MensajesDelSistemaAccess
    {
        private readonly InventariosContext _context;
        private readonly LogAccess _logacces;
        private readonly IConfiguration _iconfiguration;
        private readonly Mapping _mapping;
        private List<Mensajesdelsistema>? list;

        private readonly Validaciones _validar;


        public MensajesDelSistemaAccess(InventariosContext context, LogAccess logacces, IConfiguration iconfigutarion, Mapping mapping, Validaciones validar)
        {
            _context = context;
            _iconfiguration = iconfigutarion;
            _logacces = logacces;
            _mapping = mapping;
            _validar = validar;
        }

        public Mensaje Add(Mensajesdelsistema obj)
        {
            if (this.ValidarRegistro(obj).IndexOf("Error.") >= 0) return new Mensaje() { mensaje = this.ValidarRegistro(obj) };


            string comando = "";
            comando = "delete from mensajesdelsistema where fecha_hasta < getdate()  ";
            Utilidades ru = new(_iconfiguration);
            string mensaje = ru.ejecutarsql(comando);

            _context.Mensajesdelsistema.Add(obj);
            _context.SaveChanges();
            this.Log(obj, "Agrego Mensaje del sistema");
            return new Mensaje() { mensaje = "registro insertado ok " };
        }

        public Mensaje Delete(int id)
        {
            var obj = _context.Mensajesdelsistema.FirstOrDefault(a => a.id == id);
            _context.Mensajesdelsistema.Remove(obj);
            _context.SaveChanges();
            this.Log(obj, "Borro Mensajes del sistema");
            return new Mensaje() { mensaje = "registro borrado ok " };

        }

        public Mensaje Update(Mensajesdelsistema? obj)
        {

            if (this.ValidarRegistro(obj).IndexOf("Error.") >= 0) return new Mensaje() { mensaje = this.ValidarRegistro(obj) };
            var obj_ = _context.Mensajesdelsistema.FirstOrDefault(a => a.id == obj.id);

            obj.fechadesde = obj_.fechadesde;
            obj_.fechahasta = obj_.fechahasta;
            obj_.mensaje = obj.mensaje;
            obj_.idusuario = obj.idusuario;
            obj_.nombreusuario = obj.nombreusuario;

            _context.SaveChanges();
            this.Log(obj, "Modifico Mensajes del sistema");
            return new Mensaje() { mensaje = "registro modificado ok " };

        }

        public List<Mensajesdelsistema> GetById(int id)
        {
            list = _context.Mensajesdelsistema.Where(a => a.id == id).ToList();
            return list;
        }

        public List<MensajesDelSistemaDTO>? List(string filtro)
        {
            list = _context.Mensajesdelsistema.ToList().Where(a => a.mensaje.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
            return _mapping.ListMensajesDelSistemaToMensajesDelSistemaDTO(list);
        }

        public List<MensajesDelSistemaDTO>? ListActive()
        {
            list = _context.Mensajesdelsistema.ToList().Where(a => a.fechadesde >= System.DateTime.Now && a.fechahasta < DateTime.Now.AddDays(1)).ToList();
            return _mapping.ListMensajesDelSistemaToMensajesDelSistemaDTO(list);
        }

        public void Log(Mensajesdelsistema obj, string operacion)
        {
            string comando = "";
            comando = comando + "usuario " + obj.nombreusuario + "\n";
            comando = comando + "operacion " + operacion + "\n";
            comando = comando + "id = " + obj.id + "\n";
            comando = comando + "fecha desde = " + obj.fechadesde + "\n";
            comando = comando + "fecha hasta = " + obj.fechahasta + "\n";
            comando = comando + "Mensaje = " + obj.mensaje + "\n";
            _logacces.Add(comando);
        }

        public string ValidarRegistro(Mensajesdelsistema obj)
        {
            string mensajedeerror = "";
            mensajedeerror = mensajedeerror + _validar.Validarnombre("Mensaje" , obj.mensaje);
            mensajedeerror = mensajedeerror + _validar.Validarfechaddesdemenofechahasta("Fecha desde  ", obj.fechadesde , obj.fechahasta);
            return mensajedeerror;
        }
    }
}