<div class="modal-header">
  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
    <span aria-hidden="true">&times;</span></button>
  <h4 class="modal-title text-center">Add Promotion</h4>
</div>
<div class="modal-body">
  <div class="box-body">
    <div class="row">
      <div class="col-xs-12" style="margin: 0 5%;">
        <div class="form-group">
          <label for="name" class="col-sm-3 control-label text-right">Title:</label>
          <div class="col-sm-3">
            <input type="text" class="form-control" id="promo_name" placeholder="Title" name="promo_name">
          </div>
        </div>
        <div class="col-xs-12 padding-0" style="margin-top: 15px;">
          <label for="priority" class="col-sm-3 control-label text-right">Priority:</label>
          <div class="col-sm-3">
            <input type="number" class="form-control" id="promo_priority" placeholder="Priority" name="promo_priority">
          </div>
        </div>
        <div class="col-xs-12 padding-0" style="margin-top: 15px;">
          <label class="col-sm-3 control-label text-right">Status:</label>
          <div class="col-sm-3">
            <select class="form-control select2" style="width: 100%;" name="status" id="promo_status">
              <option value="ACTIVE" selected="selected">ACTIVE</option>
              <option value="INACTIVE">INACTIVE</option>
            </select>
          </div>
        </div>
        <!-- /.form-group -->
        <div class="col-xs-12 padding-0" style="margin-top: 15px;">
          <label class="col-sm-3 control-label text-right">FromDate:</label>
          <div class="col-sm-3">
            <div class="input-group date">
              <div class="input-group-addon">
                <i class="fa fa-calendar"></i>
              </div>
              <input type="text" class="form-control pull-right" id="promo_date_start" name="add_promo_date_start">
            </div>
            <!-- /.input group -->
          </div>
        </div>
        <div class="col-xs-12 padding-0" style="margin-top: 15px;">
          <label class="col-sm-3 control-label text-right">ToDate:</label>
          <div class="col-sm-3">
            <div class="input-group date">
              <div class="input-group-addon">
                <i class="fa fa-calendar"></i>
              </div>
              <input type="text" class="form-control pull-right" id="promo_date_end" name="add_promo_date_end">
            </div>
            <!-- /.input group -->
          </div>
        </div>
        <div class="col-xs-12 padding-0" style="margin-top: 15px;">
          <label class="col-sm-3 control-label text-right">UserGroup:</label>
          <div class="col-sm-3">
            <select class="form-control select2" style="width: 100%;" name="user_group" id="promo_user_group">
              <option value="ALL_USERS" selected="selected">ALL_USERS</option>
              <option value="NEW_USER">NEW_USER</option>
              <option value="FREE_USER">FREE_USER</option>
              <option value="PAID_USER">PAID_USER</option>
              <option value="VIP_USER">VIP_USER</option>
            </select>
          </div>
        </div>
        <!-- /.form-group -->
        <div class="col-xs-12 padding-0" style="margin-top: 15px;">
          <label for="description" class="col-sm-3 control-label text-right">Description:</label>
          <div class="col-sm-7">
            <textarea class="form-control" rows="5" id="promo_description" placeholder="Description" name="promo_description"></textarea>
          </div>
        </div>
        <div class="col-xs-12 padding-0" style="margin-top: 15px;">
          <label for="description" class="col-sm-3 control-label text-right">PromotionRateData:</label>
          <div class="col-sm-7">
            <div class="nav-tabs-custom">
              <ul class="nav nav-tabs">
                <li class="active"><a href="#tab_sms" data-toggle="tab">SMS</a></li>
                <li><a href="#tab_card" data-toggle="tab">CARD</a></li>
                <li><a href="#tab_inapp" data-toggle="tab">INAPP</a></li>
                <li class="pull-right"><i class="fa fa-gear"></i></li>
              </ul>
              <div class="tab-content">
                <div class="tab-pane active" id="tab_sms">
                  <table id="tb_result" class="table table-bordered table-striped">
                    <thead>
                      <tr>
                        <th>productKey</th>
                        <th>promotionRate</th>
                        <th>promotionType</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr class="case-promo" data-id="SMS_3000">
                        <td>SMS_3000</td>
                        <td><input type="number" class="form-control promo-rate" placeholder="Promotion Rate" name="promo_name"></td>
                        <td>
                          <select class="form-control select2" style="width: 100%;" name="user_group" id="promotion_type">
                              <option value="2" selected="selected">POPULAR</option>
                              <option value="1">SPECIALDEAL</option>
                              <option value="3">BESTDEAL</option>
                            </select>
                        </td>
                      </tr>
                      <tr class="case-promo" data-id="SMS_5000">
                        <td>SMS_5000</td>
                        <td><input type="number" class="form-control promo-rate" placeholder="Promotion Rate" name="promo_name"></td>
                        <td>
                          <select class="form-control select2" style="width: 100%;" name="user_group" id="promotion_type">
                              <option value="2" selected="selected">POPULAR</option>
                              <option value="1">SPECIALDEAL</option>
                              <option value="3">BESTDEAL</option>
                            </select>
                        </td>
                      </tr>
                      <tr class="case-promo" data-id="SMS_10000">
                        <td>SMS_10000</td>
                        <td><input type="number" class="form-control promo-rate" placeholder="Promotion Rate" name="promo_name"></td>
                        <td>
                          <select class="form-control select2" style="width: 100%;" name="user_group" id="promotion_type">
                              <option value="2" selected="selected">POPULAR</option>
                              <option value="1">SPECIALDEAL</option>
                              <option value="3">BESTDEAL</option>
                            </select>
                        </td>
                      </tr>
                      <tr class="case-promo" data-id="SMS_15000">
                        <td>SMS_15000</td>
                        <td><input type="number" class="form-control promo-rate" placeholder="Promotion Rate" name="promo_name"></td>
                        <td>
                          <select class="form-control select2" style="width: 100%;" name="user_group" id="promotion_type">
                              <option value="2" selected="selected">POPULAR</option>
                              <option value="1">SPECIALDEAL</option>
                              <option value="3">BESTDEAL</option>
                            </select>
                        </td>
                      </tr>
                      <tr class="case-promo" data-id="SMS_20000">
                        <td>SMS_20000</td>
                        <td><input type="number" class="form-control promo-rate" placeholder="Promotion Rate" name="promo_name"></td>
                        <td>
                          <select class="form-control select2" style="width: 100%;" name="user_group" id="promotion_type">
                              <option value="2" selected="selected">POPULAR</option>
                              <option value="1">SPECIALDEAL</option>
                              <option value="3">BESTDEAL</option>
                            </select>
                        </td>
                      </tr>
                      <tr class="case-promo" data-id="SMS_50000">
                        <td>SMS_50000</td>
                        <td><input type="number" class="form-control promo-rate" placeholder="Promotion Rate" name="promo_name"></td>
                        <td>
                          <select class="form-control select2" style="width: 100%;" name="user_group" id="promotion_type">
                              <option value="2" selected="selected">POPULAR</option>
                              <option value="1">SPECIALDEAL</option>
                              <option value="3">BESTDEAL</option>
                            </select>
                        </td>
                      </tr>
                      <tr class="case-promo" data-id="SMS_100000">
                        <td>SMS_100000</td>
                        <td><input type="number" class="form-control promo-rate" placeholder="Promotion Rate" name="promo_name"></td>
                        <td>
                          <select class="form-control select2" style="width: 100%;" name="user_group" id="promotion_type">
                              <option value="2" selected="selected">POPULAR</option>
                              <option value="1">SPECIALDEAL</option>
                              <option value="3">BESTDEAL</option>
                            </select>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
                <!-- /.tab-pane -->
                <div class="tab-pane" id="tab_card">
                  <table id="tb_result" class="table table-bordered table-striped">
                    <thead>
                      <tr>
                        <th>productKey</th>
                        <th>promotionRate</th>
                        <th>promotionType</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr class="case-promo" data-id="CARD_10000">
                        <td>CARD_10000</td>
                        <td><input type="number" class="form-control promo-rate" placeholder="Promotion Rate" name="promo_name"></td>
                        <td>
                          <select class="form-control select2" style="width: 100%;" name="user_group" id="promotion_type">
                              <option value="2" selected="selected">POPULAR</option>
                              <option value="1">SPECIALDEAL</option>
                              <option value="3">BESTDEAL</option>
                            </select>
                        </td>
                      </tr>
                      <tr class="case-promo" data-id="CARD_20000">
                        <td>CARD_20000</td>
                        <td><input type="number" class="form-control promo-rate" placeholder="Promotion Rate" name="promo_name"></td>
                        <td>
                          <select class="form-control select2" style="width: 100%;" name="user_group" id="promotion_type">
                              <option value="2" selected="selected">POPULAR</option>
                              <option value="1">SPECIALDEAL</option>
                              <option value="3">BESTDEAL</option>
                            </select>
                        </td>
                      </tr>
                      <tr class="case-promo" data-id="CARD_50000">
                        <td>CARD_50000</td>
                        <td><input type="number" class="form-control promo-rate" placeholder="Promotion Rate" name="promo_name"></td>
                        <td>
                          <select class="form-control select2" style="width: 100%;" name="user_group" id="promotion_type">
                              <option value="2" selected="selected">POPULAR</option>
                              <option value="1">SPECIALDEAL</option>
                              <option value="3">BESTDEAL</option>
                            </select>
                        </td>
                      </tr>
                      <tr class="case-promo" data-id="CARD_100000">
                        <td>CARD_100000</td>
                        <td><input type="number" class="form-control promo-rate" placeholder="Promotion Rate" name="promo_name"></td>
                        <td>
                          <select class="form-control select2" style="width: 100%;" name="user_group" id="promotion_type">
                              <option value="2" selected="selected">POPULAR</option>
                              <option value="1">SPECIALDEAL</option>
                              <option value="3">BESTDEAL</option>
                            </select>
                        </td>
                      </tr>
                      <tr class="case-promo" data-id="CARD_200000">
                        <td>CARD_200000</td>
                        <td><input type="number" class="form-control promo-rate" placeholder="Promotion Rate" name="promo_name"></td>
                        <td>
                          <select class="form-control select2" style="width: 100%;" name="user_group" id="promotion_type">
                              <option value="2" selected="selected">POPULAR</option>
                              <option value="1">SPECIALDEAL</option>
                              <option value="3">BESTDEAL</option>
                            </select>
                        </td>
                      </tr>
                      <tr class="case-promo" data-id="CARD_500000">
                        <td>CARD_500000</td>
                        <td><input type="number" class="form-control promo-rate" placeholder="Promotion Rate" name="promo_name"></td>
                        <td>
                          <select class="form-control select2" style="width: 100%;" name="user_group" id="promotion_type">
                              <option value="2" selected="selected">POPULAR</option>
                              <option value="1">SPECIALDEAL</option>
                              <option value="3">BESTDEAL</option>
                            </select>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
                <!-- /.tab-pane -->
                <div class="tab-pane" id="tab_inapp">
                  <table id="tb_result" class="table table-bordered table-striped">
                    <thead>
                      <tr>
                        <th>productKey</th>
                        <th>promotionRate</th>
                        <th>promotionType</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr class="case-promo" data-id="0.99">
                        <td>0.99</td>
                        <td><input type="number" class="form-control promo-rate" placeholder="Promotion Rate" name="promo_name"></td>
                        <td>
                          <select class="form-control select2" style="width: 100%;" name="user_group" id="promotion_type">
                              <option value="2" selected="selected">POPULAR</option>
                              <option value="1">SPECIALDEAL</option>
                              <option value="3">BESTDEAL</option>
                            </select>
                        </td>
                      </tr>
                      <tr class="case-promo" data-id="2.99">
                        <td>2.99</td>
                        <td><input type="number" class="form-control promo-rate" placeholder="Promotion Rate" name="promo_name"></td>
                        <td>
                          <select class="form-control select2" style="width: 100%;" name="user_group" id="promotion_type">
                              <option value="2" selected="selected">POPULAR</option>
                              <option value="1">SPECIALDEAL</option>
                              <option value="3">BESTDEAL</option>
                            </select>
                        </td>
                      </tr>
                      <tr class="case-promo" data-id="4.99">
                        <td>4.99</td>
                        <td><input type="number" class="form-control promo-rate" placeholder="Promotion Rate" name="promo_name"></td>
                        <td>
                          <select class="form-control select2" style="width: 100%;" name="user_group" id="promotion_type">
                              <option value="2" selected="selected">POPULAR</option>
                              <option value="1">SPECIALDEAL</option>
                              <option value="3">BESTDEAL</option>
                            </select>
                        </td>
                      </tr>
                      <tr class="case-promo" data-id="9.99">
                        <td>9.99</td>
                        <td><input type="number" class="form-control promo-rate" placeholder="Promotion Rate" name="promo_name"></td>
                        <td>
                          <select class="form-control select2" style="width: 100%;" name="user_group" id="promotion_type">
                              <option value="2" selected="selected">POPULAR</option>
                              <option value="1">SPECIALDEAL</option>
                              <option value="3">BESTDEAL</option>
                            </select>
                        </td>
                      </tr>
                      <tr class="case-promo" data-id="19.99">
                        <td>19.99</td>
                        <td><input type="number" class="form-control promo-rate" placeholder="Promotion Rate" name="promo_name"></td>
                        <td>
                          <select class="form-control select2" style="width: 100%;" name="user_group" id="promotion_type">
                              <option value="2" selected="selected">POPULAR</option>
                              <option value="1">SPECIALDEAL</option>
                              <option value="3">BESTDEAL</option>
                            </select>
                        </td>
                      </tr>
                      <tr class="case-promo" data-id="49.99">
                        <td>49.99</td>
                        <td><input type="number" class="form-control promo-rate" placeholder="Promotion Rate" name="promo_name"></td>
                        <td>
                          <select class="form-control select2" style="width: 100%;" name="user_group" id="promotion_type">
                              <option value="2" selected="selected">POPULAR</option>
                              <option value="1">SPECIALDEAL</option>
                              <option value="3">BESTDEAL</option>
                            </select>
                        </td>
                      </tr>
                      <tr class="case-promo" data-id="99.99">
                        <td>99.99</td>
                        <td><input type="number" class="form-control promo-rate" placeholder="Promotion Rate" name="promo_name"></td>
                        <td>
                          <select class="form-control select2" style="width: 100%;" name="user_group" id="promotion_type">
                              <option value="2" selected="selected">POPULAR</option>
                              <option value="1">SPECIALDEAL</option>
                              <option value="3">BESTDEAL</option>
                            </select>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
                <!-- /.tab-pane -->
              </div>
              <!-- /.tab-content -->
            </div>
          </div>
        </div>
        <div class="col-xs-12 padding-0" style="margin-top: 15px;">
          <label for="description" class="col-sm-3 control-label text-right">UserCreated:</label>
          <div class="col-sm-3">
            <p>
              <#if sessionInfo??>${sessionInfo.userName}</#if>
            </p>
            <input type="hidden" class="form-control" id="promo_user_created" value="<#if sessionInfo??>${sessionInfo.userName}</#if>" name="promo_user_created" disabled>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<div class="modal-footer">
  <a class="btn btn-primary add-promotion">Add</a>
</div>

<script>
  //Initialize Select2 Elements
  $('.select2').select2();

  // datetime picker
  $('#promo_date_start').datetimepicker({
    format: "yyyy-mm-dd hh:ii:00",
    autoclose: true,
    minuteStep: 5
  });

  $('#promo_date_end').datetimepicker({
    format: "yyyy-mm-dd hh:ii:00",
    autoclose: true,
    minuteStep: 5
  });

  $(".add-promotion").click(function() {

    if ($('#promo_name').val() == "") {
      alert("Title cannot empty!");
      return false;
    }

    if ($('#promo_priority').val() == "") {
      alert("Priority cannot empty!");
      return false;
    }

    if ($('#promo_description').val() == "") {
      alert("Description cannot empty!");
      return false;
    }

    if ($('#promo_date_start').val() == "") {
      alert("Date start cannot empty!");
      return false;
    }

    if ($('#promo_date_end').val() == "") {
      alert("Date end cannot empty!");
      return false;
    }

    if ($('#promo_rate_data').val() == "") {
      alert("Data cannot empty!");
      return false;
    }

    var promo_rate_data = createJSON(".case-promo");

    var datas = {
      "action": "add",
      "name": $('#promo_name').val(),
      "user_group": $('#promo_user_group').val(),
      "priority": $('#promo_priority').val(),
      "description": $('#promo_description').val(),
      "status": $('#promo_status').val(),
      "date_begin": $('#promo_date_start').val(),
      "date_end": $('#promo_date_end').val(),
      "rate_data": promo_rate_data,
      "user_created": $('#promo_user_created').val()
    }

    $.ajax({
      url: _action_url,
      data: datas,
      success: function(response) {
        if (response.code == 0) {
          alert('Thành Công');
          window.location.href = "/payment/promotion"
        } else {
          alert(response.message);
        }
      },
      error: function(response) {}
    });

  });

  function createJSON(type) {
    jsonObj = [];
    $(type).each(function() {
      var product_key = $(this).data("id");
      var promotion_rate = $(this).find('input.promo-rate').val();
      var promotion_type = $(this).find('#promotion_type').val();
      if (promotion_rate != "") {
        item = {}
        item["ProductKey"] = product_key;
        item["PromotionRate"] = promotion_rate;
        item["EPromotionType"] = promotion_type;

        jsonObj.push(item);
      }
    });
    return JSON.stringify(jsonObj);
  }
</script>
