using static System.Runtime.InteropServices.JavaScript.JSType;
using System.Drawing;

namespace Inventarios.Utils
{
    public class Validaciones
    {
        public string mensajedeerror {  get; set; }
        public Validaciones() {
            this.mensajedeerror = "";
        }


        public void Validarvalormayorquecero(string campo , int? valor)
        {
            if (valor <= 0)
            {
                this.mensajedeerror = this.mensajedeerror + campo + " no puede ser menor que cero " + '\n';
            }



        }


        public void Validarvalordiferentedecero(string campo, int? valor)
        {
            if (valor == 0)
            {
                this.mensajedeerror = this.mensajedeerror + campo + " no puede ser  cero " + '\n';
            }
        }


        public void Validarvalormenorquecero(string campo , int? valor)
        {
            if (valor < 0)
            {
                this.mensajedeerror = this.mensajedeerror + campo + " no puede ser  menor que cero " + '\n';

            }
        }



    }
}
