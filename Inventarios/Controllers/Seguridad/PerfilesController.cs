using Inventarios.DTO.Seguridad;
using Inventarios.Models.Seguridad;
using Inventarios.Models.TablasMaestras;
using Inventarios.services.Seguridad;

using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.Seguridad
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class PerfilesController : ControllerBase
    {
        private readonly PerfilesService _service;

        private List<PerfilesDTO>? list;

        public PerfilesController(PerfilesService service)
        {
            _service = service;
        }

        [HttpPost]
        [ActionName("Add")]
        public Mensaje Add(Perfiles obj)
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
        public Mensaje Update(Perfiles obj)
        {
            Mensaje list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<Perfiles>? GetById(int id)
        {
            List<Perfiles> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}")]
        [ActionName("GetAll")]
        public List<PerfilesDTO>? GetAll(string filtro = "")
        {
            list = _service.List(filtro);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetListProgramasPermisos")]
        public List<ProgramasPermisosDTO>? GetListProgramasPermisos(int id)
        {
            List<ProgramasPermisosDTO>? list = _service.ListProgramasPermisos(id);
            return list;
        }
    }
}