﻿using Inventarios.DTO;
using Inventarios.Models;
using Inventarios.services;
using Inventarios.Token;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers
{
    [Route("[controller]/[action]")]
    [ApiController]

    public class ActividadesEconomicasController : ControllerBase
    {


        private readonly ActividadesEconomicasService _service;
        private readonly JwtService _jwtservice;
        private List<ActividadesEconomicasDTO>? list;

        public ActividadesEconomicasController(ActividadesEconomicasService service, JwtService jwtservice)
        {
            _service = service;
            _jwtservice = jwtservice;
        }

        [HttpPost]
        [ActionName("Add")]
        public List<ActividadesEconomicasDTO>? Add(ActividadesEconomicas obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}")]
        [ActionName("Delete")]
        public List<ActividadesEconomicasDTO>? Delete(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public List<ActividadesEconomicasDTO>? Update(ActividadesEconomicas obj)
        {
            if (_jwtservice.UserAthenticated() == false) return null;

            list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<ActividadesEconomicas>? GetById(int id)
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            List<ActividadesEconomicas> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}")]
        [ActionName("GetAll")]
        public List<ActividadesEconomicasDTO>? GetAll(string filtro = "")
        {
            if (_jwtservice.UserAthenticated() == false) return null;
            list = _service.List(filtro);
            return list;
        }

      




    }
}
