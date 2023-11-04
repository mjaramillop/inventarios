using Inventarios.Data;
using Inventarios.Models;
using Inventarios.Token;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory.Database;

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
        public  void Add(string registro)
        {

            registro = registro + "Usuario que actualizo =" + _jwtservice.username;


            Log log = new Log();
            log.fechadeactualizacion = System.DateTime.Now;
            log.DescripcionDeLaOperacion=registro;
         
            _context.Logs.Add(log);
            _context.SaveChanges();

          


        }
    }
}
