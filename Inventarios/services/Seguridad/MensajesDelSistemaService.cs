﻿using Inventarios.DataAccess;
using Inventarios.DTO.Seguridad;
using Inventarios.Models.Seguridad;
using Inventarios.Models.TablasMaestras;


namespace Inventarios.services.Seguridad
{
    public class MensajesDelSistemaService
    {
        private readonly MensajesDelSistemaAccess _access;
        public List<MensajesDelSistemaDTO>? list;

        public MensajesDelSistemaService(MensajesDelSistemaAccess access)
        {
            _access = access;
        }

        public Mensaje Add(Mensajesdelsistema obj)
        {
            Mensaje list = _access.Add(obj);
            return list;
        }

        public Mensaje Delete(int id)
        {
            Mensaje list = _access.Delete(id);
            return list;
        }

        public Mensaje Update(Mensajesdelsistema obj)
        {
            Mensaje list = _access.Update(obj);
            return list;
        }

        public List<Mensajesdelsistema>? GetById(int id)
        {
            List<Mensajesdelsistema> list = _access.GetById(id);

            return list;
        }

        public List<MensajesDelSistemaDTO>? List(string filtro)
        {
            var list = _access.List(filtro);
            return list;
        }

        public List<MensajesDelSistemaDTO>? ListActive()
        {
            var list = _access.ListActive();
            return list;
        }
    }
}