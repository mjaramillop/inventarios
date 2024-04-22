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



    public class TiposDeRegimenController : ControllerBase
    {


        private readonly TiposDeRegimenService _service;
        private readonly JwtService _jwtservice;
        private List<TiposDeRegimenDTO>? list;

        public TiposDeRegimenController(TiposDeRegimenService service, JwtService jwtservice)
        {
            _service = service;
            _jwtservice = jwtservice;
        }

        [HttpPost]
        [ActionName("Add")]
        public List<TiposDeRegimenDTO>? Add(TiposDeRegimen obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}")]
        [ActionName("Delete")]
        public List<TiposDeRegimenDTO>? Delete(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public List<TiposDeRegimenDTO>? Update(TiposDeRegimen obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<TiposDeRegimen>? GetById(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            List<TiposDeRegimen> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}")]
        [ActionName("GetAll")]
        public List<TiposDeRegimenDTO>? GetAll(string filtro = "")
        {
            if (filtro == "undefined") filtro = "";

            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.List(filtro);
            return list;
        }



    }




}
