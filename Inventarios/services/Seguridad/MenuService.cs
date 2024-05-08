using Inventarios.DataAccess.Seguridad;
using Inventarios.DTO.Seguridad;
using Inventarios.Models.Seguridad;

namespace Inventarios.services.Seguridad
{
    public class MenuService
    {
        private readonly MenuAccess _access;
        public List<MenuDTO>? list;

        public MenuService(MenuAccess access)
        {
            _access = access;
        }

        public List<MenuDTO>? Add(Menu obj)
        {
            list = _access.Add(obj);
            return list;
        }

        public List<MenuDTO>? Delete(int id)
        {
            list = _access.Delete(id);
            return list;
        }

        public List<MenuDTO>? Update(Menu obj)
        {
            list = _access.Update(obj);
            return list;
        }

        public List<Menu>? GetById(int id)
        {
            List<Menu> obj = _access.GetById(id);

            return obj;
        }

        public List<MenuDTO>? List(string filtro)
        {
            var list = _access.List(filtro);
            return list;
        }
    }
}