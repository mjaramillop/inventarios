using Inventarios.DataAccess.CapturaDeMovimiento;
using Inventarios.Models.CapturaDeMovimiento;

namespace Inventarios.services.CapturaDeMovimiento
{
    public class MovimientodeinventariosService
    {
        private readonly MovimientodeinventariosAccess _access;
        public List<Movimientodeinventarios>? list;

        public MovimientodeinventariosService(MovimientodeinventariosAccess access)
        {
            _access = access;
        }

        public List<string>? Add(Movimientodeinventariostmp obj)
        {
            List<string> mensajedeeror = _access.Add(obj);
            return mensajedeeror;
        }

        public List<string>? Delete(int id)
        {
            List<string> mensajedeeror = _access.Delete(id);
            return mensajedeeror;
        }

        public List<string>? Update(Movimientodeinventariostmp obj)
        {
            List<string> mensajedeerror = _access.Update(obj);
            return mensajedeerror;
        }

        public List<Movimientodeinventariostmp> GetById(int id)
        {
            List<Movimientodeinventariostmp> list = _access.GetById(id);
            return list;
        }

        public List<Movimientodeinventariostmp>? List(int tipodeodcumento, int idusuario)
        {
            List<Movimientodeinventariostmp> list = _access.List(tipodeodcumento, idusuario);
            return list;
        }

        public List<Movimientodeinventarios>? GetByNumeroDeDocumento(int tipodedocumento, int numerodedocumento, int despacha, int recibe)
        {
            list = _access.GetByNumeroDeDocumento(tipodedocumento, numerodedocumento, despacha, recibe);

            return list;
        }

        public List<string> AnularDocumento(int tipodedocumento, int numerodedocumento, int despacha, int recibe)
        {
            List<string> list = _access.AnularDocumento(tipodedocumento, numerodedocumento, despacha, recibe);

            return list;
        }

        public List<string> DeleteDocument(int tipodedocumento, int idusuario)
        {
            List<string> list = _access.DeleteDocument(tipodedocumento, idusuario);
            return list;
        }

        public List<string> AddDocument(int tipodedocumento, int idusuario)
        {
            List<string> list = _access.AddDocument(tipodedocumento, idusuario);
            return list;
        }

        public List<Movimientodeinventarios> TraerDocumentoTemporal(int tipodedocumento, int idusuario)
        {
            list = _access.TraerDocumentoTemporal(tipodedocumento, idusuario);
            return list;
        }

        public void AplicarDescuentoPieDeFactura(int tipodedocumento, decimal porcentajededescuento, int idusuario)
        {
            _access.AplicarDescuentoPieDeFactura(tipodedocumento, porcentajededescuento, idusuario);
        }

        public void AplicarFletePieDeFactura(int tipodedocumento, int valorfletes, int idusuario)
        {
            _access.AplicarFletePieDeFactura(tipodedocumento, valorfletes, idusuario);
        }
    }
}