using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;
using Inventarios.services.TablasMaestras;

using Microsoft.AspNetCore.Mvc;

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

        [HttpGet("{filtro}/{bodega}")]
        [ActionName("GetAll")]
        public List<SaldosDTO>? GetAll(string filtro = "", string bodega = "")
        {
            if (filtro == "undefined") filtro = "";
            if (bodega == "undefined") bodega = "";

            list = _service.List(filtro, bodega);
            return list;
        }
    }
}