var _action_url = "/payment/invoice";
var total = $('.total-page').val();
var pageSize = $('.page-size').val();
var datetimepicker_start = "";
var datetimepicker_end = "";

$(document).ready(function() {
  $('li.log-menu').addClass('menu-open');
  $('li.log-menu').addClass('active');
  $('li.menu-invoice').addClass('active');

  //Initialize Select2 Elements
  $('.select2').select2()

  $(".format-date").each(function(index) {
    if (parseInt($(this).text()) > 0) {
      var date = new Date(parseInt($(this).text()));
      $(this).text(dateFormat(date, "yyyy-mm-dd HH:MM:ss"));
    }
  });

  if ($('.value-product-type').val() != "") {
    $('#product_type').val($('.value-product-type').val()).trigger('change');
  }

  // datetime picker
  $('#pick_start_date').datepicker({
    autoclose: true,
    format: 'yyyy-mm-dd',
    orientation: 'bottom'
  });
  $('#pick_end_date').datepicker({
    autoclose: true,
    format: 'yyyy-mm-dd',
    orientation: 'bottom'
  });
  $('#pick_end_date').datepicker('update', dateFormat(new Date(), "yyyy-mm-dd"));
  var myEndDate = new Date();
  myEndDate.setDate(myEndDate.getDate()-7);
  $('#pick_start_date').datepicker('update', dateFormat(myEndDate, "yyyy-mm-dd"));

  //Timepicker
  $('.start-timepicker').timepicker({
    showInputs: false,
    minuteStep: 1,
    showSeconds: true,
    showMeridian: false,
    defaultTime: "00:00:00"
  });
  $('.end-timepicker').timepicker({
    showInputs: false,
    minuteStep: 1,
    showSeconds: true,
    showMeridian: false,
    defaultTime: dateFormat(new Date(), "HH:MM:ss")
  });

  if ($('#start_time').val() != "" && $('#end_time').val() != "") {
    var arrStart = $('#start_time').val().split(" ");
    $('#pick_start_date').val(arrStart[0]);
    $('.start-timepicker').val(arrStart[1]);
    var arrEnd = $('#end_time').val().split(" ");
    $('#pick_end_date').val(arrEnd[0]);
    $('.end-timepicker').val(arrEnd[1]);
  }

  if ($('#pick_start_date').val().length > 0 && $('#pick_end_date').val().length > 0) {
    datetimepicker_start = $('#pick_start_date').val() + " " + $('.start-timepicker').val();
    datetimepicker_end = $('#pick_end_date').val() + " " + $('.end-timepicker').val();
  }

  if (total != "" && pageSize != "") {
    if ((parseInt(total) % parseInt(pageSize)) != 0) {
      total = parseInt(parseInt(total) / parseInt(pageSize)) + 1;
    } else {
      total = parseInt(parseInt(total) / parseInt(pageSize));
    }

    if (parseInt(total) > 0) {
      $('#pagination').twbsPagination({
        initiateStartPageClick: false,
        totalPages: total,
        visiblePages: 5,
        onPageClick: function(event, page) {

          var datas = {
            "action": "search",
            "fromDate": datetimepicker_start,
            "toDate": datetimepicker_end,
            "productType": $('#product_type').val(),
            "userId": $('#user_id').val(),
            "pageNumber": page
          }

          $.ajax({
            url: _action_url,
            data: datas,
            success: function(response) {
              var result = $(response).find('#tb_result');
              $('#tb_result').replaceWith(result);

              $(".format-date").each(function(index) {
                if (parseInt($(this).text()) > 0) {
                  var date = new Date(parseInt($(this).text()));
                  $(this).text(dateFormat(date, "yyyy-mm-dd HH:MM:ss"));
                }
              });
            },
            error: function(response) {}
          });
        }
      });
    }
  }

  $(".btn-search").click(function() {
    var product_type = $('#product_type').val();
    var user_id = $('#user_id').val();

    // validate date
    if ($('#pick_start_date').val().length > 0 && $('#pick_end_date').val().length > 0) {
      datetimepicker_start = $('#pick_start_date').val() + " " + $('.start-timepicker').val();
      datetimepicker_end = $('#pick_end_date').val() + " " + $('.end-timepicker').val();
      if (Date.parse(datetimepicker_start) > Date.parse(datetimepicker_end)) {
        alert('Không hợp lệ, ngày kết thúc nhỏ hơn ngày bắt đầu');
        return false;
      }
    }

    window.location.href = _action_url + "?action=search&fromDate="
    + datetimepicker_start + "&toDate=" + datetimepicker_end + "&productType=" + product_type
    + "&userId=" + user_id;
  });

});

$(document).on('click', 'a.btn-reprocess', function() {
  var datas = {
    "action": "re_process",
    "invoiceId": $(this).data('invoiceId')
  }

  var r = confirm("Bạn muốn thực hiện reprocess");
  if (r == true) {
    $.ajax({
      url: _action_url,
      data: datas,
      success: function(response) {
        if (response.code == 0) {
          alert('Thành Công');
          window.location.href = "/payment/invoice"
        } else {
          alert(response.message);
        }
      },
      error: function(response) {}
    });
  }
});

$(document).on('click', 'a.btn-refund', function() {
  var datas = {
    "action": "refund",
    "invoiceId": $(this).data('invoiceId')
  }

  var r = confirm("Bạn muốn thực hiện refund");
  if (r == true) {
    $.ajax({
      url: _action_url,
      data: datas,
      success: function(response) {
        if (response.code == 0) {
          alert('Thành Công');
          window.location.href = "/payment/invoice"
        } else {
          alert(response.message);
        }
      },
      error: function(response) {}
    });
  }
});

$(document).on('click', 'a.btn-detail', function() {
  var datas = {
    "action": "getId",
    "invoiceId": $(this).data('invoiceId')
  }

  $.ajax({
    url: _action_url,
    data: datas,
    success: function(response) {
      if($(response).find('.btn-lg').length > 0) {
        location.reload();
      } else {
        $(".modal-body").html(response);
        $(".format-date-detail-invoice").each(function(index) {
          if (parseInt($(this).text()) > 0) {
            var date = new Date(parseInt($(this).text()));
            $(this).text(dateFormat(date, "yyyy-mm-dd HH:MM:ss"));
          }
        });
        $('#modal_edit').modal('show');
      }
    },
    error: function(response) {
    }
  });
});
