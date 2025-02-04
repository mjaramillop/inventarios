﻿using Inventarios.DataAccess.TablasMaestras;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;

namespace Inventarios.services.TablasMaestras
{
    public class SiNoService
    {
        private readonly SiNoAccess _access;
        public List<SiNoDTO>? list;

        public SiNoService(SiNoAccess access)
        {
            _access = access;
        }

        public Mensaje Add(SiNo obj)
        {
            Mensaje list = _access.Add(obj);
            return list;
        }

        public Mensaje Delete(string id)
        {
            Mensaje list = _access.Delete(id);
            return list;
        }

        public Mensaje Update(SiNo obj)
        {
            Mensaje list = _access.Update(obj);
            return list;
        }

        public List<SiNo>? GetById(string id)
        {
            List<SiNo> list = _access.GetById(id);

            return list;
        }

        public List<SiNoDTO>? List(string? filtro)
        {
            var list = _access.List(filtro);
            return list;
        }
    }
}