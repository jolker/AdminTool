$(document).ready(function() {
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

$("#form-insert").on("submit",function(e){
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
if(stateStatus==true){
  $("#status").val("ACTIVE");
}else{
  $("#status").val("INACTIVE");
}
var messageError="";
var error=false;
//validate data

var x = new Date(formattedStartDate);
var y = new Date(formattedEndDate);
if(+x>+y){
  messageError="Ngày bắt đầu không lớn hơn ngày kết thúc\n";
  error=true;
}
if(error){
  var obj =$("#messageError").text( messageError );
obj.html(obj.html().replace(/\n/g,'<br/>'));
  $('#myModal').modal('toggle');
  e.preventDefault();
}
});
});
