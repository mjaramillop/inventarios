using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;
using Inventarios.services.TablasMaestras;
using Inventarios.Token;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;


namespace Inventarios.Controllers.TablasMaestras
{
    [Route("[controller]/[action]")]
    [ApiController]



    public class TiposDeCuentaBancariaController : ControllerBase
    {


        private readonly TiposDeCuentaBancariaService _service;
        private readonly JwtService _jwtservice;
        private List<TiposDeCuentaBancariaDTO>? list;

        public TiposDeCuentaBancariaController(TiposDeCuentaBancariaService service, JwtService jwtservice)
        {
            _service = service;
            _jwtservice = jwtservice;
        }

        [HttpPost]
        [ActionName("Add")]
        public List<TiposDeCuentaBancariaDTO>? Add(TiposDeCuentaBancaria obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}")]
        [ActionName("Delete")]
        public List<TiposDeCuentaBancariaDTO>? Delete(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public List<TiposDeCuentaBancariaDTO>? Update(TiposDeCuentaBancaria obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<TiposDeCuentaBancaria>? GetById(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            List<TiposDeCuentaBancaria> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}")]
        [ActionName("GetAll")]
        public List<TiposDeCuentaBancariaDTO>? GetAll(string filtro = "")
        {
            if (filtro == "undefined") filtro = "";

            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.List(filtro);
            return list;
        }



    }




}
