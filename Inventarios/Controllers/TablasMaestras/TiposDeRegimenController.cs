using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;
using Inventarios.services.TablasMaestras;
using Inventarios.Utils;
using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.TablasMaestras
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class TiposDeRegimenController : ControllerBase
    {
        private readonly TiposDeRegimenService _service;
        private Validaciones _validaciones;

        private List<TiposDeRegimenDTO>? list;

        public TiposDeRegimenController(TiposDeRegimenService service, Validaciones validaciones)
        {
            _service = service;
            _validaciones = validaciones;
        }

        [HttpPost]
        [ActionName("Add")]
        public Mensaje Add(TiposDeRegimen obj, int idusuario, string token)
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
        public Mensaje Update(TiposDeRegimen obj, int idusuario, string token)
        {
            Mensaje list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}/{idusuario}/{token}")]
        [ActionName("GetById")]
        public List<TiposDeRegimen>? GetById(int id, int idusuario, string token    )
        {
            List<TiposDeRegimen> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}/{idusuario}/{token}")]
        [ActionName("GetAll")]
        public List<TiposDeRegimenDTO>? GetAll(string filtro, int idusuario, string token)
        {
         
            list = _service.List(filtro);
            return list;
        }
    }
}