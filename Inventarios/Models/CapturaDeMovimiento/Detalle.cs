using System.ComponentModel.DataAnnotations.Schema;

namespace Inventarios.Models.CapturaDeMovimiento
{
    public class Detalle
    {


        public Detalle()
        {

            id = 0;
            detalle = "";
        }
              
        public int id { get; set; }
     
        public string detalle { get; set; }

    }
}
