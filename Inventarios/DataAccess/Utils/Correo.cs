


namespace Inventarios.DataAccess.Utils
{
    public class Correo
    {
        private readonly IConfiguration _iconfiguration;


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
        public Correo(IConfiguration configutarion_)
        {
            _iconfiguration = configutarion_;

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


        public string enviarcorreo(Correo? objcorreo)
        {
            objcorreo.direcciondecorreodesalida = _iconfiguration.GetConnectionString("direcciondecorreodesalida");
            objcorreo.habilitarconexionsegurassl = Convert.ToBoolean(_iconfiguration.GetConnectionString("habilitarssl"));
            objcorreo.servidorcorreodesalidasmtp = _iconfiguration.GetConnectionString("servidorcorreodesalidasmtp");
            objcorreo.servidordecorreodesalidasmtppuerto= Convert.ToInt32(_iconfiguration.GetConnectionString("servidordecorreodesalidasmtppuerto"));


            System.Net.Mail.MailMessage correo = new System.Net.Mail.MailMessage();
            correo.From = new System.Net.Mail.MailAddress(objcorreo.direcciondecorreodesalida);
            correo.To.Add(objcorreo.Destinatario);
            correo.Subject =objcorreo.Asunto;
            correo.Body = objcorreo.Mensaje;
            correo.IsBodyHtml = true;
            correo.Priority = System.Net.Mail.MailPriority.Normal;
            correo.IsBodyHtml = true;
            System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient();

            smtp.Host = objcorreo.servidorcorreodesalidasmtp ;// "correo.mincultura.gov.co";
            smtp.Credentials = new System.Net.NetworkCredential(objcorreo.direcciondecorreodesalida  , _iconfiguration.GetConnectionString("direcciondecorreodesalidapassword"));
            smtp.EnableSsl = objcorreo.habilitarconexionsegurassl; // false;
            smtp.Port = objcorreo.servidordecorreodesalidasmtppuerto;

            string MensajeDeError = "";
            try
            {
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


