using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;
using Inventarios.services.TablasMaestras;

using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.TablasMaestras
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class FormulasController : ControllerBase
    {
        private readonly FormulasService _service;
        
        private List<FormulasDTO>? list;

        public FormulasController(FormulasService service)
        {
            _service = service;
            
        }

        [HttpPost]
        [ActionName("Add")]
        public List<FormulasDTO>? Add(Formulas obj)
        {
            
            list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}")]
        [ActionName("Delete")]
        public List<FormulasDTO>? Delete(int id)
        {
            

            list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public List<FormulasDTO>? Update(Formulas obj)
        {
            

            list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<Formulas>? GetById(int id)
        {
            
            List<Formulas> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}")]
        [ActionName("GetAll")]
        public List<FormulasDTO>? GetAll(string filtro = "")
        {
            if (filtro == "undefined") filtro = "";

            
            list = _service.List(filtro);
            return list;
        }
    }
}