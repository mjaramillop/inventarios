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

namespace Inventarios.Controllers.TablasMaestras
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class SaldosController : ControllerBase
    {
        private readonly SaldosService _service;

        private List<SaldosDTO>? list;

        public SaldosController(SaldosService service)
        {
            _service = service;
        }

        [HttpPost]
        [ActionName("Add")]
        public Mensaje Add(Saldos obj)
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
        public Mensaje Update(Saldos obj)
        {
            Mensaje list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<Saldos>? GetById(int id)
        {
            List<Saldos> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}/{bodega}/{opcion}/{diassinrotar}")]
        [ActionName("GetAll")]
        public List<SaldosDTO>? GetAll(string filtro = "", string bodega = "", int opcion = 0, int diassinrotar = 0)
        {
            if (filtro == "undefined") filtro = "";
            if (bodega == "undefined") bodega = "";

            list = _service.List(filtro, bodega, opcion, diassinrotar);
            return list;
        }

        [HttpGet("{filtro}/{bodega}/{opcion}/{diassinrotar}")]
        [ActionName("DownloadCSV")]
       
        public async Task<FileResult> DownloadCSV(string filtro = "", string bodega = "", int opcion = 0, int diassinrotar = 0)
        {
            if (filtro == "undefined") filtro = "";
            if (bodega == "undefined") bodega = "";

            StringBuilder sb = _service.DownloadCSV(filtro, bodega, opcion, diassinrotar);

            return File(Encoding.UTF8.GetBytes(sb.ToString()), "text/csv", "Saldos.csv");
        }

    }
}