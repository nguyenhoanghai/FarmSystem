using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GPRO.Core.Mvc;
using System.Web.Routing;

namespace FarmSystem.Controllers
{
    public class BaseController : ControllerCore
    {
        public BaseController() { }
        protected override void Initialize(RequestContext requestContext)
        {
            base.Initialize(requestContext);
        }
    }
}