using Inventarios.DTO;
using Inventarios.services;
using Inventarios.Tables;
using Inventarios.Token;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;

namespace Inventarios.Controllers
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class StaticTablesController : ControllerBase
    {

      
        private readonly JwtService _jwtservice;
        private readonly StaticTables _statictables;


        public StaticTablesController( StaticTables statictables, JwtService jwtservice)
        {
            _statictables= statictables;
            _jwtservice = jwtservice;

        }


        [HttpGet("{filtro}")]
        [ActionName("GetEstadosDeUnRegistroGetAll")]
        public List<CodigoNombre>?   GetEstadosDeUnRegistroGetAll(string filtro)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
         
            return _statictables.EstadosDeUnRegistro.Where(a => a.nombre.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
        }

        [HttpGet("{id}")]
        [ActionName("GetEstadoDeUnRegistroById")]
        public List<CodigoNombre>? GetEstadoDeUnRegistroById(string id)
        {
            id = id.ToUpper();
            if (_jwtservice.UserAthenticated() == false) return null;

            return _statictables.EstadosDeUnRegistro.Where(a =>a.id.Equals(id)).ToList();
        }



        [HttpGet]
        [ActionName("GetSiNo")]
        public List<CodigoNombre>? GetSiNo()
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            return _statictables.SiNo;
        }


        [HttpGet]
        [ActionName("GetTiposDePersona")]
        public List<CodigoNombre>? GetTiposDePersona()
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            return _statictables.TiposDePersona;
        }

        [HttpGet]
        [ActionName("GetTallas")]
        public List<CodigoNombre>? GetTallas()
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            return _statictables.Tallas;

        }


        [HttpGet("{filtro}")]
        [ActionName("GetTiposDeAgente")]
        public List<CodigoNombre>? GetTiposDeAgente(string filtro)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            return _statictables.TiposDeAgente.Where(a => a.nombre.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();

        }


        [HttpGet("{id}")]
        [ActionName("GetTipoDeAgenteById")]
        public List<CodigoNombre>? GetTipoDeAgenteById( string id  )
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            return _statictables.TiposDeAgente.Where(a => a.id.Equals(id)).ToList();

        }





        [HttpGet]
        [ActionName("GetTiposDeCuentaBancaria")]
        public List<CodigoNombre>? GetTiposDeCuentaBancaria()
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            return _statictables.TiposDeCuentaBancaria;

        }


        [HttpGet]
        [ActionName("GetTiposDeRegimen")]
        public List<CodigoNombre>? GetTiposDeRegimen()
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            return _statictables.TiposDeRegimen;

        }





    }
}
