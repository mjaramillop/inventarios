using Inventarios.DataAccess.Seguridad;
using Inventarios.DTO;
using Inventarios.DTO.Seguridad;
using Inventarios.Models.Seguridad;
using Inventarios.Models.TablasMaestras;

namespace Inventarios.services.Seguridad
{
    public class UserService
    {
        private readonly UserAccess _access;
        private List<UsersDTO>? list;

        public UserService(UserAccess access)
        {
            _access = access;
        }

        public Mensaje Add(Usuarios obj)
        {
            Mensaje list = _access.Add(obj);
            return list;
        }

        public Mensaje Delete(int id)
        {
            Mensaje list = _access.Delete(id);
            return list;
        }

        public Mensaje Update(Usuarios obj)
        {
            Mensaje list = _access.Update(obj);
            return list;
        }

        public List<Usuarios>? GetById(int id)
        {
            List<Usuarios> obj = _access.GetById(id);
            return obj;
        }

        public List<UsersDTO>? List(string filtro )
        {
            list = _access.List(filtro);
            return list;
        }

        public List<MenuDTO>? ValidateAccess(string login, string password)
        {
            List<MenuDTO> obj = _access.ValidateAccess(login, password);

            return obj;
        }
    }
}