using Inventarios.DataAccess.TablasMaestras;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;

namespace Inventarios.services.TablasMaestras
{
    public class FormulasService
    {
        private readonly FormulasAccess _access;
        public List<FormulasDTO>? list;

        public FormulasService(FormulasAccess access)
        {
            _access = access;
        }

        public Mensaje Add(Formulas obj)
        {
            Mensaje list = _access.Add(obj);
            return list;
        }

        public Mensaje Delete(int id)
        {
            Mensaje list = _access.Delete(id);
            return list;
        }

        public Mensaje Update(Formulas obj)
        {
            Mensaje list = _access.Update(obj);
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