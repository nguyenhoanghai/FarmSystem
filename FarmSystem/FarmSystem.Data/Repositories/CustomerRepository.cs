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
    public class CustomerRepository
    {
        #region constructor
        FarmSystemEntities db;
        static object key = new object();
        private static volatile CustomerRepository _Instance;
        public static CustomerRepository Instance
        {
            get
            {
                if (_Instance == null)
                    lock (key)
                        _Instance = new CustomerRepository();

                return _Instance;
            }
        }
        private CustomerRepository() { }
        #endregion

        public List<ModelSelectItem> GetSelectItem(string connectString)
        {
            try
            {
                using (db = new FarmSystemEntities(connectString))
                {
                    var listModelSelect = new List<ModelSelectItem>();
                    var productTypes = db.KhachHangs.Where(x => !x.IsDeleted).Select(
                        x => new ModelSelectItem()
                        {
                            Value = x.Id,
                            Name = x.Name,
                            Code = x.Code,
                        }).ToList();

                    if (productTypes != null && productTypes.Count() > 0)
                    {
                        // listModelSelect.Add(new ModelSelectItem() { Value = 0, Name = " - -  Chọn Đơn vị  - - " });
                        listModelSelect.AddRange(productTypes);
                    }
                    else
                        listModelSelect.Add(new ModelSelectItem() { Value = 0, Name = " -- Không có khách hàng -- " });
                    return listModelSelect;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public ResponseBase InsertOrUpdate(string connectString, CustomerModel model)
        {
            try
            {
                var result = new ResponseBase();
                using (db = new FarmSystemEntities(connectString))
                {
                    KhachHang obj = db.KhachHangs.FirstOrDefault(x => x.Id != model.Id && x.Name.Trim().ToUpper().Equals(model.Name.Trim().ToUpper()));
                    if (obj != null)
                    {
                        result.IsSuccess = false;
                        result.Errors.Add(new Error() { MemberName = "Insert ", Message = "Tên khách hàng này đã tồn tại. Vui lòng chọn lại Tên khác !." });
                        return result;
                    }
                    else
                    {
                        if (model.Id == 0)
                        {
                            var now = DateTime.Now;
                            obj = new KhachHang();
                            Parse.CopyObject(model, ref obj);
                            obj.Code = now.ToString("ddMMyyyy-hhmmss");
                            obj.CreatedDate = now;
                            db.KhachHangs.Add(obj);
                            db.SaveChanges();
                            result.IsSuccess = true;
                        }
                        else
                        {
                            obj = db.KhachHangs.FirstOrDefault(x => !x.IsDeleted && x.Id == model.Id);
                            if (obj == null)
                            {
                                result.IsSuccess = false;
                                result.Errors.Add(new Error() { MemberName = "Update ", Message = "khách hàng bạn đang thao tác đã bị xóa hoặc không tồn tại. Vui lòng kiểm tra lại !." });
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
                                obj.Address = model.Address;
                                obj.Phone = model.Phone;
                                obj.TaxCode = model.TaxCode;
                                obj.Email = model.Email;
                                obj.BankAccount = model.BankAccount;
                                obj.Note = model.Note;
                                obj.Telephone = model.Telephone;
                                obj.Type = model.Type;
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

        public PagedList<CustomerModel> Gets(string connectString, string keyWord, int startIndexRecord, int pageSize, string sorting)
        {
            try
            {
                using (db = new FarmSystemEntities(connectString))
                {
                    if (string.IsNullOrEmpty(sorting))
                        sorting = "CreatedDate DESC";
                    IQueryable<KhachHang> objs = null;
                    var pageNumber = (startIndexRecord / pageSize) + 1;
                    if (!string.IsNullOrEmpty(keyWord))
                        objs = db.KhachHangs.Where(x => !x.IsDeleted &&
                         (x.Name.Trim().ToUpper().Contains(keyWord.Trim().ToUpper()) ||
                          x.Code.Trim().ToUpper().Contains(keyWord.Trim().ToUpper())));
                    else
                        objs = db.KhachHangs.Where(x => !x.IsDeleted);
                    return new PagedList<CustomerModel>(objs
                      .OrderBy(sorting)
                      .Select(x => new CustomerModel()
                      {
                          Id = x.Id,
                          Code =x.Code,
                          Name = x.Name,
                          Address = x.Address,
                          Phone = x.Phone,
                          TaxCode = x.TaxCode,
                          Email = x.Email,
                          BankAccount = x.BankAccount,
                          Note = x.Note,
                          Telephone = x.Telephone,
                          Type = x.Type,
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
                var obj = db.KhachHangs.FirstOrDefault(x => !x.IsDeleted && x.Id == Id);
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
