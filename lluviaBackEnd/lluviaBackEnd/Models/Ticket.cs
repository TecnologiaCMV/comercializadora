﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace lluviaBackEnd.Models
{
    public class Ticket
    {
        public int contador { get; set; }
        public int idVenta { get; set; }
        public int idProducto { get; set; }
        public string descProducto { get; set; }
        public int cantidad { get; set; }
        public int contadorProductosPorPrecio { get; set; }
        public float monto { get; set; }
        public int idCliente { get; set; }
        public string nombreCliente { get; set; }
        public int idUsuario { get; set; }
        public string nombreUsuario { get; set; }
        public int cantidadActualInvGeneral { get; set; }
        public int cantidadAnteriorInvGeneral { get; set; }
        public DateTime fechaAlta { get; set; }
        public float montoIVA { get; set; }
        public float ahorro { get; set; }
        public float precioVenta { get; set; }
        public int idVentaDetalle { get; set; }
        public int productosDevueltos { get; set; }
        public int productosAgregados { get; set; }
        public EnumTipoVenta tipoVenta { get; set; }
    }
}