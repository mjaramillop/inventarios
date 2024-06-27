using Inventarios.Data;
using Inventarios.DataAccess.Seguridad;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Map;
using Inventarios.Models.TablasMaestras;
using Inventarios.ModelsParameter;
using Inventarios.Utils;

namespace Inventarios.DataAccess.TablasMaestras
{
    public class ProveedoresAccess
    {
        private readonly InventariosContext _context;
        private readonly LogAccess _logacces;
        private readonly Mapping _mapping;

        private List<Proveedores>? list;
        private readonly IConfiguration _iconfiguration;
        private readonly Validaciones _validar;
        private readonly Utilidades _utilidades;

        public ProveedoresAccess(InventariosContext context, LogAccess logacces, Mapping mapping, IConfiguration iconfiguration, Validaciones validar, Utilidades utilidades)
        {
            _context = context;
            _logacces = logacces;
            _mapping = mapping;
            _iconfiguration = iconfiguration;
            _validar = validar;
            _utilidades = utilidades;

        }

        public Mensaje Add(Proveedores obj)
        {
            
            
            
            if (this.ValidarRegistro(obj).IndexOf("Error.") >= 0) return new Mensaje() { mensaje = this.ValidarRegistro(obj) };


            string mensajedeclave = "";
            if (obj.tipodeagente.ToString() == _utilidades.traerparametrowebconfig("codigotipodeagentecliente"))
            {
                List<Mensaje> list = new List<Mensaje>();

                list = GenerarClave(obj.id);
                obj.clavedeseguridadparapedidosporweb = list[0].mensaje;
                mensajedeclave = "Clave generada" + list[0].mensaje + " " + list[1].mensaje;
            }

            try
            {
                _context.Proveedores.Add(obj);
                _context.SaveChanges();
            }
            catch (Exception e)
            {
                mensajedeclave = e.InnerException.Message.ToString();
                return new Mensaje() { mensaje = "Error   " + mensajedeclave };
            }

            Log(obj, "Agrego Proveedores");
            return new Mensaje() { mensaje = "registro insertado ok   "  + mensajedeclave };
        }

        public Mensaje Delete(int id)
        {
            var obj = _context.Proveedores.FirstOrDefault(a => a.id == id);
            _context.Proveedores.Remove(obj);
            _context.SaveChanges();
            Log(obj, "Borro Proveedores");
            return new Mensaje() { mensaje = "registro borrado ok " };
        }

        public Mensaje Update(Proveedores? obj)
        {
            if (this.ValidarRegistro(obj).IndexOf("Error.") >= 0) return new Mensaje() { mensaje = this.ValidarRegistro(obj) };

            var obj_ = _context.Proveedores.FirstOrDefault(a => a.id == obj.id);


            try
            {


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
                obj_.tipodecuenta = obj.tipodecuenta;
                obj_.cuentacontable = obj.cuentacontable;
                obj_.codigoderetencionaaplicar = obj.codigoderetencionaaplicar;
                obj_.estadodelregistro = obj.estadodelregistro;
                obj_.nivel1 = obj.nivel1;
                obj_.nivel2 = obj.nivel2;
                obj_.nivel3 = obj.nivel3;
                obj_.nivel4 = obj.nivel4;
                obj_.nivel5 = obj.nivel5;
                obj_.idusuario = obj.idusuario;
                obj_.nombreusuario = obj.nombreusuario;
                obj_.clavedeseguridadparapedidosporweb = obj.clavedeseguridadparapedidosporweb;

                _context.SaveChanges();
            }
            catch (Exception ex)
            {

                return new Mensaje() { mensaje = "Error  " + ex.InnerException.Message.ToString() };
            }


            Log(obj, "Modifico Proveedores");
            return new Mensaje() { mensaje = "registro modificado ok " };
        }

        public List<Proveedores> GetById(int id)
        {
            list = _context.Proveedores.Where(a => a.id == id).ToList();
            return list;
        }


        public List<Mensaje> GenerarClave(int id)
        {
            Random rnd1 = new Random(10); //seed value 10
            Guid guid = Guid.NewGuid();
            string clave = guid.ToString().ToUpper();
            clave = clave.Substring(0, 7);
            var obj_ = _context.Proveedores.FirstOrDefault(a => a.id == id);
            obj_.clavedeseguridadparapedidosporweb = clave;
            _context.SaveChanges(true);

            var obj = _context.Proveedores.FirstOrDefault(a => a.id == id);


            Correo correo = new Correo(_iconfiguration,_utilidades);
            correo.Asunto = "Clave de acceso para capturar tus pedidos ;" + obj.clavedeseguridadparapedidosporweb;
            correo.Mensaje = " Tu clave es " + obj.clavedeseguridadparapedidosporweb;
            correo.Destinatario = obj.email1;
            string mensajedecorreo = correo.enviarcorreo(correo);

            List<Mensaje> list = new List<Mensaje>();


            list.Add(new Mensaje() { mensaje = clave });
            list.Add(new Mensaje() { mensaje = mensajedecorreo });



            return    list;
        }


        public List<ProveedoresDTO>? List(string filtro, int tipodeagente)
        {
            string caracterdebusqueda = _iconfiguration.GetValue<string>("ParametrosDeLaEmpresa:caracterdebusqueda");
            filtro = filtro.Replace(caracterdebusqueda, "");
            if (tipodeagente > 0)
            {
                list = _context.Proveedores.ToList().OrderBy(a => a.nombre).Where(a => a.nombre.Contains(filtro.Trim(), StringComparison.OrdinalIgnoreCase) && a.tipodeagente == tipodeagente).ToList();

            }
            else
            {
                list = _context.Proveedores.ToList().OrderBy(a => a.nombre).Where(a => a.nombre.Contains(filtro.Trim(), StringComparison.OrdinalIgnoreCase)).ToList();

            }

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

            return _mapping.ListProveedoresToProveedoresDTO(list);
        }

        public List<string>? GetNivel(int nivel)
        {
            List<Proveedores>? list_ = new List<Proveedores>();
            list_ = _context.Proveedores.ToList();

            dynamic groupnivel = null;
            if (nivel == 1) groupnivel = list_.Where(a => a.nivel1.Trim().Length > 0).GroupBy(u => u.nivel1).Select(grp => grp.ToList()).ToList();
            if (nivel == 2) groupnivel = list_.Where(a => a.nivel2.Trim().Length > 0).GroupBy(u => u.nivel2).Select(grp => grp.ToList()).ToList();
            if (nivel == 3) groupnivel = list_.Where(a => a.nivel3.Trim().Length > 0).GroupBy(u => u.nivel3).Select(grp => grp.ToList()).ToList();
            if (nivel == 4) groupnivel = list_.Where(a => a.nivel4.Trim().Length > 0).GroupBy(u => u.nivel4).Select(grp => grp.ToList()).ToList();
            if (nivel == 5) groupnivel = list_.Where(a => a.nivel5.Trim().Length > 0).GroupBy(u => u.nivel5).Select(grp => grp.ToList()).ToList();

            List<string> lista = new List<string>();

            foreach (var group in groupnivel)
            {
                foreach (var user in group)
                {
                    if (nivel == 1) lista.Add(user.nivel1);
                    if (nivel == 2) lista.Add(user.nivel2);
                    if (nivel == 3) lista.Add(user.nivel3);
                    if (nivel == 4) lista.Add(user.nivel4);
                    if (nivel == 5) lista.Add(user.nivel5);
                }
            }

            List<string> listacodigonombre = new List<string>();

            foreach (var s in lista.Distinct())
            {
                listacodigonombre.Add(s.ToString());
            }

            return listacodigonombre;
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
            comando = comando + "Estado del Registro = " + obj.estadodelregistro + "\n";
            comando = comando + "Clave de seguridad para pedidos web = " + obj.clavedeseguridadparapedidosporweb + "\n";
            _logacces.Add(comando);
        }

        public string ValidarRegistro(Proveedores obj)
        {
            string mensajedeerror = "";
            mensajedeerror = mensajedeerror + _validar.ValidarEstadoDelRegistro(obj.estadodelregistro);
            mensajedeerror = mensajedeerror + _validar.Validarnombre("Nombre ", obj.nombre);
            mensajedeerror = mensajedeerror + _validar.ValidarRetencion(obj.codigoderetencionaaplicar);
            mensajedeerror = mensajedeerror + _validar.Validarnombre("Email ", obj.email1);
            mensajedeerror = mensajedeerror + _validar.Validarnombre("Celular 1 ", obj.celular1);
            mensajedeerror = mensajedeerror + _validar.Validarnombre("Direccion ", obj.direccion);
          
            mensajedeerror = mensajedeerror + _validar.ValidarActividadComercial(obj.actividadcomercial);
            mensajedeerror = mensajedeerror + _validar.ValidarTipoDeRegimen(obj.tipoderegimen);
            mensajedeerror = mensajedeerror + _validar.ValidarTipoDeCuentaBancaria(obj.tipodecuenta);

            if (mensajedeerror.IndexOf("Error.")>=0)
            {
                int posicioninicial = mensajedeerror.IndexOf("Error.");
                int posicionfinial = mensajedeerror.IndexOf(",");

                mensajedeerror = mensajedeerror.Substring(posicioninicial, posicionfinial-posicioninicial);


            }


            return mensajedeerror;
        }
    }
}