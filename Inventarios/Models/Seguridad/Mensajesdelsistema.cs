using System;
using System.Collections.Generic;

namespace Inventarios.Models.Seguridad;

public class Mensajesdelsistema
{

    public Mensajesdelsistema() {

        this.id = 0;
        this.fechahasta=DateTime.Now;   
        this.fechadesde=DateTime.Now;   

    } 
    public int id { get; set; }

    public DateTime fechadesde { get; set; }

    public DateTime fechahasta { get; set; }

    public string? mensaje { get; set; }
}
