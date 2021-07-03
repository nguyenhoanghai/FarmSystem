readURL = (fileInput, imageTag) => {
    if (fileInput.files && fileInput.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $('#' + imageTag).attr('src', e.target.result);
        }
        reader.readAsDataURL(fileInput.files[0]); // convert to base64 string
    }
}

UploadPicture = (controlId, returnId) => {
    if (window.FormData !== undefined) {
        var fileUpload = $('#' + controlId).get(0);
        var files = fileUpload.files;
        var fileData = new FormData();
        for (var i = 0; i < files.length; i++) {
            fileData.append(files[i].name, files[i]);
        }
        $.ajax({
            url: '/Upload/UploadFile',
            type: "POST",
            data: fileData,
            contentType: false, // Not to set any content header  
            processData: false, // Not to process data  
            success: function (result) {
                $('#' + returnId).attr("newUrl", result);
                $('#' + returnId).select();
            },
            error: function (err) {
                alert("Lỗi up hình : " + err.statusText);
            }
        });
    }
    else {
        alert("FormData is not supported.");
    }
}

UploadVideo = (controlId, returnId) => {
    if (window.FormData !== undefined) {
        var fileUpload = $('#' + controlId).get(0);
        var files = fileUpload.files;
        var fileData = new FormData();
        for (var i = 0; i < files.length; i++) {
            fileData.append(files[i].name, files[i]);
        }

        $.ajax({
            url: '/Upload/UploadVideo',
            type: "POST",
            data: fileData,
            contentType: false, // Not to set any content header  
            processData: false, // Not to process data  
            success: function (result) {
                $('#' + returnId).attr("newUrl", result);
                $('#' + returnId).select();
            },
            error: function (err) {
                alert("Lỗi up hình : " + err.statusText);
            }
        });
    }
    else {
        alert("FormData is not supported.");
    }
}

DeleteFile = (fileName, typeOfFile) => {
    $.ajax({
        url: '/Upload/DeleteFile',
        type: "POST",
        data: JSON.stringify({ 'filename': fileName, type: typeOfFile }),
        contentType: 'application/json charset=utf-8',
    });
}

ddMMyyyy = (strDate) => {
    var date = moment(strDate);
    return date.format('DD/MM/YYYY');
}

GetWorkSelect = (controlName) => {
    $.ajax({
        url: '/work/GetSelectList',
        type: 'POST',
        data: '',
        contentType: 'application/json charset=utf-8',
        success: function (data) {
            if (data.Result == "OK") {
                var str = '<option value="">Không có dữ liệu</option>';
                if (data.Data.length > 0) {
                    str = '';
                    $.each(data.Data, function (index, item) {
                        str += '<option value="' + item.Value + '" >' + item.Name + '</option>';
                    });
                }
                $('#' + controlName).empty().append(str);
                $('#' + controlName).change();
            }
            else
                alert("Đã có lỗi xảy ra trong quá trình sử lý.");
        }
    });
}

GetMaterialSelect = (controlName) => {
    $.ajax({
        url: '/material/GetSelectList',
        type: 'POST',
        data: '',
        contentType: 'application/json charset=utf-8',
        success: function (data) {
            if (data.Result == "OK") {
                var str = '<option value="">Không có dữ liệu</option>';
                if (data.Data.length > 0) {
                    str = '';
                    $.each(data.Data, function (index, item) {
                        str += '<option value="' + item.Value + '" >' + item.Name + '</option>';
                    });
                }
                $('#' + controlName).empty().append(str);
                $('#' + controlName).change();
            }
            else
                alert("Đã có lỗi xảy ra trong quá trình sử lý.");
        }
    });
}

GetCustomerSelect = (controlName) => {
    $.ajax({
        url: '/customer/GetSelectList',
        type: 'POST',
        data: '',
        contentType: 'application/json charset=utf-8',
        success: function (data) {
            if (data.Result == "OK") {
                var str = '<option value="">Không có dữ liệu</option>';
                if (data.Data.length > 0) {
                    str = '';
                    $.each(data.Data, function (index, item) {
                        str += '<option value="' + item.Value + '" >' + item.Name + '</option>';
                    });
                }
                $('#' + controlName).empty().append(str);
                $('#' + controlName).change();
            }
            else
                alert("Đã có lỗi xảy ra trong quá trình sử lý.");
        }
    });
}


CurrencyFormat = (value) => {
    if (value)
        return value.toFixed(1).replace(/(\d)(?=(\d{3})+\.)/g, "$1,");
    return '';
}