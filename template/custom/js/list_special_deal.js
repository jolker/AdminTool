var _action_url = "/payment/special-deal";
var total = $('.total-page').val();
var pageSize = $('.page-size').val();

$(document).ready(function () {

    $(".format-date").each(function (index) {
        if (parseInt($(this).text()) > 0) {
            var date = new Date(parseInt($(this).text()));
            var dd = date.getDate();
            var MM = date.getMonth() + 1; //January is 0!
            var hh = date.getHours();
            var mm = date.getMinutes();
            var ss = date.getSeconds();
            var yyyy = date.getFullYear();
            if (dd < 10) {
                dd = '0' + dd;
            }
            if (MM < 10) {
                MM = '0' + MM;
            }
            if (hh < 10) {
                hh = '0' + hh;
            }
            if (mm < 10) {
                mm = '0' + mm;
            }
            if (ss < 10) {
                ss = '0' + ss;
            }
            var formattedStartDate = yyyy + "-" + MM + "-" + dd + " " + hh + ":" + mm + ":" + ss;
            $(this).text(formattedStartDate);
        }
    });


    // $("#datepicker").datepicker();
    $('li.log-menu').addClass('menu-open');
    $('li.log-menu').addClass('active');
    $('li.menu-special-deal').addClass('active');
      // $('.select2').select2();
    // $('#fromDate').datepicker({
    //     dateFormat: 'yy-mm-dd',
    //     onSelect: function (dateStr) {
    //         var date = $(this).datepicker('getDate');
    //         if (date) {
    //             date.setDate(date.getDate());
    //         }
    //         $('#endDate').datepicker('option', 'minDate', date);
    //         var day1 = $(this).datepicker('getDate').getDate();
    //         var month1 = $(this).datepicker('getDate').getMonth() + 1;
    //         var year1 = $(this).datepicker('getDate').getFullYear();
    //         var strDate = year1 + "-" + month1 + "-" + day1 + " " + "00:00:00";
    //         $(this).val(strDate);
    //     }
    // });
    // $('#toDate').datepicker({
    //     dateFormat: 'yy-mm-dd',
    //     onSelect: function (selectedDate) {
    //         var date = $(this).datepicker('getDate');
    //         if (date) {
    //             date.setDate(date.getDate());
    //         }
    //         $('#startDate').datepicker('option', 'maxDate', date || 0);
    //         var day1 = $(this).datepicker('getDate').getDate();
    //         var month1 = $(this).datepicker('getDate').getMonth() + 1;
    //         var year1 = $(this).datepicker('getDate').getFullYear();
    //         var strDate = year1 + "-" + month1 + "-" + day1 + " " + "00:00:00";
    //         $(this).val(strDate);
    //
    //     }
    // });
    if ($("#user_id").val() ==0) {
        $("#user_id").val("");
    }
    if ($('.value-status-type').val() != "") {
      $('#status').val($('.value-status-type').val()).trigger('change');
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
                onPageClick: function (event, page) {
                    var datas = {
                        "action": "search",
                        "userId": $('#user_id').val(),
                        "status": $('#status').val(),
                        "fromDate": datetimepicker_start,
                        "toDate": datetimepicker_end,
                        "pageNumber": page
                    }
                    if($('#user_id').val()==""||$('#user_id').val()==0){
                    delete datas["userId"];
                  }if($('#status').val()==""){
                    delete datas["status"];
                    }
                    $.ajax({
                        url: _action_url,
                        data: datas,
                        success: function (response) {
                            var result = $(response).find('#tb_result');
                            $('#tb_result').replaceWith(result);
                            var decimal = "";
                            $(".format-decimal").each(function (index) {
                                if (parseInt($(this).text()) > 0) {
                                    decimal = (parseInt($(this).text()) + "").replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,");
                                    $(this).text(decimal);
                                }
                            });
                            $(".format-date").each(function (index) {
                                if (parseInt($(this).text()) > 0) {
                                    var date = new Date(parseInt($(this).text()));
                                    var dd = date.getDate();
                                    var MM = date.getMonth() + 1; //January is 0!
                                    var hh = date.getHours();
                                    var mm = date.getMinutes();
                                    var ss = date.getSeconds();
                                    var yyyy = date.getFullYear();
                                    if (dd < 10) {
                                        dd = '0' + dd;
                                    }
                                    if (MM < 10) {
                                        MM = '0' + MM;
                                    }
                                    if (hh < 10) {
                                        hh = '0' + hh;
                                    }
                                    if (mm < 10) {
                                        mm = '0' + mm;
                                    }
                                    if (ss < 10) {
                                        ss = '0' + ss;
                                    }
                                    var formattedDate = yyyy + "-" + MM + "-" + dd + " " + hh + ":" + mm + ":" + ss;
                                    $(this).text(formattedDate);
                                }
                            });

                        },
                        error: function (response) {

                        }
                    });
                }
            });
        }
    }

    $("#user_id").on("click", function () {
        $("#status").val("ALL");
    });
    $("#status").on("click", function () {
        $("#user_id").val("");
    });

    $(".btn-search").click(function() {
      var status = $('#status').val();
      var user_id = $('#user_id').val();

      // validate date
      if ($('#pick_start_date').val().length > 0 && $('#pick_end_date').val().length > 0) {
        datetimepicker_start = $('#pick_start_date').val() + " " + $('.start-timepicker').val();
        datetimepicker_end = $('#pick_end_date').val() + " " + $('.end-timepicker').val();
        if (Date.parse(datetimepicker_start) > Date.parse(datetimepicker_end)) {
          alert('To date cannot be less than from date');
          return false;
        }
      }
      var url=_action_url + "?action=search&fromDate="
      + datetimepicker_start + "&toDate=" + datetimepicker_end;
      if(user_id!=""){
        url=url+"&userId=" + user_id;
      }
      if(status!=""){
        url=url+"&status=" + status;
      }
      window.location.href = url;
    });

//handle add
    $("[name='eventStatus']").bootstrapSwitch('state', true);
    $('#datetimepicker1').datetimepicker({
        autoclose: true,
        format: "yyyy-mm-dd hh:ii:00",
    });
    $('#datetimepicker2').datetimepicker({
        autoclose: true,
        format: "yyyy-mm-dd hh:ii:00"
    });
    $('#datetimepicker2').datetimepicker({
        useCurrent: false //Important! See issue #1075
    });
    $("#datetimepicker1").on("dp.change", function (e) {
        $('#datetimepicker2').data("DateTimePicker").minDate(e.date);
    });
    $("#datetimepicker2").on("dp.change", function (e) {
        $('#datetimepicker1').data("DateTimePicker").maxDate(e.date);
    });

    //Get Date
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth() + 1; //January is 0!

    var yyyy = today.getFullYear();
    if (dd < 10) {
        dd = '0' + dd;
    }
    if (mm < 10) {
        mm = '0' + mm;
    }
    var today = yyyy + '-' + mm + '-' + dd + " 00:00:00";
    $("#input_datetimepicker1").val(today);
    $("#input_datetimepicker2").val(today);

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
            $('#modal_special_deal').modal('show');
          }
        },
        error: function(response) {}
      });
    });
    $(document).on('click', 'a.btn-detail', function() {
      var datas = {
        "action": "getId",
        "specialDealId": $(this).data('specialDealId')
      }

      $.ajax({
        url: _action_url,
        data: datas,
        success: function(response) {
          if($(response).find('.btn-lg').length > 0) {
            location.reload();
          } else {
            $(".modal-content").html(response);
            $('#modal_special_deal').modal('show');
          }
        },
        error: function(response) {}
      });
    });

//handle update

// $(document).on('click', 'a.btn-detail', function() {
//   var datas = {
//     "action": "getId",
//     "specialDealId": $(this).data('specialDealId')
//   }
//
//   $.ajax({
//     url: _action_url,
//     data: datas,
//     success: function(response) {
//       $(".modal-body-update").html(response);
//       //Get Date
//       var today = new Date(parseInt($("#update_input_datetimepicker1").val()));
//
//       var dd = today.getDate();
//       var MM = today.getMonth() + 1; //January is 0!
//
//       var yyyy = today.getFullYear();
//       var hh = today.getHours();
//       var mm = today.getMinutes();
//       var ss = today.getSeconds();
//       if (dd < 10) {
//           dd = '0' + dd;
//       }
//       if (MM < 10) {
//           MM = '0' + MM;
//       }
//       if (hh < 10) {
//           hh = '0' + hh;
//       }
//       if (mm < 10) {
//           mm = '0' + mm;
//       }
//       if (ss < 10) {
//           ss = '0' + ss;
//       }
//       var formattedDate = yyyy + "-" + MM + "-" + dd + " " + hh + ":" + mm + ":" + ss;
//
//       $("#update_input_datetimepicker1").val(formattedDate);
//       var today = new Date(parseInt($("#update_input_datetimepicker2").val()));
//
//       var dd = today.getDate();
//       var MM = today.getMonth() + 1; //January is 0!
//
//       var yyyy = today.getFullYear();
//       var hh = today.getHours();
//       var mm = today.getMinutes();
//       var ss = today.getSeconds();
//       if (dd < 10) {
//           dd = '0' + dd;
//       }
//       if (MM < 10) {
//           MM = '0' + MM;
//       }
//       if (hh < 10) {
//           hh = '0' + hh;
//       }
//       if (mm < 10) {
//           mm = '0' + mm;
//       }
//       if (ss < 10) {
//           ss = '0' + ss;
//       }
//       var formattedDate = yyyy + "-" + MM + "-" + dd + " " + hh + ":" + mm + ":" + ss;
//       $("#update_input_datetimepicker2").val(formattedDate);
//
//       // convertDateTime("update_dateCreated");
//       // convertDateTime("update_dateModified");
//       $('#modal_edit').modal('show');
//       $("[name='update_eventStatus']").bootstrapSwitch();
//       var stateStatus=$("[name='update_eventStatus']").bootstrapSwitch('state');
//       if(stateStatus==true){
//         $("#status").val("ACTIVE");
//       }else{
//         $("#status").val("INACTIVE");
//       }
//       $('#update_datetimepicker1').datetimepicker({
//           autoclose: true,
//           format: "yyyy-mm-dd hh:ii:00",
//       });
//       $('#update_datetimepicker2').datetimepicker({
//           autoclose: true,
//           format: "yyyy-mm-dd hh:ii:00"
//       });
//       $('#update_datetimepicker2').datetimepicker({
//           useCurrent: false //Important! See issue #1075
//       });
//       $("#update_datetimepicker1").on("dp.change", function (e) {
//           $('#update_datetimepicker2').data("DateTimePicker").minDate(e.date);
//       });
//       $("#update_datetimepicker2").on("dp.change", function (e) {
//           $('#update_datetimepicker1').data("DateTimePicker").maxDate(e.date);
//       });
//
//     },
//     error: function(response) {}
//   });
// });

//handle update



    $("#form-update").on("submit", function (e) {
        e.preventDefault();
        var startDate = $("#update_datetimepicker1").data("datetimepicker").getDate();
        var dd_start = startDate.getDate();
        var MM_start = startDate.getMonth() + 1; //January is 0!
        var hh_start = startDate.getHours();
        var mm_start = startDate.getMinutes();
        var ss_start = startDate.getSeconds();
        var yyyy_start = startDate.getFullYear();
        if (dd_start < 10) {
            dd_start = '0' + dd_start;
        }
        if (MM_start < 10) {
            MM_start = '0' + MM_start;
        }
        if (hh_start < 10) {
            hh_start = '0' + hh_start;
        }
        if (mm_start < 10) {
            mm_start = '0' + mm_start;
        }
        if (ss_start < 10) {
            ss_start = '0' + ss_start;
        }
        var endDate = $("#update_datetimepicker2").data("datetimepicker").getDate();
        var dd_end = endDate.getDate();
        var MM_end = endDate.getMonth() + 1; //January is 0!
        var hh_end = endDate.getHours();
        var mm_end = endDate.getMinutes();
        var ss_end = endDate.getSeconds();
        var yyyy_end = endDate.getFullYear();
        if (dd_end < 10) {
            dd_end = '0' + dd_end;
        }
        if (MM_end < 10) {
            MM_end = '0' + MM_end;
        }
        if (hh_end < 10) {
            hh_end = '0' + hh_end;
        }
        if (mm_end < 10) {
            mm_end = '0' + mm_end;
        }
        if (ss_start < 10) {
            ss_end = '0' + ss_end;
        }
        var formattedStartDate = yyyy_start + "-" + MM_start + "-" + dd_start + " " + hh_start + ":" + mm_start + ":" + ss_start;
        var formattedEndDate = yyyy_end + "-" + MM_end + "-" + dd_end + " " + hh_end + ":" + mm_end + ":" + ss_end;
        $("#update_date_begin").val(formattedStartDate);
        $("#update_date_end").val(formattedEndDate);
        var stateStatus = $("[name='update_eventStatus']").bootstrapSwitch('state');
        var status = "INACTIVE";
        if (stateStatus == true) {
            status = "ACTIVE";
        }
        var messageError = "";
        var error = false;
        //validate data

        var x = new Date(formattedStartDate);
        var y = new Date(formattedEndDate);
        if (+x > +y) {
            alert("Ngày bắt đầu không lớn hơn ngày kết thúc");
            return false;
        }

        var datas = {
            "action": "update",
            "specialDealId":$('#update_specialDealId').val(),
            "userId": $('#update_userId').val(),
            "userName": $('#update_userName').val(),
            "campaignName": $('#update_campaignName').val(),
            "promotionRateData": $('#update_promotionRateData').val(),
            "currentNCoin": $('#update_currentNCoin').val(),
            "description": $('#update_description').val(),
            "status": status,
            "purchased": $('#update_purchased').val(),
            "date_begin": formattedStartDate,
            "date_end": formattedEndDate
        }

        $.ajax({
            url: _action_url,
            data: datas,
            success: function (response) {
                if (response.code == 0) {
                    $('#modal_edit').modal('hide');
                    alert('Thành Công');
                    window.location.href = _action_url
                } else {
                    alert('Thất Bại');
                }
            },
            error: function (response) {}
        });

    });
function convertDateTime(id){
  var today = new Date(parseInt(document.getElementById(id).innerHTML));

  var dd = today.getDate();
  var MM = today.getMonth() + 1; //January is 0!

  var yyyy = today.getFullYear();
  var hh = today.getHours();
  var mm = today.getMinutes();
  var ss = today.getSeconds();
  if (dd < 10) {
      dd = '0' + dd;
  }
  if (MM < 10) {
      MM = '0' + MM;
  }
  if (hh < 10) {
      hh = '0' + hh;
  }
  if (mm < 10) {
      mm = '0' + mm;
  }
  if (ss < 10) {
      ss = '0' + ss;
  }
  var formattedDate = yyyy + "-" + MM + "-" + dd + " " + hh + ":" + mm + ":" + ss;
  document.getElementById(id).innerHTML =formattedDate;
}
});
