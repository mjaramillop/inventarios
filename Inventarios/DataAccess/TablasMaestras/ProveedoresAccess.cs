using Inventarios.Data;
using Inventarios.DataAccess.Seguridad;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Map;
using Inventarios.Models.TablasMaestras;
using Inventarios.ModelsParameter;

namespace Inventarios.DataAccess.TablasMaestras
{
    public class ProveedoresAccess
    {
        private readonly InventariosContext _context;
        private readonly LogAccess _logacces;
        private readonly Mapping _mapping;

        private List<Proveedores>? list;
        private readonly IConfiguration _iconfiguration;

        public ProveedoresAccess(InventariosContext context, LogAccess logacces, Mapping mapping, IConfiguration iconfiguration)
        {
            _context = context;
            _logacces = logacces;
            _mapping = mapping;
            _iconfiguration = iconfiguration;
        }

        public List<ProveedoresDTO> Add(Proveedores obj)
        {
            _context.Proveedores.Add(obj);
            _context.SaveChanges();
            Log(obj, "Agrego Proveedores");
            list = _context.Proveedores.Where(a => a.id == obj.id).ToList();
            return _mapping.ListProveedoresToProveedoresDTO(list);
        }

        public List<ProveedoresDTO>? Delete(int id)
        {
            var obj = _context.Proveedores.FirstOrDefault(a => a.id == id);
            _context.Proveedores.Remove(obj);
            _context.SaveChanges();
            Log(obj, "Borro Proveedores");
            list = _context.Proveedores.Where(a => a.id == obj.id).ToList();
            return _mapping.ListProveedoresToProveedoresDTO(list);
        }

        public List<ProveedoresDTO>? Update(Proveedores? obj)
        {
            var obj_ = _context.Proveedores.FirstOrDefault(a => a.id == obj.id);

            obj_.nombre = obj.nombre;
            obj_.direccion = obj.direccion;
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

            obj_.tipodeagente = obj.tipodeagente;
            obj_.cuentacontable = obj.cuentacontable;
            obj_.codigoderetencionaaplicar = obj.codigoderetencionaaplicar;
            //
            obj_.estadodelregistro = obj.estadodelregistro;
            obj_.nivel1 = obj.nivel1;
            obj_.nivel2 = obj.nivel2;
            obj_.nivel3 = obj.nivel3;
            obj_.nivel4 = obj.nivel4;
            obj_.nivel5 = obj.nivel5;
            obj_.idusuario = obj.idusuario;
            obj_.nombreusuario = obj.nombreusuario;


            _context.SaveChanges();
            Log(obj, "Modifico Proveedores");

            list = _context.Proveedores.Where(a => a.id == obj.id).ToList();
            return _mapping.ListProveedoresToProveedoresDTO(list);
        }

        public List<Proveedores> GetById(int id)
        {
            list = _context.Proveedores.Where(a => a.id == id).ToList();
            return list;
        }

        public List<ProveedoresDTO>? List(string filtro)
        {
            string caracterdebusqueda = _iconfiguration.GetValue<string>("ParametrosDeLaEmpresa:caracterdebusqueda");
            filtro = filtro.Replace(caracterdebusqueda, "");
            list = _context.Proveedores.ToList().OrderBy(a => a.nombre).Where(a => a.nombre.Contains(filtro.Trim(), StringComparison.OrdinalIgnoreCase)).ToList();
            return _mapping.ListProveedoresToProveedoresDTO(list);
        }

        public List<ProveedoresDTO>? UpdateNiveles(UpdateNiveles obj)
        {
            List<Proveedores>? list = null;

            if (obj.filtronivel1remplazar.Trim().Length > 0)
            {
                list = _context.Proveedores.ToList()
                     .Where(a => a.nivel1.Contains(obj.filtronivel1remplazar.Trim(), StringComparison.OrdinalIgnoreCase)).ToList();
                list.ForEach(c => { c.nivel1 = obj.filtronivel1remplazarpor; });
                _context.SaveChanges();
            }

            if (obj.filtronivel2remplazar.Trim().Length > 0)
            {
                list = _context.Proveedores.ToList()
                     .Where(a => a.nivel2.Contains(obj.filtronivel2remplazar.Trim(), StringComparison.OrdinalIgnoreCase)).ToList();
                list.ForEach(c => { c.nivel2 = obj.filtronivel2remplazarpor; });
                _context.SaveChanges();
            }

            if (obj.filtronivel3remplazar.Trim().Length > 0)
            {
                list = _context.Proveedores.ToList()
                     .Where(a => a.nivel3.Contains(obj.filtronivel3remplazar.Trim(), StringComparison.OrdinalIgnoreCase)).ToList();
                list.ForEach(c => { c.nivel3 = obj.filtronivel3remplazarpor; });
                _context.SaveChanges();
            }

            if (obj.filtronivel4remplazar.Trim().Length > 0)
            {
                list = _context.Proveedores.ToList()
                     .Where(a => a.nivel4.Contains(obj.filtronivel4remplazar.Trim(), StringComparison.OrdinalIgnoreCase)).ToList();
                list.ForEach(c => { c.nivel4 = obj.filtronivel4remplazarpor; });
                _context.SaveChanges();
            }

            if (obj.filtronivel5remplazar.Trim().Length > 0)
            {
                list = _context.Proveedores.ToList()
                     .Where(a => a.nivel5.Contains(obj.filtronivel5remplazar.Trim(), StringComparison.OrdinalIgnoreCase)).ToList();
                list.ForEach(c => { c.nivel5 = obj.filtronivel5remplazarpor; });
                _context.SaveChanges();
            }

            //list = _context.Proveedores
            //    .OrderBy(a => a.nivel1)
            //    .OrderBy(a => a.nivel2)
            //    .OrderBy(a => a.nivel3)
            //    .OrderBy(a => a.nivel4)
            //    .OrderBy(a => a.nivel5)
            //    .Where(a =>
            //     a.nivel1.Contains(obj.filtronivel1remplazarpor) ||
            //     a.nivel2.Contains(obj.filtronivel2remplazarpor) ||
            //     a.nivel3.Contains(obj.filtronivel3remplazarpor) ||
            //     a.nivel4.Contains(obj.filtronivel4remplazarpor) ||
            //     a.nivel5.Contains(obj.filtronivel5remplazarpor)).ToList();

            return _mapping.ListProveedoresToProveedoresDTO(list);
        }

        public void Log(Proveedores obj, string operacion)
        {
            string comando = "";
            comando = comando + "usuario " + obj.nombreusuario + "\n";

            comando = comando + "operacion " + operacion + "\n";

            comando = comando + "id = " + obj.id + "\n";
            comando = comando + "Nombre = " + obj.nombre + "\n";

            comando = comando + "+direccion = " + obj.direccion;
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
            comando = comando + "tipodeagente = " + obj.tipodeagente;
            comando = comando + "cuentacontable = " + obj.cuentacontable;
            comando = comando + "codigoderetencionaaplicar = " + obj.codigoderetencionaaplicar;
            comando = comando + "NIVEL 1 " + obj.nivel1;
            comando = comando + "NIVEL 2 " + obj.nivel2;
            comando = comando + "NIVEL 3 " + obj.nivel3;
            comando = comando + "NIVEL 4 " + obj.nivel4;
            comando = comando + "NIVEL 5 " + obj.nivel5;

            //
            comando = comando + "Estado del Registro = " + obj.estadodelregistro + "\n";

            _logacces.Add(comando);
        }
    }
}