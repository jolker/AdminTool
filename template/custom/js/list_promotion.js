var _action_url = "/payment/promotion";
var total = $('.total-page').val();
var pageSize = $('.page-size').val();
var datetimepicker_start = "";
var datetimepicker_end = "";

$(document).ready(function() {
  $('li.log-menu').addClass('menu-open');
  $('li.log-menu').addClass('active');
  $('li.menu-promotion').addClass('active');

  //Initialize Select2 Elements
  $('.select2').select2()

  $(".format-date").each(function(index) {
    if (parseInt($(this).text()) > 0) {
      var date = new Date(parseInt($(this).text()));
      $(this).text(dateFormat(date, "yyyy-mm-dd HH:MM:ss"));
    }
  });

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
    // validate date
    if ($('#pick_start_date').val().length > 0 && $('#pick_end_date').val().length > 0) {
      datetimepicker_start = $('#pick_start_date').val() + " " + $('.start-timepicker').val();
      datetimepicker_end = $('#pick_end_date').val() + " " + $('.end-timepicker').val();
      if (Date.parse(datetimepicker_start) > Date.parse(datetimepicker_end)) {
        alert('Không hợp lệ, ngày kết thúc nhỏ hơn ngày bắt đầu');
        return false;
      }
    }

    window.location.href = _action_url + "?action=search&fromDate=" + datetimepicker_start + "&toDate=" + datetimepicker_end;
  });

});

$(document).on('click', 'a.btn-add-page', function() {
  var datas = {
    "action": "add_page"
  }

  $.ajax({
    url: _action_url,
    data: datas,
    success: function(response) {
      if($(response).find('.btn-lg').length > 0) {
        location.reload();
      } else {
        $(".modal-content").html(response);
        $('#modal_promotion').modal('show');
      }
    },
    error: function(response) {}
  });
});

$(document).on('click', 'a.btn-detail', function() {
  var datas = {
    "action": "getId",
    "promotionId": $(this).data('promoId')
  }

  $.ajax({
    url: _action_url,
    data: datas,
    success: function(response) {
      if($(response).find('.btn-lg').length > 0) {
        location.reload();
      } else {
        $(".modal-content").html(response);
        $('#modal_promotion').modal('show');
      }
    },
    error: function(response) {}
  });
});
