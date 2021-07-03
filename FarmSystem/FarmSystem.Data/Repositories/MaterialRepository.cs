using FarmSystem.Data.Model;
using GPRO.Ultilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Hugate.Framework;
using PagedList;
using GPRO.Core.Mvc;

namespace FarmSystem.Data.Repositories
{
   public class MaterialRepository
    {
        #region constructor
        FarmSystemEntities db;
        static object key = new object();
        private static volatile MaterialRepository _Instance;
        public static MaterialRepository Instance
        {
            get
            {
                if (_Instance == null)
                    lock (key)
                        _Instance = new MaterialRepository();

                return _Instance;
            }
        }
        private MaterialRepository() { }
        #endregion

        public List<ModelSelectItem> GetSelectItem(string connectString)
        {
            try
            {
                using (db = new FarmSystemEntities(connectString))
                {
                    var listModelSelect = new List<ModelSelectItem>();
                    var productTypes = db.VatTus.Where(x => !x.IsDeleted).Select(
                        x => new ModelSelectItem()
                        {
                            Value = x.Id,
                            Name = x.Ten,
                            Code = x.CongDung,
                        }).ToList();

                    if (productTypes != null && productTypes.Count() > 0)
                    {
                        // listModelSelect.Add(new ModelSelectItem() { Value = 0, Name = " - -  Chọn Đơn vị  - - " });
                        listModelSelect.AddRange(productTypes);
                    }
                    else
                        listModelSelect.Add(new ModelSelectItem() { Value = 0, Name = " -- Không có vật tư -- " });
                    return listModelSelect;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public ResponseBase InsertOrUpdate(string connectString, MaterialsModel model)
        {
            try
            {
                var result = new ResponseBase();
                using (db = new FarmSystemEntities(connectString))
                {
                    VatTu obj = db.VatTus.FirstOrDefault(x => x.Id != model.Id && x.Ten.Trim().ToUpper().Equals(model.Ten.Trim().ToUpper()));
                    if (obj != null)
                    {
                        result.IsSuccess = false;
                        result.Errors.Add(new Error() { MemberName = "Insert ", Message = "Tên vật tư này đã tồn tại. Vui lòng chọn lại Tên khác !." });
                        return result;
                    }
                    else
                    {
                        if (model.Id == 0)
                        {
                            obj = new VatTu();
                            Parse.CopyObject(model, ref obj);
                            if (!string.IsNullOrEmpty(model.Picture))
                                obj.Image = model.Picture;

                            db.VatTus.Add(obj);
                            db.SaveChanges();
                            result.IsSuccess = true;
                        }
                        else
                        {
                            obj = db.VatTus.FirstOrDefault(x => !x.IsDeleted && x.Id == model.Id);
                            if (obj == null)
                            {
                                result.IsSuccess = false;
                                result.Errors.Add(new Error() { MemberName = "Update ", Message = "vật tư bạn đang thao tác đã bị xóa hoặc không tồn tại. Vui lòng kiểm tra lại !." });
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
                                obj.Ten = model.Ten;
                                obj.CongDung = model.CongDung;
                                obj.CachDung = model.CachDung;
                                obj.DanhGia = model.DanhGia;
                                obj.DonGia = model.DonGia;
                                if (!string.IsNullOrEmpty(model.Picture))
                                    obj.Image = model.Picture;
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
        public PagedList<MaterialsModel> Gets(string connectString, string keyWord, int startIndexRecord, int pageSize, string sorting)
        {
            try
            {
                using (db = new FarmSystemEntities(connectString))
                {
                    if (string.IsNullOrEmpty(sorting))
                        sorting = "CreatedDate DESC";
                    IQueryable<VatTu> objs = null;
                    var pageNumber = (startIndexRecord / pageSize) + 1;
                    if (!string.IsNullOrEmpty(keyWord))
                        objs = db.VatTus.Where(x => !x.IsDeleted &&
                         x.Ten.Trim().ToUpper().Contains(keyWord.Trim().ToUpper()));
                    else
                        objs = db.VatTus.Where(x => !x.IsDeleted);
                    return new PagedList<MaterialsModel>(objs
                      .OrderBy(sorting)
                      .Select(x => new MaterialsModel()
                      {
                          Id = x.Id,
                          Ten = x.Ten,
                          CachDung = x.CachDung,
                          CongDung = x.CongDung,
                          DanhGia = x.DanhGia,
                          Image = x.Image,
                          DonGia = x.DonGia,
                          CreatedDate = x.CreatedDate
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
                var obj = db.VatTus.FirstOrDefault(x => !x.IsDeleted && x.Id == Id);
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
