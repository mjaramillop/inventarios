using Inventarios.DTO;
using Inventarios.Models.TablasMaestras;
using Inventarios.services.TablasMaestras;
using Inventarios.Utils;
using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.TablasMaestras
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class ConceptosNotaDebitoCreditoController : ControllerBase
    {
        private readonly ConceptosNotaDebitoCreditoService _service;
        private Validaciones _validaciones;

        private List<ConceptosNotaDebitoCreditoDTO>? list;

        public ConceptosNotaDebitoCreditoController(ConceptosNotaDebitoCreditoService service, Validaciones validaciones)
        {
            _service = service;
            _validaciones = validaciones;
        }

        [HttpPost]
        [ActionName("Add")]
        public Mensaje Add(ConceptosNotaDebitoCredito obj, int idusuario, string token)
        {
            Mensaje list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}/{idusuario}/{token}")]
        [ActionName("Delete")]
        public Mensaje Delete(int id, int idusuario, string token)
        {
            Mensaje list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public Mensaje Update(ConceptosNotaDebitoCredito obj, int idusuario, string token)
        {
            Mensaje list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}/{idusuario}/{token}")]
        [ActionName("GetById")]
        public List<ConceptosNotaDebitoCredito>? GetById(int id, int idusuario, string token)
        {
            List<ConceptosNotaDebitoCredito> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}/{idusuario}/{token}")]
        [ActionName("GetAll")]
        public List<ConceptosNotaDebitoCreditoDTO>? GetAll(string filtro, int idusuario, string token)
        {
            if (filtro == "undefined") filtro = "";

            list = _service.List(filtro);
            return list;
        }
    }
}