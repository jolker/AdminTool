<form method="GET" action="../special-deal" id="form-insert">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
      <span aria-hidden="true">&times;</span></button>
    <h4 class="modal-title text-center">Add SpecialDeal</h4>
  </div>

    <div class="modal-body">
      <div class="box-body">

        <section class="content">
          <div class="container-fluid">
            <div class="row">
  <div class="col-xs-12 padding-0">
    <!-- ID -->
    <div class="col-xs-2 text-right">
      <label>UserID:</label>
    </div>
    <div class="col-xs-4">
      <input type='number' min="1" class="form-control" required="required" id="userId"  placeholder="user id..." />
    </div>
    <!-- user name -->
    <div class="col-xs-2 text-right">
      <label>UserName:</label>
    </div>
    <div class="col-xs-4">
      <input type='text' class="form-control" required="required" id="userName" placeholder="user name..." />
    </div>
  </div>
  <div class="col-xs-12 padding-0 margin-top-20">
    <!-- fromdate -->
    <div class="col-xs-2 text-right">
      <label for="status">FromDate:</label>
    </div>
    <div class="col-xs-4">
      <div class="form-group">
        <div class='input-group date' id='datetimepicker1'>
          <input type='text' class="form-control" readonly id="input_dateBegin" />
          <span class="input-group-addon">
          <span class="glyphicon glyphicon-calendar"></span>
          </span>
        </div>
      </div>
    </div>
    <!-- toDate -->
    <div class="col-xs-2 text-right">
      <label for="status">ToDate:</label>
    </div>
    <div class="col-xs-4">
    <div class="form-group">
      <div class='input-group date' id='datetimepicker2'>
        <input type='text' class="form-control" readonly id="input_dateEnd" />
        <span class="input-group-addon">
                         <span class="glyphicon glyphicon-calendar"></span>
        </span>
      </div>
    </div>
  </div>
  </div>
  <div class="col-xs-12 padding-0 margin-top-20">
    <div class="col-xs-2 text-right">
      <label>Status:</label>
    </div>
    <div class="col-xs-4">
      <div class="col-xs-2" style="margin-left:-15px">
      <input type="checkbox" name="eventStatus" class="form-control" id="cb-eventStatus">
    </div>
    </div>
    <div class="col-xs-2 text-right">
      <label>Purchased:</label>
    </div>
    <div class="col-xs-4">
      <input type='number' class="form-control" required="required" id="purchased" placeholder="@number..." />
    </div>
  </div>
  <div class="col-xs-12 padding-0 margin-top-20">
    <div class="col-xs-2 text-right">
      <label>CampaignName:</label>
    </div>
    <div class="col-xs-4">
      <input type='text' class="form-control" required="required" id="campaignName"  placeholder="campagin name..." /></div>
    <div class="col-xs-2 text-right">
      <label>Ncoin:</label>
    </div>
    <div class="col-xs-4">
      <input type='number' min="0" class="form-control" required="required" id="currentNCoin"  placeholder="@number..."  />
    </div>
  </div>


  <div class="col-xs-12 padding-0 margin-top-20">
    <div class="col-xs-2 text-right">
      <label>Description:</label>
    </div>
    <div class="col-xs-10">
      <textarea class="form-control" rows="4" id="description" required="required" placeholder="description..."  ></textarea>
    </div>

  </div>
  <div class="col-xs-12 padding-0 margin-top-20">
    <div class="col-xs-2 text-right">
      <label for="status">PromotionRate:</label>
    </div>
    <div class="col-xs-10">
      <textarea class="form-control" rows="4" name="promotionRateData" required="required" id="promotionRateData" placeholder="promotion rate data..."></textarea>
    </div>
  </div>

</div>
</div>
</section>
</div>
</div>

<div class="modal-footer">
<!-- <a class="btn btn-primary add-promotion">Xác Nhận</a> -->
<input type="submit" class="btn btn-primary add-promotion" value="Add"/>
</div>
</form>
<script>
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
  $("#datetimepicker1").on("dp.change", function(e) {
    $('#datetimepicker2').data("DateTimePicker").minDate(e.date);
  });
  $("#datetimepicker2").on("dp.change", function(e) {
    $('#datetimepicker1').data("DateTimePicker").maxDate(e.date);
  });
  var today = new Date();

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

  var formattedDate = yyyy + "-" + MM + "-" + dd + " " + "00:00:00";
  $("#input_dateBegin").val(formattedDate);
  $("#input_dateEnd").val(formattedDate);
  $("#form-insert").on("submit", function(e) {
    e.preventDefault();
    var startDate = $("#datetimepicker1").data("datetimepicker").getDate();
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
    var endDate = $("#datetimepicker2").data("datetimepicker").getDate();
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
    var formattedStartDate = yyyy_start + "-" + MM_start + "-" + dd_start + " " + hh_start + ":" + mm_start + ":" + "00";
    var formattedEndDate = yyyy_end + "-" + MM_end + "-" + dd_end + " " + hh_end + ":" + mm_end + ":" + "00";
    $("#startDate").val(formattedStartDate);
    $("#endDate").val(formattedEndDate);
    var stateStatus = $("[name='eventStatus']").bootstrapSwitch('state');
    var status = "ACTIVE";
    if (stateStatus == true) {
      status = "ACTIVE";
    } else {
      status = "INACTIVE";
    }
    var nowDate = new Date();
    var dd_now = nowDate.getDate();
    var MM_now = nowDate.getMonth() + 1; //January is 0!
    var hh_now = nowDate.getHours();
    var mm_now = nowDate.getMinutes();
    var ss_now = nowDate.getSeconds();
    var yyyy_now = nowDate.getFullYear();
    if (dd_now < 10) {
      dd_now = '0' + dd_now;
    }
    if (MM_now < 10) {
      MM_now = '0' + MM_now;
    }
    if (hh_now < 10) {
      hh_now = '0' + hh_now;
    }
    if (mm_now < 10) {
      mm_now = '0' + mm_now;
    }
    if (ss_now < 10) {
      ss_now = '0' + ss_now;
    }
    var now = yyyy_now + "-" + MM_now + "-" + dd_now + " " + hh_now + ":" + mm_now + ":" + ss_now;
    if(formattedStartDate < now){
      alert("From date cannot be less than current date "+"["+now+"]");
      return false;
    }
    if (formattedStartDate > formattedEndDate) {
      alert("To date cannot be less than from date");
      return false;
    }


        var datas = {
            "action": "add",
            "userId": $('#userId').val(),
            "userName": $('#userName').val(),
            "campaignName": $('#campaignName').val(),
            "promotionRateData": $('#promotionRateData').val(),
            "currentNCoin": $('#currentNCoin').val(),
            "description": $('#description').val(),
            "status": status,
            "purchased": $('#purchased').val(),
            "date_begin": formattedStartDate,
            "date_end": formattedEndDate
        }

    $.ajax({
      url: _action_url,
      data: datas,
      success: function(response) {
        if (response.code == 0) {
          alert('successfully!');
          window.location.href = "special-deal"
        } else {
          alert(response.message);
        }
      },
      error: function(response) {}
    });

  });
</script>
