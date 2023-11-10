using Inventarios.Data;
using Inventarios.DTO;
using Inventarios.Map;
using Inventarios.Models;
using Inventarios.Token;

namespace Inventarios.DataAccess
{
    public class TiposDeDocumentoAccess
    {
        private readonly InventariosContext _context;
        private readonly JwtService _jwtservice;
        private readonly LogAccess _logacces;
        private List<TiposDeDocumento>? list;

        public TiposDeDocumentoAccess(InventariosContext context, JwtService jwtService, LogAccess logacces)
        {
            _context = context;
            _jwtservice = jwtService;
            _logacces = logacces;
        }

        public List<TiposDeDocumentoDTO> Add(TiposDeDocumento obj)
        {
            obj.estadodelregistro = obj.estadodelregistro.ToUpper();

            _context.TiposDeDocumento.Add(obj);
            _context.SaveChanges();
            this.Log(obj, "Agrego Tipos de Dcoumento");
            list = _context.TiposDeDocumento.Where(a => a.id == obj.id).ToList();
            return Mapping.ListTiposDeDocumentoToTiposDeDocumentoDTO(list);
        }

        public List<TiposDeDocumentoDTO>? Delete(int id)
        {
            var obj = _context.TiposDeDocumento.FirstOrDefault(a => a.id == id);
            _context.TiposDeDocumento.Remove(obj);
            _context.SaveChanges();
            this.Log(obj, "Borro Tipos de Documento");
            obj.nombre = "Registro borrado satisfactoriamente";
            list = _context.TiposDeDocumento.Where(a => a.id == obj.id).ToList();
            return Mapping.ListTiposDeDocumentoToTiposDeDocumentoDTO(list);
        }

        public List<TiposDeDocumentoDTO>? Update(TiposDeDocumento? obj)
        {
           
            obj.estadodelregistro = obj.estadodelregistro.ToUpper();

            var obj_ = _context.TiposDeDocumento.FirstOrDefault(a => a.id == obj.id);
            if (obj_ != null)
            {
                obj_.nombre = obj.nombre;
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
                obj_.pidesubtotal = obj.pidesubtotal;
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
                obj_.tipoagentedespacha = obj.tipoagentedespacha;
                obj_.tipoagenterecibe = obj.tipoagenterecibe;
                obj_.eldocumentoallamarsolosepuedellamarunavez = obj.eldocumentoallamarsolosepuedellamarunavez;
                obj_.eldocumentoseimprimeanombrededespachaorecibe = obj.eldocumentoseimprimeanombrededespachaorecibe;
                obj_.esunanota = obj.esunanota;
                obj_.esuninventarioinicial = obj.esuninventarioinicial;

                //
                obj_.estadodelregistro = obj.estadodelregistro;

                _context.SaveChanges();
                this.Log(obj, "Modifico TiposDeDocumento");
            }
            list = _context.TiposDeDocumento.Where(a => a.id == obj.id).ToList();
            return Mapping.ListTiposDeDocumentoToTiposDeDocumentoDTO(list);
        }

        public List<TiposDeDocumento> GetById(int id)
        {
            list = _context.TiposDeDocumento.Where(a => a.id == id).ToList();
            return list;
        }

        public List<TiposDeDocumentoDTO>? List(string filtro)
        {
            list = _context.TiposDeDocumento.ToList().OrderBy(a => a.nombre).Where(a => a.nombre.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
            return Mapping.ListTiposDeDocumentoToTiposDeDocumentoDTO(list);
        }

        public List<TiposDeDocumentoDTO> ListActive(string filtro)
        {
            list = _context.TiposDeDocumento.ToList().OrderBy(a => a.nombre).Where(a => a.estadodelregistro != "I").Where(a => a.nombre.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
            return Mapping.ListTiposDeDocumentoToTiposDeDocumentoDTO(list);
        }

        public List<TiposDeDocumentoDTO> ListCodigoNombre(string filtro)
        {
            var list = from pro in _context.TiposDeDocumento
                       select new TiposDeDocumentoDTO() { nombre = pro.nombre, id = pro.id };

            return list.OrderBy(a => a.nombre).ToList();
        }

        public List<TiposDeDocumentoPermisosDTO>? ListDocumentosPermisos(int id)
        {
            var list = _context.TiposDeDocumento.Where(a => !a.estadodelregistro.Contains("I")).OrderBy(a => a.nombre).ToList();

            Usuarios? obj = _context.Usuarios.FirstOrDefault(a => a.id == id);
            string? tiposdedocumento = obj.tiposdedocumento;

            List<TiposDeDocumentoPermisosDTO> listapermisos = new List<TiposDeDocumentoPermisosDTO>();

            foreach (var s in list)
            {
                TiposDeDocumentoPermisosDTO obj1 = new TiposDeDocumentoPermisosDTO();
                obj1.nombre = s.nombre;
                obj1.id = s.id;
                obj1.agregar = false;
                obj1.borrar = false;
                obj1.modificar = false;
                obj1.anular = false;
                obj1.imprimir = false;
                obj1.estadodelregistro = s.estadodelregistro;

                listapermisos.Add(obj1);
            }

            string[] permisos = obj.tiposdedocumento.Split(",");
            for (int i = 1; i < permisos.Length - 1; i++)
            {
                string codigotipodedocumento = permisos[i].Substring(0, permisos[i].IndexOf("="));

                foreach (var s in listapermisos)
                {
                    if (s.id == Convert.ToInt32(codigotipodedocumento))
                    {
                        if (permisos[i].IndexOf("A") >= 0) s.agregar = true;
                        if (permisos[i].IndexOf("M") >= 0) s.modificar = true;
                        if (permisos[i].IndexOf("B") >= 0) s.borrar = true;
                        if (permisos[i].IndexOf("I") >= 0) s.imprimir = true;
                        if (permisos[i].IndexOf("N") >= 0) s.anular = true;
                    }
                }
            }

            return listapermisos;
        }

        public void Log(TiposDeDocumento obj, string operacion)
        {
            string comando = "";
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
            comando = comando + "pidesubtotal = " + obj.pidesubtotal + "\n";
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
            comando = comando + "tipoagentedespacha = " + obj.tipoagentedespacha + "\n";
            comando = comando + "tipoagenterecibe = " + obj.tipoagenterecibe + "\n";
            comando = comando + "eldocumentoallamarsolosepuedellamarunavez = " + obj.eldocumentoallamarsolosepuedellamarunavez + "\n";
            comando = comando + "eldocumentoseimprimeanombrededespachaorecibe = " + obj.eldocumentoseimprimeanombrededespachaorecibe + "\n";
            comando = comando + "esunanota = " + obj.esunanota + "\n";
            comando = comando + "esuninventarioinicial = " + obj.esuninventarioinicial + "\n";

            //
            comando = comando + "Estado del Registro = " + obj.estadodelregistro + "\n";

            _logacces.Add(comando);
        }
    }
}