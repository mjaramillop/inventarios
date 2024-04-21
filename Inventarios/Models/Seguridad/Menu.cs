using Newtonsoft.Json;
using System;
using System.Collections.Generic;

namespace Inventarios.Models.Seguridad;

public  class Menu
{

    public Menu() {

        this.id = 0;
        this.orden = "";
        this.nombre = "";
        this.paginaweb = "";
        this.estadodelregistro = 0;
    
    
    }


    public int id { get; set; }

    public string orden { get; set; } = null!;

    public string nombre { get; set; }

    public string paginaweb { get; set; }

    public int estadodelregistro { get; set; }



}
