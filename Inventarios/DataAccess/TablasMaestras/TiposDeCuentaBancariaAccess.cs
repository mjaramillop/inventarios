using Inventarios.Data;
using Inventarios.DataAccess.Seguridad;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Map;
using Inventarios.Models.TablasMaestras;

namespace Inventarios.DataAccess.TablasMaestras
{
    public class TiposDeCuentaBancariaAccess
    {
        private readonly InventariosContext _context;

        private readonly LogAccess _logacces;

        private readonly Mapping _mapping;

        private List<TiposDeCuentaBancaria>? list;

        private readonly IConfiguration _iconfiguration;

        public TiposDeCuentaBancariaAccess(InventariosContext context, LogAccess logacces, Mapping mapping, IConfiguration iconfiguration)
        {
            _context = context;

            _logacces = logacces;
            _mapping = mapping;
            _iconfiguration = iconfiguration;
        }

        public List<TiposDeCuentaBancariaDTO>? Add(TiposDeCuentaBancaria obj)
        {
            _context.TiposDeCuentaBancaria.Add(obj);
            _context.SaveChanges();
            Log(obj, "Agrego Tipo de cuenta bancaria");
            list = _context.TiposDeCuentaBancaria.Where(a => a.id == obj.id).ToList();
            return _mapping.ListTiposDeCuentaBancariaToTiposDeCuentaBancariaDTO(list);
        }

        public List<TiposDeCuentaBancariaDTO> Delete(int id)
        {
            var obj = _context.TiposDeCuentaBancaria.FirstOrDefault(a => a.id == id);
            _context.TiposDeCuentaBancaria.Remove(obj);
            _context.SaveChanges();
            Log(obj, "Borro Tipo de cuenta  bancaria");
            list = _context.TiposDeCuentaBancaria.Where(a => a.id == obj.id).ToList();
            return _mapping.ListTiposDeCuentaBancariaToTiposDeCuentaBancariaDTO(list);
        }

        public List<TiposDeCuentaBancariaDTO>? Update(TiposDeCuentaBancaria? obj)
        {
            var obj_ = _context.TiposDeCuentaBancaria.FirstOrDefault(a => a.id == obj.id);

            obj_.nombre = obj.nombre;



            _context.SaveChanges();
            Log(obj, "Modifico Tipo de cuenta bancaria");

            list = _context.TiposDeCuentaBancaria.Where(a => a.id == obj.id).ToList();
            return _mapping.ListTiposDeCuentaBancariaToTiposDeCuentaBancariaDTO(list);
        }

        public List<TiposDeCuentaBancaria> GetById(int id)
        {

            list = _context.TiposDeCuentaBancaria.Where(a => a.id == id).ToList();
            return list;
        }

        public List<TiposDeCuentaBancariaDTO>? List(string filtro)
        {
            string caracterdebusqueda = _iconfiguration.GetValue<string>("ParametrosDeLaEmpresa:caracterdebusqueda");
            filtro = filtro.Replace(caracterdebusqueda, "");
            list = _context.TiposDeCuentaBancaria.ToList().OrderBy(a => a.nombre).Where(a => a.nombre.Contains(filtro.Trim(), StringComparison.OrdinalIgnoreCase)).ToList();
            return _mapping.ListTiposDeCuentaBancariaToTiposDeCuentaBancariaDTO(list);
        }

        public void Log(TiposDeCuentaBancaria obj, string operacion)
        {
            string comando = "";
            comando = comando + "operacion " + operacion + "\n";

            comando = comando + "id = " + obj.id + "\n";

            comando = comando + "Nombre = " + obj.nombre + "\n";

            //


            _logacces.Add(comando);
        }
    }
}

