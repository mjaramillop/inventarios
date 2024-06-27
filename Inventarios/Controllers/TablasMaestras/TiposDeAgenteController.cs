﻿using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;
using Inventarios.services.TablasMaestras;
using Inventarios.Utils;
using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.TablasMaestras
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class TiposDeAgenteController : ControllerBase
    {
        private readonly TiposDeAgenteService _service;
        private Validaciones _validaciones;

        private List<TiposDeAgenteDTO>? list;

        public TiposDeAgenteController(TiposDeAgenteService service,Validaciones validaciones)
        {
            _service = service;
            _validaciones = validaciones;
        }

        [HttpPost]
        [ActionName("Add")]
        public Mensaje Add(TiposDeAgente obj, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            Mensaje list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}/{idusuario}/{token}")]
        [ActionName("Delete")]
        public Mensaje Delete(int id, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            Mensaje list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public Mensaje Update(TiposDeAgente obj, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            Mensaje list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}/{idusuario}/{token}")]
        [ActionName("GetById")]
        public List<TiposDeAgente>? GetById(int id, int idusuario, string token )
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            List<TiposDeAgente> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}/{idusuario}/{token}")]
        [ActionName("GetAll")]
        public List<TiposDeAgenteDTO>? GetAll(string filtro, int idusuario, string token    )
        {

            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            list = _service.List(filtro);
            return list;
        }
    }
}