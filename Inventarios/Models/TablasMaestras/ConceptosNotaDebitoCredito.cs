using Newtonsoft.Json;
using System;
using System.Collections.Generic;

namespace Inventarios.Models.TablasMaestras;

public class ConceptosNotaDebitoCredito
{

    public ConceptosNotaDebitoCredito() {
        this.id = 0;
        this.nombre = "";
        this.estadodelregistro = 0;

    }
    public int id { get; set; }

    public string nombre { get; set; }

    public int estadodelregistro { get; set; }



}
