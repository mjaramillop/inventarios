using Inventarios.Data;
using Inventarios.DTO;
using Inventarios.Map;
using Inventarios.Models;
using Inventarios.Token;

namespace Inventarios.DataAccess
{
    public class UserAccess
    {
        private readonly InventariosContext _context;
        private readonly JwtService _jwtservice;
        private readonly LogAccess _logacces;
        private readonly Mapping _mapping;

        private List<Usuarios>? list;
        private readonly IConfiguration _iconfiguration;

        public UserAccess(InventariosContext context, JwtService jwtservice, LogAccess logacces, Mapping mapping, IConfiguration iconfiguration)
        {
            _context = context;
            _jwtservice = jwtservice;
            _logacces = logacces;
            _mapping = mapping;
            _iconfiguration = iconfiguration;
        }

        public List<UsersDTO>? Add(Usuarios obj)
        {
           

            _context.Usuarios.Add(obj);
            _context.SaveChanges();
            this.Log(obj, "Agrego usuario");
            list = _context.Usuarios.Where(a => a.id == obj.id).ToList();
            return _mapping.ListUsersToListUsersDTO(list);
        }

        public List<UsersDTO>? Delete(int id)
        {
            var obj = _context.Usuarios.FirstOrDefault(a => a.id == id);

            if (obj != null) _context.Usuarios.Remove(obj);
            _context.SaveChanges();
            this.Log(obj, "Borro usuario");
            list = _context.Usuarios.Where(a => a.id == obj.id).ToList();
            return _mapping.ListUsersToListUsersDTO(list);
        }

        public List<UsersDTO> Update(Usuarios obj)
        {
            

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
            obj_.bodega = obj.bodega;

            obj_.estadodelregistro = obj.estadodelregistro;

            _context.SaveChanges();
            this.Log(obj, "Modifico usuario");

            list = _context.Usuarios.Where(a => a.id == obj.id).ToList();
            return _mapping.ListUsersToListUsersDTO(list);
        }

        public List<Usuarios> GetById(int id)
        {
            List<Usuarios>? obj = _context.Usuarios.Where(a => a.id == id).ToList();
            return obj;
        }

        public List<UsersDTO>? List(string filtro = "")
        {
            string caracterdebusqueda = _iconfiguration.GetValue<string>("ParametrosDeLaEmpresa:caracterdebusqueda");
            filtro = filtro.Replace(caracterdebusqueda, "");
            list = _context.Usuarios.ToList().OrderBy(a => a.nombre).Where(a => a.nombre.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
            return _mapping.ListUsersToListUsersDTO(list);
        }

        //  operations not basics

        public List<TokenDTO> ValidateAccess(string login, string password)
        {
            login = login.ToUpper();
            password = password.ToUpper();
            var list = _context.Usuarios.Where(a => a.login == login && a.password == password).ToList();

            string jwt = "xxx";
            _jwtservice.jwt = "xxx";
            _jwtservice.Id = -1;
            _jwtservice.username = "";
            _jwtservice.password = "x";
            _jwtservice.login = "x";

            if (list == null) return new List<TokenDTO>() { new TokenDTO() { token = jwt } };

            int? idperfil = 0;
            foreach (var s in list)
            {
                jwt = _jwtservice.Generate(Convert.ToInt16(s.id));
                _jwtservice.Id = s.id;
                _jwtservice.username = s.nombre;
                _jwtservice.password = s.password;
                _jwtservice.login = s.login;
                _jwtservice.tiposdedocumento = s.tiposdedocumento;

                _jwtservice.jwt = jwt;
                idperfil = s.perfil;
            }

            if (idperfil == 0) return new List<TokenDTO>() { new TokenDTO() { token = jwt } };

            var perfil = _context.Perfiles.FirstOrDefault(a => a.id == idperfil);
            _jwtservice.programas = perfil.programas;

            return new List<TokenDTO>() { new TokenDTO() { token = jwt } };
        }

        public List<MenuDTO> ValidateToken(string token)
        {
            var menu = _context.Menus.OrderBy(a => a.orden).ToList();

            List<MenuDTO> listmenudto = new List<MenuDTO>();

            string[]? permisosdelosprogramas = _jwtservice.programas?.Split(",");

            foreach (var s in menu)
            {
                if (_jwtservice.programas?.IndexOf("," + s.id.ToString().Trim() + "=") >= 0)
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
                    listmenudto.Add(responseobject);
                }
            }

            return listmenudto;
        }

        public void Log(Usuarios obj, string operacion)
        {
            string comando = "";
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

            //
            comando = comando + "Estado del Registro = " + obj.estadodelregistro + "\n";

            _logacces.Add(comando);
        }
    }
}