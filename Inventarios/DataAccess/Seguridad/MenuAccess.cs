using Inventarios.Data;
using Inventarios.DTO.Seguridad;
using Inventarios.Map;
using Inventarios.Models.Seguridad;
using Inventarios.Models.TablasMaestras;
using Inventarios.Utils;

namespace Inventarios.DataAccess.Seguridad
{
    public class MenuAccess
    {
        private readonly InventariosContext _context;
        private readonly LogAccess _logacces;
        private readonly Mapping _mapping;

        private List<Menu>? list;
        private readonly IConfiguration _iconfiguration;
        private readonly Validaciones _validar;


        public MenuAccess(InventariosContext context, LogAccess logacces, Mapping mapping, IConfiguration iconfiguration, Validaciones validar)
        {
            _context = context;
            _logacces = logacces;
            _mapping = mapping;
            _iconfiguration = iconfiguration;
            _validar = validar;
        }

        public Mensaje Add(Menu? obj)
        {
            if (this.ValidarRegistro(obj).IndexOf("Error.") >= 0) return new Mensaje() { mensaje = this.ValidarRegistro(obj) };

            _context.Menus.Add(obj);
            _context.SaveChanges();
            Log(obj, "Agrego menu");
            return new Mensaje() { mensaje = "registro insertado ok " };

        }

        public Mensaje Delete(int id)
        {
            var obj = _context.Menus.FirstOrDefault(a => a.id == id);
            _context.Menus.Remove(obj);
            _context.SaveChanges();
            Log(obj, "Borro menu");
            return new Mensaje() { mensaje = "registro borrado ok " };

        }

        public Mensaje Update(Menu obj)
        {
            if (this.ValidarRegistro(obj).IndexOf("Error.") >= 0) return new Mensaje() { mensaje = this.ValidarRegistro(obj) };

            var obj_ = _context.Menus.FirstOrDefault(a => a.id == obj.id);
            obj_.nombre = obj.nombre;
            obj_.paginaweb = obj.paginaweb;

            obj_.estadodelregistro = obj.estadodelregistro;
            obj_.idusuario = obj.idusuario;
            obj_.nombreusuario = obj.nombreusuario;

            _context.SaveChanges();
            Log(obj, "Modifico menu");

            return new Mensaje() { mensaje = "registro modificado ok " };

        }

        public List<Menu>? GetById(int id)
        {
            list = _context.Menus.Where(a => a.id == id).ToList();
            return list;
        }

        public List<MenuDTO>? List(string filtro)
        {
            list = _context.Menus.ToList().OrderBy(a => a.orden).Where(a => a.nombre.Contains(filtro.Trim(), StringComparison.OrdinalIgnoreCase)).ToList();
            return _mapping.ListMenuToListMenuDTO(list);
        }

        public void Log(Menu obj, string operacion)
        {
            string comando = "";
            comando = comando + "usuario " + obj.nombreusuario + "\n";
            comando = comando + "operacion " + operacion + "\n";
            comando = comando + "id = " + obj.id + "\n";
            comando = comando + "Orden  = " + obj.orden + "\n";
            comando = comando + "Nombre = " + obj.nombre + "\n";
            comando = comando + "Pagina web = " + obj.paginaweb + "\n";
            comando = comando + "Estado del Registro = " + obj.estadodelregistro + "\n";
            _logacces.Add(comando);
        }

        public string ValidarRegistro(Menu obj)
        {
            string mensajedeerror = "";
            mensajedeerror = mensajedeerror + _validar.ValidarEstadoDelRegistro(obj.estadodelregistro);
            mensajedeerror = mensajedeerror + _validar.Validarnombre("Nombre ", obj.nombre);

            return mensajedeerror;
        }

    }
}