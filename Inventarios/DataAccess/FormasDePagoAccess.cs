using Inventarios.Data;
using Inventarios.DTO;
using Inventarios.Map;
using Inventarios.Models;

namespace Inventarios.DataAccess
{
    public class FormasDePagoAccess
    {
        private readonly InventariosContext _context;

        private readonly LogAccess _logacces;

        private readonly Mapping _mapping;

        private List<FormasDePago>? list;
        private readonly IConfiguration _iconfiguration;

        public FormasDePagoAccess(InventariosContext context, LogAccess logacces, Mapping mapping, IConfiguration iconfiguration)
        {
            _context = context;

            _logacces = logacces;
            _mapping = mapping;
            _iconfiguration = iconfiguration;
        }

        public List<FormasDePagoDTO>? Add(FormasDePago obj)
        {
            obj.estadodelregistro = obj.estadodelregistro.ToUpper();
            _context.FormasDePago.Add(obj);
            _context.SaveChanges();
            this.Log(obj, "Agrego Formas de pago");
            list = _context.FormasDePago.Where(a => a.id == obj.id).ToList();
            return _mapping.ListFormasDePagoToFormasDePagoDTO(list);
        }

        public List<FormasDePagoDTO> Delete(int id)
        {
            var obj = _context.FormasDePago.FirstOrDefault(a => a.id == id);
            _context.FormasDePago.Remove(obj);
            _context.SaveChanges();
            this.Log(obj, "Borro Formas de pago");
            list = _context.FormasDePago.Where(a => a.id == obj.id).ToList();
            return _mapping.ListFormasDePagoToFormasDePagoDTO(list);
        }

        public List<FormasDePagoDTO>? Update(FormasDePago? obj)
        {
            obj.estadodelregistro = obj.estadodelregistro.ToUpper();
            var obj_ = _context.FormasDePago.FirstOrDefault(a => a.id == obj.id);

            obj_.nombre = obj.nombre;

            obj_.estadodelregistro = obj.estadodelregistro;

            _context.SaveChanges();
            this.Log(obj, "Modifico Formas de pago");

            list = _context.FormasDePago.Where(a => a.id == obj.id).ToList();
            return _mapping.ListFormasDePagoToFormasDePagoDTO(list);
        }

        public List<FormasDePago> GetById(int id)
        {
            list = _context.FormasDePago.Where(a => a.id == id).ToList();
            return list;
        }

        public List<FormasDePagoDTO>? List(string filtro)
        {
            string caracterdebusqueda = _iconfiguration.GetValue<string>("ParametrosDeLaEmpresa:caracterdebusqueda");
            filtro = filtro.Replace(caracterdebusqueda, "");
            list = _context.FormasDePago.ToList().OrderBy(a => a.nombre).Where(a => a.nombre.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
            return _mapping.ListFormasDePagoToFormasDePagoDTO(list);
        }

        public void Log(FormasDePago obj, string operacion)
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