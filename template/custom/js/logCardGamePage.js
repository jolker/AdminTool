var _action_url = "/log_card_game";
var total = $('.total-page').val();
var pageSize = $('.page-size').val();
var datetimepicker_start = "";
var datetimepicker_end = "";

$(document).ready(function() {
  $('li.log-menu').removeClass('menu-open');
  $('li.log-menu').removeClass('active');
  $('li.log-cg-menu').removeClass('active');
  $('li.card-game-log').addClass('active');

  // datetime picker
  $('#pick_start_date').datepicker({
    autoclose: true,
    format: 'yyyy-mm-dd'
  });
  $('#pick_end_date').datepicker({
    autoclose: true,
    format: 'yyyy-mm-dd'
  });

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
    var arrStart = $('#start_time').val().split("T");
    $('#pick_start_date').val(arrStart[0]);
    $('.start-timepicker').val(arrStart[1]);
    var arrEnd = $('#end_time').val().split("T");
    $('#pick_end_date').val(arrEnd[0]);
    $('.end-timepicker').val(arrEnd[1]);
  }

  if ($('#pick_start_date').val().length > 0 && $('#pick_end_date').val().length > 0) {
    datetimepicker_start = $('#pick_start_date').val() + "T" + $('.start-timepicker').val();
    datetimepicker_end = $('#pick_end_date').val() + "T" + $('.end-timepicker').val();
  }

  if ($('.value-channel-id').val() != "") {
    $('#channel_id').val($('.value-channel-id').val()).trigger('change');
  }

  if ($('.value-game-id').val() != "") {
    $('#game_id').val($('.value-game-id').val()).trigger('change');
  }

  if ($('.value-special-type').val() != "") {
    $('#type_result').val($('.value-special-type').val()).trigger('change');
  }

  if ($('.value-number-player').val() != "") {
    $('#number_players').val($('.value-number-player').val()).trigger('change');
  }

  if ($('.value-owner-id').val() != "-1" && $('.value-owner-id').val() != "") {
    $('#check_owner').iCheck('toggle');
  }

  if ($('#room_id').val() == "-1") {
    $('#room_id').val("");
  }

  if ($('#min_money').val() == "-1") {
    $('#min_money').val("");
  }

  if ($('#max_money').val() == "-1") {
    $('#max_money').val("")
  }

  if (total != "" && pageSize != "") {
    if ((parseInt(total) % parseInt(pageSize)) != 0) {
      total = parseInt(parseInt(total) / parseInt(pageSize)) + 1;
    } else {
      total = parseInt(parseInt(total) / parseInt(pageSize));
    }

    if (parseInt(total) > 0) {
      $('#pagination').twbsPagination({
        totalPages: total,
        visiblePages: 5,
        onPageClick: function(event, page) {
          // check owner user
          var owner_id = "";
          if ($('#check_owner:checkbox:checked').length > 0) {
            if ($('#user_ids').val()) {
              owner_id = $('#user_ids').val().split(" ")[0];
            } else {
              alert("Vui lòng nhập user id");
              return false;
            }
          }

          var datas = {
            "action": "search",
            "user_ids": $('#user_ids').val(),
            "user_name": $('#user_name').val(),
            "owner_id": owner_id,
            "game_id": $('#game_id').val(),
            "level_id": $('#channel_id').val(),
            "number_user": $('#number_players').val(),
            "from_money": $('#min_money').val(),
            "to_money": $('#max_money').val(),
            "room_id": $('#room_id').val(),
            "special_type": $('#type_result').val(),
            "device_id": $('#user_device_ids').val(),
            "ip": $('#user_ip').val(),
            "from_date": datetimepicker_start,
            "to_date": datetimepicker_end,
            "page": page
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
            },
            error: function(response) {

            }
          });
        }
      });
    }
  }

  //Initialize Select2 Elements
  $('.select2').select2();

  //iCheck for checkbox and radio inputs
  $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
    checkboxClass: 'icheckbox_minimal-purple',
    radioClass: 'iradio_minimal-purple'
  });

  var myVar;
  $('#action_refesh').on('ifChecked', function(event) {
    alert('Bật chức năng auto');
    myVar = setInterval(ajaxCall, $('.time-interval').val());
  });

  $('#action_refesh').on('ifUnchecked', function(event) {
    alert('Tắt chức năng auto');
    clearInterval(myVar);
  });

  $(".btn-search-game-log").click(function() {

    // validate date
    if ($('#pick_start_date').val().length > 0 && $('#pick_end_date').val().length > 0) {
      datetimepicker_start = $('#pick_start_date').val() + "T" + $('.start-timepicker').val();
      datetimepicker_end = $('#pick_end_date').val() + "T" + $('.end-timepicker').val();
      if (Date.parse(datetimepicker_start) > Date.parse(datetimepicker_end)) {
        alert('Không hợp lệ, ngày kết thúc nhỏ hơn ngày bắt đầu');
        return false;
      }
    }

    // check owner user
    var owner_id = "";
    if ($('#check_owner:checkbox:checked').length > 0) {
      if ($('#user_ids').val()) {
        owner_id = $('#user_ids').val().split(" ")[0];
      } else {
        alert("Vui lòng nhập user id");
        return false;
      }
    }

    var action = "search";
    var user_id = $('#user_ids').val();
    var user_name = $('#user_name').val();
    var game_id = $('#game_id').val();
    var channel = $('#channel_id').val();
    var number_users = $('#number_players').val();
    var from_money = $('#min_money').val();
    var to_money = $('#max_money').val();
    var room_id = $('#room_id').val();
    var special_type = $('#type_result').val();
    var device_id = $('#user_device_ids').val();
    var ip = $('#user_ip').val();
    var date_start = datetimepicker_start;
    var date_end = datetimepicker_end;

    window.location.href = _action_url + "?action=" + action + "&user_ids=" + user_id + "&user_name=" + user_name + "&owner_id=" + owner_id +
      "&game_id=" + game_id + "&level_id=" + channel + "&number_user=" + number_users + "&from_money=" + from_money +
      "&to_money=" + to_money + "&room_id=" + room_id + "&special_type=" + special_type + "&from_date=" + date_start +
      "&to_date=" + date_end + "&device_id=" + device_id + "&ip=" + ip;
  });
});

function ajaxCall() {
  var total = $('.total-page').val();
  var pageSize = $('.page-size').val();
  var datetimepicker_start = "";
  var datetimepicker_end = "";

  if ($('#pick_start_date').val().length > 0 && $('#pick_end_date').val().length > 0) {
    datetimepicker_start = $('#pick_start_date').val() + "T" + $('.start-timepicker').val();
    datetimepicker_end = $('#pick_end_date').val() + "T" + $('.end-timepicker').val();
  }

  // check owner user
  var owner_id = "";
  if ($('#check_owner:checkbox:checked').length > 0) {
    if ($('#user_ids').val()) {
      owner_id = $('#user_ids').val().split(" ")[0];
    } else {
      alert("Vui lòng nhập user id");
      return false;
    }
  }

  var datas = {
    "action": "search",
    "user_ids": $('#user_ids').val(),
    "user_name": $('#user_name').val(),
    "owner_id": owner_id,
    "game_id": $('#game_id').val(),
    "level_id": $('#channel_id').val(),
    "number_user": $('#number_players').val(),
    "from_money": $('#min_money').val(),
    "to_money": $('#max_money').val(),
    "room_id": $('#room_id').val(),
    "special_type": $('#type_result').val(),
    "from_date": $('#datetimepicker_start').val(),
    "to_date": $('#datetimepicker_end').val(),
    "device_id": $('#user_device_ids').val(),
    "ip": $('#user_ip').val()
  }

  $.ajax({
    url: "/log_card_game",
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

      if (total != "" && pageSize != "") {
        if ((parseInt(total) % parseInt(pageSize)) != 0) {
          total = parseInt(parseInt(total) / parseInt(pageSize)) + 1;
        } else {
          total = parseInt(parseInt(total) / parseInt(pageSize));
        }

        if (parseInt(total) > 0) {
          $('#pagination').twbsPagination('destroy');
          $('#pagination').twbsPagination({
            totalPages: total,
            visiblePages: 5,
            onPageClick: function(event, page) {
              // check owner user
              var owner_id = "";
              if ($('#check_owner:checkbox:checked').length > 0) {
                if ($('#user_ids').val()) {
                  owner_id = $('#user_ids').val().split(" ")[0];
                } else {
                  alert("Vui lòng nhập user id");
                  return false;
                }
              }

              var datas = {
                "action": "search",
                "user_ids": $('#user_ids').val(),
                "user_name": $('#user_name').val(),
                "owner_id": owner_id,
                "game_id": $('#game_id').val(),
                "level_id": $('#channel_id').val(),
                "number_user": $('#number_players').val(),
                "from_money": $('#min_money').val(),
                "to_money": $('#max_money').val(),
                "room_id": $('#room_id').val(),
                "special_type": $('#type_result').val(),
                "from_date": $('#datetimepicker_start').val(),
                "to_date": $('#datetimepicker_end').val(),
                "device_id": $('#user_device_ids').val(),
                "ip": $('#user_ip').val(),
                "page": page
              }

              $.ajax({
                url: "/log_card_game",
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
                },
                error: function(response) {}
              });
            }
          });
        }
      }
    },
    error: function(response) {}
  });
}
