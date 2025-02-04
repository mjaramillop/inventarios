﻿using Inventarios.DataAccess.TablasMaestras;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;
using Inventarios.ModelsParameter;
using Microsoft.EntityFrameworkCore;

namespace Inventarios.services.TablasMaestras
{
    public class ProveedoresService
    {
        private readonly ProveedoresAccess _access;
        public List<ProveedoresDTO>? list;

        public ProveedoresService(ProveedoresAccess access)
        {
            _access = access;
        }

        public Mensaje Add(Proveedores obj)
        {
            Mensaje list = _access.Add(obj);
            return list;
        }

        public Mensaje Delete(int id)
        {
            Mensaje list = _access.Delete(id);
            return list;
        }

        public Mensaje Update(Proveedores obj)
        {
            Mensaje list = _access.Update(obj);
            return list;
        }

        public List<Proveedores>? GetById(int id)
        {
            List<Proveedores> list = _access.GetById(id);

            return list;
        }


        public List<Mensaje> GenerarClave(int id)
        {
            List<Mensaje> list = _access.GenerarClave(id);
            return list;
        }

        public List<string>? GetNivel(int nivel)
        {
            List<string>? list = new List<string>();

            list = _access.GetNivel(nivel);

            return list;
        }

        public List<ProveedoresDTO>? List(string filtro , int tipodeagente)
        {
            var list = _access.List(filtro,tipodeagente);
            return list;
        }

        public List<ProveedoresDTO>? UpdateNiveles(UpdateNiveles obj)
        {
            list = _access.UpdateNiveles(obj);
            return list;
        }
    }
}