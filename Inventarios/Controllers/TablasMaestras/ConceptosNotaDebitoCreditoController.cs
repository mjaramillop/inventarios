﻿using Inventarios.DTO;
using Inventarios.Models.TablasMaestras;
using Inventarios.services.TablasMaestras;

using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.TablasMaestras
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class ConceptosNotaDebitoCreditoController : ControllerBase
    {
        private readonly ConceptosNotaDebitoCreditoService _service;

        private List<ConceptosNotaDebitoCreditoDTO>? list;

        public ConceptosNotaDebitoCreditoController(ConceptosNotaDebitoCreditoService service)
        {
            _service = service;
        }

        [HttpPost]
        [ActionName("Add")]
        public Mensaje Add(ConceptosNotaDebitoCredito obj)
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
        public Mensaje Update(ConceptosNotaDebitoCredito obj)
        {
            Mensaje list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<ConceptosNotaDebitoCredito>? GetById(int id)
        {
            List<ConceptosNotaDebitoCredito> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}")]
        [ActionName("GetAll")]
        public List<ConceptosNotaDebitoCreditoDTO>? GetAll(string filtro = "")
        {
            if (filtro == "undefined") filtro = "";

            list = _service.List(filtro);
            return list;
        }
    }
}