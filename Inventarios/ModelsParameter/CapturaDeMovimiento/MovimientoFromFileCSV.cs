using Microsoft.EntityFrameworkCore;

namespace Inventarios.ModelsParameter.CapturaDeMovimiento
{
    public class MovimientoFromFileCSV
    {

        public int tipodedocumento {  get; set; }   
        public int producto { get; set; }

        public int bodega { get; set; }
    }
}