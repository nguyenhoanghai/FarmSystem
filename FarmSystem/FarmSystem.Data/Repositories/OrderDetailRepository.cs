using FarmSystem.Data.Model;
using GPRO.Core.Mvc;
using GPRO.Ultilities;
using Hugate.Framework;
using PagedList;
using System;
using System.Linq;

namespace FarmSystem.Data.Repositories
{
    public class OrderDetailRepository
    {
        #region constructor
        FarmSystemEntities db;
        static object key = new object();
        private static volatile OrderDetailRepository _Instance;
        public static OrderDetailRepository Instance
        {
            get
            {
                if (_Instance == null)
                    lock (key)
                        _Instance = new OrderDetailRepository();

                return _Instance;
            }
        }
        private OrderDetailRepository() { }
        #endregion

        public ResponseBase InsertOrUpdate(string connectString, OrderDetailModel model)
        {
            try
            {
                var result = new ResponseBase();
                using (db = new FarmSystemEntities(connectString))
                {
                    ChiTietHoaDon obj = db.ChiTietHoaDons.FirstOrDefault(x => !x.IsDeleted && x.HoaDonId == model.HoaDonId && x.VatTuId == model.VatTuId && x.Id != model.Id);

                    if (obj != null)
                    {
                        result.IsSuccess = false;
                        result.Errors.Add(new Error() { MemberName = "Insert ", Message = "Vật tư này đã tồn tại. Vui lòng chọn lại vật tư khác !." });
                        return result;
                    }
                    else
                    {

                        if (model.Id == 0)
                        {
                            obj = new ChiTietHoaDon();
                            Parse.CopyObject(model, ref obj);
                            db.ChiTietHoaDons.Add(obj);
                            db.SaveChanges();
                            result.IsSuccess = true;
                        }
                        else
                        {
                            obj = db.ChiTietHoaDons.FirstOrDefault(x => !x.IsDeleted && x.Id == model.Id);
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
                                obj.VatTuId = model.VatTuId;
                                obj.Quantity = model.Quantity;
                                obj.Price = model.Price;
                                obj.Note = model.Note;
                                obj.CreatedDate = model.CreatedDate;
                                db.SaveChanges();
                                result.IsSuccess = true;
                                // }
                            }
                        }

                        if (result.IsSuccess)
                        {
                            //upate hoadon 
                            var hoadon = db.HoaDons.FirstOrDefault(x => !x.IsDeleted && x.Id == model.HoaDonId);
                            if (hoadon!= null)
                            {
                                hoadon.Total = hoadon.ChiTietHoaDons.Where(x => !x.IsDeleted).Sum(x => (x.Price * x.Quantity));
                                db.SaveChanges();
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

        public PagedList<OrderDetailModel> Gets(string connectString, int hoadonId, int startIndexRecord, int pageSize, string sorting)
        {
            try
            {
                using (db = new FarmSystemEntities(connectString))
                {
                    if (string.IsNullOrEmpty(sorting))
                        sorting = "CreatedDate DESC";
                    IQueryable<ChiTietHoaDon> objs = null;
                    var pageNumber = (startIndexRecord / pageSize) + 1;
                    objs = db.ChiTietHoaDons.Where(x => !x.IsDeleted && x.HoaDonId == hoadonId);
                    return new PagedList<OrderDetailModel>(objs
                      .OrderBy(sorting)
                     .Select(x => new OrderDetailModel()
                     {
                         Id = x.Id,
                         VatTuId = x.VatTuId,
                         MaterialName = x.VatTu.Ten,
                         CreatedDate = x.CreatedDate,
                         Note = x.Note,
                         Price = x.Price,
                         Quantity = x.Quantity
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
                var obj = db.ChiTietHoaDons.FirstOrDefault(x => !x.IsDeleted && x.Id == Id);
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
