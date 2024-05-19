using Inventarios.Data;
using Inventarios.Models.TablasMaestras;

namespace Inventarios.DataAccess.Utils
{
    public class MovimientosDeInventarios
    {

        private readonly IConfiguration _iconfiguration;

        private readonly InventariosContext _context;

        // Iva
        public int idiva { get; set; }
        public decimal porcentajedeiva { get; set; }
        public int valoriva { get; set; }

        public string nombreiva { get; set; }

        public string nombreproducto { get; set; }

        // Retencion

        public int idretencion { get; set; }
        public decimal porcentajederetencion { get; set; }
        public int valorretencion { get; set; }
        public string nombreretencion { get; set; }

        public MovimientosDeInventarios(IConfiguration configutarion) 
        { 
       
            _iconfiguration = configutarion;
        
        
        }   


        public void CalcularIva(TiposDeDocumento objtipodedocumento,  int idproducto, decimal valorbruto)
        {
        

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


        public void CalcularRetencion(TiposDeDocumento objtipodedocumento, int recibe, decimal valorbruto)
        {
         
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
