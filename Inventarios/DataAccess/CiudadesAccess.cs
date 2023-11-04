using Inventarios.Data;
using Inventarios.DTO;
using Inventarios.Map;
using Inventarios.Models;
using Inventarios.Token;

namespace Inventarios.DataAccess
{
    public class CiudadesAccess
    {
        private readonly InventariosContext _context;
        private readonly JwtService _jwtservice;
        private readonly LogAccess _logacces;
        private List<Ciudades>? list;

        public CiudadesAccess(InventariosContext context, JwtService jwtService, LogAccess logacces)
        {
            _context = context;
            _jwtservice = jwtService;
            _logacces = logacces;
        }

        public List<CiudadesDTO>? Add(Ciudades obj)
        {
            obj.estadodelregistro = obj.estadodelregistro.ToUpper();
            _context.Ciudades.Add(obj);
            _context.SaveChanges();
            this.Log(obj, "Agrego Ciudad");
            list = _context.Ciudades.Where(a => a.id == obj.id).ToList();
            return Mapping.ListCiudadesToCiudadesDTO(list);
        }

        public List<CiudadesDTO> Delete(int id)
        {
            var obj = _context.Ciudades.FirstOrDefault(a => a.id == id);
            _context.Ciudades.Remove(obj);
            _context.SaveChanges();
            this.Log(obj, "Borro Ciudad");
            obj.nivel1 = "Registro borrado satisfactoriamente";
            list = _context.Ciudades.Where(a => a.id == obj.id).ToList();
            return Mapping.ListCiudadesToCiudadesDTO(list);
        }

        public List<CiudadesDTO>? Update(Ciudades obj)
        {
            obj.estadodelregistro = obj.estadodelregistro.ToUpper();
            var obj_ = _context.Ciudades.FirstOrDefault(a => a.id == obj.id);
            if (obj_ != null)
            {
                obj_.codigo1 = obj.codigo1;
                obj_.codigo2 = obj.codigo2;
                obj_.codigo3 = obj.codigo3;
                obj_.codigo4 = obj.codigo4;
                obj_.codigo5 = obj.codigo5;
                obj_.nivel1 = obj.nivel1;
                obj_.nivel2 = obj.nivel2;
                obj_.nivel3 = obj.nivel3;
                obj_.nivel4 = obj.nivel4;
                obj_.nivel5 = obj.nivel5;

                //
                obj_.estadodelregistro = obj.estadodelregistro;

                _context.SaveChanges();
                this.Log(obj, "Modifico Ciudad");
            }
            list = _context.Ciudades.Where(a => a.id == obj.id).ToList();
            return Mapping.ListCiudadesToCiudadesDTO(list);
        }

        public List<CiudadesDTO>? UpdateNiveles(Ciudades obj)
        {

            List<Ciudades>? list = _context.Ciudades.ToList();

            if (obj.nivel1.Trim().Length > 0)
            {
                list = _context.Ciudades.ToList()
                     .Where(a => a.nivel1.Contains((obj.nivel1.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
                list.ForEach(c => { c.nivel1 = obj.nivel1; });
                _context.SaveChanges();
            }

            if (obj.nivel2.Trim().Length > 0)
            {
                 list = _context.Ciudades.ToList()
                     .Where(a => a.nivel2.Contains((obj.nivel2.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
                list.ForEach(c => { c.nivel2 = obj.nivel2; });
                _context.SaveChanges();
            }


            if (obj.nivel3.Trim().Length > 0)
            {
                 list = _context.Ciudades.ToList()
                     .Where(a => a.nivel3.Contains((obj.nivel3.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
                list.ForEach(c => { c.nivel3 = obj.nivel3; });
                _context.SaveChanges();
            }

            if (obj.nivel4.Trim().Length > 0)
            {
                list = _context.Ciudades.ToList()
                     .Where(a => a.nivel4.Contains((obj.nivel4.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
                list.ForEach(c => { c.nivel4 = obj.nivel4; });
                _context.SaveChanges();
            }

            if (obj.nivel5.Trim().Length > 0)
            {
                 list = _context.Ciudades.ToList()
                     .Where(a => a.nivel5.Contains((obj.nivel5.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
                list.ForEach(c => { c.nivel5 = obj.nivel5; });
                _context.SaveChanges();
            }

            return Mapping.ListCiudadesToCiudadesDTO(list);
        }

        public List<Ciudades>? GetById(int id)
        {
            list = _context.Ciudades.Where(a => a.id == id).ToList();
            return list;
        }

        public List<CiudadesDTO>? List(string filtro)
        {
            list = _context.Ciudades.ToList()
            .OrderBy(a => a.nivel1)
                .OrderBy(a => a.nivel2)
                .OrderBy(a => a.nivel3)
                .OrderBy(a => a.nivel4)
                .OrderBy(a => a.nivel5)
                .Where(a => a.nivel1.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase))
                .Where(a => a.nivel2.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase))
                .Where(a => a.nivel3.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase))
                .Where(a => a.nivel4.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase))
                .Where(a => a.nivel5.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();

            return Mapping.ListCiudadesToCiudadesDTO(list);
        }

        public List<CiudadesDTO>? ListActive(string filtro)
        {
            list = _context.Ciudades.ToList()
                .OrderBy(a => a.nivel1)
                .OrderBy(a => a.nivel2)
                .OrderBy(a => a.nivel3)
                .OrderBy(a => a.nivel4)
                .OrderBy(a => a.nivel5)
                .Where(a => a.estadodelregistro != "I")
                .Where(a => a.nivel1.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase))
                .Where(a => a.nivel2.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase))
                .Where(a => a.nivel3.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase))
                .Where(a => a.nivel4.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase))
                .Where(a => a.nivel5.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();

            return Mapping.ListCiudadesToCiudadesDTO(list);
        }

        public void Log(Ciudades obj, string operacion)
        {
            string comando = "";
            comando = comando + "operacion " + operacion + "\n";

            comando = comando + "id = " + obj.id + "\n";

            comando = comando + "Codigo1 = " + obj.codigo1 + "\n";
            comando = comando + "Codigo2 = " + obj.codigo2 + "\n";
            comando = comando + "Codigo3 = " + obj.codigo3 + "\n";
            comando = comando + "Codigo4 = " + obj.codigo4 + "\n";
            comando = comando + "Codigo5 = " + obj.codigo5 + "\n";
            comando = comando + "Nivel 1 = " + obj.nivel1 + "\n";
            comando = comando + "Nivel 2 = " + obj.nivel2 + "\n";
            comando = comando + "Nivel 3 = " + obj.nivel3 + "\n";
            comando = comando + "Nivel 4 = " + obj.nivel4 + "\n";
            comando = comando + "Nivel 5 = " + obj.nivel5 + "\n";

            //

            comando = comando + "Estado del Registro = " + obj.estadodelregistro + "\n";

            _logacces.Add(comando);
        }
    }
}