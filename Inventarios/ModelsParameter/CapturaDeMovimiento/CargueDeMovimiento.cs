namespace Inventarios.ModelsParameter.CapturaDeMovimiento
{
    public class CargueDeMovimiento
    {

        public int tipodedocumento {  get; set; }   

        public int numerodeldocumento { get; set; }

        public int despacha        { get; set; }    

        public int recibe { get; set; }

        public string consecutivousuario {  get; set; } 
        
        public int idusuario { get; set; }  

        public int programa { get; set; }       

        public int vendedor { get; set; }   

        public DateTime fechadeldocumento { get; set; }  

        public int plazo { get; set; }  

        public DateTime fechadevencimientodeldocumento { get; set; } 

        public int tipodedocumentoaafectar {  get; set; }   

        public int numerodeldocumentoaafectar { get; set; } = 0;

        public int despachaaafectar { get; set; }   

        public int recibeaafectar { get; set; } 



    }
}
