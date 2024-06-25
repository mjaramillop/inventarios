using Inventarios.DTO.Seguridad;
using Inventarios.Models;
using Inventarios.Models.Seguridad;
using Inventarios.Models.TablasMaestras;
using Inventarios.services.Seguridad;
using Inventarios.Utils;
using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.Seguridad
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class PerfilesController : ControllerBase
    {
        private readonly PerfilesService _service;

        private List<PerfilesDTO>? list;
        private Validaciones _validaciones;
      

        public PerfilesController(PerfilesService service , Validaciones validaciones   )
        {   
          
            _service = service; 
            _validaciones = validaciones;   
        }

        [HttpPost]
        [ActionName("Add")]
        public Mensaje Add(Perfiles obj, int idusuario, string token)
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
        public Mensaje Update(Perfiles obj, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;

            Mensaje list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}/{idusuario}/{token}")]
        [ActionName("GetById")]
        public List<Perfiles>? GetById(int id, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;

            List<Perfiles> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{filtro}/{idusuario}/{token}")]
        [ActionName("GetAll")]
        public List<PerfilesDTO>? GetAll(string filtro, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;

            list = _service.List(filtro);
            return list;
        }

        [HttpGet("{id}/{idusuario}/{token}")]
        [ActionName("GetListProgramasPermisos")]
        public List<ProgramasPermisosDTO>? GetListProgramasPermisos(int id, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;

            List<ProgramasPermisosDTO>? list = _service.ListProgramasPermisos(id);
            return list;
        }
    }
}