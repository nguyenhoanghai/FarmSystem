
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
GPRO.namespace('WorkHistory');
GPRO.WorkHistory = function () {
    var Global = {
        UrlAction: {
            Gets: '/WorkHistories/Gets',
            Delete: '/WorkHistories/Delete',
            Save: '/WorkHistories/Save'
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
        $('[re-work]').click();
    }

    var RegisterEvent = function () {
        $('[re-work]').click(() => { GetWorkSelect('work-select'); });
    }

    function InitList() {
        $('#' + Global.Element.Jtable).jtable({
            title: 'Lịch sử làm việc',
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
                CreatedDate: {
                    title: "Ngày làm",
                    width: "7%",
                    columnClass: 'text-center',
                    display: function (data) {
                        return `<span>${ddMMyyyy(data.record.CreatedDate)}</span>`;
                    }
                },
                WorkName: {
                    title: "Công việc",
                    width: "20%",
                },

                Note: {
                    title: "Ghi chú",
                    width: "50%",
                    sorting: false
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
                            $('#work-select').val(data.record.CVId);
                            $('#note').val(data.record.Note);
                            $('#work-date').val(ddMMyyyy(data.record.CreatedDate));
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
            CVId: $('#work-select').val(),
            Note: $('#note').val(),
            CreatedDate: $('#work-date').val()
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
                Save();
        });

        $("#" + Global.Element.Popup + ' button[cancel]').click(function () {
            $("#" + Global.Element.Popup).modal("hide");
            $('#id').val(0);
            $('#work-select').val(0);
            $('#note').val('');
            $('#work-date').val(moment().format('DD/MM/YYYY'));
        });
    }

    function CheckValidate() {
        if ($('#work-date').val().trim() == "") {
            GlobalCommon.ShowMessageDialog("Vui lòng chọn ngày làm việc.", function () { $('#name').focus() }, "Lỗi Nhập liệu");
            return false;
        }
        else if ($('#work-select').val().trim() == "") {
            GlobalCommon.ShowMessageDialog("Vui lòng chọn công việc.", function () { $('#name').focus() }, "Lỗi Nhập liệu");
            return false;
        }
        else
            return true;
    }

}
$(document).ready(function () {
    var obj = new GPRO.WorkHistory();
    obj.Init();
})