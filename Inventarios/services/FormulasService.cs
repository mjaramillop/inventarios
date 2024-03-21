using Inventarios.DataAccess;
using Inventarios.DTO;
using Inventarios.Models;

namespace Inventarios.services
{

    public class FormulasService
    {

        private readonly FormulasAccess _access;
        public List<FormulasDTO>? list;

        public FormulasService(FormulasAccess access)
        {
            _access = access;

        }

        public List<FormulasDTO>? Add(Formulas obj)
        {
            list = _access.Add(obj);
            return list;
        }

        public List<FormulasDTO>? Delete(int id)
        {
            list = _access.Delete(id);
            return list;
        }

        public List<FormulasDTO>? Update(Formulas obj)
        {
            list = _access.Update(obj);
            return list;
        }

        public List<Formulas>? GetById(int id)
        {
            List<Formulas> list = _access.GetById(id);

            return list;
        }

        public List<FormulasDTO>? List(string filtro)
        {
            var list = _access.List(filtro);
            return list;
        }





    }

}
