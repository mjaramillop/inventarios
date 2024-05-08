using Inventarios.Data;
using Inventarios.DataAccess.Seguridad;
using Inventarios.DataAccess.Utils;
using Inventarios.DTO.Seguridad;
using Inventarios.Map;
using Inventarios.Models.Seguridad;

namespace Inventarios.DataAccess
{
    public class MensajesDelSistemaAccess
    {
        private readonly InventariosContext _context;
        private readonly LogAccess _logacces;
        private readonly IConfiguration _iconfiguration;
        private readonly Mapping _mapping;

        private List<Mensajesdelsistema>? list;

        public MensajesDelSistemaAccess(InventariosContext context, LogAccess logacces, IConfiguration iconfigutarion, Mapping mapping)
        {
            _context = context;
            _iconfiguration = iconfigutarion;
            _logacces = logacces;
            _mapping = mapping;
        }

        public List<MensajesDelSistemaDTO>? Add(Mensajesdelsistema obj)
        {
            string comando = "";
            comando = "delete from mensajesdelsistema where fecha_hasta < getdate()  ";
            UtilidadesAccess ru = new(_iconfiguration);
            string mensaje = ru.ejecutarsql(comando);

            _context.Mensajesdelsistema.Add(obj);
            _context.SaveChanges();
            this.Log(obj, "Agrego Mensaje del sistema");
            list = _context.Mensajesdelsistema.Where(a => a.id == obj.id).ToList();
            return _mapping.ListMensajesDelSistemaToMensajesDelSistemaDTO(list);
        }

        public List<MensajesDelSistemaDTO> Delete(int id)
        {
            var obj = _context.Mensajesdelsistema.FirstOrDefault(a => a.id == id);
            _context.Mensajesdelsistema.Remove(obj);
            _context.SaveChanges();
            this.Log(obj, "Borro Mensajes del sistema");
            list = _context.Mensajesdelsistema.Where(a => a.id == obj.id).ToList();
            return _mapping.ListMensajesDelSistemaToMensajesDelSistemaDTO(list);
        }

        public List<MensajesDelSistemaDTO>? Update(Mensajesdelsistema? obj)
        {
            var obj_ = _context.Mensajesdelsistema.FirstOrDefault(a => a.id == obj.id);

            obj.fechadesde = obj_.fechadesde;
            obj_.fechahasta = obj_.fechahasta;
            obj_.mensaje = obj.mensaje;
            _context.SaveChanges();
            this.Log(obj, "Modifico Mensajes del sistema");

            list = _context.Mensajesdelsistema.Where(a => a.id == obj.id).ToList();
            return _mapping.ListMensajesDelSistemaToMensajesDelSistemaDTO(list);
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
            list = _context.Mensajesdelsistema.ToList().Where(a => DateTime.Now >= a.fechadesde && DateTime.Now < a.fechahasta.AddDays(1)).ToList();
            return _mapping.ListMensajesDelSistemaToMensajesDelSistemaDTO(list);
        }

        public void Log(Mensajesdelsistema obj, string operacion)
        {
            string comando = "";
            comando = comando + "operacion " + operacion + "\n";

            comando = comando + "id = " + obj.id + "\n";

            comando = comando + "fecha desde = " + obj.fechadesde + "\n";
            comando = comando + "fecha hasta = " + obj.fechahasta + "\n";
            comando = comando + "Mensaje = " + obj.mensaje + "\n";

            _logacces.Add(comando);
        }
    }
}