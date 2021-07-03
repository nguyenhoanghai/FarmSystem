using FarmSystem.App_Global;
using FarmSystem.Data.Model;
using FarmSystem.Data.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace FarmSystem.Controllers
{
    public class WorkHistoriesController : BaseController
    { 
        public ActionResult Index()
        {
            return View();
        }

        public JsonResult Gets(string keyword, int jtStartIndex, int jtPageSize, string jtSorting)
        {
            try
            {
                var objs = WorkHistoriesRepository.Instance.Gets(AppGlobal.Connectionstring, keyword, jtStartIndex, jtPageSize, jtSorting);
                JsonDataResult.Records = objs;
                JsonDataResult.Result = "OK";
                JsonDataResult.TotalRecordCount = objs.TotalItemCount;

            }
            catch (Exception ex)
            {
                throw (ex);
            }
            return Json(JsonDataResult);
        }

        [HttpPost]
        public JsonResult Save(WorkHistoryModel model)
        {
            ResponseBase res = new ResponseBase();
            try
            {
                res = WorkHistoriesRepository.Instance.InsertOrUpdate(AppGlobal.Connectionstring, model);
                if (!res.IsSuccess)
                {
                    JsonDataResult.Result = "ERROR";
                    JsonDataResult.ErrorMessages.AddRange(res.Errors);
                }
                else
                    JsonDataResult.Result = "OK";

            }
            catch (Exception ex)
            {
                throw (ex);
            }
            return Json(JsonDataResult);
        }

        [HttpPost]
        public JsonResult Delete(int Id)
        {
            ResponseBase result = new ResponseBase();
            try
            {
                //if (isAuthenticate)
                //{
                result.IsSuccess = WorkHistoriesRepository.Instance.Delete(AppGlobal.Connectionstring, Id);
                if (!result.IsSuccess)
                {
                    JsonDataResult.Result = "ERROR";
                }
                else
                {
                    JsonDataResult.Result = "OK";
                }
                // }
            }
            catch (Exception ex)
            {
                throw (ex);
            }
            return Json(JsonDataResult);
        }
    }
}