﻿using Inventarios.Data;
using Inventarios.DTO;
using Inventarios.Map;
using Inventarios.Models;
using Inventarios.ModelsParameter;

namespace Inventarios.DataAccess
{
    public class ProductosAccess
    {
        private readonly InventariosContext _context;

        private readonly LogAccess _logacces;

        private readonly Mapping _mapping;

        private List<Productos>? list;

        public ProductosAccess(InventariosContext context, LogAccess logacces, Mapping mapping)
        {
            _context = context;

            _logacces = logacces;
            _mapping = mapping;
        }

        public List<ProductosDTO>? Add(Productos obj)
        {
            obj.estadodelregistro = obj.estadodelregistro.ToUpper();
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
            this.Log(obj, "Borro Producto");
            list = _context.Productos.Where(a => a.id == obj.id).ToList();
            return _mapping.ListProductosToProductosDTO(list);
        }

        public List<ProductosDTO>? Update(Productos? obj)
        {
            obj.estadodelregistro = obj.estadodelregistro.ToUpper();
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
            list = _context.Productos.ToList().OrderBy(a => a.nombre).Where(a => a.nombre.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
            return _mapping.ListProductosToProductosDTO(list);
        }




        public List<ProductosDTO>? UpdateNiveles(UpdateNiveles obj)
        {
            List<Productos>? list = null;

            if (obj.filtronivel1remplazar.Trim().Length > 0)
            {
                list = _context.Productos.ToList()
                     .Where(a => a.nivel1.Contains((obj.filtronivel1remplazar.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
                list.ForEach(c => { c.nivel1 = obj.filtronivel1remplazarpor; });
                _context.SaveChanges();
            }



            if (obj.filtronivel2remplazar.Trim().Length > 0)
            {
                list = _context.Productos.ToList()
                     .Where(a => a.nivel2.Contains((obj.filtronivel2remplazar.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
                list.ForEach(c => { c.nivel2 = obj.filtronivel2remplazarpor; });
                _context.SaveChanges();
            }



            if (obj.filtronivel3remplazar.Trim().Length > 0)
            {
                list = _context.Productos.ToList()
                     .Where(a => a.nivel3.Contains((obj.filtronivel3remplazar.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
                list.ForEach(c => { c.nivel3 = obj.filtronivel3remplazarpor; });
                _context.SaveChanges();
            }



            if (obj.filtronivel4remplazar.Trim().Length > 0)
            {
                list = _context.Productos.ToList()
                     .Where(a => a.nivel4.Contains((obj.filtronivel4remplazar.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
                list.ForEach(c => { c.nivel4 = obj.filtronivel4remplazarpor; });
                _context.SaveChanges();
            }



            if (obj.filtronivel5remplazar.Trim().Length > 0)
            {
                list = _context.Productos.ToList()
                     .Where(a => a.nivel5.Contains((obj.filtronivel5remplazar.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
                list.ForEach(c => { c.nivel5 = obj.filtronivel5remplazarpor; });
                _context.SaveChanges();
            }





            list = _context.Productos
                .OrderBy(a => a.nivel1)
                .OrderBy(a => a.nivel2)
                .OrderBy(a => a.nivel3)
                .OrderBy(a => a.nivel4)
                .OrderBy(a => a.nivel5)
                .Where(a =>
                 a.nivel1.Contains(obj.filtronivel1remplazarpor) ||
                 a.nivel2.Contains(obj.filtronivel2remplazarpor) ||
                 a.nivel3.Contains(obj.filtronivel3remplazarpor) ||
                 a.nivel4.Contains(obj.filtronivel4remplazarpor) ||
                 a.nivel5.Contains(obj.filtronivel5remplazarpor)).ToList();

            return _mapping.ListProductosToProductosDTO(list);
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
