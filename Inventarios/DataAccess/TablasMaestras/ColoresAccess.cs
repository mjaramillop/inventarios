﻿using Inventarios.Data;
using Inventarios.DataAccess.Seguridad;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Map;
using Inventarios.Models.TablasMaestras;
using Inventarios.Utils;

namespace Inventarios.DataAccess.TablasMaestras
{
    public class ColoresAccess
    {
        private readonly InventariosContext _context;

        private readonly LogAccess _logacces;

        private readonly Mapping _mapping;

        private List<Colores>? list;

        private readonly IConfiguration _iconfiguration;

        private readonly Validaciones _validar;

        public ColoresAccess(InventariosContext context, LogAccess logacces, Mapping mapping, IConfiguration iconfiguration, Validaciones validar)
        {
            _context = context;

            _logacces = logacces;
            _mapping = mapping;
            _iconfiguration = iconfiguration;
            _validar = validar;
        }

        public Mensaje Add(Colores obj)
        {
            if (this.ValidarRegistro(obj).IndexOf("Error.") >= 0) return new Mensaje() { mensaje = this.ValidarRegistro(obj) };

            _context.Colores.Add(obj);
            _context.SaveChanges();
            Log(obj, "Agrego Color");
            return new Mensaje() { mensaje = "registro insertado ok " };
        }

        public Mensaje Delete(int id)
        {
            var obj = _context.Colores.FirstOrDefault(a => a.id == id);
            _context.Colores.Remove(obj);
            _context.SaveChanges();
            Log(obj, "Borro Color");
            return new Mensaje() { mensaje = "registro borrado ok " };
        }

        public Mensaje Update(Colores? obj)
        {
            if (this.ValidarRegistro(obj).IndexOf("Error.") >= 0) return new Mensaje() { mensaje = this.ValidarRegistro(obj) };

            var obj_ = _context.Colores.FirstOrDefault(a => a.id == obj.id);
            obj_.nombre = obj.nombre;
            obj_.idusuario = obj.idusuario;
            obj_.nombreusuario = obj.nombreusuario;
            obj_.estadodelregistro = obj.estadodelregistro;
            _context.SaveChanges();
            Log(obj, "Modifico Color");
            return new Mensaje() { mensaje = "registro modificado ok " };
        }

        public List<Colores> GetById(int id)
        {
            list = _context.Colores.Where(a => a.id == id).ToList();
            return list;
        }

        public List<ColoresDTO>? List(string filtro)
        {
            string caracterdebusqueda = _iconfiguration.GetValue<string>("ParametrosDeLaEmpresa:caracterdebusqueda");
            filtro = filtro.Replace(caracterdebusqueda, "");
            list = _context.Colores.ToList().OrderBy(a => a.nombre).Where(a => a.nombre.Contains(filtro.Trim(), StringComparison.OrdinalIgnoreCase)).ToList();
            return _mapping.ListColoresToColoresDTO(list);
        }

        public void Log(Colores obj, string operacion)
        {
            string comando = "";
            comando = comando + "usuario " + obj.nombreusuario + "\n";
            comando = comando + "operacion " + operacion + "\n";
            comando = comando + "id = " + obj.id + "\n";
            comando = comando + "Nombre = " + obj.nombre + "\n";
            comando = comando + "Estado del Registro = " + obj.estadodelregistro + "\n";
            _logacces.Add(comando);
        }

        public string ValidarRegistro(Colores obj)
        {
            string mensajedeerror = "";
            mensajedeerror = mensajedeerror + _validar.ValidarEstadoDelRegistro(obj.estadodelregistro);
            mensajedeerror = mensajedeerror + _validar.Validarnombre("Nombre ", obj.nombre);

            return mensajedeerror;
        }
    }
}