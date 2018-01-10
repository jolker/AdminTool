<form method="GET" action="../eventv3" id="form-insert">
<div class="modal-header">
  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
    <span aria-hidden="true">&times;</span></button>
  <h4 class="modal-title text-center">Update Event</h4>
</div>
<form method="GET" action="../eventv3" id="form-insert">
<div class="modal-body">
  <div class="box-body">

    <section class="content">
        <div class="container-fluid">
            <div class="row">
              <section class="content">
                  <div class="container-fluid">
                      <div class="row">

                          <div class="col-xs-12 padding-0">
                              <div class="col-xs-2 text-right">
                                <label for="status ">Title:</label>
                              </div>
                              <div class="col-xs-4">
                                  <input type='text' class="form-control" value="${data.title}" name="title" id="title"  required="required"/>
                              </div>
                              <div class="col-xs-2 text-right">
                                <label for="status">Status:</label>
                              </div>
                              <div class="col-xs-1">
                                <input type="checkbox" name="eventStatus"  class="form-control" id="cb-eventStatus"
                                <#if data.eventStatus="ACTIVE">
                                checked
                                </#if>
                                >
                              </div>
                          </div>
                          <div class="col-xs-12 padding-0 margin-top-20">

                              <div class="col-xs-2 text-right">
                                <label for="status">FromDate:</label>
                              </div>
                              <div class="col-xs-4">

                                   <div class="form-group">
                                       <div class='input-group date' id='datetimepicker1' readonly>
                                           <input type='text' class="form-control format-date" value="${fromDate}" readonly id="input-datetimepicker1" />
                                           <span class="input-group-addon">
                                               <span class="glyphicon glyphicon-calendar"></span>
                                           </span>
                                       </div>
                                   </div>

                              </div>
                              <div class="col-xs-2 text-right">
                                <label for="status">ToDate:</label>
                              </div>
                              <div class="col-xs-4">

                                   <div class="form-group">
                                       <div class='input-group date' id='datetimepicker2' readonly >
                                           <input type='text' class="form-control format-date" value="${toDate}" readonly id="input-datetimepicker2"/>
                                           <span class="input-group-addon">
                                               <span class="glyphicon glyphicon-calendar"></span>
                                           </span>
                                       </div>

                               </div>
                          </div>
                          <div class="col-xs-12 padding-0 margin-top-20">
                              <div class="col-xs-2 text-right">
                                <label for="status">Priority:</label>
                              </div>
                              <div class="col-xs-4">
                                  <input type='number' class="form-control" value="${data.priority}" name="priority" id="priority" min="0" max="127" required="required"/>
                              </div>
                              <div class="col-xs-2 text-right">
                                <label for="status">Frequency:</label>
                              </div>
                              <div class="col-xs-4">
                                  <input type='number' class="form-control" value="${data.frequency}" name="frequency" id="frequency" min="0" max="32767" required="required"/>
                              </div>
                          </div>

                          <div class="col-xs-12 padding-0 margin-top-20">
                              <div class="col-xs-2 text-right">
                                <label for="status">ButtonAction:</label>
                              </div>
                              <div class="col-xs-4 text-right">
                                <select class="form-control" id="buttonAction" name="buttonAction">
                                 <option value="OPEN_BROWSER"
                                 <#if data.buttonAction=="OPEN_BROWSER">selected="selected"</#if>
                                 >OPEN BROWSER</option>
                                 <option value="OPEN_WEBVIEW"
                                 <#if data.buttonAction=="OPEN_WEBVIEW">selected="selected"</#if>
                                 >OPEN WEBVIEW</option>
                                 <option value="OPEN_SHOP"
                                 <#if data.buttonAction=="OPEN_SHOP">selected="selected"</#if>
                                 >OPEN SHOP</option>
                                 <option value="OPEN_GAME"
                                 <#if data.buttonAction=="OPEN_GAME">selected="selected"</#if>
                                 >OPEN GAME</option>
                               </select>

                              </div>
                              <div class="col-xs-2 text-right">
                                <label for="status">Type:</label>
                              </div>
                              <div class="col-xs-4 ">
                                <select class="form-control" id="eventType" name="eventType" >
                                 <option value="BANNER"
                                 <#if data.eventType=="BANNER">selected="selected"</#if>
                                 >BANNER</option>
                                 <option value="POPUP"
                                 <#if data.eventType=="POPUP">selected="selected"</#if>
                                 >POPUP</option>
                                 <option value="HEADER"
                                 <#if data.eventType=="HEADER">selected="selected"</#if>
                                 >HEADER</option>
                               </select>
                              </div>
                          </div>
                          <div class="col-xs-12 padding-0 margin-top-20">
                              <div class="col-xs-2 text-right">
                                <label for="status">ButtonLink:</label>
                              </div>
                              <div class="col-xs-4">
                                 <div class="input-group">
                                   <input type="file" class="form-control"  aria-describedby="basic-addon3"  id="buttonLinkFile" id-short="buttonLink" value="http://${data.buttonLink}">
                                   <input type="hidden" class="form-control" aria-describedby="basic-addon3" name="buttonLink" required="required" id="buttonLink" placeholder="example.com" value="${data.buttonLink}" >
                               </div>
                              </div>
                              <div class="col-xs-2 text-right">
                                <label for="status">ImageUrl:</label>
                              </div>
                              <div class="col-xs-4">
                                <div class="input-group">
                                  <input type="file" class="form-control" aria-describedby="basic-addon3"  id="imgUrlFile" placeholder="example.com" id-short="imgUrl">
                                  <input type="hidden" class="form-control" aria-describedby="basic-addon3" name="imgUrl" required="required" id="imgUrl" value="${data.imgUrl}" >
                                </div>
                              </div>
                          </div>
                          <div class="col-xs-12 padding-0 margin-top-20">
                            <div class="col-xs-2 text-right">

                            </div>
                            <div class="col-xs-4">
                              <div class="input-group">
                                <img src="http://${data.buttonLink}" class="img-thumbnail" alt="Smiley face" height="120" width="120" id="img-buttonLink">
                              </div>
                            </div>
                            <div class="col-xs-2 text-right">

                            </div>
                            <div class="col-xs-4">
                              <div class="input-group">
                                <img src="http://${data.imgUrl}" class="img-thumbnail" alt="Smiley face" height="120" width="120" id="img-imgUrl" ></div>
                            </div>
                          </div>
                          <div class="col-xs-12 padding-0 margin-top-20">
                              <div class="col-xs-2 text-right">
                                <label for="status">ButtonText:</label>
                              </div>
                              <div class="col-xs-4">
                                  <input type='text' class="form-control" value="${data.buttonText}" name="buttonText" id="buttonText" required="required"/>
                              </div>
                              <div class="col-xs-2 text-right">
                                <label for="status">PaymentType:</label>
                              </div>
                              <div class="col-xs-4">
                                <select class="form-control" id="paymentType" name="paymentType">
                                 <option value="ALL_USER"
                                 <#if data.paymentType=="ALL_USER">selected="selected"</#if>
                                 >ALL USER</option>
                                 <option value="INAPP_USER"
                                 <#if data.paymentType=="INAPP_USER">selected="selected"</#if>
                                 >INAPP USER</option>
                                 <option value="CARD_USER"
                                 <#if data.paymentType=="CARD_USER">selected="selected"</#if>
                                 >CARD USER</option>
                               </select>
                              </div>
                          </div>

                          <div class="col-xs-12 padding-0 margin-top-20">

                              <div class="col-xs-2 text-right">
                                <label for="status">UserGroup:</label>
                              </div>
                              <div class="col-xs-4">
                                <select class="form-control" id="eventUserGroup" name="eventUserGroup">
                                 <option value="ALL_USERS"
                                 <#if data.eventUserGroup=="ALL_USERS">selected="selected"</#if>
                                 >ALL USERS</option>
                                 <option value="NEW_USER"
                                 <#if data.eventUserGroup=="NEW_USER">selected="selected"</#if>
                                 >NEW USER</option>
                                 <option value="FREE_USER"
                                 <#if data.eventUserGroup=="FREE_USER">selected="selected"</#if>
                                 >FREE USER</option>
                                 <option value="PAID_USER"
                                 <#if data.eventUserGroup=="PAID_USER">selected="selected"</#if>
                                 >PAID USER</option>
                                 <option value="VIP_USER"
                                 <#if data.eventUserGroup=="VIP_USER">selected="selected"</#if>
                                 >VIP USER</option>
                               </select>
                             </div>
                          </div>

                          <div class="col-xs-12 padding-0 margin-top-20">
                              <div class="col-xs-2 text-right">
                                <label for="status">Description:</label>
                              </div>
                              <div class="col-xs-10">
                                <textarea class="form-control" rows="3" id="description" name="description" required="required">${data.description}</textarea>
                              </div>

                          </div>

                          <div class="col-xs-12 padding-0 margin-top-20">

                              <div class="col-xs-2 text-right">
                                <label for="status">UserCreated:</label>
                              </div>
                              <div class="col-xs-4">
                                ${data.userCreated}
                              </div>
                              <div class="col-xs-2 text-right">
                                <label for="status">CreatedAt:</label>
                              </div>
                              <div class="col-xs-4 format-date" >
                                <p id="dateCreated">${data.dateCreated}</p>
                              </div>
                          </div>
                          <div class="col-xs-12 padding-0 margin-top-20">

                              <div class="col-xs-2 text-right">
                                <label for="status">UserUpdated:</label>
                              </div>
                              <div class="col-xs-4">
                                <p ><#if data.userUpdated??>${data.userUpdated}</#if></p>
                              </div>
                              <div class="col-xs-2 text-right">
                                <label for="status">UpdatedAt:</label>
                              </div>
                              <div class="col-xs-4 format-date" id="dateUpdated">
                                   <#if data.dateUpdated??>${data.dateUpdated}</#if>
                              </div>
                          </div>
                          <div class="col-xs-12 padding-0 margin-top-20" style="text-align:center">
                              <input type="hidden" name="eventId" value="${data.eventId}" id="eventId">
                              <input type="hidden" class="format-date" id="startDate" name="startDate" value="${data.dateBegin}">
                              <input type="hidden" class="format-date" id="endDate" name="endDate" value="${data.dateEnd}">
                              <input type="hidden" id="status" name="status" value="${data.eventStatus}">

                          </div>
                       </div>
                   </div>
               </section>
         </div>
  </div>
  </section>
</div>
</div>

<div class="modal-footer">
  <!-- <a class="btn btn-primary add-promotion">Xác Nhận</a> -->
  <input type="submit" class="btn btn-primary add-promotion" value="Update"/>
</div>
</form>
<script>
$('#buttonLinkFile').on('change', uploadFile);
$('#imgUrlFile').on('change', uploadFile);
function uploadFile(event)
	{
	    event.stopPropagation();
	    event.preventDefault();
	    var files = event.target.files;
	    var data = new FormData();
	    $.each(files, function(key, value)
	    {
	        data.append("image", value);
	    });
      data.append("name",event.target.files[0].name);
      var id=$(this).attr('id-short');
	    postFilesData(data,id);
	 }

function postFilesData(data,id)
	{
	 $.ajax({
        url: '/upload',
        type: 'POST',
        data: data,
        cache: false,
        dataType: 'json',
        processData: false,
        contentType: false,
        success: function(data, textStatus, jqXHR)
        {
        	$("#"+id).val(data.pathFile);
          $("#img-"+id).attr("src", "http://"+data.pathFile);
        },
        error: function(jqXHR, textStatus, errorThrown)
        {
            console.log('ERRORS: ' + textStatus);
        }
	    });
	}
var date = new Date(parseInt($("#dateCreated").text()));
    $("#dateCreated").text(dateFormat(date, "yyyy-mm-dd HH:MM:ss"));
var date = new Date(parseInt($("#dateUpdated").text()));
        $("#dateUpdated").text(dateFormat(date, "yyyy-mm-dd HH:MM:ss"));
$("[name='eventStatus']").bootstrapSwitch();
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

$("#form-insert").on("submit", function (e) {
  e.preventDefault();
  var startDate = $("#datetimepicker1").data("datetimepicker").getDate();
  var dd_start = startDate.getDate();
  var MM_start = startDate.getMonth()+1; //January is 0!
  var hh_start = startDate.getHours();
  var mm_start =startDate.getMinutes();
  var ss_start =startDate.getSeconds();
  var yyyy_start = startDate.getFullYear();
  if(dd_start<10){
    dd_start='0'+dd_start;
  }
  if(MM_start<10){
    MM_start='0'+MM_start;
  }
  if(hh_start<10){
    hh_start='0'+hh_start;
  }
  if(mm_start<10){
    mm_start='0'+mm_start;
  }
  if(ss_start<10){
    ss_start='0'+ss_start;
  }
  var endDate = $("#datetimepicker2").data("datetimepicker").getDate();
  var dd_end = endDate.getDate();
  var MM_end = endDate.getMonth()+1; //January is 0!
  var hh_end = endDate.getHours();
  var mm_end =endDate.getMinutes();
  var ss_end =endDate.getSeconds();
  var yyyy_end = endDate.getFullYear();
  if(dd_end<10){
    dd_end='0'+dd_end;
  }
  if(MM_end<10){
    MM_end='0'+MM_end;
  }
  if(hh_end<10){
    hh_end='0'+hh_end;
  }
  if(mm_end<10){
    mm_end='0'+mm_end;
  }
  if(ss_start<10){
    ss_end='0'+ss_end;
  }
    var formattedStartDate = yyyy_start+ "-" + MM_start + "-" + dd_start + " " + hh_start + ":" + mm_start + ":" + ss_start;
    var formattedEndDate = yyyy_end+ "-" + MM_end + "-" + dd_end + " " + hh_end + ":" + mm_end + ":" + ss_end;
  $("#startDate").val(formattedStartDate);
  $("#endDate").val(formattedEndDate);
  var stateStatus=$("[name='eventStatus']").bootstrapSwitch('state');
  var status="ACTIVE";
  if(stateStatus==true){
    status="ACTIVE";
  }else{
  status="INACTIVE";
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


  if(formattedStartDate > formattedEndDate){
    alert("To date cannot be less than from date");
    return false;
  }
  var datas = {
    "action": "update",
    "eventId": $('#eventId').val(),
    "title": $('#title').val(),
    "status": status,
    "priority": $('#priority').val(),
    "description": $('#description').val(),
    "buttonAction": $('#buttonAction').val(),
    "buttonLink": $('#buttonLink').val(),
    "buttonText": $('#buttonText').val(),
    "eventType": $('#eventType').val(),
    "frequency": $('#frequency').val(),
    "imgUrl": $('#imgUrl').val(),
    "paymentType":$('#paymentType').val(),
    "eventUserGroup":$('#eventUserGroup').val(),
    "startDate":formattedStartDate,
    "endDate":formattedEndDate,

  }

  $.ajax({
    url: _action_url,
    data: datas,
    success: function(response) {
      if(response.code == 0) {
        alert('successfully!');
        window.location.href = "eventv3"
      } else {
        alert(response.message);
      }
    },
    error: function(response) {}
  });

});

</script>
