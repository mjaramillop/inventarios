using Inventarios.Data;
using Inventarios.DataAccess.Seguridad;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Map;
using Inventarios.Models.TablasMaestras;
using Inventarios.Utils;

namespace Inventarios.DataAccess.TablasMaestras
{
    public class SaldosAccess
    {
        private readonly InventariosContext _context;

        private readonly LogAccess _logacces;

        private readonly Mapping _mapping;

        private List<Saldos>? list;

        private readonly IConfiguration _iconfiguration;

        private readonly Validaciones _validar;

        public SaldosAccess(InventariosContext context, LogAccess logacces, Mapping mapping, IConfiguration iconfiguration, Validaciones validar)
        {
            _context = context;
            _logacces = logacces;
            _mapping = mapping;
            _iconfiguration = iconfiguration;
            _validar = validar;
        }

        public Mensaje Add(Saldos obj)
        {
            _context.Saldos.Add(obj);
            _context.SaveChanges();
            Log(obj, "Agrego Saldo");
            return new Mensaje() { mensaje = "registro insertado ok " };
        }

        public Mensaje Delete(int id)
        {
            var obj = _context.Saldos.FirstOrDefault(a => a.id == id);
            _context.Saldos.Remove(obj);
            _context.SaveChanges();
            Log(obj, "Borro Saldo");
            return new Mensaje() { mensaje = "registro insertado ok " };
        }

        public Mensaje Update(Saldos? obj)
        {
            if (this.ValidarRegistro(obj).IndexOf("Error.") >= 0) return new Mensaje() { mensaje = this.ValidarRegistro(obj) };

            var obj_ = _context.Saldos.Where(n => n.producto == obj.producto && n.bodega == obj.bodega).ToList()[0];

            obj_.costopromedio = obj.costopromedio;
            obj_.saldofisico = obj.saldofisico;
            obj_.saldofisico = obj.saldofisico;
            obj_.saldo = obj.saldo;
            obj_.saldoinicial = obj.saldoinicial;
            obj_.salidas = obj.salidas;
            obj_.entradas = obj.entradas;
            obj_.fechadelaultimasalida = obj.fechadelaultimasalida;
            obj_.stockmaximo = obj.stockmaximo;
            obj_.stockminimo = obj.stockminimo;

            _context.SaveChanges();
            Log(obj, "Modifico Saldo");
            return new Mensaje() { mensaje = "registro modificado ok " };
        }

        public List<Saldos> GetById(int id)
        {
            list = _context.Saldos.Where(a => a.id == id).ToList();
            return list;
        }

        public List<SaldosDTO>? List(string filtro, string bodega)
        {
            string caracterdebusqueda = _iconfiguration.GetValue<string>("ParametrosDeLaEmpresa:caracterdebusqueda");
            filtro = filtro.Replace(caracterdebusqueda, "");

            list = (from s in _context.Saldos
                    join p in _context.Productos on s.producto equals p.id
                    join b in _context.Proveedores on s.bodega equals b.id
                    where p.nombre.Contains(filtro.Trim()) && b.nombre.Contains(bodega.Trim())
                    select s).ToList();

            return _mapping.ListSaldosToSaldosDTO(list);
        }

        public void Log(Saldos obj, string operacion)
        {
            string comando = "";
            comando = comando + "operacion " + operacion + "\n";

            comando = comando + "id = " + obj.id + "\n";
            comando = comando + "Bodega = " + obj.bodega + "\n";
            comando = comando + "Producto = " + obj.producto + "\n";

            comando = comando + "Saldo inicial = " + obj.saldoinicial + "\n";
            comando = comando + "Entradas      = " + obj.entradas + "\n";
            comando = comando + "Salidas       = " + obj.salidas + "\n";
            comando = comando + "Saldo         = " + obj.saldo + "\n";
            comando = comando + "Fecha Ultima salida = " + obj.fechadelaultimasalida.ToString() + "\n";
            comando = comando + "Stock minimo = " + obj.stockminimo + "\n";
            comando = comando + "Stock maximo = " + obj.stockmaximo + "\n";

            _logacces.Add(comando);
        }

        public string ValidarRegistro(Saldos obj)
        {
            string mensajedeerror = "";
            mensajedeerror = mensajedeerror + _validar.Validarvalormayorquecero("stock maximo", obj.stockmaximo);
            mensajedeerror = mensajedeerror + _validar.Validarvalormayorquecero("stock minimo", obj.stockminimo);
            mensajedeerror = mensajedeerror + _validar.Validarvalor1menorquevalor2("Los stocks estan mal", obj.stockminimo,obj.stockmaximo);


            return mensajedeerror;
        }
    }
}