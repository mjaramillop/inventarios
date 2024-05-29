using Inventarios.Models.CapturaDeMovimiento;
using Inventarios.services.CapturaDeMovimiento;

using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.CapturaDeMovimiento
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class MovimientodeinventariosController : ControllerBase
    {
        private readonly MovimientodeinventariosService _service;
        private List<Movimientodeinventarios>? list;

        public MovimientodeinventariosController(MovimientodeinventariosService service)
        {
            _service = service;
        }

        [HttpPost]
        [ActionName("Add")]
        public List<string>? Add(Movimientodeinventarios obj)
        {
            List<string>? list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}")]
        [ActionName("Delete")]
        public List<string>? Delete(int id)
        {
            List<string>? list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public List<string>? Update(Movimientodeinventarios obj)
        {
            List<string>? list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}")]
        [ActionName("GetById")]
        public List<Movimientodeinventarios>? GetById(int id)
        {
            list = _service.GetById(id);
            return list;
        }

        [HttpGet("{tipodedocumento}/{numerodedocumento}/{despacha}/{recibe}")]
        [ActionName("GetByNumeroDeDocumento")]
        public List<Movimientodeinventarios>? GetByNumeroDeDocumento(int tipodedocumento, int numerodedocumento, int despacha, int recibe)
        {
            list = _service.GetByNumeroDeDocumento(tipodedocumento, numerodedocumento, despacha, recibe);
            return list;
        }

        [HttpGet("{tipodedocumento}/{idusuario}")]
        [ActionName("GetAll")]
        public List<Movimientodeinventarios>? GetAll(int tipodedocumento, int idusuario)
        {
            list = _service.List(tipodedocumento, idusuario);
            return list;
        }

        [HttpGet("{tipodedocumento}/{numerodedocumento}/{despacha}/{recibe}")]
        [ActionName("AnularDocumento")]
        public List<string> AnularDocumento(int tipodedocumento, int numerodedocumento, int despacha, int recibe)
        {
            List<string> list = _service.AnularDocumento(tipodedocumento, numerodedocumento, despacha, recibe);

            return list;
        }

        [HttpGet("{tipodedocumento}/{idusuario}")]
        [ActionName("DeleteDocument")]
        public List<string> DeleteDocument(int tipodedocumento, int idusuario)
        {
            List<string> list = _service.DeleteDocument(tipodedocumento, idusuario);
            return list;
        }

        [HttpGet("{tipodedocumento}/{idusuario}")]
        [ActionName("AddDocument")]
        public List<string> AddDocument(int tipodedocumento, int idusuario)
        {
            List<string> list = _service.AddDocument(tipodedocumento, idusuario);
            return list;
        }

        [HttpGet("{tipodedocumento}/{idusuario}")]
        [ActionName("TraerTipoDeDocumentoTemporal")]
        public List<Movimientodeinventarios> TraerDocumentoTemporal(int tipodedocumento, int idusuario)
        {
            list = _service.TraerDocumentoTemporal(tipodedocumento, idusuario);
            return list;
        }

        [HttpGet("{tipodedocumento}/{porcentajededescuento}/{idusuario}")]
        [ActionName("AplicarDescuentoPieDeFactura")]
        public void AplicarDescuentoPieDeFactura(int tipodedocumento, decimal porcentajededescuento, int idusuario)
        {
            _service.AplicarDescuentoPieDeFactura(tipodedocumento, porcentajededescuento, idusuario);
        }

        [HttpGet("{tipodedocumento}/{valorfletes}/{idusuario}")]
        [ActionName("AplicarFletePieDeFactura")]
        public void AplicarFletePieDeFactura(int tipodedocumento, int valorfletes, int idusuario)
        {
            _service.AplicarFletePieDeFactura(tipodedocumento, valorfletes, idusuario);
        }
    }
}