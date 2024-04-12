using Inventarios.Data;
using Inventarios.DTO;
using Inventarios.Map;
using Inventarios.Models;

namespace Inventarios.DataAccess
{

    public class UnidadesDeMedidaAccess
    {
        private readonly InventariosContext _context;

        private readonly LogAccess _logacces;

        private readonly Mapping _mapping;

        private List<UnidadesDeMedida>? list;

        private readonly IConfiguration _iconfiguration;

        public UnidadesDeMedidaAccess(InventariosContext context, LogAccess logacces, Mapping mapping, IConfiguration iconfiguration)
        {
            _context = context;

            _logacces = logacces;
            _mapping = mapping;
            _iconfiguration = iconfiguration;
        }

        public List<UnidadesDeMedidaDTO>? Add(UnidadesDeMedida obj)
        {
            obj.estadodelregistro = obj.estadodelregistro.ToUpper();
            _context.UnidadesDeMedida.Add(obj);
            _context.SaveChanges();
            this.Log(obj, "Agrego Unidad de medida");
            list = _context.UnidadesDeMedida.Where(a => a.id == obj.id).ToList();
            return _mapping.ListUnidadesDeMedidaToUnidadesDeMedidaDTO(list);
        }

        public List<UnidadesDeMedidaDTO> Delete(int id)
        {
            var obj = _context.UnidadesDeMedida.FirstOrDefault(a => a.id == id);
            _context.UnidadesDeMedida.Remove(obj);
            _context.SaveChanges();
            this.Log(obj, "Borro Unidad de medida");
            list = _context.UnidadesDeMedida.Where(a => a.id == obj.id).ToList();
            return _mapping.ListUnidadesDeMedidaToUnidadesDeMedidaDTO(list);
        }

        public List<UnidadesDeMedidaDTO>? Update(UnidadesDeMedida? obj)
        {
            obj.estadodelregistro = obj.estadodelregistro.ToUpper();
            var obj_ = _context.UnidadesDeMedida.FirstOrDefault(a => a.id == obj.id);

            obj_.nombre = obj.nombre;

            //
            obj_.estadodelregistro = obj.estadodelregistro;

            _context.SaveChanges();
            this.Log(obj, "Modifico Unidade de medida");

            list = _context.UnidadesDeMedida.Where(a => a.id == obj.id).ToList();
            return _mapping.ListUnidadesDeMedidaToUnidadesDeMedidaDTO(list);
        }

        public List<UnidadesDeMedida> GetById(int id)
        {
            list = _context.UnidadesDeMedida.Where(a => a.id == id).ToList();
            return list;
        }

        public List<UnidadesDeMedidaDTO>? List(string filtro)
        {
            string caracterdebusqueda = _iconfiguration.GetValue<string>("ParametrosDeLaEmpresa:caracterdebusqueda");
            filtro = filtro.Replace(caracterdebusqueda, "");
            list = _context.UnidadesDeMedida.ToList().OrderBy(a => a.nombre).Where(a => a.nombre.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
            return _mapping.ListUnidadesDeMedidaToUnidadesDeMedidaDTO(list);
        }

        public void Log(UnidadesDeMedida obj, string operacion)
        {
            string comando = "";
            comando = comando + "operacion " + operacion + "\n";

            comando = comando + "id = " + obj.id + "\n";

            comando = comando + "Nombre = " + obj.nombre + "\n";

            //
            comando = comando + "Estado del Registro = " + obj.estadodelregistro + "\n";

            _logacces.Add(comando);
        }
    }

}
