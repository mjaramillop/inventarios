using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;
using Inventarios.services.TablasMaestras;

using Microsoft.AspNetCore.Mvc;
using Microsoft.CodeAnalysis.Elfie.Serialization;
using Microsoft.EntityFrameworkCore;
using System.Globalization;
using System.Collections.Generic;
using System.Text;
using System.Reflection;
using Inventarios.Utils;

namespace Inventarios.Controllers.TablasMaestras
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class SaldosController : ControllerBase
    {
        private readonly SaldosService _service;
        private Validaciones _validaciones;

        private List<SaldosDTO>? list;

        public SaldosController(SaldosService service,Validaciones validaciones)
        {
            _service = service;
            _validaciones = validaciones;
        }

        [HttpPost]
        [ActionName("Add")]
        public Mensaje Add(Saldos obj, int idusuario, string token)
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
        public Mensaje Update(Saldos obj, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            Mensaje list = _service.Update(obj );
            return list;
        }

        [HttpGet("{id}/{idusuario}/{token}")]
        [ActionName("GetById")]
        public List<Saldos>? GetById(int id, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            List<Saldos> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}/{bodega}/{opcion}/{diassinrotar}/{idusuario}/{token}")]
        [ActionName("GetAll")]
        public List<SaldosDTO>? GetAll(string filtro , string bodega , int opcion , int diassinrotar, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            list = _service.List(filtro, bodega, opcion, diassinrotar);
            return list;
        }

        [HttpGet("{filtro}/{bodega}/{opcion}/{diassinrotar}/{idusuario}/{token}")]
        [ActionName("DownloadCSV")]
       
        public async Task<FileResult> DownloadCSV(string filtro , string bodega , int opcion , int diassinrotar, int idusuario, string token)
        {

            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            StringBuilder sb = _service.DownloadCSV(filtro, bodega, opcion, diassinrotar);

            return File(Encoding.UTF8.GetBytes(sb.ToString()), "text/csv", "Saldos.csv");
        }

    }
}