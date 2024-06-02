﻿using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;
using Inventarios.services.TablasMaestras;

using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.TablasMaestras
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class TallasController : ControllerBase
    {
        private readonly TallasService _service;

        private List<TallasDTO>? list;

        public TallasController(TallasService service)
        {
            _service = service;
        }

        [HttpPost]
        [ActionName("Add")]
        public Mensaje Add(Tallas obj)
        {
            Mensaje list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}")]
        [ActionName("Delete")]
        public Mensaje Delete(int id)
        {
            Mensaje list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public Mensaje Update(Tallas obj)
        {
            Mensaje list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<Tallas>? GetById(int id)
        {
            List<Tallas> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}")]
        [ActionName("GetAll")]
        public List<TallasDTO>? GetAll(string filtro = "")
        {
            if (filtro == "undefined") filtro = "";

            list = _service.List(filtro);
            return list;
        }
    }
}