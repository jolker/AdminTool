<!DOCTYPE html>
<html>
<#include "head.ftl">

  <body class="hold-transition skin-purple-light sidebar-mini">
    <div class="wrapper">
      <!-- header -->
      <#include "header.ftl">
        <!-- end header -->

        <!-- Left side column. contains the logo and sidebar -->
        <#include "leftSidebar.ftl">
          <!-- end left side column -->

          <!-- Content Wrapper. Contains page content -->
          <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <section class="content-header">
              <h1>
            Card Game Log
          </h1>
              <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
                <li><a href="#">Logs</a></li>
                <li class="active">Card Game Log</li>
              </ol>
            </section>

            <!-- Main content -->
            <section class="content">
              <!-- content result -->
              <div class="box">
                <div class="box-header">
                  <i class="ion ion-clipboard"></i>
                  <h3 class="box-title">Detail</h3>
                  <#if game_play??>
                    <h3 class="box-title pull-right">Bet Money: <span class="format-decimal">${game_play.betMoney}</span></h3>
                  </#if>
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                  <#if game_play?? && game_play.playerTurn??>
                    <#list game_play.playerTurn as player>
                      <div class="col-xs-12 text-center item-detail-card-game">
                        <div class="col-xs-3">
                          <a class="btn btn-info info_user" data-userid="${player.userId}">
                            User Id: ${player.userId}
                          </a>
                          <p><em>Pay Total: ${player.chiTotal}</em></p>
                          <p><em>Money Transfer: <span class="format-decimal">${player.moneyTransfer}</span></em></p>
                        </div>
                        <div class="col-xs-6">
                          <div class="row">
                            <#if player.cards1st??>
                              <#list player.cards1st as card>
                                <div class="col-xs-2">
                                  <img class="img-responsive" src="${root_url}img/card/${card}" alt="Photo">
                                </div>
                              </#list>
                            </#if>
                          </div>
                          <div class="row">
                            <#if player.cards2nd??>
                              <#list player.cards2nd as card>
                                <div class="col-xs-2">
                                  <img class="img-responsive" src="${root_url}img/card/${card}" alt="Photo">
                                </div>
                              </#list>
                            </#if>
                          </div>
                          <div class="row">
                            <#if player.cards3rd??>
                              <#list player.cards3rd as card>
                                <div class="col-xs-2">
                                  <img class="img-responsive" src="${root_url}img/card/${card}" alt="Photo">
                                </div>
                              </#list>
                            </#if>
                          </div>
                        </div>
                        <div class="col-xs-3">
                          <!-- <button type="button" class="btn btn-block btn-danger btn-sm">Ban User</button> -->
                        </div>
                      </div>
                    </#list>
                    <#else>
                      <p class="text-center">${error}</p>
                  </#if>
                </div>
                <!-- /.box-body -->
              </div>
              <!-- /.box -->
            </section>
            <!-- /.content -->
          </div>
          <!-- /.content-wrapper -->

          <!-- footer -->
          <#include "footer.ftl">
            <!-- end footer -->
    </div>
    <!-- ./wrapper -->
    <div class="modal fade" id="modal_info">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title text-center">User Information</h4>
          </div>
          <div class="modal-body">
            <!-- Profile Image -->
            <div class="box box-primary">
              <div class="box-body box-profile">
                <img class="profile-user-img img-responsive img-circle" src="" alt="User profile picture">

                <h3 class="profile-username text-center"></h3>

                <p class="profile-userid text-muted text-center"></p>

                <ul class="list-group list-group-unbordered">
                  <li class="list-group-item">
                    <b>Last login:</b> <a class="pull-right profile-lastlogin"></a>
                  </li>
                  <li class="list-group-item">
                    <b>Ncoin:</b> <a class="pull-right profile-ncoin"></a>
                  </li>
                  <li class="list-group-item">
                    <b>Status:</b> <a class="pull-right profile-status"></a>
                  </li>
                </ul>

                <!-- <a href="#" class="btn btn-primary btn-block"><b>Follow</b></a> -->
              </div>
              <!-- /.box-body -->
            </div>
            <!-- /.box -->
          </div>
        </div>
        <!-- /.modal-content -->
      </div>
      <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->

    <#include "script.ftl">
      <script src="${root_url}custom/js/detailCardGamePage.js"></script>
  </body>

</html>
