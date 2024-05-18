using Inventarios.Data;
using Inventarios.Models.TablasMaestras;
using Microsoft.EntityFrameworkCore;

namespace Inventarios.DataAccess.Utils
{
    public class CalcularIva
    {
        private readonly InventariosContext _context;
        public int idiva { get; set; }
        public decimal porcentajedeiva { get; set; }
        public int valoriva { get; set; }

        public string nombreiva { get; set; }

        public string nombreproducto { get; set; }

        public CalcularIva(TiposDeDocumento objtipodedocumento, InventariosContext context, int idproducto, decimal valorbruto)

        {
            _context = context;

            idiva = 0;
            porcentajedeiva = 0;
            valoriva = 0;
            nombreiva = "";
            nombreproducto = "";

            if ((objtipodedocumento.esunaventa == "S") || (objtipodedocumento.esunacompra == "S"))
            {
                Productos? objproducto = new Productos();
                objproducto = _context.Productos.FirstOrDefault(a => a.id == idproducto);

                if (objproducto == null) nombreproducto = "Codigo errado..";

                if (objproducto != null)
                {
                    Ivas? objivas = new Ivas();
                    objivas = _context.Ivas.FirstOrDefault(a => a.id == objproducto.codigoiva1);

                    idiva = objivas.id;
                    porcentajedeiva = objivas.porcentaje;
                    valoriva = Convert.ToInt32(valorbruto * (objivas.porcentaje / 100));
                    nombreiva = objivas.nombre;
                }
            }
        }
    }
}