using Inventarios.DTO;
using Inventarios.Models;

namespace Inventarios.Map
{
    public static class Mapping
    {

        public static LogDTO LogToLogDTO(Log obj)
        {
            LogDTO dto = new();
            dto.id = obj.id;
            dto.descripciondelaoperacion = obj.descripciondelaoperacion;
            dto.fechadeactualizacion = obj.fechadeactualizacion;
           
            return dto;
        }

        public static List<LogDTO> ListLogToLogDTO(List<Log> list)
        {
            List<LogDTO> listdto = new();

            foreach (var s in list)
            {
                listdto.Add(LogToLogDTO(s));
            }
            return listdto;
        }


        public static ProveedoresDTO ProveedoresToProveedoresDTO(Proveedores obj)
        {
            ProveedoresDTO dto = new();
            dto.id = obj.id;
            dto.nombre = obj.nombre;
            dto.ciudad = obj.ciudad;
            dto.ciudad = obj.ciudad;
            dto.telefono = obj.telefono;
            dto.estadodelregistro = obj.estadodelregistro;
            return dto;
        }

        public static List<ProveedoresDTO> ListProveedoresToProveedoresDTO(List<Proveedores> list)
        {
            List<ProveedoresDTO> listdto = new();

            foreach (var s in list)
            {
                listdto.Add(ProveedoresToProveedoresDTO(s));
            }
            return listdto;
        }

        public static TiposDeDocumentoDTO TiposDeDocumentoToTiposDeDocumentoDTO(TiposDeDocumento obj)
        {
            TiposDeDocumentoDTO dto = new();
            dto.id = obj.id;
            dto.nombre = obj.nombre;
            dto.estadodelregistro = obj.estadodelregistro;
            return dto;
        }

        public static List<TiposDeDocumentoDTO> ListTiposDeDocumentoToTiposDeDocumentoDTO(List<TiposDeDocumento> list)
        {
            List<TiposDeDocumentoDTO> listdto = new();

            foreach (var s in list)
            {
                listdto.Add(TiposDeDocumentoToTiposDeDocumentoDTO(s));
            }
            return listdto;
        }

        public static PerfilesDTO PerfilesToPerfilesDTO(Perfiles obj)
        {
            PerfilesDTO dto = new();
            dto.id = obj.id;
            dto.nombre = obj.nombre;

            dto.estadodelregistro = obj.estadodelregistro;

            return dto;
        }

        public static List<PerfilesDTO> ListPerfilesToPerfilesDTO(List<Perfiles> list)
        {
            List<PerfilesDTO> listdto = new();

            foreach (var s in list)
            {
                listdto.Add(PerfilesToPerfilesDTO(s));
            }
            return listdto;
        }

        public static ActividadesEconomicasDTO ActividadeseconomicasToActividadeseconomicasDTO(ActividadesEconomicas obj)
        {
            ActividadesEconomicasDTO dto = new();
            dto.id = obj.id;
            dto.nombre = obj.nombre;
            dto.estadodelregistro = obj.estadodelregistro;

            return dto;
        }

        public static List<ActividadesEconomicasDTO> ListActividadeseconomicasToActividadeseconomicasDTO(List<ActividadesEconomicas> list)
        {
            List<ActividadesEconomicasDTO> listdto = new();

            foreach (var s in list)
            {
                listdto.Add(ActividadeseconomicasToActividadeseconomicasDTO(s));
            }
            return listdto;
        }

        public static CiudadesDTO CiudadesToCiudadesDTO(Ciudades obj)
        {
            CiudadesDTO dto = new();
            dto.id = obj.id;
            dto.codigo1 = obj.codigo1;
            dto.codigo2 = obj.codigo2;
            dto.codigo3 = obj.codigo3;
            dto.codigo4 = obj.codigo4;
            dto.codigo5 = obj.codigo5;
            dto.nivel1 = obj.nivel1;
            dto.nivel2 = obj.nivel2;
            dto.nivel3 = obj.nivel3;

            dto.estadodelregistro = obj.estadodelregistro;

            return dto;
        }

        public static List<CiudadesDTO> ListCiudadesToCiudadesDTO(List<Ciudades> list)
        {
            List<CiudadesDTO> listdto = new();

            foreach (var s in list)
            {
                listdto.Add(CiudadesToCiudadesDTO(s));
            }
            return listdto;
        }

        public static MenuDTO MenuToMenuDTO(Menu menu)
        {
            MenuDTO dto = new();
            dto.id = menu.id;
            dto.orden = menu.orden;
            dto.nombre = menu.nombre;
            dto.paginaweb = menu.paginaweb;
            dto.estadodelregistro = menu.estadodelregistro;

            return dto;
        }

        public static List<MenuDTO> ListMenuToListMenuDTO(List<Menu> list)
        {
            List<MenuDTO> listdto = new();

            foreach (var s in list)
            {
                listdto.Add(MenuToMenuDTO(s));
            }
            return listdto;
        }

        public static UsersDTO UsersToUsersDTO(Usuarios user)
        {
            UsersDTO dto = new();

            dto.id = user.id;

            dto.area = user.area;
            dto.nombre = user.nombre;
            dto.cargo = user.cargo;
            dto.estadodelregistro = user.estadodelregistro;

            return dto;
        }

        public static List<UsersDTO> ListUsersToListUsersDTO(List<Usuarios> list)
        {
            List<UsersDTO> listdto = new();

            foreach (var s in list)
            {
                listdto.Add(UsersToUsersDTO(s));
            }
            return listdto;
        }
    }
}