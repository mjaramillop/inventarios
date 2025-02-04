﻿using Inventarios.DataAccess.TablasMaestras;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;

namespace Inventarios.services.TablasMaestras
{
    public class TiposDeCuentaBancariaService
    {
        private readonly TiposDeCuentaBancariaAccess _access;
        public List<TiposDeCuentaBancariaDTO>? list;

        public TiposDeCuentaBancariaService(TiposDeCuentaBancariaAccess access)
        {
            _access = access;
        }

        public Mensaje Add(TiposDeCuentaBancaria obj)
        {
            Mensaje list = _access.Add(obj);
            return list;
        }

        public Mensaje Delete(int id)
        {
            Mensaje list = _access.Delete(id);
            return list;
        }

        public Mensaje Update(TiposDeCuentaBancaria obj)
        {
            Mensaje list = _access.Update(obj);
            return list;
        }

        public List<TiposDeCuentaBancaria>? GetById(int id)
        {
            List<TiposDeCuentaBancaria> list = _access.GetById(id);

            return list;
        }

        public List<TiposDeCuentaBancariaDTO>? List(string filtro)
        {
            var list = _access.List(filtro);
            return list;
        }
    }
}