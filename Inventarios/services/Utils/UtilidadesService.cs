using Inventarios.DataAccess.Utils;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Inventarios.services.Utils
{
   

    public class UtilidadesService
    {
        private UtilidadesAccess? _access;

       public UtilidadesService(UtilidadesAccess access) {
        
        _access = access;

        }


        public string ejecutarsql(string comando)
        {
            return _access.ejecutarsql(comando);
        }

        public DataTable creartabla(string comando)
        {
            return _access.creartabla(comando);

        }

        public string MontoEscrito(string valor)
        {

            return _access.MontoEscrito(valor);
        }


        public List<string> CalcularFechaDeVencimiento(string fecha, int plazo)
        {

            return _access.CalcularFechaDeVencimiento(fecha, plazo);


        }


        /// <summary>
        /// el primer PARAMETRO fecha1 es la fecha mayor
        /// EL SEGUNDO PARAMETRO E LA FECHA MENOR
        /// </summary>
        /// <param name="fecha1"></param>
        /// <param name="fecha2"></param>
        /// <returns></returns>
        public int restarfechas(DateTime fecha1, DateTime fecha2)
        {
            return _access.restarfechas(fecha1, fecha2);
           
        }






    }
}
