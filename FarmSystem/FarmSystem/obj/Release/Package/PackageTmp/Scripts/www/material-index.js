
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
GPRO.namespace('Material');
GPRO.Material = function () {
    var Global = {
        UrlAction: {
            Gets: '/Material/Gets',
            Delete: '/Material/Delete',
            Save: '/Material/Save'
        },
        Element: {
            Jtable: 'jtable',
            Popup: 'popup'
        },
        Data: {
            Id: 0
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
    }

    var RegisterEvent = function () {

        $('#p-file-upload').change(function () {
            readURL(this, 'img-avatar');
        });

        $('#p-btn-file-upload').click(function () {
            $('#p-file-upload').click();
        });

        // Register event after upload file done the value of [filelist] will be change => call function save your Data 
        $('#p-file-upload').select(function () {
            Save();
        });
    }

    function InitList() {
        $('#' + Global.Element.Jtable).jtable({
            title: 'Danh sách vật tư',
            paging: true,
            pageSize: 50,
            pageSizeChange: true,
            sorting: true,
            selectShow: true,
            actions: {
                listAction: Global.UrlAction.Gets,
                createAction: Global.Element.Popup
            },
            messages: {
                addNewRecord: 'Thêm mới',
                selectShow: 'Ẩn hiện cột'
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
            fields: {
                Id: {
                    key: true,
                    create: false,
                    edit: false,
                    list: false
                }, 
                Image: {
                    title: " ",
                    width: "7%",
                    columnClass: 'text-center',
                    sorting: false,
                    display: function (data) {
                        var txt;
                        if (data.record.Image != null)
                            txt = `<span><img src="/Upload/${data.record.Image}" width="40px" height="40px"/></span>`;
                        else
                            txt = '<span>' + " " + '</span>';
                        return txt;
                    }
                },
                Ten: {
                    title: "Tên vật tư",
                    width: "10%",
                },
                CongDung: {
                    title: "Công dụng",
                    width: "10%",
                },
                CachDung: {
                    title: "HD sử dụng",
                    width: "10%",
                },
                DonGia: {
                    title: "Đơn giá",
                    width: "5%",
                    columnClass: 'text-center',
                },
                DanhGia: {
                    title: "Đánh giá",
                    width: "5%",
                    columnClass: 'text-center',
                    //display: function (data) {

                    //}
                }, 
                actions: {
                    title: '',
                    width: '5%',
                    sorting: false,
                    columnClass: 'text-center',
                    display: function (data) {
                        var div = $('<div></div>');
                        var btnEdit = $('<i data-toggle="modal" data-target="#' + Global.Element.Popup + '" title="Chỉnh sửa thông tin" class="fa fa-pencil-square-o clickable text-blue"  ></i>');
                        btnEdit.click(function () { 
                            $('#id').val(data.record.Id);
                            $('#name').val(data.record.Ten);
                            $('#cong-dung').val(data.record.CongDung);
                            $('#cach-dung').val(data.record.CachDung);
                            $('#danh-gia').val(data.record.DanhGia);
                            $('#don-gia').val(data.record.DonGia); 
                            if (data.record.Image)
                                $('.img-avatar').attr('src', `/Upload/${data.record.Image}`);
                        });
                        div.append(btnEdit);

                        var btnDelete = $('<i title="Xóa" class="fa fa-trash-o red clickable i-delete"></i>');
                        btnDelete.click(function () {
                            GlobalCommon.ShowConfirmDialog('Bạn có chắc chắn muốn xóa?', function () {
                                Delete(data.record.Id);
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
            Ten: $('#name').val(),
            CongDung: $('#cong-dung').val(),
            CachDung: $('#cach-dung').val(),
            DanhGia: $('#danh-gia').val(),
            DonGia: parseFloat($('#don-gia').val()),
            Picture: $('#p-file-upload').attr('newurl')
        };
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
                if ($('#p-file-upload').val() != '')
                    UploadPicture("p-file-upload", 'p-file-upload');
                else {
                    Save();
                }
        });

        $("#" + Global.Element.Popup + ' button[cancel]').click(function () {
            $("#" + Global.Element.Popup).modal("hide");
            $('#id').val(0);
            $('#name').val('');
            $('#cong-dung').val('');
            $('#cach-dung').val('');
            $('#danh-gia').val('');
            $('#don-gia').val(0);
            $('.img-avatar').attr('src', '/Upload/no-image.png');
            $('#p-file-upload').attr('newurl', '');
            $('#p-file-upload').val('');
        });
    }

    function CheckValidate() {
        if ($('#name').val().trim() == "") {
            GlobalCommon.ShowMessageDialog("Vui lòng nhập tên công việc.", function () { $('#name').focus() }, "Lỗi Nhập liệu");
            return false;
        }
        else
            return true;
    }

}
$(document).ready(function () {
    var obj = new GPRO.Material();
    obj.Init();
})