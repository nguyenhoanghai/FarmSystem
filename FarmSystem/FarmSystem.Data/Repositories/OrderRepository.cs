using FarmSystem.Data.Model;
using GPRO.Core.Mvc;
using GPRO.Ultilities;
using Hugate.Framework;
using PagedList;
using System;
using System.Linq;

namespace FarmSystem.Data.Repositories
{
    public class OrderRepository
    {
        #region constructor
        FarmSystemEntities db;
        static object key = new object();
        private static volatile OrderRepository _Instance;
        public static OrderRepository Instance
        {
            get
            {
                if (_Instance == null)
                    lock (key)
                        _Instance = new OrderRepository();

                return _Instance;
            }
        }
        private OrderRepository() { }
        #endregion

        public ResponseBase InsertOrUpdate(string connectString, OrderModel model)
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
                    HoaDon obj;
                    if (model.Id == 0)
                    {
                        obj = new HoaDon();
                        Parse.CopyObject(model, ref obj);
                        db.HoaDons.Add(obj);
                        db.SaveChanges();
                        result.IsSuccess = true;
                    }
                    else
                    {
                        obj = db.HoaDons.FirstOrDefault(x => !x.IsDeleted && x.Id == model.Id);
                        if (obj == null)
                        {
                            result.IsSuccess = false;
                            result.Errors.Add(new Error() { MemberName = "Update ", Message = "Đơn hàng bạn đang thao tác đã bị xóa hoặc không tồn tại. Vui lòng kiểm tra lại !." });
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
                            obj.Code = model.Code;
                            obj.CustomerId = model.CustomerId;
                            obj.Total = model.Total;
                            obj.Note = model.Note;
                            obj.CreatedDate = model.CreatedDate;
                            obj.Total = obj.ChiTietHoaDons.Where(x => !x.IsDeleted).Sum(x => (x.Price * x.Quantity));
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

        public PagedList<OrderModel> Gets(string connectString, string keyWord, int startIndexRecord, int pageSize, string sorting)
        {
            try
            {
                using (db = new FarmSystemEntities(connectString))
                {
                    if (string.IsNullOrEmpty(sorting))
                        sorting = "CreatedDate DESC";
                    IQueryable<HoaDon> objs = null;
                    var pageNumber = (startIndexRecord / pageSize) + 1;
                    if (!string.IsNullOrEmpty(keyWord))
                        objs = db.HoaDons.Where(x => !x.IsDeleted &&
                        (x.Code.Trim().ToUpper().Contains(keyWord.Trim().ToUpper()) ||
                         x.KhachHang.Code.Trim().ToUpper().Contains(keyWord.Trim().ToUpper()) ||
                         x.KhachHang.Name.Trim().ToUpper().Contains(keyWord.Trim().ToUpper())));
                    else
                        objs = db.HoaDons.Where(x => !x.IsDeleted);
                    return new PagedList<OrderModel>(objs
                      .OrderBy(sorting)
                     .Select(x => new OrderModel()
                     {
                         Id = x.Id,
                         Code = x.Code,
                         CreatedDate = x.CreatedDate,
                         Note = x.Note,
                         Total = x.Total,
                         CustomerId = x.CustomerId,
                         CustomerName = x.KhachHang.Name
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
                var obj = db.HoaDons.FirstOrDefault(x => !x.IsDeleted && x.Id == Id);
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
