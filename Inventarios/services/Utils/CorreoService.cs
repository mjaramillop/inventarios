using Inventarios.DataAccess.Utils;
using Inventarios.Models.Uitls;

namespace Inventarios.services.Utils
{


    public class CorreoService
    {

        private CorreoAccess _access;
        public CorreoService(CorreoAccess access)
        {
            _access = access;
        }


        public string enviarcorreo(Correo objcorreo)
        {

            return _access.enviarcorreo(objcorreo);


        }
    }
}
