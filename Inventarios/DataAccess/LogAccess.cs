using Inventarios.Data;
using Inventarios.DTO;
using Inventarios.Map;
using Inventarios.Models;
using Inventarios.ModelsParameter;
using Inventarios.Token;
using Inventarios.Utils;
using System.Data;
using System.Globalization;

namespace Inventarios.DataAccess
{
    public class LogAccess
    {
        private readonly InventariosContext _context;
        private readonly JwtService _jwtservice;
        private readonly IConfiguration _iconfiguration;
        public LogAccess(InventariosContext context, JwtService jwtservice , IConfiguration iconfigutarion )
        {
            _context = context;
            _jwtservice = jwtservice;
            _iconfiguration = iconfigutarion;
        }

        public void Add(string registro)
        {
            registro = registro + "Usuario que actualizo =" + _jwtservice.username;

            Log log = new Log();
            log.fechadeactualizacion = System.DateTime.Now;
            log.descripciondelaoperacion = registro;

            _context.Logs.Add(log);
            _context.SaveChanges();
        }

        public List<LogDTO> List(LogConsultar?obj)
        {


            string comando = "";


            comando = "Select id,DESCRIPCION_DE_LA_OPERACION ,FECHA_DE_ACTUALIZACION  ";
            comando = comando + "from ";
            comando = comando + "LOG                       ";
            comando = comando + " where ID IS NOT NULL ";


            if (obj.fechadesde != null) comando = comando + " AND FECHA_DE_ACTUALIZACION>='" + obj.fechadesde.Value.ToString("yyyy-MM-dd") + "'";
            if (obj.fechahasta != null) comando = comando + " AND FECHA_DE_ACTUALIZACION<'" + obj.fechahasta.Value.AddDays(1).ToString("yyyy-MM-dd") + "'";
            if (obj.filtro1.Trim().Length>0) comando = comando+  " AND   DESCRIPCION_DE_LA_OPERACION LIKE " + "'%" + obj.filtro1 + "%'";
            if (obj.filtro2.Trim().Length > 0) comando = comando + " AND DESCRIPCION_DE_LA_OPERACION LIKE " + "'%" + obj.filtro2 + "%'";
            if (obj.filtro3.Trim().Length > 0) comando = comando + " AND DESCRIPCION_DE_LA_OPERACION LIKE " + "'%" + obj.filtro3 + "%'";
            if (obj.filtro4.Trim().Length > 0) comando = comando + " AND DESCRIPCION_DE_LA_OPERACION LIKE " + "'%" + obj.filtro4 + "%'";
            if (obj.filtro5.Trim().Length > 0) comando = comando + " AND DESCRIPCION_DE_LA_OPERACION LIKE " + "'%" + obj.filtro5 + "%'";
            comando = comando + " order by FECHA_DE_ACTUALIZACION DESC";

            Rutinas ru = new(_iconfiguration);

            DataTable list = ru.rtn_creartabla(comando);


            return Mapping.TableLogToLogDTO(list);
        }
    }
}