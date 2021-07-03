using FarmSystem.Data.Model;
using GPRO.Core.Mvc;
using GPRO.Ultilities;
using Hugate.Framework;
using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;

namespace FarmSystem.Data.Repositories
{
    public class WorkRepository
    {
        #region constructor
        FarmSystemEntities db;
        static object key = new object();
        private static volatile WorkRepository _Instance;
        public static WorkRepository Instance
        {
            get
            {
                if (_Instance == null)
                    lock (key)
                        _Instance = new WorkRepository();

                return _Instance;
            }
        }
        private WorkRepository() { }
        #endregion

        public List<ModelSelectItem> GetSelectItem(string connectString)
        {
            try
            {
                using (db = new FarmSystemEntities(connectString))
                {
                    var listModelSelect = new List<ModelSelectItem>();
                    var productTypes = db.F_CongViec.Where(x => !x.IsDeleted).Select(
                        x => new ModelSelectItem()
                        {
                            Value = x.Id,
                            Name = x.Name,
                            Code = x.Note,
                        }).ToList();

                    if (productTypes != null && productTypes.Count() > 0)
                    {
                        // listModelSelect.Add(new ModelSelectItem() { Value = 0, Name = " - -  Chọn Đơn vị  - - " });
                        listModelSelect.AddRange(productTypes);
                    }
                    else
                        listModelSelect.Add(new ModelSelectItem() { Value = 0, Name = "  Không có công việc  " });
                    return listModelSelect;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public ResponseBase InsertOrUpdate(string connectString, WorkModel model)
        {
            try
            {
                var result = new ResponseBase();
                using (db = new FarmSystemEntities(connectString))
                {
                    F_CongViec obj = db.F_CongViec.FirstOrDefault(x => x.Id != model.Id && x.Name.Trim().ToUpper().Equals(model.Name.Trim().ToUpper()));
                    if (obj != null)
                    {
                        result.IsSuccess = false;
                        result.Errors.Add(new Error() { MemberName = "Insert ", Message = "Tên công việc này đã tồn tại. Vui lòng chọn lại Tên khác !." });
                        return result;
                    }
                    else
                    {
                        if (model.Id == 0)
                        {
                            obj = new F_CongViec();
                            Parse.CopyObject(model, ref obj);
                            db.F_CongViec.Add(obj);
                            db.SaveChanges();
                            result.IsSuccess = true;
                        }
                        else
                        {
                            obj = db.F_CongViec.FirstOrDefault(x => !x.IsDeleted && x.Id == model.Id);
                            if (obj == null)
                            {
                                result.IsSuccess = false;
                                result.Errors.Add(new Error() { MemberName = "Update ", Message = "Công việc bạn đang thao tác đã bị xóa hoặc không tồn tại. Vui lòng kiểm tra lại !." });
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
                                obj.Name = model.Name;
                                obj.Note = model.Note;
                                obj.CreatedDate = model.CreatedDate;
                                db.SaveChanges();
                                result.IsSuccess = true;
                                // }
                            }
                        }
                    }
                }
                return result;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public PagedList<WorkModel> Gets(string connectString, string keyWord, int startIndexRecord, int pageSize, string sorting)
        {
            try
            {
                using (db = new FarmSystemEntities(connectString))
                {
                    if (string.IsNullOrEmpty(sorting))
                        sorting = "CreatedDate DESC";
                    IQueryable<F_CongViec> objs = null;
                    var pageNumber = (startIndexRecord / pageSize) + 1;
                    if (!string.IsNullOrEmpty(keyWord))
                        objs = db.F_CongViec.Where(x => !x.IsDeleted &&
                         x.Name.Trim().ToUpper().Contains(keyWord.Trim().ToUpper()));
                    else
                        objs = db.F_CongViec.Where(x => !x.IsDeleted);
                    return new PagedList<WorkModel>(objs
                      .OrderBy(sorting)
                      .Select(x => new WorkModel()
                      {
                          Id = x.Id,
                          Name = x.Name,
                          CreatedDate = x.CreatedDate,
                          Note = x.Note
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
                var obj = db.F_CongViec.FirstOrDefault(x => !x.IsDeleted && x.Id == Id);
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
