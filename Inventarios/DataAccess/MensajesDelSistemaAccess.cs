﻿using Inventarios.Data;
using Inventarios.DTO;
using Inventarios.Map;
using Inventarios.Models;
using Inventarios.Token;
using Inventarios.Utils;

namespace Inventarios.DataAccess
{
    public class MensajesDelSistemaAccess
    {
        private readonly InventariosContext _context;
        private readonly LogAccess _logacces;
        private readonly IConfiguration _iconfiguration;

        private List<Mensajesdelsistema>? list;

        public MensajesDelSistemaAccess(InventariosContext context, LogAccess logacces, IConfiguration iconfigutarion)
        {
            _context = context;
            _iconfiguration = iconfigutarion;
            _logacces = logacces;
        }

        public List<MensajesDelSistemaDTO>? Add(Mensajesdelsistema obj)
        {

            string comando = "";
            comando = "delete from mensajesdelsistema where fecha_hasta < getdate()  ";
            Rutinas ru = new(_iconfiguration);
            string mensaje=ru.rtn_ejecutarsql(comando);


           

            _context.Mensajesdelsistema.Add(obj);
            _context.SaveChanges();
            this.Log(obj, "Agrego Mensaje del sistema");
            list = _context.Mensajesdelsistema.Where(a => a.id == obj.id).ToList();
            return Mapping.ListMensajesDelSistemaToMensajesDelSistemaDTO(list);
        }



        public List<MensajesDelSistemaDTO> Delete(int id)
        {
            var obj = _context.Mensajesdelsistema.FirstOrDefault(a => a.id == id);
            _context.Mensajesdelsistema.Remove(obj);
            _context.SaveChanges();
            this.Log(obj, "Borro Mensajes del sistema");
            obj.mensaje = "Registro borrado satisfactoriamente";
            list = _context.Mensajesdelsistema.Where(a => a.id == obj.id).ToList();
            return Mapping.ListMensajesDelSistemaToMensajesDelSistemaDTO(list);
        }


        public List<MensajesDelSistemaDTO>? Update(Mensajesdelsistema? obj)
        {
         
            var obj_ = _context.Mensajesdelsistema.FirstOrDefault(a => a.id == obj.id);
            if (obj_ != null)
            {
                obj.fechadesde= obj_.fechadesde;
                obj_.fechahasta= obj_.fechahasta;
                obj_.mensaje = obj.mensaje;
                _context.SaveChanges();
                this.Log(obj, "Modifico Mensajes del sistema");
            }
            list = _context.Mensajesdelsistema.Where(a => a.id == obj.id).ToList();
            return Mapping.ListMensajesDelSistemaToMensajesDelSistemaDTO(list);
        }

        public List<Mensajesdelsistema> GetById(int id)
        {
            list = _context.Mensajesdelsistema.Where(a => a.id == id).ToList();
            return list;
        }


        public List<MensajesDelSistemaDTO>? List( string filtro )
        {
            list = _context.Mensajesdelsistema.ToList().Where(a => a.mensaje.Contains((filtro.Trim()), StringComparison.OrdinalIgnoreCase)).ToList();
            return Mapping.ListMensajesDelSistemaToMensajesDelSistemaDTO(list);
        }

        public List<MensajesDelSistemaDTO>? ListActive()
        {
            list = _context.Mensajesdelsistema.ToList().Where(a => DateTime.Now >= a.fechadesde && DateTime.Now < a.fechahasta.Value.AddDays(1)).ToList();
            return Mapping.ListMensajesDelSistemaToMensajesDelSistemaDTO(list);
        }



        public void Log(Mensajesdelsistema obj, string operacion)
        {
            string comando = "";
            comando = comando + "operacion " + operacion + "\n";

            comando = comando + "id = " + obj.id + "\n";

            comando = comando + "fecha desde = " + obj.fechadesde + "\n";
            comando = comando + "fecha hasta = " + obj.fechahasta + "\n";
            comando = comando + "Mensaje = " + obj.mensaje + "\n";

            _logacces.Add(comando);
        }
    }
}