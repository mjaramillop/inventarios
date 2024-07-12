using Inventarios.Models.CapturaDeMovimiento;
using Inventarios.ModelsParameter.CapturaDeMovimiento;
using Inventarios.services.CapturaDeMovimiento;
using Inventarios.Utils;
using Microsoft.AspNetCore.Mvc;

namespace Inventarios.Controllers.CapturaDeMovimiento
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class MovimientodeinventariosController : ControllerBase
    {
        private readonly MovimientodeinventariosService _service;
        private List<Movimientodeinventarios>? list;
        private Validaciones _validaciones;

        public MovimientodeinventariosController(MovimientodeinventariosService service , Validaciones validaciones)
        {
            _service = service;
            _validaciones = validaciones;   
        }


        [HttpPost]
        [ActionName("Add")]
        public List<string>? Add(Movimientodeinventariostmp obj, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;

            List<string>? list = _service.Add(obj);
            return list;
        }

        [HttpDelete("{id}/{idusuario}/{token}")]
        [ActionName("Delete")]
        public List<string>? Delete(int id, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            List<string>? list = _service.Delete(id);
            return list;
        }

        [HttpPut]
        [ActionName("Update")]
        public List<string>? Update(Movimientodeinventariostmp obj, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            List<string>? list = _service.Update(obj);
            return list;
        }

        [HttpGet("{id}/{idusuario}/{token}")]
        [ActionName("GetById")]
        public List<Movimientodeinventariostmp>? GetById(int id, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            List<Movimientodeinventariostmp> list = _service.GetById(id);
            return list;
        }

        [HttpGet("{tipodedocumento}/{numerodedocumento}/{despacha}/{recibe}/{idusuario}/{token}")]
        [ActionName("GetByNumeroDeDocumento")]
        public List<Movimientodeinventarios>? GetByNumeroDeDocumento(int tipodedocumento, int numerodedocumento, int despacha, int recibe, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            list = _service.GetByNumeroDeDocumento(tipodedocumento, numerodedocumento, despacha, recibe);
            return list;
        }

        [HttpGet("{tipodedocumento}/{numerodedocumento}/{despacha}/{recibe}/{idusuario}/{token}")]
        [ActionName("GetByNumeroDeDocumentoYPasarloAlTemporal")]
        public List<Movimientodeinventariostmp>? GetByNumeroDeDocumentoYPasarloAlTemporal(int tipodedocumento, int numerodedocumento, int despacha, int recibe, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
          List<Movimientodeinventariostmp>   list = _service.GetByNumeroDeDocumentoYPasarloAlTemporal(tipodedocumento, numerodedocumento, despacha, recibe);
            return list;
        }

        // trae todo el documento temporal que esta generando el usuario
        // cada vez que graba un registro nuevo
        [HttpGet("{tipodedocumento}/{idusuario}/{token}")]
        [ActionName("TraerDocumentoTemporal")]
        public List<Movimientodeinventariostmp>?  TraerDocumentoTemporal(int tipodedocumento, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            List<Movimientodeinventariostmp> list = _service.TraerDocumentoTemporal(tipodedocumento, idusuario);
            return list;
        }


        // anula un documento en el movimiento definitivo
        [HttpPut]
        [ActionName("AnularDocumento")]
        public List<string> AnularDocumento(Movimientodeinventariostmp obj , int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            List<string> list = _service.AnularDocumento(obj);

            return list;
        }

        // borra documento en el temporal 
        [HttpGet("{tipodedocumento}/{idusuario}/{token}")]
        [ActionName("DeleteDocument")]
        public List<string> DeleteDocument(int tipodedocumento, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            List<string> list = _service.DeleteDocument(tipodedocumento, idusuario);
            return list;
        }

        [HttpPut]
        [ActionName("AddDocument")]
        public List<string> AddDocument(Movimientodeinventariostmp obj, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == false) return null;
            List<string> list = _service.AddDocument(obj);
            return list;
        }



        [HttpGet("{tipodedocumento}/{porcentajededescuento}/{idusuario}/{token}")]
        [ActionName("AplicarDescuentoPieDeFactura")]
        public void AplicarDescuentoPieDeFactura(int tipodedocumento, decimal porcentajededescuento, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == true)
            {
                _service.AplicarDescuentoPieDeFactura(tipodedocumento, porcentajededescuento, idusuario);
            }
        }

        [HttpGet("{tipodedocumento}/{valorfletes}/{idusuario}/{token}")]
        [ActionName("AplicarFletePieDeFactura")]
        public void AplicarFletePieDeFactura(int tipodedocumento, int valorfletes, int idusuario, string token)
        {
            if (_validaciones.ValidarToken(idusuario, token) == true)
            {
                _service.AplicarFletePieDeFactura(tipodedocumento, valorfletes, idusuario);
            }
        }
    }
}