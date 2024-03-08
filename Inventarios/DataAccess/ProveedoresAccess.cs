using Inventarios.Data;
using Inventarios.DTO;
using Inventarios.Map;
using Inventarios.Models;
using Inventarios.Token;

namespace Inventarios.DataAccess
{
    public class ProveedoresAccess
    {
        private readonly InventariosContext _context;
        private readonly LogAccess _logacces;
        private List<Proveedores>? list;

        public ProveedoresAccess(InventariosContext context,LogAccess logacces)
        {
            _context = context;
            _logacces = logacces;
        }

        public List<ProveedoresDTO> Add(Proveedores obj)
        {
            obj.estadodelregistro = obj.estadodelregistro?.ToUpper();

            _context.Proveedores.Add(obj);
            _context.SaveChanges();
            this.Log(obj, "Agrego Proveedores");
            list = _context.Proveedores.Where(a => a.id == obj.id).ToList();
            return Mapping.ListProveedoresToProveedoresDTO(list);
        }

        public List<ProveedoresDTO>? Delete(int id)
        {
            var obj = _context.Proveedores.FirstOrDefault(a => a.id == id);
            _context.Proveedores.Remove(obj);
            _context.SaveChanges();
            this.Log(obj, "Borro Proveedores");
            obj.nombre = "Registro borrado satisfactoriamente";
            list = _context.Proveedores.Where(a => a.id == obj.id).ToList();
            return Mapping.ListProveedoresToProveedoresDTO(list);
        }

        public List<ProveedoresDTO>? Update(Proveedores? obj)
        {

            obj.estadodelregistro = obj.estadodelregistro.ToUpper();

            var obj_ = _context.Proveedores.FirstOrDefault(a => a.id == obj.id);
            if (obj_ != null)
            {
                obj_.nombre = obj.nombre;
                obj_.direccion = obj.direccion;
                obj_.ciudad = obj.ciudad;
                obj_.telefono = obj.telefono;
                obj_.celular1 = obj.celular1;
                obj_.celular2 = obj.celular2;
                obj_.email1 = obj.email1;
                obj_.email2 = obj.email2;
                obj_.nit = obj.nit;
                obj_.fechadeingreso = obj.fechadeingreso;
                obj_.observaciones = obj.observaciones;
                obj_.contactos = obj.contactos;
                obj_.actividadcomercial = obj.actividadcomercial;
                obj_.seleretienefuente = obj.seleretienefuente;
                obj_.seleretieneiva = obj.seleretieneiva;
                obj_.seleretieneica = obj.seleretieneica;
                obj_.puedecobrariva = obj.puedecobrariva;
                obj_.espersonanaturalojuridica = obj.espersonanaturalojuridica;
                obj_.declararenta = obj.declararenta;
                obj_.esgrancontribuyente = obj.esgrancontribuyente;
                obj_.tipoderegimen = obj.tipoderegimen;
                obj_.clasificacion = obj.clasificacion;
                obj_.tipodeagente = obj.tipodeagente;
                obj_.cuentacontable = obj.cuentacontable;
                obj_.codigoderetencionaaplicar = obj.codigoderetencionaaplicar;
                //
                obj_.estadodelregistro = obj.estadodelregistro;

                _context.SaveChanges();
                this.Log(obj, "Modifico Proveedores");
            }
            list = _context.Proveedores.Where(a => a.id == obj.id).ToList();
            return Mapping.ListProveedoresToProveedoresDTO(list);
        }

        public List<Proveedores> GetById(int id)
        {
            list = _context.Proveedores.Where(a => a.id == id).ToList();
            return list;
        }

        public List<ProveedoresDTO>? List(string filtro)
        {
            list = _context.Proveedores.ToList().OrderBy(a => a.nombre).Where(a => a.nombre.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
            return Mapping.ListProveedoresToProveedoresDTO(list);
        }

        public void Log(Proveedores obj, string operacion)
        {
            string comando = "";
            comando = comando + "operacion " + operacion + "\n";
         
            comando = comando + "id = " + obj.id + "\n";
            comando = comando + "Nombre = " + obj.nombre + "\n";

            comando = comando + "+direccion = " + obj.direccion;
            comando = comando + "ciudad = " + obj.ciudad;
            comando = comando + "telefono = " + obj.telefono;
            comando = comando + "celular1 = " + obj.celular1;
            comando = comando + "celular2 = " + obj.celular2;
            comando = comando + "email1 = " + obj.email1;
            comando = comando + "email2 = " + obj.email2;
            comando = comando + "nit = " + obj.nit;
            comando = comando + "fechadeingreso = " + obj.fechadeingreso;
            comando = comando + "observaciones = " + obj.observaciones;
            comando = comando + "contactos = " + obj.contactos;
            comando = comando + "actividadcomercial = " + obj.actividadcomercial;
            comando = comando + "seleretienefuente = " + obj.seleretienefuente;
            comando = comando + "seleretieneiva = " + obj.seleretieneiva;
            comando = comando + "seleretieneica = " + obj.seleretieneica;
            comando = comando + "puedecobrariva = " + obj.puedecobrariva;
            comando = comando + "espersonanaturalojuridica = " + obj.espersonanaturalojuridica;
            comando = comando + "declararenta = " + obj.declararenta;
            comando = comando + "esgrancontribuyente = " + obj.esgrancontribuyente;
            comando = comando + "tipoderegimen = " + obj.tipoderegimen;
            comando = comando + "clasificacion = " + obj.clasificacion;
            comando = comando + "tipodeagente = " + obj.tipodeagente;
            comando = comando + "cuentacontable = " + obj.cuentacontable;
            comando = comando + "codigoderetencionaaplicar = " + obj.codigoderetencionaaplicar;
          

            //
            comando = comando + "Estado del Registro = " + obj.estadodelregistro + "\n";

            _logacces.Add(comando);
        }
    }
}