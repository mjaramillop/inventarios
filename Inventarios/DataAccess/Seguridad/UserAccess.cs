using Inventarios.Data;
using Inventarios.DTO;
using Inventarios.DTO.Seguridad;
using Inventarios.Map;
using Inventarios.Models.Seguridad;
using Inventarios.Models.TablasMaestras;
using Inventarios.Utils;

namespace Inventarios.DataAccess.Seguridad
{
    public class UserAccess
    {
        private readonly InventariosContext _context;

        private readonly LogAccess _logacces;
        private readonly Mapping _mapping;

        private List<Usuarios>? list;
        private readonly IConfiguration _iconfiguration;
        private readonly Validaciones _validar;
        private readonly Utilidades _utilidades;


        public UserAccess(InventariosContext context, LogAccess logacces, Mapping mapping, IConfiguration iconfiguration, Validaciones validar, Utilidades utlidades  )
        {
            _context = context;
            _logacces = logacces;
            _mapping = mapping;
            _iconfiguration = iconfiguration;
            _validar = validar;
            _utilidades = utlidades;
        }

        public Mensaje Add(Usuarios obj)
        {
            if (this.ValidarRegistro(obj).IndexOf("Error.") >= 0) return new Mensaje() { mensaje = this.ValidarRegistro(obj) };

            _context.Usuarios.Add(obj);
            _context.SaveChanges();
            Log(obj, "Agrego usuario");
            list = _context.Usuarios.Where(a => a.id == obj.id).ToList();
            return new Mensaje() { mensaje = "registro insertado ok " };
        }

        public Mensaje Delete(int id)
        {
            var obj = _context.Usuarios.FirstOrDefault(a => a.id == id);

            if (obj != null) _context.Usuarios.Remove(obj);
            _context.SaveChanges();

            // borra la imagen del usuario
            string route = Path.Combine(Directory.GetCurrentDirectory(), "imagesusers");
            route = route + "\\" + id.ToString() + ".jpg";
            File.Delete(route);

            Log(obj, "Borro usuario");
            return new Mensaje() { mensaje = "registro insertado ok " };


        }

        public Mensaje Update(Usuarios obj)
        {

            if (this.ValidarRegistro(obj).IndexOf("Error.") >= 0) return new Mensaje() { mensaje = this.ValidarRegistro(obj) };

            var obj_ = _context.Usuarios.FirstOrDefault(a => a.id == obj.id);
            obj_.correoelectronico = obj.correoelectronico;
            obj_.area = obj.area;
            obj_.cargo = obj.cargo;
            obj_.nombre = obj.nombre;
            obj_.telefono = obj.telefono;
            obj_.perfil = obj.perfil;
            obj_.direccion = obj.direccion;
            obj_.login = obj.login;
            obj_.password = obj.password;
            obj_.perfil = obj.perfil;
            obj_.tiposdedocumento = obj.tiposdedocumento;
            obj_.estadodelregistro = obj.estadodelregistro;
            obj_.idusuario = obj.idusuario;
            obj_.nombreusuario = obj.nombreusuario;
            obj_.tipodedocumentocargueinventarioinicial = obj.tipodedocumentocargueinventarioinicial;
            obj_.tipodedocumentocargueinventariofisico = obj.tipodedocumentocargueinventariofisico;
            obj_.token=obj.token;   

            _context.SaveChanges();
            Log(obj, "Modifico usuario");

            return new Mensaje() { mensaje = "registro modificado ok " };
            
        }

        public List<Usuarios> GetById(int id)
        {
            list = _context.Usuarios.Where(a => a.id == id).ToList();
            return list;
        }

        public List<UsersDTO>? List(string filtro)
        {
            string caracterdebusqueda = _utilidades.traerparametrowebconfig("caracterdebusqueda");
            filtro = filtro.Replace(caracterdebusqueda, "");
            list = _context.Usuarios.ToList().OrderBy(a => a.nombre).Where(a => a.nombre.Contains(filtro.Trim(), StringComparison.OrdinalIgnoreCase)).ToList();
            return _mapping.ListUsersToListUsersDTO(list);
        }

        //  operations not basics

        public List<MenuDTO> ValidateAccess(string login, string password)
        {
            login = login.ToUpper();
            password = password.ToUpper();
            Usuarios objusuarios = _context.Usuarios.FirstOrDefault(a => a.login == login && a.password == password);


            if (objusuarios == null) return new List<MenuDTO>();
            if (objusuarios.perfil == 0) return new List<MenuDTO>();
            if ( objusuarios.estadodelregistro == Convert.ToInt16( _utilidades.traerparametrowebconfig("codigoestadoinactivo"))   ) return new List<MenuDTO>();



            var perfil = _context.Perfiles.FirstOrDefault(a => a.id == objusuarios.perfil);

            var menu = _context.Menus.OrderBy(a => a.orden).ToList();

            List<MenuDTO> listmenudto = new List<MenuDTO>();

            string[]? permisosdelosprogramas = perfil.programas?.Split(",");

            foreach (var s in menu)
            {
                if (perfil.programas?.IndexOf("," + s.id.ToString().Trim() + "=") >= 0)
                {
                    string codigoabuscar = "," + s.id.ToString().Trim() + "=";

                    string permisos = "";
                    for (int i = 0; i <= permisosdelosprogramas.Length - 1; i++)
                    {
                        permisosdelosprogramas[i] = "," + permisosdelosprogramas[i];
                        if (permisosdelosprogramas[i].IndexOf(codigoabuscar) >= 0)
                        {
                            int posicion = permisosdelosprogramas[i].IndexOf("=");
                            int longitudcadena = permisosdelosprogramas[i].Length;
                            string valor = permisosdelosprogramas[i];

                            permisos = valor.Substring(posicion + 1, longitudcadena - (posicion + 1));
                            break;
                        }
                    }

                    MenuDTO responseobject = new();
                    responseobject.id = s.id;
                    responseobject.orden = s.orden;
                    responseobject.nombre = s.nombre;
                    responseobject.paginaweb = s.paginaweb;
                    responseobject.permisos = permisos;
                    responseobject.idusuario = objusuarios.id;
                    responseobject.username = objusuarios.nombre;
                    responseobject.login = objusuarios.login;
                    responseobject.password = objusuarios.password;
                    responseobject.token=objusuarios.token; 

                    listmenudto.Add(responseobject);
                }
            }

            return listmenudto.OrderBy(a=>a.nombre).OrderBy(a =>a.orden).ToList();
        }

        public void Log(Usuarios obj, string operacion)
        {
            string comando = "";
            comando = comando + "usuario " + obj.nombreusuario + "\n";

            comando = comando + "operacion " + operacion + "\n";
            comando = comando + "id = " + obj.id + "\n";
            comando = comando + "Area  = " + obj.area + "\n";
            comando = comando + "Nombre = " + obj.nombre + "\n";
            comando = comando + "Cargo = " + obj.cargo + "\n";
            comando = comando + "direccion = " + obj.direccion + "\n";
            comando = comando + "telefono = " + obj.telefono + "\n";
            comando = comando + "Correo Electronico = " + obj.correoelectronico + "\n";
            comando = comando + "login = " + obj.login + "\n";
            comando = comando + "password = " + obj.password + "\n";
            comando = comando + "Perfil = " + obj.perfil + "\n";
            comando = comando + "Tipos de documento = " + obj.tiposdedocumento + "\n";
            comando = comando + "Estado del Registro = " + obj.estadodelregistro + "\n";
            _logacces.Add(comando);
        }


        public string ValidarRegistro(Usuarios obj)
        {
            string mensajedeerror = "";
            mensajedeerror = mensajedeerror + _validar.ValidarEstadoDelRegistro(obj.estadodelregistro);
            mensajedeerror = mensajedeerror + _validar.Validarnombre("Nombre ", obj.nombre);

            return mensajedeerror;
        }

    }
}