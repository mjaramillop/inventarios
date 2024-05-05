using Newtonsoft.Json;
using System;
using System.Collections.Generic;

namespace Inventarios.Models.Seguridad;

public class Usuarios
{
    public Usuarios()
    {
        this.id = 0;
        this.area = "";
        this.nombre = "";
        this.cargo = "";
        this.direccion = "";
        this.telefono = "";
        this.correoelectronico = "";
        this.login = "";
        this.password = "";
        this.perfil = 0;
        this.tiposdedocumento = "";
        this.bodega = 0;
        this.estadodelregistro = 0;
        this.consecutivo = 0;
    }

    public int id { get; set; }

    public string area { get; set; }

    public string nombre { get; set; }

    public string cargo { get; set; }

    public string direccion { get; set; }

    public string telefono { get; set; }

    public string correoelectronico { get; set; }

    public string login { get; set; }

    public string password { get; set; }

    public int perfil { get; set; }

    public string tiposdedocumento { get; set; }

    public int bodega { get; set; }

    public int estadodelregistro { get; set; }

    public int consecutivo { get; set; }
}