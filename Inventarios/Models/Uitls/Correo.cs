namespace Inventarios.Models.Uitls
{
    public class Correo
    {
        public Correo() {

            this.Asunto = "";
            this.Mensaje = "";
            this.Destinatario = "";
            this.ServidorSmtpRemitePuerto = "";
            this.habilitarconexionsegurassl = true;
            this.direcciondecorreodesalida = "";
            this.MensajeDeError = "";
            this.servidorcorreodesalidasmtp = "";
            this.servidordecorreodesalidasmtppuerto = 25;

        } 

        public string Asunto { get; set; }
        public string Mensaje { get; set; }
        public string Destinatario { get; set; }
        public string ServidorSmtpRemitePuerto { get; set; }
        public bool habilitarconexionsegurassl { get; set; }

        //  public string RemitePassword { get; set; }
        public string MensajeDeError { get; set; }

        public string direcciondecorreodesalida { get; set; }   
        public string servidorcorreodesalidasmtp { get; set; }  

        public int servidordecorreodesalidasmtppuerto { get; set; }


    }
}
