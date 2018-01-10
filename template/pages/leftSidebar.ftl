<!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
      <!-- Sidebar user panel -->
      <div class="user-panel">
        <div class="pull-left image">
          <img src="${root_url}img/avata_admin.png" class="img-circle" alt="User Image">
        </div>
        <div class="pull-left info">
          <p><#if sessionInfo??>${sessionInfo.userName}</#if></p>
          <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
        </div>
      </div>
      <!-- /.search form -->
      <!-- sidebar menu: : style can be found in sidebar.less -->
      <ul class="sidebar-menu" data-widget="tree">
        <li class="header">MAIN NAVIGATION</li>
         <li class="menu-eventv3">
          <a href="/eventv3">
            <i class="fa fa-calendar-o"></i>
            <span>Event</span>
          </a>
        </li>
        <li class="treeview log-menu">
          <a href="#">
            <i class="fa fa-files-o"></i>
            <span>Payment</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li class="log-cg-menu menu-promotion"><a href="/payment/promotion"><i class="fa fa-circle-o"></i> Promotion</a></li>
            <li class="log-cg-menu menu-invoice"><a href="/payment/invoice"><i class="fa fa-circle-o"></i> Invoice</a></li>
            <li class="log-cg-menu menu-special-deal"><a href="/payment/special-deal"><i class="fa fa-circle-o"></i> Special Deal</a></li>
          </ul>
        </li>
        <li class="user-profile">
          <a href="/home">
            <i class="fa fa-users"></i>
            <span>UserProfile(Game)</span>
          </a>
        </li>
        <li class="card-game-log">
          <a href="/log_card_game">
            <i class="fa fa-credit-card"></i>
            <span>Card Game</span>
          </a>
        </li>
        <#if sessionInfo.role == "ADMIN">
          <li class="account-manager">
            <a href="/user-operators">
              <i class="fa fa-user"></i>
              <span>UserManager(Operators)</span>
            </a>
          </li>
        </#if>
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>
