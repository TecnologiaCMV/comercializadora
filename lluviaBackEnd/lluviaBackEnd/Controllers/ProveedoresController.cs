﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using lluviaBackEnd.DAO;
using lluviaBackEnd.Filters;
using lluviaBackEnd.Models;

namespace lluviaBackEnd.Controllers
{
    [SessionTimeout]
    public class ProveedoresController : Controller
    {
        // GET: Proveedores
        [PermisoAttribute(Permiso = EnumRolesPermisos.Puede_visualizar_Proveedores)]
        public ActionResult Proveedores()
        {
            try
            {
                ViewBag.lstProveedores = new ProveedorDAO().ObtenerProveedores(new Models.Proveedor() { idProveedor = 0 });
                return View();
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }




        public ActionResult ObtenerProveedor(int idProveedor)
        {
            try
            {
                Models.Proveedor p = new ProveedorDAO().ObtenerProveedores(new Models.Proveedor() { idProveedor = idProveedor })[0];
                return Json(p, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public ActionResult _ObtenerProveedores(int idProveedor)
        {
            try
            {
                //List<Models.Socio> Lstsocio = new SocioDAO().ObtenerSocios(new Models.Socio() { IdSocio = 0 });
                ViewBag.lstProveedores = new ProveedorDAO().ObtenerProveedores(new Models.Proveedor() { idProveedor = 0 });
                return PartialView("_ObtenerProveedores");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        [HttpPost]
        public ActionResult GuardarProveedor(Proveedor p)
        {
            try
            {
                Notificacion<Proveedor> notificacion = new ProveedorDAO().GuardarProveedor(p);

                //Result result = new Result();
                //result = new ProveedorDAO().GuardarProveedor(p);
                return Json(notificacion, JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [HttpPost]
        public ActionResult ActualizarEstatusProveedor(int idProveedor, bool activo)
        {
            try
            {
                Result result = new ProveedorDAO().ActualizarEstatusProveedor(idProveedor, activo);
                return Json(result, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public ActionResult _NuevoProveedor()
        {
            try
            {               
                return PartialView();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }


}
