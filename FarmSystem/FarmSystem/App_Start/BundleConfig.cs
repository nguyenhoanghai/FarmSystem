using System.Web.Optimization;

namespace FarmSystem
{
    public class BundleConfig
    {
        // For more information on bundling, visit https://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/jquery-{version}.js",
                        "~/Scripts/jquery-ui-1.11.4.min.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                        "~/Scripts/jquery.validate*"));

            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-2.8.3.js"));

            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                      "~/Scripts/bootstrap.js"));

            bundles.Add(new ScriptBundle("~/bundles/timepicker").Include(
                     "~/Scripts/timepicker.js"));

            bundles.Add(new ScriptBundle("~/bundles/alert").Include(
                     "~/Scripts/alert/jquery.alerts.js",
                     "~/Scripts/alert/common.js" 
                     ));
            bundles.Add(new ScriptBundle("~/bundles/jtable").Include(
                    "~/Scripts/jtable/jquery.jtable.js",
                    "~/Scripts/jtable/localization/jquery.jtable.vi.js"
                    ));

            bundles.Add(new ScriptBundle("~/bundles/moment").Include(
                   "~/Scripts/moment.js" 
                   ));

            bundles.Add(new ScriptBundle("~/bundles/common").Include(
                  "~/Scripts/www/common.js"
                  ));

            bundles.Add(new StyleBundle("~/Content/css").Include(
                      "~/Content/bootstrap.css",
                      "~/Content/site.css",
                      "~/Content/jtable/themes/metro/blue/jtable.css",
                      "~/Content/jtable/customizejtable.css",
                      "~/Content/Jquery.alerts/jquery.alerts.css",
                      "~/Content/bootstrap-toggle.min.css",
                      "~/Content/timepicker.css",
                      "~/Content/font-awesome-4.7.0/css/font-awesome.min.css"
                       ));
        }
    }
}
