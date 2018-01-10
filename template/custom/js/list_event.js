var _action_url = "/eventv3";
var total = $('.total-page').val();
var pageSize = $('.page-size').val();
var datetimepicker_start = "";
var datetimepicker_end = "";

$(document).ready(function() {
  //Initialize Select2 Elements
  $('.select2').select2();
  $(".format-date").each(function(index) {
       if (parseInt($(this).text()) > 0) {
  var date = new Date(parseInt($(this).text()));
  var dd = date.getDate();
  var MM = date.getMonth()+1; //January is 0!
  var hh = date.getHours();
  var mm =date.getMinutes();
  var ss =date.getSeconds();
  var yyyy= date.getFullYear();
  if(dd<10){
    dd='0'+dd;
  }
  if(MM<10){
    MM='0'+MM;
  }
  if(hh<10){
    hh='0'+hh;
  }
  if(mm<10){
    mm='0'+mm;
  }
  if(ss<10){
    ss='0'+ss;
  }
    var formattedStartDate = yyyy+ "-" + MM + "-" + dd + " " + hh + ":" + mm + ":" + ss;
   $(this).text(formattedStartDate);
       }
       });


$('li.log-menu').removeClass('menu-open');
$('li.log-menu').removeClass('active');
$('li.log-cg-menu').removeClass('active');
$('li.menu-eventv3').addClass('active');

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
  defaultTime: "00:00:00"
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
              var decimal = "";
              $(".format-decimal").each(function(index) {
                if (parseInt($(this).text()) > 0) {
                  decimal = (parseInt($(this).text()) + "").replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,");
                  $(this).text(decimal);
                }
              });
              $(".format-date").each(function(index) {
                   if (parseInt($(this).text()) > 0) {
              var date = new Date(parseInt($(this).text()));
              var dd = date.getDate();
              var MM = date.getMonth()+1; //January is 0!
              var hh = date.getHours();
              var mm =date.getMinutes();
              var ss =date.getSeconds();
              var yyyy= date.getFullYear();
              if(dd<10){
                dd='0'+dd;
              }
              if(MM<10){
                MM='0'+MM;
              }
              if(hh<10){
                hh='0'+hh;
              }
              if(mm<10){
                mm='0'+mm;
              }
              if(ss<10){
                ss='0'+ss;
              }
                var formattedStartDate = yyyy+ "-" + MM + "-" + dd + " " + hh + ":" + mm + ":" + ss;
               $(this).text(formattedStartDate);
                   }
                   });

            },
            error: function(response) {

            }
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
        alert('To date cannot be less than from date');
        return false;
      }
    }

    window.location.href = _action_url + "?action=search&fromDate="
    + datetimepicker_start + "&toDate=" + datetimepicker_end;
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
          $('#modal_event').modal('show');
        }
      },
      error: function(response) {}
    });
  });


});
$(document).on('click', 'a.btn-detail', function() {
  var datas = {
    "action": "getId",
    "eventId": $(this).data('eventId')
  }

  $.ajax({
    url: _action_url,
    data: datas,
    success: function(response) {
      if($(response).find('.btn-lg').length > 0) {
        location.reload();
      } else {
        $(".modal-content").html(response);
        $('#modal_event').modal('show');
      }
    },
    error: function(response) {}
  });
});
