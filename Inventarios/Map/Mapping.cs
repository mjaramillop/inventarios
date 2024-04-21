using Inventarios.Data;
using Inventarios.DataAccess;
using Inventarios.DTO;
using Inventarios.DTO.Seguridad;
using Inventarios.DTO.TablasMaestras;
using Inventarios.Models.TablasMaestras;
using Inventarios.Models.Seguridad;
using Microsoft.EntityFrameworkCore;
using System.Data;
using System;
using Inventarios.Utils;

namespace Inventarios.Map
{
    public  class Mapping
    {

        private readonly InventariosContext _context;
        private readonly Utilidades _utilidades;
      


        public Mapping(InventariosContext context , Utilidades utilidades)
        {
            _context = context;
            _utilidades = utilidades;
           

           
        }

        public SaldosDTO SaldosToSaldosDTO(Saldos obj)
        {
            Productos producto = _context.Productos.FirstOrDefault(a => a.id == obj.producto);
            Proveedores proveedor = _context.Proveedores.FirstOrDefault(a => a.id == obj.bodega);




            SaldosDTO dto = new();
            dto.id = obj.id;
            dto.saldo = obj.saldo;
            dto.saldoinicial = obj.saldoinicial;    
            dto.saldofisico = obj.saldofisico;
            dto.salidas = obj.salidas;
            dto.fechadelaultimasalida = obj.fechadelaultimasalida;
            dto.bodega = obj.bodega;
            dto.costopromedio = obj.costopromedio;
            dto.entradas = obj.entradas;
            dto.fechadelaultimaentrada = obj.fechadelaultimaentrada;
            dto.nombrebodega = proveedor.nombre;
            dto.nombreproducto = producto.nombre;
            dto.producto = obj.producto;

            dto.diassinrotar = _utilidades.RestarFechas(obj.fechadelaultimasalida, obj.fechadelaultimaentrada);

          

            return dto;
        }


        public List<SaldosDTO> ListSaldosToSaldosDTO(List<Saldos> list)
        {
            List<SaldosDTO> listdto = new();

            foreach (var s in list)
            {
                listdto.Add(SaldosToSaldosDTO(s));
            }
            return listdto;
        }



        public SiNoDTO SiNoToSiNoDTO(SiNo obj)
        {
            SiNoDTO dto = new();
            dto.id = obj.id;
            dto.nombre = obj.nombre;


            return dto;
        }


        public List<SiNoDTO> ListSiNoToSiNoDTO(List<SiNo> list)
        {
            List<SiNoDTO> listdto = new();

            foreach (var s in list)
            {
                listdto.Add(SiNoToSiNoDTO(s));
            }
            return listdto;
        }




        public ColoresDTO ColoresToColoresDTO(Colores obj)
        {
            ColoresDTO dto = new();
            dto.id = obj.id;
            dto.nombre = obj.nombre;


            return dto;
        }


        public List<ColoresDTO> ListColoresToColoresDTO(List<Colores> list)
        {
            List<ColoresDTO> listdto = new();

            foreach (var s in list)
            {
                listdto.Add(ColoresToColoresDTO(s));
            }
            return listdto;
        }



        public EstadosDeUnRegistroDTO EstadosDeUnRegistroToEstadosDeUnRegistroDTO(EstadosDeUnRegistro obj)
        {
            EstadosDeUnRegistroDTO dto = new();
            dto.id = obj.id;
            dto.nombre = obj.nombre;
           

            return dto;
        }


        public List<EstadosDeUnRegistroDTO> ListEstadosDeUnRegistroToEstadosDeUnRegistroDTO(List<EstadosDeUnRegistro> list)
        {
            List<EstadosDeUnRegistroDTO> listdto = new();

            foreach (var s in list)
            {
                listdto.Add(EstadosDeUnRegistroToEstadosDeUnRegistroDTO(s));
            }
            return listdto;
        }


        public RetencionesDTO RetencionesToRetencionesDTO(Retenciones obj)
        {
            RetencionesDTO dto = new();
            dto.id = obj.id;
            dto.nombre = obj.nombre;
            dto.basedelaretencion = obj.basedelaretencion;
            dto.estadodelregistro = obj.estadodelregistro;

            return dto;
        }


        public List<RetencionesDTO> ListRetencionesToRetencionesDTO(List<Retenciones> list)
        {
            List<RetencionesDTO> listdto = new();

            foreach (var s in list)
            {
                listdto.Add(RetencionesToRetencionesDTO(s));
            }
            return listdto;
        }



        public ProgramasDTO ProgramasToProgramasDTO(Programas obj)
        {
            ProgramasDTO dto = new();
            dto.id = obj.id;
            dto.nombre = obj.nombre;
            dto.estadodelregistro = obj.estadodelregistro;

            return dto;
        }


        public List<ProgramasDTO> ListProgramasToProgramasDTO(List<Programas> list)
        {
            List<ProgramasDTO> listdto = new();

            foreach (var s in list)
            {
                listdto.Add(ProgramasToProgramasDTO(s));
            }
            return listdto;
        }



        public IvasDTO IvasToIvasDTO(Ivas obj)
        {
            IvasDTO dto = new();
            dto.id = obj.id;
            dto.nombre = obj.nombre;
            dto.porcentaje = obj.porcentaje;
            dto.estadodelregistro = obj.estadodelregistro;

            return dto;
        }


        public List<IvasDTO> ListIvasToIvasDTO(List<Ivas> list)
        {
            List<IvasDTO> listdto = new();

            foreach (var s in list)
            {
                listdto.Add(IvasToIvasDTO(s));
            }
            return listdto;
        }




        public UnidadesDeMedidaDTO UnidadesDeMedidaToUnidadesDeMedidaDTO(UnidadesDeMedida obj)
        {
            UnidadesDeMedidaDTO dto = new();
            dto.id = obj.id;
            dto.nombre = obj.nombre;
            dto.estadodelregistro = obj.estadodelregistro;

            return dto;
        }


        public List<UnidadesDeMedidaDTO> ListUnidadesDeMedidaToUnidadesDeMedidaDTO(List<UnidadesDeMedida> list)
        {
            List<UnidadesDeMedidaDTO> listdto = new();

            foreach (var s in list)
            {
                listdto.Add(UnidadesDeMedidaToUnidadesDeMedidaDTO(s));
            }
            return listdto;
        }



        public ProductosDTO ProductosToProductosDTO(Productos obj)
        {

            UnidadesDeMedida unidadesdemedida = _context.UnidadesDeMedida.FirstOrDefault(a => a.id == obj.unidaddemedida);


            ProductosDTO dto = new();
            dto.id = obj.id;
            dto.nombre = obj.nombre;
            dto.precio1 = obj.precio1;  
            dto.costoultimo = obj.costoultimo;
            dto.secargalinventario = obj.secargalinventario;
            dto.codigoiva1 = obj.codigoiva1;    
            dto.unidaddemedida = obj.unidaddemedida;
            dto.nombreunidaddemedida = unidadesdemedida.nombre;
            dto.estadodelregistro = obj.estadodelregistro;
            dto.nivel1 = obj.nivel1;
            dto.nivel2= obj.nivel2;
            dto.nivel3=obj.nivel3;
            dto.nivel4= obj.nivel4; 
            dto.nivel5= obj.nivel5;

            return dto;
        }


        public List<ProductosDTO> ListProductosToProductosDTO(List<Productos> list)
        {
            List<ProductosDTO> listdto = new();

            foreach (var s in list)
            {
                listdto.Add(ProductosToProductosDTO(s));
            }
            return listdto;
        }




        public FormulasDTO FormulasToFormulasDTO(Formulas obj)
        {

            Productos producto= new Productos();
            producto =  _context.Productos.FirstOrDefault(a => a.id == obj.formula);
            Productos componente= new Productos();
            componente = _context.Productos.FirstOrDefault(a => a.id == obj.componente);

            UnidadesDeMedida unidadesdemedida  = _context.UnidadesDeMedida.FirstOrDefault(a => a.id == componente.unidaddemedida);



            FormulasDTO dto = new();
            dto.id = obj.id;
            dto.formula= obj.formula;
            dto.nombreformula = producto.nombre;
            dto.componente=obj.componente;
            dto.nombrecomponente = componente.nombre;
            dto.cantidad = obj.cantidad;
            dto.unidaddemedida = componente.unidaddemedida;
            dto.nombreunidaddemedida = unidadesdemedida.nombre;


        

            return dto;
        }


        public  List<FormulasDTO> ListFormulasToFormulasDTO(List<Formulas> list)
        {
            List<FormulasDTO> listdto = new();

            foreach (var s in list)
            {
                listdto.Add(FormulasToFormulasDTO(s));
            }
            return listdto;
        }


     




        public  FormasDePagoDTO FormasDePagoToFormasDePagoDTO(FormasDePago obj)
        {
            FormasDePagoDTO dto = new();
            dto.id = obj.id;
            dto.nombre = obj.nombre;
            dto.estadodelregistro = obj.estadodelregistro;

            return dto;
        }


        public  List<FormasDePagoDTO> ListFormasDePagoToFormasDePagoDTO(List<FormasDePago> list)
        {
            List<FormasDePagoDTO> listdto = new();

            foreach (var s in list)
            {
                listdto.Add(FormasDePagoToFormasDePagoDTO(s));
            }
            return listdto;
        }


        public  ConceptosNotaDebitoCreditoDTO ConceptosNotaDebitoCreditoToConceptosNotaDebitoCreditoDTO(ConceptosNotaDebitoCredito obj)
        {
            ConceptosNotaDebitoCreditoDTO dto = new();
            dto.id = obj.id;
            dto.nombre = obj.nombre;
            dto.estadodelregistro = obj.estadodelregistro;

            return dto;
        }


        public  List<ConceptosNotaDebitoCreditoDTO> ListConceptosNotaDebitoCreditoToConceptosNotaDebitoCreditoDTO(List<ConceptosNotaDebitoCredito> list)
        {
            List<ConceptosNotaDebitoCreditoDTO> listdto = new();

            foreach (var s in list)
            {
                listdto.Add(ConceptosNotaDebitoCreditoToConceptosNotaDebitoCreditoDTO(s));
            }
            return listdto;
        }



        public  MensajesDelSistemaDTO MensajesDelSistemaToMensajesDelSistemaDTO(Mensajesdelsistema obj)
        {
            MensajesDelSistemaDTO dto = new();
            dto.id=obj.id;
            dto.fechadesde = String.Format("{0:f}", obj.fechadesde);
            dto.fechahasta = String.Format("{0:f}", obj.fechahasta);
            dto.mensaje = obj.mensaje;
          
            return dto;
        }

        public  List<MensajesDelSistemaDTO> ListMensajesDelSistemaToMensajesDelSistemaDTO(List<Mensajesdelsistema> list)
        {
            List<MensajesDelSistemaDTO> listdto = new();

            foreach (var s in list)
            {
                listdto.Add(MensajesDelSistemaToMensajesDelSistemaDTO(s));
            }
            return listdto;
        }





        public  LogDTO LogToLogDTO(Log obj)
        {
            LogDTO dto = new();
            dto.id = obj.id;
            dto.descripciondelaoperacion = obj.descripciondelaoperacion;
            dto.fechadeactualizacion = String.Format("{0:f}", obj.fechadeactualizacion);


            return dto;
        }

        public  List<LogDTO> ListLogToLogDTO(List<Log> list)
        {
            List<LogDTO> listdto = new();

            foreach (var s in list)
            {
                listdto.Add(LogToLogDTO(s));
            }
            return listdto;
        }

        public  List<LogDTO> TableLogToLogDTO(DataTable? list)
        {
            List<LogDTO> listdto = new();

            if (list != null)
            {
                foreach (DataRow dr in list.Rows)
                {
                    LogDTO dto = new();
                    dto.id = Convert.ToInt32(dr["id"]);
                    dto.descripciondelaoperacion = dr["descripcion_de_la_operacion"].ToString();
                    dto.fechadeactualizacion = dr["fecha_de_actualizacion"].ToString();
                    listdto.Add(dto);

                }
            }

         
            return listdto;
        }



        public  ProveedoresDTO ProveedoresToProveedoresDTO(Proveedores obj)
        {
            ProveedoresDTO dto = new();
            dto.id = obj.id;
            dto.nombre = obj.nombre;
            dto.telefono = obj.telefono;
            dto.estadodelregistro = obj.estadodelregistro;
            dto.nivel1 = obj.nivel1;
            dto.nivel2 = obj.nivel2;
            dto.nivel3 = obj.nivel3;
            dto.nivel4 = obj.nivel4;
            dto.nivel5 = obj.nivel5;
            return dto;
        }

        public  List<ProveedoresDTO> ListProveedoresToProveedoresDTO(List<Proveedores> list)
        {
            List<ProveedoresDTO> listdto = new();

            foreach (var s in list)
            {
                listdto.Add(ProveedoresToProveedoresDTO(s));
            }
            return listdto;
        }

        public  TiposDeDocumentoDTO TiposDeDocumentoToTiposDeDocumentoDTO(TiposDeDocumento obj)
        {
            TiposDeDocumentoDTO dto = new();
            dto.id = obj.id;
            dto.nombre = obj.nombre;
            dto.estadodelregistro = obj.estadodelregistro;
            return dto;
        }

        public  List<TiposDeDocumentoDTO> ListTiposDeDocumentoToTiposDeDocumentoDTO(List<TiposDeDocumento> list)
        {
            List<TiposDeDocumentoDTO> listdto = new();

            foreach (var s in list)
            {
                listdto.Add(TiposDeDocumentoToTiposDeDocumentoDTO(s));
            }
            return listdto;
        }

        public  PerfilesDTO PerfilesToPerfilesDTO(Perfiles obj)
        {
            PerfilesDTO dto = new();
            dto.id = obj.id;
            dto.nombre = obj.nombre;

            dto.estadodelregistro = obj.estadodelregistro;

            return dto;
        }

        public  List<PerfilesDTO> ListPerfilesToPerfilesDTO(List<Perfiles> list)
        {
            List<PerfilesDTO> listdto = new();

            foreach (var s in list)
            {
                listdto.Add(PerfilesToPerfilesDTO(s));
            }
            return listdto;
        }

        public  ActividadesEconomicasDTO ActividadeseconomicasToActividadeseconomicasDTO(ActividadesEconomicas obj)
        {
            ActividadesEconomicasDTO dto = new();
            dto.id = obj.id;
            dto.nombre = obj.nombre;
            dto.estadodelregistro = obj.estadodelregistro;

            return dto;
        }

        public  List<ActividadesEconomicasDTO> ListActividadeseconomicasToActividadeseconomicasDTO(List<ActividadesEconomicas> list)
        {
            List<ActividadesEconomicasDTO> listdto = new();

            foreach (var s in list)
            {
                listdto.Add(ActividadeseconomicasToActividadeseconomicasDTO(s));
            }
            return listdto;
        }

      
        public  MenuDTO MenuToMenuDTO(Menu menu)
        {
            MenuDTO dto = new();
            dto.id = menu.id;
            dto.orden = menu.orden;
            dto.nombre = menu.nombre;
            dto.paginaweb = menu.paginaweb;
            dto.estadodelregistro = menu.estadodelregistro;

            return dto;
        }

        public  List<MenuDTO> ListMenuToListMenuDTO(List<Menu> list)
        {
            List<MenuDTO> listdto = new();

            foreach (var s in list)
            {
                listdto.Add(MenuToMenuDTO(s));
            }
            return listdto;
        }

        public  UsersDTO UsersToUsersDTO(Usuarios user)
        {
            UsersDTO dto = new();

            dto.id = user.id;

            dto.area = user.area;
            dto.nombre = user.nombre;
            dto.cargo = user.cargo;
            dto.estadodelregistro = user.estadodelregistro;

            return dto;
        }

        public  List<UsersDTO> ListUsersToListUsersDTO(List<Usuarios> list)
        {
            List<UsersDTO> listdto = new();

            foreach (var s in list)
            {
                listdto.Add(UsersToUsersDTO(s));
            }
            return listdto;
        }
    }
}