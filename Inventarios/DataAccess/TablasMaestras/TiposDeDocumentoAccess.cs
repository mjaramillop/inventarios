using Inventarios.Data;
using Inventarios.DataAccess.Seguridad;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Map;
using Inventarios.Models.Seguridad;
using Inventarios.Models.TablasMaestras;
using Microsoft.VisualStudio.Web.CodeGenerators.Mvc.Templates.BlazorIdentity.Pages;

namespace Inventarios.DataAccess.TablasMaestras
{
    public class TiposDeDocumentoAccess
    {
        private readonly InventariosContext _context;
        private readonly LogAccess _logacces;
        private readonly Mapping _mapping;
        private readonly IConfiguration _iconfiguration;
    

        private List<TiposDeDocumento>? list;

        public TiposDeDocumentoAccess(InventariosContext context, LogAccess logacces, Mapping mapping, IConfiguration iconfigutarion )
        {
            _context = context;
            _logacces = logacces;
            _mapping = mapping;
            _iconfiguration = iconfigutarion;
          
        }

        public List<TiposDeDocumentoDTO> Add(TiposDeDocumento obj)
        {
            _context.TiposDeDocumento.Add(obj);
            _context.SaveChanges();
            Log(obj, "Agrego Tipos de Dcoumento");
            list = _context.TiposDeDocumento.Where(a => a.id == obj.id).ToList();
            return _mapping.ListTiposDeDocumentoToTiposDeDocumentoDTO(list);
        }

        public List<TiposDeDocumentoDTO>? Delete(int id)
        {
            var obj = _context.TiposDeDocumento.FirstOrDefault(a => a.id == id);
            _context.TiposDeDocumento.Remove(obj);
            _context.SaveChanges();
            Log(obj, "Borro Tipos de Documento");
            list = _context.TiposDeDocumento.Where(a => a.id == obj.id).ToList();
            return _mapping.ListTiposDeDocumentoToTiposDeDocumentoDTO(list);
        }

        public List<TiposDeDocumentoDTO>? Update(TiposDeDocumento? obj)
        {
            var obj_ = _context.TiposDeDocumento.FirstOrDefault(a => a.id == obj.id);

            obj_.nombre = obj.nombre;
            obj_.abreviatura = obj.abreviatura;
            obj_.consecutivo = obj.consecutivo;
            obj_.cuentacontabledebito = obj.cuentacontabledebito;
            obj_.cuentacontablecredito = obj.cuentacontablecredito;
            obj_.despacha = obj.despacha;
            obj_.recibe = obj.recibe;

            obj_.pidefechadevencimiento = obj.pidefechadevencimiento;
            obj_.pideprograma = obj.pideprograma;
            obj_.pideconceptonotadebitocredito = obj.pideconceptonotadebitocredito;
            obj_.pidevendedor = obj.pidevendedor;
            obj_.pidetipodedocumentoaafectar = obj.pidetipodedocumentoaafectar;
            obj_.pideproducto = obj.pideproducto;
            obj_.pidetalla = obj.pidetalla;
            obj_.pidecolor = obj.pidecolor;
            obj_.pideempaque = obj.pideempaque;
            obj_.pidecantidad = obj.pidecantidad;
            obj_.pidevalorunitario = obj.pidevalorunitario;
            obj_.pidedescuentodetalle = obj.pidedescuentodetalle;
            obj_.pideivadetalle = obj.pideivadetalle;
            obj_.pidetipodedocumentoaafectardetalle = obj.pidetipodedocumentoaafectardetalle;
            obj_.pideconsecutivoautomatico = obj.pideconsecutivoautomatico;
            obj_.eldocumentoseimprime = obj.eldocumentoseimprime;
            obj_.esunacompra = obj.esunacompra;
            obj_.esunaventa = obj.esunaventa;
            obj_.esunpago = obj.esunpago;
            obj_.restarcartera = obj.restarcartera;
            obj_.sumarcartera = obj.sumarcartera;
            obj_.restainventario = obj.restainventario;
            obj_.sumainventario = obj.sumainventario;
            obj_.saldarcantidadesdeldocumentollamado = obj.saldarcantidadesdeldocumentollamado;
            obj_.leyendaimpresaeneldocumento = obj.leyendaimpresaeneldocumento;
            obj_.pidefisico = obj.pidefisico;

            obj_.eldocumentoallamarsolosepuedellamarunavez = obj.eldocumentoallamarsolosepuedellamarunavez;
            obj_.eldocumentoseimprimeanombrededespachaorecibe = obj.eldocumentoseimprimeanombrededespachaorecibe;
            obj_.esunanota = obj.esunanota;
            obj_.esuninventarioinicial = obj.esuninventarioinicial;
            obj_.titulodespacha = obj.titulodespacha;
            obj_.titulorecibe = obj.titulorecibe;

            obj_.transaccionesquepuedellamar = obj.transaccionesquepuedellamar;
            obj_.estadodelregistro = obj.estadodelregistro;
            obj_.idusuario = obj.idusuario;
            obj_.nombreusuario = obj.nombreusuario;


            _context.SaveChanges();
            Log(obj, "Modifico TiposDeDocumento");

            list = _context.TiposDeDocumento.Where(a => a.id == obj.id).ToList();
            return _mapping.ListTiposDeDocumentoToTiposDeDocumentoDTO(list);
        }

        public List<TiposDeDocumento> GetById(int id , int idusuario)
        {
            Usuarios objusuarios = _context.Usuarios.FirstOrDefault(a => a.id ==idusuario);


            if (objusuarios.tiposdedocumento.IndexOf("," + id.ToString() + "=") < 0)
            {
                return  list;
            }


            list = _context.TiposDeDocumento.Where(a => a.id == id).ToList();
            if (list.Count == 0) return list;

            if (list[0].despacha.Trim().Length > 0)
            {
                var obj1_ = _context.Proveedores.FirstOrDefault(a => a.id == Convert.ToInt32(list[0].despacha));
                list[0].nombredespacha = obj1_.nombre;
            }
            if (list[0].recibe.Trim().Length > 0)
            {
                var obj2_ = _context.Proveedores.FirstOrDefault(a => a.id == Convert.ToInt32(list[0].recibe));
                list[0].nombrerecibe = obj2_.nombre;
            }

            return list;
        }

        public List<TiposDeDocumentoDTO>? List(string filtro)
        {
            string caracterdebusqueda = _iconfiguration.GetValue<string>("ParametrosDeLaEmpresa:caracterdebusqueda");
            filtro = filtro.Replace(caracterdebusqueda, "");
            list = _context.TiposDeDocumento.ToList().OrderBy(a => a.nombre).Where(a => a.nombre.Contains(filtro.Trim(), StringComparison.OrdinalIgnoreCase)).ToList();
            return _mapping.ListTiposDeDocumentoToTiposDeDocumentoDTO(list);
        }

        public List<TiposDeDocumentoDTO> ListCodigoNombre(string filtro)
        {
            var list = from pro in _context.TiposDeDocumento
                       select new TiposDeDocumentoDTO() { nombre = pro.nombre, id = pro.id };

            return list.OrderBy(a => a.nombre).ToList();
        }

        public List<TiposDeDocumentoPermisosDTO>? ListDocumentosPermisos(int idusuario)
        {
        


            Usuarios? obj = _context.Usuarios.FirstOrDefault(a => a.id == idusuario);
            string? tiposdedocumento = obj.tiposdedocumento;

            List<TiposDeDocumentoPermisosDTO> listapermisos = new List<TiposDeDocumentoPermisosDTO>();

            if (tiposdedocumento.Trim().Length <= 1) tiposdedocumento = "";

            string[] permisos = tiposdedocumento.Split(",");
            for (int i = 1; i < permisos.Length - 1; i++)
            {
                string codigotipodedocumento = permisos[i].Substring(0, permisos[i].IndexOf("="));

                List<TiposDeDocumento> ls = new List<TiposDeDocumento>();
                list = _context.TiposDeDocumento.Where(a => a.id == Convert.ToInt32(codigotipodedocumento)).ToList();
                if (list.Count > 0)
                {
                    TiposDeDocumentoPermisosDTO obj1 = new TiposDeDocumentoPermisosDTO();

                    obj1.nombre = list[0].nombre;
                    obj1.id = list[0].id;
                    obj1.agregar = false;
                    obj1.borrar = false;
                    obj1.modificar = false;
                    obj1.anular = false;
                    obj1.imprimir = false;
                    obj1.estadodelregistro = list[0].estadodelregistro;

                    if (permisos[i].IndexOf("A") >= 0) obj1.agregar = true;
                    if (permisos[i].IndexOf("M") >= 0) obj1.modificar = true;
                    if (permisos[i].IndexOf("B") >= 0) obj1.borrar = true;
                    if (permisos[i].IndexOf("I") >= 0) obj1.imprimir = true;
                    if (permisos[i].IndexOf("N") >= 0) obj1.anular = true;
                    listapermisos.Add(obj1);
                }
            }

            return listapermisos;
        }

        public List<TiposDeDocumentoPermisosDTO>? DarAccesoTotal(int id ,int idusuario)
        {

            List<TiposDeDocumento> list = new List<TiposDeDocumento>();
            list = _context.TiposDeDocumento.ToList();

            string tiposdedocumentoquepuedeaccesar = ",";

            foreach (var s in list)
            {
                tiposdedocumentoquepuedeaccesar = tiposdedocumentoquepuedeaccesar + s.id + "=AMBIN,";
            }

            var obj = _context.Usuarios.FirstOrDefault(a => a.id == id);

            obj.tiposdedocumento = tiposdedocumentoquepuedeaccesar;

            _context.SaveChanges();
            Log2(obj, "Modifico usuario");

            return ListDocumentosPermisos(idusuario);
        }

        public List<TiposDeDocumentoPermisosDTO>? DarRestriccionTotal(int id, int idusuario)
        {
            string tiposdedocumentoquepuedeaccesar = ",";

            var obj = _context.Usuarios.FirstOrDefault(a => a.id == id);

            obj.tiposdedocumento = tiposdedocumentoquepuedeaccesar;

            _context.SaveChanges();
            Log2(obj, "Modifico usuario");

            return ListDocumentosPermisos(idusuario);
        }

        public void Log(TiposDeDocumento obj, string operacion)
        {
            string comando = "";
            comando = comando + "usuario " + obj.nombreusuario + "\n";

            comando = comando + "operacion " + operacion + "\n";

            comando = comando + "id = " + obj.id + "\n";

            comando = comando + "Nombre = " + obj.nombre + "\n";
            comando = comando + "pideprograma = " + obj.pideprograma + "\n";
            comando = comando + "pideconceptonotadebitocredito = " + obj.pideconceptonotadebitocredito + "\n";
            comando = comando + "pidevendedor = " + obj.pidevendedor + "\n";
            comando = comando + "pidetipodedocumentoaafectar= " + obj.pidetipodedocumentoaafectar + "\n";
            comando = comando + "pideproducto = " + obj.pideproducto + "\n";
            comando = comando + "pidetalla = " + obj.pidetalla + "\n";
            comando = comando + "pidecolor = " + obj.pidecolor + "\n";
            comando = comando + "pideempaque = " + obj.pideempaque + "\n";
            comando = comando + "pidecantidad = " + obj.pidecantidad + "\n";
            comando = comando + "pidevalorunitario = " + obj.pidevalorunitario + "\n";
            comando = comando + "pidedescuentodetalle = " + obj.pidedescuentodetalle + "\n";
            comando = comando + "pideivadetalle = " + obj.pideivadetalle + "\n";
            comando = comando + "pidetipodedocumentoaafectatdetalle = " + obj.pidetipodedocumentoaafectardetalle + "\n";
            comando = comando + "pideconsecutivoautomatico = " + obj.pideconsecutivoautomatico + "\n";
            comando = comando + "eldocumentoseimprime = " + obj.eldocumentoseimprime + "\n";
            comando = comando + "esunacompra = " + obj.esunacompra + "\n";
            comando = comando + "esuncaventa = " + obj.esunaventa + "\n";
            comando = comando + "esunpago = " + obj.esunpago + "\n";
            comando = comando + "restarcartera= " + obj.restarcartera + "\n";
            comando = comando + "sumarcartera = " + obj.sumarcartera + "\n";
            comando = comando + "restarinventario = " + obj.restainventario + "\n";
            comando = comando + "sumainventario = " + obj.sumainventario + "\n";
            comando = comando + "saldarcantidadesdeldocumentollamado = " + obj.saldarcantidadesdeldocumentollamado + "\n";
            comando = comando + "leyendaimpresaeneldocumento = " + obj.leyendaimpresaeneldocumento + "\n";
            comando = comando + "pidefisico = " + obj.pidefisico + "\n";

            comando = comando + "eldocumentoallamarsolosepuedellamarunavez = " + obj.eldocumentoallamarsolosepuedellamarunavez + "\n";
            comando = comando + "eldocumentoseimprimeanombrededespachaorecibe = " + obj.eldocumentoseimprimeanombrededespachaorecibe + "\n";
            comando = comando + "esunanota = " + obj.esunanota + "\n";
            comando = comando + "esuninventarioinicial = " + obj.esuninventarioinicial + "\n";
            comando = comando + "titulodespacha  = " + obj.titulodespacha;
            comando = comando + "titulorecibe =" + obj.titulorecibe;

            comando = comando + "transaccionesquepuedellamar =" + obj.transaccionesquepuedellamar;

            //
            comando = comando + "Estado del Registro = " + obj.estadodelregistro + "\n";

            _logacces.Add(comando);
        }

        public void Log2(Usuarios obj, string operacion)
        {
            string comando = "";
            comando = comando + "operacion " + operacion + "\n";

            comando = comando + "id = " + obj.id + "\n";
            comando = comando + "tipos de documento a accesar = " + obj.tiposdedocumento + "\n";

            _logacces.Add(comando);
        }
    }
}