namespace Inventarios.Utils
{
    public class Correo
    {
        private readonly IConfiguration _iconfiguration;

        public String Asunto { get; set; }
        public string Mensaje { get; set; }
        public string Destinatario { get; set; }
        public string ServidorSmtpRemitePuerto { get; set; }
        public string habilitarconexionsegurassl { get; set; }

        //  public string RemitePassword { get; set; }
        public string MensajeDeError { get; set; }

        public Correo(IConfiguration configutarion_)
        {
            _iconfiguration = configutarion_;

            this.habilitarconexionsegurassl = "";
            this.MensajeDeError = "";
        }

        public string enviarcorreo()
        {
         
            System.Net.Mail.MailMessage correo = new System.Net.Mail.MailMessage();
            correo.From = new System.Net.Mail.MailAddress(_iconfiguration.GetConnectionString("direcciondecorreodesalida"));
            correo.To.Add(this.Destinatario);
            correo.Subject = this.Asunto;
            string texto = this.Mensaje;
            correo.Body = texto;
            correo.IsBodyHtml = true;
            correo.Priority = System.Net.Mail.MailPriority.Normal;
            correo.IsBodyHtml = true;
            System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient();

            smtp.Host = _iconfiguration.GetConnectionString("servidorcorreodesalidasmtp");// "correo.mincultura.gov.co";
            smtp.Credentials = new System.Net.NetworkCredential(_iconfiguration.GetConnectionString("direcciondecorreodesalida"), _iconfiguration.GetConnectionString("direcciondecorreodesalidapassword"));
            smtp.EnableSsl = Convert.ToBoolean(_iconfiguration.GetConnectionString("habilitarssl")); // false;
            smtp.Port = Convert.ToInt32(_iconfiguration.GetConnectionString("servidordecorreodesalidasmtppuerto"));

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

            return this.MensajeDeError;
        }
    }
}