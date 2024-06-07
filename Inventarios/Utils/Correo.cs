using System.Net.Mail;

namespace Inventarios.Utils
{
    public class Correo
    {

        private readonly Utilidades _utilidades;
        private readonly IConfiguration _iconfiguration;

        public Correo(IConfiguration configutarion_ ,Utilidades utilidades ) 
        {
            _iconfiguration = configutarion_;
            _utilidades = utilidades;

            Asunto = "";
            Mensaje = "";
            Destinatario = "";
            ServidorSmtpRemitePuerto = "";
            habilitarconexionsegurassl = true;
            direcciondecorreodesalida = "";
            MensajeDeError = "";
            servidorcorreodesalidasmtp = "";
            servidordecorreodesalidasmtppuerto = 25;
        }



        public string Asunto { get; set; }
        public string Mensaje { get; set; }
        public string Destinatario { get; set; }
        private string ServidorSmtpRemitePuerto { get; set; }
        private bool habilitarconexionsegurassl { get; set; }

        //  public string RemitePassword { get; set; }
        public string MensajeDeError { get; set; }

        private string direcciondecorreodesalida { get; set; }
        private string servidorcorreodesalidasmtp { get; set; }

        public int servidordecorreodesalidasmtppuerto { get; set; }

    
        public string enviarcorreo(Correo? objcorreo)
        {
            objcorreo.direcciondecorreodesalida = _utilidades.traerparametrowebconfig("direcciondecorreodesalida");
            objcorreo.habilitarconexionsegurassl = Convert.ToBoolean( Convert.ToInt16( _utilidades.traerparametrowebconfig("habilitarssl")));
            objcorreo.servidorcorreodesalidasmtp = _utilidades.traerparametrowebconfig("servidordecorreodesalidasmtp");
            objcorreo.servidordecorreodesalidasmtppuerto = Convert.ToInt32(_utilidades.traerparametrowebconfig("servidordecorreodesalidasmtppuerto"));


            System.Net.Mail.MailMessage correo = new System.Net.Mail.MailMessage();
            string Mensajedeerror = "";
            try
            {
                correo.From = new System.Net.Mail.MailAddress(objcorreo.direcciondecorreodesalida);
                correo.To.Add(objcorreo.Destinatario);
                correo.Subject = objcorreo.Asunto;
                correo.Body = objcorreo.Mensaje;
                correo.IsBodyHtml = true;
                correo.Priority = System.Net.Mail.MailPriority.Normal;
                correo.IsBodyHtml = true;
            }
            catch (Exception ex)
            {
                MensajeDeError = "Error:" + ex.Message;
             
                    MensajeDeError += " Error revise el destinatario" + ex.Message.ToString();
                    return MensajeDeError;
               
            }

            System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient();

            smtp.Host = objcorreo.servidorcorreodesalidasmtp;// "correo.mincultura.gov.co";
            smtp.Credentials = new System.Net.NetworkCredential(objcorreo.direcciondecorreodesalida, _utilidades.traerparametrowebconfig("direcciondecorreodesalidapassword"));
            smtp.Port = objcorreo.servidordecorreodesalidasmtppuerto;
            smtp.EnableSsl = objcorreo.habilitarconexionsegurassl; // false;

            smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
         
            try
            {
                MensajeDeError = "Correo enviado satisfactoriamente a " + objcorreo.Destinatario;
                smtp.Send(correo);
            }
            catch (Exception ex)
            {
                MensajeDeError = "Error:" + ex.Message;

                if (ex.InnerException != null)
                {
                    MensajeDeError += " " + ex.InnerException.InnerException.Message.ToString();
                }
            }

            return MensajeDeError;
        }
    }
}