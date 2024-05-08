﻿using Inventarios.DataAccess.TablasMaestras;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;

namespace Inventarios.services.TablasMaestras
{
    public class TiposDeAgenteService
    {
        private readonly TiposDeAgenteAccess _access;
        public List<TiposDeAgenteDTO>? list;

        public TiposDeAgenteService(TiposDeAgenteAccess access)
        {
            _access = access;
        }

        public List<TiposDeAgenteDTO>? Add(TiposDeAgente obj)
        {
            list = _access.Add(obj);
            return list;
        }

        public List<TiposDeAgenteDTO>? Delete(int id)
        {
            list = _access.Delete(id);
            return list;
        }

        public List<TiposDeAgenteDTO>? Update(TiposDeAgente obj)
        {
            list = _access.Update(obj);
            return list;
        }

        public List<TiposDeAgente>? GetById(int id)
        {
            List<TiposDeAgente> list = _access.GetById(id);

            return list;
        }

        public List<TiposDeAgenteDTO>? List(string filtro)
        {
            var list = _access.List(filtro);
            return list;
        }
    }
}