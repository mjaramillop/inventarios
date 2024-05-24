﻿using Inventarios.Data;
using Inventarios.DataAccess.Seguridad;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Map;
using Inventarios.Models.TablasMaestras;

namespace Inventarios.DataAccess
{
    public class ProgramasAccess
    {
        private readonly InventariosContext _context;

        private readonly LogAccess _logacces;

        private readonly Mapping _mapping;

        private List<Programas>? list;

        private readonly IConfiguration _iconfiguration;

        public ProgramasAccess(InventariosContext context, LogAccess logacces, Mapping mapping, IConfiguration iconfiguration)
        {
            _context = context;

            _logacces = logacces;
            _mapping = mapping;
            _iconfiguration = iconfiguration;
        }

        public List<ProgramasDTO>? Add(Programas obj)
        {
            _context.Programas.Add(obj);
            _context.SaveChanges();
            this.Log(obj, "Agrego Actividades Economicas");
            list = _context.Programas.Where(a => a.id == obj.id).ToList();
            return _mapping.ListProgramasToProgramasDTO(list);
        }

        public List<ProgramasDTO> Delete(int id)
        {
            var obj = _context.Programas.FirstOrDefault(a => a.id == id);
            _context.Programas.Remove(obj);
            _context.SaveChanges();
            this.Log(obj, "Borro Actividades Economicas");
            list = _context.Programas.Where(a => a.id == obj.id).ToList();
            return _mapping.ListProgramasToProgramasDTO(list);
        }

        public List<ProgramasDTO>? Update(Programas? obj)
        {
            var obj_ = _context.Programas.FirstOrDefault(a => a.id == obj.id);

            obj_.nombre = obj.nombre;

            //
            obj_.estadodelregistro = obj.estadodelregistro;

            _context.SaveChanges();
            this.Log(obj, "Modifico Programas");

            list = _context.Programas.Where(a => a.id == obj.id).ToList();
            return _mapping.ListProgramasToProgramasDTO(list);
        }

        public List<Programas> GetById(int id)
        {
            list = _context.Programas.Where(a => a.id == id).ToList();
            return list;
        }

        public List<ProgramasDTO>? List(string filtro)
        {
            string caracterdebusqueda = _iconfiguration.GetValue<string>("ParametrosDeLaEmpresa:caracterdebusqueda");
            filtro = filtro.Replace(caracterdebusqueda, "");
            list = _context.Programas.ToList().OrderBy(a => a.nombre).Where(a => a.nombre.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
            return _mapping.ListProgramasToProgramasDTO(list);
        }

        public void Log(Programas obj, string operacion)
        {
            string comando = "";
            comando = comando + "usuario " + obj.nombreusuario + "\n";

            comando = comando + "operacion " + operacion + "\n";

            comando = comando + "id = " + obj.id + "\n";

            comando = comando + "Nombre = " + obj.nombre + "\n";

            //
            comando = comando + "Estado del Registro = " + obj.estadodelregistro + "\n";

            _logacces.Add(comando);
        }
    }
}