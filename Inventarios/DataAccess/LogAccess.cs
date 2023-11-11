using Inventarios.Data;
using Inventarios.DTO;
using Inventarios.Map;
using Inventarios.Models;
using Inventarios.ModelsParameter;
using Inventarios.Token;

namespace Inventarios.DataAccess
{
    public class LogAccess
    {
        private readonly InventariosContext _context;
        private readonly JwtService _jwtservice;

        public LogAccess(InventariosContext context, JwtService jwtservice)
        {
            _context = context;
            _jwtservice = jwtservice;
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
            if (obj.fechadesde != null) comando = comando + "1";
            if (obj.fechahasta != null) comando = comando + "2";
            if (obj.filtro1.Trim().Length>0) comando = comando + "3";
            if (obj.filtro2.Trim().Length > 0) comando = comando + "4";
            if (obj.filtro3.Trim().Length > 0) comando = comando + "5";
            if (obj.filtro4.Trim().Length > 0) comando = comando + "6";
            if (obj.filtro5.Trim().Length > 0) comando = comando + "7";





            var list =   _context.Logs.ToList().Where(a => a.id < 0).ToList();

            if (comando.Trim().Length==1)
            {
                list = _context.Logs.ToList()
                 .OrderByDescending(a => a.fechadeactualizacion)
                 .Where(a => a.fechadeactualizacion >= obj.fechadesde).ToList();
            }


            if (comando.Trim().Length==2)
            {
                list = _context.Logs.ToList()
                 .OrderByDescending(a => a.fechadeactualizacion)
                  .Where(a => a.fechadeactualizacion >= obj.fechadesde)
                  .Where(a => a.fechadeactualizacion < obj.fechadesde.Value.AddDays(1)).ToList();
            }



            if (comando.Trim().Length==3)
            {
                list = _context.Logs.ToList()
                 .OrderByDescending(a => a.fechadeactualizacion)
                  .Where(a => a.fechadeactualizacion >= obj.fechadesde)
                  .Where(a => a.fechadeactualizacion < obj.fechadesde.Value.AddDays(1))
                  .Where(a => a.descripciondelaoperacion.Contains((obj.filtro1.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
            }

            if (comando.Trim().Length == 4)
            {
                list = _context.Logs.ToList()
                 .OrderByDescending(a => a.fechadeactualizacion)
                  .Where(a => a.fechadeactualizacion >= obj.fechadesde)
                  .Where(a => a.fechadeactualizacion < obj.fechadesde.Value.AddDays(1))
                  .Where(a => a.descripciondelaoperacion.Contains((obj.filtro1.Trim()), StringComparison.OrdinalIgnoreCase))
                  .Where(a => a.descripciondelaoperacion.Contains((obj.filtro2.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
            }

            if (comando.Trim().Length == 5)
            {
                list = _context.Logs.ToList()
                 .OrderByDescending(a => a.fechadeactualizacion)
                  .Where(a => a.fechadeactualizacion >= obj.fechadesde)
                  .Where(a => a.fechadeactualizacion < obj.fechadesde.Value.AddDays(1))
                  .Where(a => a.descripciondelaoperacion.Contains((obj.filtro1.Trim()), StringComparison.OrdinalIgnoreCase))
                  .Where(a => a.descripciondelaoperacion.Contains((obj.filtro2.Trim()), StringComparison.OrdinalIgnoreCase))
                  .Where(a => a.descripciondelaoperacion.Contains((obj.filtro3.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();

            }


            if (comando.Trim().Length == 6)
            {
                list = _context.Logs.ToList()
                 .OrderByDescending(a => a.fechadeactualizacion)
                  .Where(a => a.fechadeactualizacion >= obj.fechadesde)
                  .Where(a => a.fechadeactualizacion < obj.fechadesde.Value.AddDays(1))
                  .Where(a => a.descripciondelaoperacion.Contains((obj.filtro1.Trim()), StringComparison.OrdinalIgnoreCase))
                  .Where(a => a.descripciondelaoperacion.Contains((obj.filtro2.Trim()), StringComparison.OrdinalIgnoreCase))
                  .Where(a => a.descripciondelaoperacion.Contains((obj.filtro3.Trim()), StringComparison.OrdinalIgnoreCase))
                  .Where(a => a.descripciondelaoperacion.Contains((obj.filtro4.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();

            }


            if (comando.Trim().Length == 6)
            {
                list = _context.Logs.ToList()
                 .OrderByDescending(a => a.fechadeactualizacion)
                  .Where(a => a.fechadeactualizacion >= obj.fechadesde)
                  .Where(a => a.fechadeactualizacion < obj.fechadesde.Value.AddDays(1))
                  .Where(a => a.descripciondelaoperacion.Contains((obj.filtro1.Trim()), StringComparison.OrdinalIgnoreCase))
                  .Where(a => a.descripciondelaoperacion.Contains((obj.filtro2.Trim()), StringComparison.OrdinalIgnoreCase))
                  .Where(a => a.descripciondelaoperacion.Contains((obj.filtro3.Trim()), StringComparison.OrdinalIgnoreCase))
                  .Where(a => a.descripciondelaoperacion.Contains((obj.filtro4.Trim()), StringComparison.OrdinalIgnoreCase))
                  .Where(a => a.descripciondelaoperacion.Contains((obj.filtro5.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();

            }


            return Mapping.ListLogToLogDTO(list);
        }
    }
}