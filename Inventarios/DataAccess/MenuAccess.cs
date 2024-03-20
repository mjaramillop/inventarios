﻿using Inventarios.Data;
using Inventarios.DTO;
using Inventarios.Map;
using Inventarios.Models;
using Inventarios.Token;

namespace Inventarios.DataAccess
{
    public class MenuAccess
    {
        private readonly InventariosContext _context;
        private readonly LogAccess _logacces;
        private readonly Mapping _mapping;

        private List<Menu>? list;

        public MenuAccess(InventariosContext context, LogAccess logacces, Mapping mapping)
        {
            _context = context;
            _logacces = logacces;
            _mapping = mapping;
        }

        public List<MenuDTO>? Add(Menu? obj)
        {
            obj.estadodelregistro = obj.estadodelregistro.ToUpper();

            _context.Menus.Add(obj);
            _context.SaveChanges();
            this.Log(obj, "Agrego menu");
            list = _context.Menus.Where(a => a.id == obj.id).ToList();
            return _mapping.ListMenuToListMenuDTO(list);
        }

        public List<MenuDTO>? Delete(int id)
        {
            var obj = _context.Menus.FirstOrDefault(a => a.id == id);
            _context.Menus.Remove(obj);
            _context.SaveChanges();
            this.Log(obj, "Borro menu");
            list = _context.Menus.Where(a => a.id == obj.id).ToList();
            return _mapping.ListMenuToListMenuDTO(list);
        }

        public List<MenuDTO>? Update(Menu obj)
        {
            obj.estadodelregistro = obj.estadodelregistro.ToUpper();

            var obj_ = _context.Menus.FirstOrDefault(a => a.id == obj.id);
            obj_.nombre = obj.nombre;
            obj_.paginaweb = obj.paginaweb;

            obj_.estadodelregistro = obj.estadodelregistro;

            _context.SaveChanges();
            this.Log(obj, "Modifico menu");

            list = _context.Menus.Where(a => a.id == obj.id).ToList();
            return _mapping.ListMenuToListMenuDTO(list);
        }

        public List<Menu>? GetById(int id)
        {
            list = _context.Menus.Where(a => a.id == id).ToList();
            return list;
        }

        public List<MenuDTO>? List(string filtro)
        {
            list = _context.Menus.ToList().OrderBy(a => a.orden).Where(a => a.nombre.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
            return _mapping.ListMenuToListMenuDTO(list);
        }

        public void Log(Menu obj, string operacion)
        {
            string comando = "";
            comando = comando + "operacion " + operacion + "\n";
            comando = comando + "id = " + obj.id + "\n";
            comando = comando + "Orden  = " + obj.orden + "\n";
            comando = comando + "Nombre = " + obj.nombre + "\n";
            comando = comando + "Pagina web = " + obj.paginaweb + "\n";
            //
            comando = comando + "Estado del Registro = " + obj.estadodelregistro + "\n";

            _logacces.Add(comando);
        }
    }
}