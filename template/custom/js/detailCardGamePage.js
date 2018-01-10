var _action_url = "/detail_card_game";

$(document).ready(function() {
  $('li.log-menu').removeClass('menu-open');
  $('li.log-menu').removeClass('active');
  $('li.log-cg-menu').removeClass('active');
  $('li.card-game-log').addClass('active');

  var decimal = "";
  $(".format-decimal").each(function(index) {
    decimal = $(this).text().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,");
    $(this).text(decimal);
  });

  $(".info_user").click(function() {

    var datas = {
      "action": "get_user_info",
      "user_id": $(this).data('userid')
    }

    $.ajax({
      url: _action_url,
      data: datas,
      success: function(response) {
        if (response.result == true) {
          $('.profile-username').text("User Name: " + response.displayName);
          $('.profile-userid').text("User Id: " + response.userId);
          $('.profile-lastlogin').text(response.lastLogin);
          $('.profile-ncoin').text(response.money);
          if (response.status == 0) {
            $('.profile-status').text('Hoạt động');
          } else if (response.status == 1) {
            $('.profile-status').text('Khóa');
          } else {
            $('.profile-status').text('Xóa');
          }

          $('.profile-user-img').attr("src", response.avata);

          $('#modal_info').modal('show');
        } else {
        }
      }
    });
  });
});
