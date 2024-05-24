using Inventarios.DataAccess.Seguridad;
using Inventarios.DTO;
using Inventarios.DTO.Seguridad;
using Inventarios.Models.Seguridad;

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

        public List<UsersDTO> Add(Usuarios obj)
        {
            list = _access.Add(obj);
            return list;
        }

        public List<UsersDTO>? Delete(int id)
        {
            list = _access.Delete(id);
            return list;
        }

        public List<UsersDTO>? Update(Usuarios obj)
        {
            list = _access.Update(obj);
            return list;
        }

        public List<Usuarios>? GetById(int id)
        {
            List<Usuarios> obj = _access.GetById(id);
            return obj;
        }



       
        public List<UsersDTO>? List(string filtro = "")
        {
            list = _access.List(filtro);
            return list;
        }

        public List<MenuDTO>? ValidateAccess(string login, string password )
        {
            List<MenuDTO> obj = _access.ValidateAccess(login, password);

            return obj;
        }

      
    }
}