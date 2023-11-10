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



        public List<ProgramasPermisosDTO>? ListProgramasPermisos(int id)
        {
            var list = _context.Menus.Where(a => !a.estadodelregistro.Contains("I")).OrderBy(a => a.nombre).ToList();

            Perfiles? obj = _context.Perfiles.FirstOrDefault(a => a.id == id);
            string? programas = obj.programas;

            List<ProgramasPermisosDTO> listaprogramaspermisos = new List<ProgramasPermisosDTO>();

            foreach (var s in list)
            {
                ProgramasPermisosDTO obj1 = new ProgramasPermisosDTO();
                obj1.nombre = s.nombre;
                obj1.id = s.id;
                obj1.agregar = false;
                obj1.borrar = false;
                obj1.modificar = false;
                obj1.anular = false;
                obj1.imprimir = false;
                obj1.estadodelregistro = s.estadodelregistro;

                listaprogramaspermisos.Add(obj1);
            }

            string[] permisos = obj.programas.Split(",");
            for (int i = 1; i < permisos.Length - 1; i++)
            {
                string codigoprograma = permisos[i].Substring(0, permisos[i].IndexOf("="));

                foreach (var s in listaprogramaspermisos)
                {
                    if (s.id == Convert.ToInt32(codigoprograma))
                    {
                        if (permisos[i].IndexOf("A") >= 0) s.agregar = true;
                        if (permisos[i].IndexOf("M") >= 0) s.modificar = true;
                        if (permisos[i].IndexOf("B") >= 0) s.borrar = true;
                        if (permisos[i].IndexOf("I") >= 0) s.imprimir = true;
                        if (permisos[i].IndexOf("N") >= 0) s.anular = true;
                    }
                }
            }

            return listaprogramaspermisos;
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
