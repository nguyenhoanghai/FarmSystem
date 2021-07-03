
if (typeof GPRO == 'undefined' || !GPRO) {
    var GPRO = {};
}

GPRO.namespace = function () {
    var a = arguments,
        o = null,
        i, j, d;
    for (i = 0; i < a.length; i = i + 1) {
        d = ('' + a[i]).split('.');
        o = GPRO;
        for (j = (d[0] == 'GPRO') ? 1 : 0; j < d.length; j = j + 1) {
            o[d[j]] = o[d[j]] || {};
            o = o[d[j]];
        }
    }
    return o;
}
GPRO.namespace('Order');
GPRO.Order = function () {
    var Global = {
        UrlAction: {
            Gets: '/Order/Gets',
            Delete: '/Order/Delete',
            Save: '/Order/Save',

            _Gets: '/Order/_Gets',
            _Delete: '/Order/_Delete',
            _Save: '/Order/_Save'
        },
        Element: {
            Jtable: 'jtable',
            Popup: 'popup',
            PopupChild: '_popup', 
        },
        Data: {
            ParentId: 0
        }
    }
    this.GetGlobal = function () {
        return Global;
    }

    this.Init = function () {
        RegisterEvent();
        InitList();
        ReloadList();
        InitPopup();
        InitPopupChild(); 
        $('[re-customer],[re-material]').click();
    }

    var RegisterEvent = function () {
        $('[re-customer]').click(() => { GetCustomerSelect('customer-select'); });
        $('[re-material]').click(() => { GetMaterialSelect('material-select');});
    }

    function InitList() {
        $('#' + Global.Element.Jtable).jtable({
            title: 'Danh sách hóa đơn',
            paging: true,
            pageSize: 50,
            pageSizeChange: true,
            sorting: true,
            selectShow: false,
            actions: {
                listAction: Global.UrlAction.Gets,
                createAction: Global.Element.Popup,
            },
            messages: {
                addNewRecord: 'Thêm mới',
            },
            searchInput: {
                id: 'search-key',
                className: 'search-input',
                placeHolder: 'Nhập từ khóa ...',
                keyup: function (evt) {
                    if (evt.keyCode == 13)
                        ReloadList();
                }
            },
            datas: {
                jtableId: Global.Element.Jtable
            },
            rowInserted: function (event, data) {
                if (data.record.Id == Global.Data.ParentId) {
                    var $a = $('#' + Global.Element.Jtable).jtable('getRowByKey', data.record.Id);
                    $($a.children().find('.aaa')).click();
                }
            },
            fields: {
                Id: {
                    key: true,
                    create: false,
                    edit: false,
                    list: false
                },
                CreatedDate: {
                    title: "Ngày mua",
                    width: "7%",
                    columnClass: 'text-center',
                    display: function (data) {
                        return `<span>${ddMMyyyy(data.record.CreatedDate)}</span>`;
                    }
                },
                Code: {
                    visibility: 'fixed',
                    title: "Mã đơn",
                    width: "10%",
                },
                CustomerName: {
                    title: "Nhà cung cấp",
                    width: "10%",
                },
                Total: {
                    title: "Tổng tiền",
                    width: "7%",
                    columnClass: 'text-center',
                    display: function (data) {
                        return (`<span  >${CurrencyFormat(data.record.Total)}</span> `);
                    }
                },
                Note: {
                    title: "Ghi chú",
                    width: "53%",
                    sorting: false
                },
                actions: {
                    title: '',
                    width: "7%",
                    sorting: false,
                    columnClass: 'text-center',
                    display: function (parent) {
                        var div = $('<div></div>');
                        var $img = $('<i style="margin-right:10px" class="fa fa-list-ol clickable red aaa" title="Danh sách nghiệp vụ nhân viên: ' + parent.record.Name + '"></i>');
                        $img.click(function () {
                            Global.Data.ParentId = parent.record.Id;
                            $('#' + Global.Element.Jtable).jtable('openChildTable',
                                $img.closest('tr'),
                                {
                                    title: `<div>Chi tiết của <span class="red">${parent.record.Code}</span></div>`,
                                    paging: true,
                                    pageSize: 20,
                                    pageSizeChange: true,
                                    sorting: true,
                                    selectShow: true,
                                    actions: {
                                        listAction: Global.UrlAction._Gets + '?parentId=' + parent.record.Id,
                                        createAction: Global.Element.PopupChild,
                                    },
                                    messages: {
                                        addNewRecord: 'Thêm vật tư',
                                        selectShow: 'Ẩn hiện cột'
                                    },
                                    fields: {
                                        OrderId: {
                                            type: 'hidden',
                                            defaultValue: parent.record.Id
                                        },
                                        Id: {
                                            key: true,
                                            create: false,
                                            edit: false,
                                            list: false
                                        },
                                        MaterialName: {
                                            title: "Vật tư",
                                            width: "30%",
                                        },
                                        Quantity: {
                                            title: "Số lượng",
                                            width: "7%",
                                            columnClass: 'text-center'
                                        },
                                        Price: {
                                            title: "Đơn giá",
                                            width: "7%",
                                            columnClass: 'text-center',
                                            display: function (data) {
                                                return `<span>${CurrencyFormat(data.record.Price)}</span>`;
                                            }
                                        },
                                        Total: {
                                            title: "Thành tiền",
                                            width: "10%",
                                            columnClass: 'text-center',
                                            sorting: false,
                                            display: function (data) {
                                                return `<span>${CurrencyFormat(data.record.Price * data.record.Quantity)}</span>`;
                                            }
                                        },
                                        Note: {
                                            title: "Ghi chú",
                                            width: "30%",
                                        },
                                        actions: {
                                            title: '',
                                            width: '5%',
                                            sorting: false,
                                            columnClass: 'text-center',
                                            display: function (data) {
                                                var div = $('<div></div>');

                                                var btnEdit = $('<i data-toggle="modal" data-target="#' + Global.Element.PopupChild + '" title="Chỉnh sửa thông tin" class="fa fa-pencil-square-o clickable blue"  ></i>');
                                                btnEdit.click(function () {
                                                    $('#id-c').val(data.record.Id);
                                                    $('#material-select').val(data.record.VatTuId);
                                                    $('#price').val(data.record.Price);
                                                    $('#quantity').val(data.record.Quantity); 
                                                    $('#note-c').val(data.record.Note); 
                                                });
                                                div.append(btnEdit)

                                                var btnDelete = $('<i title="Xóa" class="fa fa-trash-o clickable red i-delete"></i>');
                                                btnDelete.click(function () {
                                                    GlobalCommon.ShowConfirmDialog('Bạn có chắc chắn muốn xóa?', function () {
                                                        DeleteChild(data.record.Id);
                                                    }, function () { }, 'Đồng ý', 'Hủy bỏ', 'Thông báo');
                                                });
                                                div.append(btnDelete);
                                                return div;
                                            }
                                        },
                                    }
                                }, function (data) { //opened handler
                                    data.childTable.jtable('load');
                                });
                        });
                        div.append($img)

                        var btnEdit = $('<i data-toggle="modal" data-target="#' + Global.Element.Popup + '" title="Chỉnh sửa" class="fa fa-pencil-square-o clickable blue"  ></i>');
                        btnEdit.click(function () {
                            $('#id').val(parent.record.Id);
                            $('#code').val(parent.record.Code);
                            $('#customer-select').val(parent.record.CustomerId);
                            $('#note').val(parent.record.Note);
                            $('#order-date').val(ddMMyyyy(parent.record.CreatedDate));
                        });
                        div.append(btnEdit);

                        var btnDelete = $('<i title="Xóa" class="fa fa-trash red i-delete clickable"></i>');
                        btnDelete.click(function () {
                            GlobalCommon.ShowConfirmDialog('Bạn có chắc chắn muốn xóa?', function () {
                                Delete(parent.record.Id);
                            }, function () { }, 'Đồng ý', 'Hủy bỏ', 'Thông báo');
                        });
                        div.append(btnDelete);
                        return div;
                    }
                }
            }
        });
    }

    function ReloadList() {
        $('#' + Global.Element.Jtable).jtable('load', { 'keyword': $('#search-key').val() });
    }

    //#region
    function Delete(Id) {
        $.ajax({
            url: Global.UrlAction.Delete,
            type: 'POST',
            data: JSON.stringify({ 'Id': Id }),
            contentType: 'application/json charset=utf-8',
            beforeSend: function () { $('#loading').show(); },
            success: function (data) {
                GlobalCommon.CallbackProcess(data, function () {
                    if (data.Result == "OK") {
                        ReloadList();
                        $('#loading').hide();
                    }
                }, false, Global.Element.PopupNhanVien, true, true, function () {

                    var msg = GlobalCommon.GetErrorMessage(data);
                    GlobalCommon.ShowMessageDialog(msg, function () { }, "Đã có lỗi xảy ra.");
                });
            }
        });
    }

    function Save() {
        var obj = {
            Id: $('#id').val(),
            Code: $('#code').val(),
            Total: 0,
            Note: $('#note').val(),
            CreatedDate: $('#order-date').val(),
            CustomerId: $('#customer-select').val()
        }
        $.ajax({
            url: Global.UrlAction.Save,
            type: 'post',
            data: JSON.stringify(obj),
            contentType: 'application/json',
            beforeSend: function () { $('#loading').show(); },
            success: function (result) {
                $('#loading').hide();
                GlobalCommon.CallbackProcess(result, function () {
                    if (result.Result == "OK") {
                        ReloadList();
                        $("#" + Global.Element.Popup + ' button[cancel]').click();
                    }
                    else
                        GlobalCommon.ShowMessageDialog(msg, function () { }, "Đã có lỗi xảy ra trong quá trình sử lý.");
                }, false, Global.Element.PopupModule, true, true, function () {
                    var msg = GlobalCommon.GetErrorMessage(result);
                    GlobalCommon.ShowMessageDialog(msg, function () { }, "Đã có lỗi xảy ra trong quá trình sử lý.");
                });
            }
        });
    }

    function InitPopup() {
        $("#" + Global.Element.Popup).modal({
            keyboard: false,
            show: false
        });
        $("#" + Global.Element.Popup + ' button[save]').click(function () {
            if (CheckValidate())
                Save();
        });

        $("#" + Global.Element.Popup + ' button[cancel]').click(function () {
            $("#" + Global.Element.Popup).modal("hide");
            $('#id').val(0);
            $('#code').val('');
            $('#note').val('');
            $('#order-date').val(moment().format('DD/MM/YYYY'));
            $('#customer-select').val(0);
        });
    }

    function CheckValidate() {
        if ($('#order-date').val().trim() == "") {
            GlobalCommon.ShowMessageDialog("Vui lòng chọn ngày.", function () { $('#order-date').focus() }, "Lỗi Nhập liệu");
            return false;
        }
        else if ($('#code').val().trim() == "") {
            GlobalCommon.ShowMessageDialog("Vui lòng nhập mã hóa đơn.", function () { $('#code').focus() }, "Lỗi Nhập liệu");
            return false;
        }
        else if ($('#customer-select').val().trim() == "") {
            GlobalCommon.ShowMessageDialog("Vui lòng chọn khách hàng.", function () { $('#code').focus() }, "Lỗi Nhập liệu");
            return false;
        }
        else
            return true;
    }
    //#endregion

    //#region

    function SaveChild() {
        var obj = {
            Id: $('#id-c').val(),
            VatTuId: $('#material-select').val(),
            Price: $('#price').val(),
            Quantity: $('#quantity').val(),
            Note: $('#note-c').val(),
            HoaDonId: Global.Data.ParentId
        }
        $.ajax({
            url: Global.UrlAction._Save,
            type: 'post',
            data: JSON.stringify(obj),
            contentType: 'application/json',
            beforeSend: function () { $('#loading').show(); },
            success: function (result) {
                $('#loading').hide();
                GlobalCommon.CallbackProcess(result, function () {
                    if (result.Result == "OK") {
                        ReloadList();
                        $("#" + Global.Element.PopupChild + ' button[cancel]').click();
                    }
                    else
                        GlobalCommon.ShowMessageDialog(msg, function () { }, "Đã có lỗi xảy ra trong quá trình sử lý.");
                }, false, Global.Element.PopupModule, true, true, function () {
                    var msg = GlobalCommon.GetErrorMessage(result);
                    GlobalCommon.ShowMessageDialog(msg, function () { }, "Đã có lỗi xảy ra trong quá trình sử lý.");
                });
            }
        });
    }

    function InitPopupChild() {
        $("#" + Global.Element.PopupChild).modal({
            keyboard: false,
            show: false
        });
        $("#" + Global.Element.PopupChild + ' button[save]').click(function () {
            if (CheckValidateChild())
                SaveChild();
        });

        $("#" + Global.Element.PopupChild + ' button[cancel]').click(function () {
            $("#" + Global.Element.PopupChild).modal("hide");
            $('#id-c').val(0);
            $('#material-select').val('');
            $('#price').val(0);
            $('#quantity').val(0);
            $('#note-c').val(0);
        });
    }

    function CheckValidateChild() {
        if ($('#material-select').val().trim() == "") {
            GlobalCommon.ShowMessageDialog("Vui lòng chọn vật tư.", function () { $('#material-select').focus() }, "Lỗi Nhập liệu");
            return false;
        }
        else if ($('#price').val().trim() == "") {
            GlobalCommon.ShowMessageDialog("Vui lòng chọn nhập đơn giá.", function () { $('#price').focus() }, "Lỗi Nhập liệu");
            return false;
        }
        else if ($('#quantity').val().trim() == "") {
            GlobalCommon.ShowMessageDialog("Vui lòng chọn nhập số lượng.", function () { $('#quantity').focus() }, "Lỗi Nhập liệu");
            return false;
        }
        else
            return true;
    }

    function DeleteChild(Id) {
        $.ajax({
            url: Global.UrlAction._Delete,
            type: 'POST',
            data: JSON.stringify({ 'Id': Id }),
            contentType: 'application/json charset=utf-8',
            beforeSend: function () { $('#loading').show(); },
            success: function (data) {
                GlobalCommon.CallbackProcess(data, function () {
                    if (data.Result == "OK") {
                        ReloadList();
                        $('#loading').hide();
                    }
                }, false, Global.Element.PopupNhanVien, true, true, function () {

                    var msg = GlobalCommon.GetErrorMessage(data);
                    GlobalCommon.ShowMessageDialog(msg, function () { }, "Đã có lỗi xảy ra.");
                });
            }
        });
    }

    //#endregion
}
$(document).ready(function () {
    var obj = new GPRO.Order();
    obj.Init();
})