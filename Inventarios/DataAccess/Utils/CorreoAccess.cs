﻿using Inventarios.Models.Uitls;

namespace Inventarios.DataAccess.Utils
{
    public class CorreoAccess
    {
        private readonly IConfiguration _iconfiguration;

        public CorreoAccess(IConfiguration configutarion_)
        {
            _iconfiguration = configutarion_;

        }


        public string enviarcorreo(Correo objcorreo)
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