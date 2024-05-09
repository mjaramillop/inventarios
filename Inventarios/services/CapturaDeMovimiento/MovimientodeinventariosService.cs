using Inventarios.DataAccess.CapturaDeMovimiento;
using Inventarios.Models.CapturaDeMovimiento;
using Microsoft.EntityFrameworkCore;
using System.ComponentModel;

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

        public List<string>? Add(Movimientodeinventarios obj)
        {
            List<string> mensajedeerror = _access.Add(obj);
            return mensajedeerror;
        }

        public List<string>? Delete(int id)
        {
            List<string> mensajedeeror = _access.Delete(id);
            return mensajedeeror;
        }

        public List<string>? Update(Movimientodeinventarios obj)
        {
            List<string> mensajedeerror = _access.Update(obj);
            return mensajedeerror;
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

        public List<string> AddDocument(int tipodedocumento)
        {
            List<string> list = _access.AddDocument(tipodedocumento);
            return list;
        }
    }

}