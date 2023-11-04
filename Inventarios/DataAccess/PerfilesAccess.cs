using Inventarios.Data;
using Inventarios.DTO;
using Inventarios.Map;
using Inventarios.Models;
using Inventarios.Token;

namespace Inventarios.DataAccess
{
    public class PerfilesAccess
    {

        private readonly InventariosContext _context;
        private readonly JwtService _jwtservice;
        private readonly LogAccess _logacces;
        private List<Perfiles>? list;

        public PerfilesAccess(InventariosContext context, JwtService jwtService, LogAccess logacces)
        {
            _context = context;
            _jwtservice = jwtService;
            _logacces = logacces;
        }

        public List<PerfilesDTO> Add(Perfiles obj)
        {
            obj.estadodelregistro = obj.estadodelregistro?.ToUpper();

            _context.Perfiles.Add(obj);
            _context.SaveChanges();
            this.Log(obj, "Agrego Perfiles");
            list = _context.Perfiles.Where(a => a.id == obj.id).ToList();
            return Mapping.ListPerfilesToPerfilesDTO(list);
        }

        public List<PerfilesDTO> Delete(int id)
        {
            var obj = _context.Perfiles.FirstOrDefault(a => a.id == id);
            _context.Perfiles.Remove(obj);
            _context.SaveChanges();
            this.Log(obj, "Borro Perfiles");
            obj.nombre = "Registro borrado satisfactoriamente";
            list = _context.Perfiles.Where(a => a.id == obj.id).ToList();
            return Mapping.ListPerfilesToPerfilesDTO(list);
        }

        public List<PerfilesDTO> Update(Perfiles obj)
        {
            obj.estadodelregistro = obj.estadodelregistro?.ToUpper();

            var obj_ = _context.Perfiles.FirstOrDefault(a => a.id == obj.id);
            if (obj_ != null)
            {
                obj_.nombre = obj.nombre;
                obj_.programas=obj.programas;

                //
                obj_.estadodelregistro = obj.estadodelregistro;
              
                _context.SaveChanges();
                this.Log(obj, "Modifico Perfiles");
            }
            list = _context.Perfiles.Where(a => a.id == obj.id).ToList();
            return Mapping.ListPerfilesToPerfilesDTO(list);
        }

        public List<Perfiles> GetById(int id)
        {

            list = _context.Perfiles.Where(a => a.id == id).ToList();
            return list;
        }

        public List<PerfilesDTO>? List(string filtro)
        {
            list = _context.Perfiles.ToList().OrderBy(a => a.nombre).Where(a => a.nombre.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
            return Mapping.ListPerfilesToPerfilesDTO(list);
        }

        public List<PerfilesDTO>? ListActive(string filtro)
        {
            list = _context.Perfiles.ToList().OrderBy(a => a.nombre).Where(a => a.estadodelregistro != "I").Where(a => a.nombre.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
            return Mapping.ListPerfilesToPerfilesDTO(list);
        }

        public void Log(Perfiles obj, string operacion)
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
