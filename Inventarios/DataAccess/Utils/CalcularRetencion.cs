using Inventarios.Data;
using Inventarios.Models.TablasMaestras;

namespace Inventarios.DataAccess.Utils
{
    public class CalcularRetencion
    {
        private readonly InventariosContext _context;

        public int idretencion { get; set; }
        public decimal porcentajederetencion { get; set; }
        public int valorretencion { get; set; }

        public string nombreretencion { get; set; }

        public CalcularRetencion(TiposDeDocumento objtipodedocumento, InventariosContext context, int recibe, decimal valorbruto)
        {
            _context = context;
            idretencion = 0;
            porcentajederetencion = 0;
            valorretencion = 0;
            nombreretencion = "";

            if (objtipodedocumento.esunpago == "S")
            {
                Proveedores? objproveedores = new Proveedores();
                objproveedores = _context.Proveedores.FirstOrDefault(a => a.id == recibe);

                if (objproveedores != null)
                {
                    Retenciones? objretenciones = new Retenciones();
                    objretenciones = _context.Retenciones.FirstOrDefault(a => a.id == objproveedores.codigoderetencionaaplicar);

                    if (objretenciones != null)
                    {
                        idretencion = objretenciones.id;
                        porcentajederetencion = objretenciones.porcentaje;
                        if (valorbruto >= objretenciones.basedelaretencion)
                        {
                            valorretencion = Convert.ToInt32(valorbruto * (objretenciones.porcentaje / 100));
                        }
                        nombreretencion = objretenciones.nombre;
                    }
                }
            }
        }
    }
}