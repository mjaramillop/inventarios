namespace Inventarios.Tables
{
    public class StaticTables
    {
        public List<CodigoNombre> EstadosDeUnRegistro { get; set; }
        public List<CodigoNombre> TiposDePersona { get; set; }

        public List<CodigoNombre> SiNo { get; set; }

        public List<CodigoNombre> Tallas { get; set; }

        public List<CodigoNombre> TiposDeAgente { get; set; }

        public List<CodigoNombre> TiposDeCuentaBancaria { get; set; }

        public List<CodigoNombre> TiposDeRegimen { get; set; }

        public List<CodigoNombre> TiposDeRetencion { get; set; }

        public StaticTables()
        {
            EstadosDeUnRegistro = new List<CodigoNombre>()
            {
                   new CodigoNombre{ id="A", nombre= "Activo"   },
                new CodigoNombre{ id="I",nombre="Inactivo"   }
            };

            TiposDePersona = new List<CodigoNombre>()
            {
                 new  CodigoNombre{ id="N",nombre="Natural"   },
                new   CodigoNombre{ id="J", nombre= "Juridica"   },
            };

            SiNo = new List<CodigoNombre>()
            {
                 new  CodigoNombre{ id="S",nombre="Si"   },
                new   CodigoNombre{ id="N", nombre= "No"   },
            };

            Tallas = new List<CodigoNombre>()
            {
                 new  CodigoNombre{ id="S",nombre="Small"   },
                new  CodigoNombre{ id="M", nombre= "Medium"   },
                new  CodigoNombre{ id="L", nombre= "Large"   },
                new  CodigoNombre{ id="XL", nombre= "Extreme"   },
                new  CodigoNombre{ id="XXL", nombre= "DoubleExtreme"   },
                new  CodigoNombre{ id="0", nombre= "No Aplica"   },
            };

            TiposDeAgente = new List<CodigoNombre>()
            {
                new  CodigoNombre{ id="0",nombre="Bodega"   },
                new  CodigoNombre{ id="1", nombre= "Cliente"   },
                new  CodigoNombre{ id="2", nombre= "Banco"   },
                new  CodigoNombre{ id="3", nombre= "Proveedor"   },
                new  CodigoNombre{ id="4", nombre= "Vendedor"   },
                new  CodigoNombre{ id="5", nombre= "ClienteProveedor"   },
                new  CodigoNombre{ id="6", nombre= "Usuarios"   }

            };

            TiposDeCuentaBancaria = new List<CodigoNombre>()
            {
                new  CodigoNombre{ id="1",nombre="Ahorros"   },
                new  CodigoNombre{ id="2", nombre= "Corriente"   }
            };

            TiposDeRegimen = new List<CodigoNombre>()
            {
                 new  CodigoNombre{ id="1",nombre="Comun"   },
                new   CodigoNombre{ id="2", nombre= "Simplificado"   },
            };

            TiposDeRetencion = new List<CodigoNombre>()
            {
                   new  CodigoNombre{ id="0",nombre="No Aplica"   },
                 new  CodigoNombre{ id="1",nombre="Fuente"   },
                new   CodigoNombre{ id="2", nombre= "Iva"   },
                new   CodigoNombre{ id="3", nombre= "Ica"   },
            };
        }
    }

    public class CodigoNombre
    {
        public string? id { get; set; }
        public string? nombre { get; set; }
    }
}