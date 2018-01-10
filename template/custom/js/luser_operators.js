var _action_url = "/user-operators";
var total = $('.total-page').val();
var pageSize = $('.page-size').val();

$(document).ready(function() {
  $('li.log-menu').removeClass('menu-open');
  $('li.log-menu').removeClass('active');
  $('li.log-cg-menu').removeClass('active');
  $('li.account-manager').addClass('active');

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
            "pageNumber": page
          }

          $.ajax({
            url: _action_url,
            data: datas,
            success: function(response) {
              var result = $(response).find('#tb_result');
              $('#tb_result').replaceWith(result);
            },
            error: function(response) {}
          });
        }
      });
    }
  }
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
        $('#modal_user_oper').modal('show');
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
        $('#modal_user_oper').modal('show');
      }
    },
    error: function(response) {}
  });
});
