<div class="modal-header">
  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
    <span aria-hidden="true">&times;</span></button>
  <h4 class="modal-title text-center">Add Account</h4>
</div>
<div class="modal-body" style="width: 55%; margin: 0 auto;">
  <div class="box-body">
    <div class="row">
      <div class="col-xs-6">
        <div class="form-group">
          <label for="user">User Name</label>
          <input type="text" class="form-control" id="user_name" placeholder="Nhập user name">
        </div>
        <div class="form-group">
          <label for="psw">Password</label>
          <input type="password" class="form-control" id="password" placeholder="Nhập Password">
        </div>
      </div>
      <div class="col-xs-6">
        <div class="form-group">
          <label>Status</label>
          <select class="form-control select2" style="width: 100%;" id="status">
            <option value="PENDING" selected="selected">PENDING</option>
            <option value="ACTIVED">ACTIVED</option>
            <option value="DISABLED">DISABLED</option>
          </select>
        </div>
        <div class="form-group">
          <label>Role</label>
          <select class="form-control select2" style="width: 100%;" id="role">
            <option value="USER" selected="selected">USER</option>
            <option value="ADMIN">ADMIN</option>
          </select>
        </div>
      </div>
    </div>
  </div>
</div>
<div class="modal-footer" style="text-align: center;">
  <a class="btn bg-purple margin btn-add-account">Add</a>
</div>

<script>
$(".btn-add-account").click(function() {

  if($('#user_name').val() == "") {
    alert("Vui lòng điền thông tin user name");
    return false;
  }

  if($('#password').val() == "") {
    alert("Vui lòng điền password");
    return false;
  }

  var datas = {
    "action": "add",
    "user_name": $('#user_name').val(),
    "password": $('#password').val(),
    "status": $('#status').val(),
    "role": $('#role').val()
  }

  $.ajax({
    url: _action_url,
    data: datas,
    success: function(response) {
      if(response.code == 0) {
        alert('Thành Công');
        window.location.href = "/user-operators"
      } else {
        alert(response.message);
      }
    },
    error: function(response) {}
  });

});
</script>
