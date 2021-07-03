using FarmSystem.Data.Model;
using GPRO.Ultilities;
using PagedList;
using System;
using Hugate.Framework;
using System.Linq;
using GPRO.Core.Mvc;

namespace FarmSystem.Data.Repositories
{
    public class WorkHistoriesRepository
    {
        #region constructor
        FarmSystemEntities db;
        static object key = new object();
        private static volatile WorkHistoriesRepository _Instance;
        public static WorkHistoriesRepository Instance
        {
            get
            {
                if (_Instance == null)
                    lock (key)
                        _Instance = new WorkHistoriesRepository();

                return _Instance;
            }
        }
        private WorkHistoriesRepository() { }
        #endregion

        public ResponseBase InsertOrUpdate(string connectString, WorkHistoryModel model)
        {
            try
            {
                var result = new ResponseBase();
                using (db = new FarmSystemEntities(connectString))
                {
                    //if (CheckExists(model, model.Id))
                    //{
                    //    result.IsSuccess = false;
                    //    result.Errors.Add(new Error() { MemberName = "Insert ", Message = "Tên  Đơn vị này đã tồn tại. Vui lòng chọn lại Tên khác !." });
                    //    return result;
                    //}
                    //else
                    //{
                    F_LichSuLamViec obj;
                    if (model.Id == 0)
                    {
                        obj = new F_LichSuLamViec();
                        Parse.CopyObject(model, ref obj);
                        db.F_LichSuLamViec.Add(obj);
                        db.SaveChanges();
                        result.IsSuccess = true;
                    }
                    else
                    {
                        obj = db.F_LichSuLamViec.FirstOrDefault(x => !x.IsDeleted && x.Id == model.Id);
                        if (obj == null)
                        {
                            result.IsSuccess = false;
                            result.Errors.Add(new Error() { MemberName = "Update ", Message = "Lịch sử bạn đang thao tác đã bị xóa hoặc không tồn tại. Vui lòng kiểm tra lại !." });
                            return result;
                        }
                        else
                        {
                            //if (!checkPermis(obj, model.ActionUser, isOwner))
                            //{
                            //    result.IsSuccess = false;
                            //    result.Errors.Add(new Error() { MemberName = "update", Message = "Bạn không phải là người tạo mã hàng này nên bạn không cập nhật được thông tin cho mã hàng này." });
                            //}
                            //else
                            //{ 
                            obj.CVId = model.CVId;
                            obj.Note = model.Note;
                            obj.CreatedDate = model.CreatedDate;
                            db.SaveChanges();
                            result.IsSuccess = true;
                            // }
                        }
                        //}                        
                    }
                }
                return result;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public PagedList<WorkHistoryModel> Gets(string connectString, string keyWord, int startIndexRecord, int pageSize, string sorting)
        {
            try
            {
                using (db = new FarmSystemEntities(connectString))
                {
                    if (string.IsNullOrEmpty(sorting))
                        sorting = "CreatedDate DESC";
                    IQueryable<F_LichSuLamViec> objs = null;
                    var pageNumber = (startIndexRecord / pageSize) + 1;
                    if (!string.IsNullOrEmpty(keyWord))
                        objs = db.F_LichSuLamViec.Where(x => !x.IsDeleted &&
                         x.F_CongViec.Name.Trim().ToUpper().Contains(keyWord.Trim().ToUpper()));
                    else
                        objs = db.F_LichSuLamViec.Where(x => !x.IsDeleted);
                    return new PagedList<WorkHistoryModel>(objs
                      .OrderBy(sorting)
                     .Select(x => new WorkHistoryModel()
                     {
                         Id = x.Id,
                         CVId = x.CVId,
                         CreatedDate = x.CreatedDate,
                         Note = x.Note,
                         WorkName = x.F_CongViec.Name
                     }).ToList(), pageNumber, pageSize);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Delete(string connectString, int Id)
        {
            using (db = new FarmSystemEntities(connectString))
            {
                var obj = db.F_LichSuLamViec.FirstOrDefault(x => !x.IsDeleted && x.Id == Id);
                if (obj != null)
                {
                    obj.IsDeleted = true;
                    db.SaveChanges();
                    return true;
                }
                return false;
            }
        }
    }
}
