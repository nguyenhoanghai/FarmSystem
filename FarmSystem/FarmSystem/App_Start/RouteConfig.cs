using System.Web.Mvc;
using System.Web.Routing;

namespace FarmSystem
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");
            routes.MapRoute(
                name: "csdl",
                url: "ket-noi-csdl",
                defaults: new { controller = "sqlconnect", action = "Index", id = UrlParameter.Optional }
            );
            routes.MapRoute(
                name: "congviec",
                url: "cong-viec",
                defaults: new { controller = "work", action = "Index", id = UrlParameter.Optional }
            );
            routes.MapRoute(
               name: "khachhang",
               url: "khach-hang",
               defaults: new { controller = "customer", action = "Index", id = UrlParameter.Optional }
           );
            routes.MapRoute(
              name: "vattu",
              url: "vat-tu",
              defaults: new { controller = "material", action = "Index", id = UrlParameter.Optional }
          );
            routes.MapRoute(
              name: "lichsu",
              url: "lich-su",
              defaults: new { controller = "workhistories", action = "Index", id = UrlParameter.Optional }
          );
            routes.MapRoute(
             name: "donhang",
             url: "don-hang",
             defaults: new { controller = "order", action = "Index", id = UrlParameter.Optional }
         );
            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "workhistories", action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
