using Inventarios.Data;
using Inventarios.DTO;
using Inventarios.Map;
using Inventarios.Models;
using Inventarios.ModelsParameter;
using Inventarios.Utils;

namespace Inventarios.DataAccess
{
    public class ProductosAccess
    {
        private readonly InventariosContext _context;

        private readonly LogAccess _logacces;

        private readonly Mapping _mapping;

        private List<Productos>? list;

        private readonly Validaciones _validaciones;

        private readonly IConfiguration _iconfiguration;

        public ProductosAccess(InventariosContext context, LogAccess logacces, Mapping mapping, Validaciones validaciones, IConfiguration iconfiguration)
        {
            _context = context;

            _logacces = logacces;
            _mapping = mapping;
            _validaciones = validaciones;
            _iconfiguration = iconfiguration;
        }

        public List<ProductosDTO>? Add(Productos obj)
        {
           
            _context.Productos.Add(obj);
            _context.SaveChanges();
            this.Log(obj, "Agrego Producto");
            list = _context.Productos.Where(a => a.id == obj.id).ToList();
            return _mapping.ListProductosToProductosDTO(list);
        }

        public List<ProductosDTO> Delete(int id)
        {
            var obj = _context.Productos.FirstOrDefault(a => a.id == id);
            _context.Productos.Remove(obj);
            _context.SaveChanges();


            string route = Path.Combine(Directory.GetCurrentDirectory(), "imagesproducts");


            route = route + "\\" + id.ToString() + ".jpg";

            System.IO.File.Delete(route);

            this.Log(obj, "Borro Producto");
            list = _context.Productos.Where(a => a.id == obj.id).ToList();
            return _mapping.ListProductosToProductosDTO(list);
        }

        public List<ProductosDTO>? Update(Productos? obj)
        {
           
            var obj_ = _context.Productos.FirstOrDefault(a => a.id == obj.id);
            obj_.nombre = obj.nombre;
            obj_.unidaddemedida = obj.unidaddemedida;
            obj_.secargalinventario = obj.secargalinventario;
            obj_.precio1 = obj.precio1;
            obj_.codigoiva1 = obj.codigoiva1;
            obj_.costoultimo = obj.costoultimo;
            obj_.estadodelregistro = obj.estadodelregistro;
            obj_.nivel1 = obj.nivel1;
            obj_.nivel2 = obj.nivel2;
            obj_.nivel3 = obj.nivel3;
            obj_.nivel4 = obj.nivel4;
            obj_.nivel5 = obj.nivel5;

            _context.SaveChanges();
            this.Log(obj, "Modifico Productos");

            list = _context.Productos.Where(a => a.id == obj.id).ToList();
            return _mapping.ListProductosToProductosDTO(list);
        }

        public List<Productos> GetById(int id)
        {
            list = _context.Productos.Where(a => a.id == id).ToList();
            return list;
        }

        public List<ProductosDTO>? List(string filtro)
        {
            string caracterdebusqueda = _iconfiguration.GetValue<string>("ParametrosDeLaEmpresa:caracterdebusqueda");
            filtro = filtro.Replace(caracterdebusqueda, "");

            list = _context.Productos
               .OrderBy(a => a.nombre)
               
                .Where(a =>
                 a.nombre.Contains(filtro) ||
                 a.nivel1.Contains(filtro) ||
                 a.nivel2.Contains(filtro) ||
                 a.nivel3.Contains(filtro) ||
                 a.nivel4.Contains(filtro) ||
                 a.nivel5.Contains(filtro)).ToList();

            return _mapping.ListProductosToProductosDTO(list);
        }

        public List<string>? UpdateNiveles(UpdateNiveles obj)
        {
            List<Productos>? list = null;

            string mensajedeerror = "";

            if ((obj.filtronivel1remplazar.Trim().Length + obj.filtronivel2remplazar.Trim().Length) > 0)
            {
                if (obj.filtronivel1remplazar.Trim() == obj.filtronivel2remplazar) mensajedeerror = "El nivel 1 no puede ser igual al nivel 2";
            }

            if ((obj.filtronivel2remplazar.Trim().Length + obj.filtronivel3remplazar.Trim().Length) > 0)
            {
                if (obj.filtronivel2remplazar.Trim() == obj.filtronivel3remplazar) mensajedeerror = "El nivel 2 no puede ser igual al nivel 3";
            }

            if ((obj.filtronivel3remplazar.Trim().Length + obj.filtronivel4remplazar.Trim().Length) > 0)
            {
                if (obj.filtronivel3remplazar.Trim() == obj.filtronivel4remplazar) mensajedeerror = "El nivel 3 no puede ser igual al nivel 4";
            }

            if ((obj.filtronivel4remplazar.Trim().Length + obj.filtronivel5remplazar.Trim().Length) > 0)
            {
                if (obj.filtronivel4remplazar.Trim() == obj.filtronivel5remplazar) mensajedeerror = "El nivel 4 no puede ser igual al nivel 5";
            }

            List<string> listadeerrores = new List<string>();

            if (mensajedeerror.Trim().Length > 0)
            {
                listadeerrores.Add(mensajedeerror);
                return listadeerrores;
            }

            if (obj.filtronivel1remplazar.Trim().Length > 0)
            {
                if (obj.filtronivel1remplazarpor.Trim().Length > 0)
                {
                    list = _context.Productos.ToList()
                     .Where(a => a.nivel1.Contains((obj.filtronivel1remplazar.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
                    list.ForEach(c => { c.nivel1 = obj.filtronivel1remplazarpor; });
                    _context.SaveChanges();
                }
            }

            if (obj.filtronivel2remplazar.Trim().Length > 0)
            {
                if (obj.filtronivel2remplazar.Trim().Length > 0)
                {
                    list = _context.Productos.ToList()
                     .Where(a => a.nivel2.Contains((obj.filtronivel2remplazar.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
                    list.ForEach(c => { c.nivel2 = obj.filtronivel2remplazarpor; });
                    _context.SaveChanges();
                }
            }

            if (obj.filtronivel3remplazar.Trim().Length > 0)
            {
                if (obj.filtronivel3remplazar.Trim().Length > 0)
                {
                    list = _context.Productos.ToList()
                     .Where(a => a.nivel3.Contains((obj.filtronivel3remplazar.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
                    list.ForEach(c => { c.nivel3 = obj.filtronivel3remplazarpor; });
                    _context.SaveChanges();
                }
            }

            if (obj.filtronivel4remplazar.Trim().Length > 0)
            {
                if (obj.filtronivel4remplazar.Trim().Length > 0)
                {
                    list = _context.Productos.ToList()
                     .Where(a => a.nivel4.Contains((obj.filtronivel4remplazar.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
                    list.ForEach(c => { c.nivel4 = obj.filtronivel4remplazarpor; });
                    _context.SaveChanges();
                }
            }

            if (obj.filtronivel5remplazar.Trim().Length > 0)
            {
                if (obj.filtronivel5remplazar.Trim().Length > 0)
                {
                    list = _context.Productos.ToList()
                     .Where(a => a.nivel5.Contains((obj.filtronivel5remplazar.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
                    list.ForEach(c => { c.nivel5 = obj.filtronivel5remplazarpor; });
                    _context.SaveChanges();
                }
            }

            if (list.Count == 0)
            {
                mensajedeerror = "No hubo filas para actualizar";
                listadeerrores.Add(mensajedeerror);
                return listadeerrores;
            }

            //list = _context.Productos
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

            mensajedeerror = "Filas actualizadas existosamente";
            listadeerrores.Add(mensajedeerror);

            return listadeerrores;
        }

        public List<string>? CambiarPrecios(CambiarPrecios obj)
        {
            List<Productos>? list = null;
            List<string> listadeerrores = new List<string>();

            _validaciones.mensajedeerror = "";
            _validaciones.Validarvalordiferentedecero("Porcentaje de incremento de precio", obj.porcentajedeincremento);

            if (_validaciones.mensajedeerror.Trim().Length > 0)
            {
                listadeerrores.Add(_validaciones.mensajedeerror);
                return listadeerrores;
            }

            list = _context.Productos.ToList()
             .Where(a =>
             a.nivel1.Contains(obj.nivel1.Trim()) &&
             a.nivel2.Contains(obj.nivel2.Trim()) &&
             a.nivel3.Contains(obj.nivel3.Trim()) &&
            a.nivel4.Contains(obj.nivel4.Trim()) &&
            a.nivel5.Contains(obj.nivel5.Trim())).ToList();

            decimal descuento = Convert.ToDecimal(Convert.ToDecimal(obj.porcentajedeincremento) / 100);

            list.ForEach(c => { c.precio1 = c.precio1 + (c.precio1 * descuento); });
            _context.SaveChanges();

            if (list.Count == 0)
            {
                _validaciones.mensajedeerror = "No hubo filas para actualizar";
                listadeerrores.Add(_validaciones.mensajedeerror);
                return listadeerrores;
            }

            if (_validaciones.mensajedeerror.Trim().Length == 0) _validaciones.mensajedeerror = "Precio cambiado exitosamente";

            listadeerrores.Add(_validaciones.mensajedeerror);

            return listadeerrores;
        }

        public List<CodigoNombre>? GetNivel(int nivel)
        {
            List<Productos>? list_ = new List<Productos>();
            list_ = _context.Productos.ToList();

            dynamic groupnivel = null;
            if (nivel == 1) groupnivel = list_.Where(a => a.nivel1.Trim().Length>0).GroupBy(u => u.nivel1).Select(grp => grp.ToList()).ToList();
            if (nivel == 2) groupnivel = list_.Where(a => a.nivel2.Trim().Length>0).GroupBy(u => u.nivel2).Select(grp => grp.ToList()).ToList();
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

            List<CodigoNombre> listacodigonombre = new List<CodigoNombre>();

            foreach (var s in lista.Distinct())
            {
                CodigoNombre obj_ = new CodigoNombre();
                obj_.id = s;
                obj_.nombre = s;
             //   if (obj_.nombre.Trim().Length>0)
                listacodigonombre.Add(obj_);
            }

            return listacodigonombre;
        }

        public void Log(Productos obj, string operacion)
        {
            string comando = "";
            comando = comando + "operacion " + operacion + "\n";
            comando = comando + "id = " + obj.id + "\n";
            comando = comando + "Nombre = " + obj.nombre + "\n";
            comando = comando + "Unidad de medida = " + obj.unidaddemedida + "\n";
            comando = comando + "Precion1 = " + obj.precio1 + "\n";
            comando = comando + "Costo Ultimo = " + obj.costoultimo + "\n";
            comando = comando + "Se carga al inventario = " + obj.secargalinventario + "\n";
            comando = comando + "Codigo iva 1 = " + obj.codigoiva1 + "\n";
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