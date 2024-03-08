using Inventarios.Data;
using Inventarios.DTO;
using Inventarios.Map;
using Inventarios.Models;

namespace Inventarios.DataAccess
{
    public class TiposDeProgramaAccess
    {
        private readonly InventariosContext _context;

        private readonly LogAccess _logacces;

        private List<TiposDePrograma>? list;

        public TiposDeProgramaAccess(InventariosContext context, LogAccess logacces)
        {
            _context = context;

            _logacces = logacces;
        }

        public List<TiposDeProgramaDTO>? Add(TiposDePrograma obj)
        {
            obj.estadodelregistro = obj.estadodelregistro.ToUpper();
            _context.TiposDePrograma.Add(obj);
            _context.SaveChanges();
            this.Log(obj, "Agrego Tipos de programa");
            list = _context.TiposDePrograma.Where(a => a.id == obj.id).ToList();
            return Mapping.ListTiposDeProgramaToTiposDeProgramaDTO(list);
        }

        public List<TiposDeProgramaDTO> Delete(int id)
        {
            var obj = _context.TiposDePrograma.FirstOrDefault(a => a.id == id);
            _context.TiposDePrograma.Remove(obj);
            _context.SaveChanges();
            this.Log(obj, "Borro Tipos de programa");
            obj.nombre = "Registro borrado satisfactoriamente";
            list = _context.TiposDePrograma.Where(a => a.id == obj.id).ToList();
            return Mapping.ListTiposDeProgramaToTiposDeProgramaDTO(list);
        }

        public List<TiposDeProgramaDTO>? Update(TiposDePrograma? obj)
        {
            obj.estadodelregistro = obj.estadodelregistro.ToUpper();
            var obj_ = _context.TiposDePrograma.FirstOrDefault(a => a.id == obj.id);
            if (obj_ != null)
            {
                obj_.nombre = obj.nombre;

                //
                obj_.estadodelregistro = obj.estadodelregistro;

                _context.SaveChanges();
                this.Log(obj, "Modifico Tipos de programa");
            }
            list = _context.TiposDePrograma.Where(a => a.id == obj.id).ToList();
            return Mapping.ListTiposDeProgramaToTiposDeProgramaDTO(list);
        }

        public List<TiposDePrograma> GetById(int id)
        {
            list = _context.TiposDePrograma.Where(a => a.id == id).ToList();
            return list;
        }

        public List<TiposDeProgramaDTO>? List(string filtro)
        {
            list = _context.TiposDePrograma.ToList().OrderBy(a => a.nombre).Where(a => a.nombre.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
            return Mapping.ListTiposDeProgramaToTiposDeProgramaDTO(list);
        }

      

        public void Log(TiposDePrograma obj, string operacion)
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
