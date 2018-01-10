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
            Log Card Game
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li><a href="#">Logs</a></li>
            <li class="active">Log Card Game</li>
          </ol>
        </section>

        <!-- Main content -->
        <section class="content">
          <!-- SELECT2 EXAMPLE -->
          <div class="box box-default">
            <div class="box-header with-border">
              <h3 class="box-title">Search Log Card Game</h3>

              <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
              </div>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <div class="row">
                <div class="col-md-4">
                  <div class="form-group">
                    <label>User Ids</label>
                    <div class="input-group">
                      <span class="input-group-addon">@</span>
                      <input type="text" class="form-control" placeholder="Các Id cách nhau bằng khoảng trắng" id="user_ids" value="<#if userIds??>${userIds}</#if>">
                    </div>
                  </div>
                  <!-- /.form-group -->
                  <div class="form-group">
                    <label>User Name</label>
                    <div class="input-group">
                      <span class="input-group-addon">@</span>
                      <input type="text" class="form-control" placeholder="Nhập User Name" id="user_name" value="<#if userName??>${userName}</#if>">
                    </div>
                  </div>
                  <!-- /.form-group -->
                  <div class="form-group">
                    <label>Device Ids</label>
                    <div class="input-group">
                      <span class="input-group-addon">@</span>
                      <input type="text" class="form-control" placeholder="Các Id cách nhau bằng khoảng trắng" id="user_device_ids" value="<#if deviceId??>${deviceId}</#if>">
                    </div>
                  </div>
                  <!-- /.form-group -->
                  <div class="form-group">
                    <label>Ip</label>
                    <div class="input-group">
                      <span class="input-group-addon">@</span>
                      <input type="text" class="form-control" placeholder="Các Ip cách nhau bằng khoảng trắng" id="user_ip" value="<#if ip??>${ip}</#if>">
                    </div>
                  </div>
                  <!-- /.form-group -->
                </div>
                <!-- /.col -->
                <div class="col-md-4">
                  <!-- Date and time range -->
                  <div class="form-group">
                    <!-- /.input group -->
                    <div class="row">
                      <input type="hidden" value="<#if fromDate??>${fromDate}</#if>" id="start_time">
                      <input type="hidden" value="<#if toDate??>${toDate}</#if>" id="end_time">
                      <div class="col-xs-6">
                        <div class="form-group">
                          <label>FromDate:</label>
                            <div class='input-group date' >
                                <input type='text' class="form-control" id='pick_start_date'/>
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-calendar"></span>
                                </span>
                            </div>
                        </div>
                      </div>
                      <div class="col-xs-6">
                        <div class="bootstrap-timepicker">
                          <div class="form-group">
                            <label>hh:mm:ss</label>
                            <div class="input-group">
                              <input type="text" class="form-control start-timepicker">
                              <div class="input-group-addon">
                                <i class="fa fa-clock-o"></i>
                              </div>
                            </div>
                            <!-- /.input group -->
                          </div>
                          <!-- /.form group -->
                        </div>
                      </div>
                      <div class="col-xs-6">
                        <div class="form-group">
                          <label>ToDate:</label>
                            <div class='input-group date' >
                                <input type='text' class="form-control" id='pick_end_date'/>
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-calendar"></span>
                                </span>
                            </div>
                        </div>
                      </div>
                      <div class="col-xs-6">
                        <div class="bootstrap-timepicker">
                          <div class="form-group">
                            <label>hh:mm:ss</label>
                            <div class="input-group">
                              <input type="text" class="form-control end-timepicker">
                              <div class="input-group-addon">
                                <i class="fa fa-clock-o"></i>
                              </div>
                            </div>
                            <!-- /.input group -->
                          </div>
                          <!-- /.form group -->
                        </div>
                      </div>
                    </div>
                  </div>
                  <!-- /.form group -->
                  <div class="form-group">
                    <label>Type Game</label>
                    <input type="hidden" value="<#if gameId??>${gameId}</#if>" class="value-game-id">
                    <select class="form-control select2" id="game_id" style="width: 100%;">
                      <!-- <option selected="selected" value="-1">Tất cả</option>
                      <option value="2">Tiến Lên Miền Nam</option>
                      <option value="5">Phỏm</option>
                      <option value="7">Tiến Lên Miền Nam - NAT</option> -->
                      <option selected="selected" value="8">Mậu Binh</option>
                      <!-- <option value="11">Xì tố</option>
                      <option value="19">Tiến Lên Miền Nam - Đếm Lá</option>
                      <option value="20">Tiến Lên Miền Nam - Đếm Lá NAT</option>
                      <option value="24">Cát tê</option> -->
                    </select>
                  </div>
                  <!-- /.form-group -->
                </div>
                <!-- /.col -->
                <div class="col-md-2">
                  <div class="form-group">
                    <label>Bet Money</label>
                    <div class="input-group">
                      <span class="input-group-addon">$</span>
                      <input type="number" class="form-control" placeholder="Ít Nhất" id="min_money" value="<#if fromMoney??>${fromMoney}</#if>">
                    </div>
                  </div>
                  <!-- /.form-group -->
                  <div class="form-group">
                    <div class="input-group">
                      <span class="input-group-addon">$</span>
                      <input type="number" class="form-control" placeholder="Nhiều Nhất" id="max_money" value="<#if toMoney??>${toMoney}</#if>">
                    </div>
                  </div>
                  <!-- /.form-group -->
                  <div class="form-group">
                    <label>Type Result</label>
                    <input type="hidden" value="<#if specialType??>${specialType}</#if>" class="value-special-type">
                    <select class="form-control select2" id="type_result" style="width: 100%;">
                      <option selected="selected" value="-1">Tất cả</option>
                      <option value="0">Không sập</option>
                      <option value="2">Sập 1 nhà</option>
                      <option value="8">Sập 2 nhà</option>
                      <option value="32">Sập 3 nhà</option>
                      <option value="128">Sập 4 nhà</option>
                    </select>
                  </div>
                  <!-- /.form-group -->
                  <div class="form-group">
                    <label>
                      <input type="hidden" value="<#if ownerId??>${ownerId}</#if>" class="value-owner-id">
                      <input type="checkbox" class="minimal" id="check_owner">
                      Owner
                    </label>
                  </div>
                  <!-- /.form-group -->
                  <div class="form-group">
                    <label>
                      <input type="checkbox" class="minimal" id="action_refesh">
                      Auto Refesh
                    </label>
                  </div>
                  <input type="hidden" value="<#if time_interval??>${time_interval}</#if>" class="time-interval">
                  <!-- /.form-group -->
                </div>
                <!-- /.col -->
                <div class="col-md-2">
                  <div class="form-group">
                    <label>Room</label>
                    <div class="input-group">
                      <div class="input-group-addon">
                        <i class="fa fa-window-maximize"></i>
                      </div>
                      <input type="text" class="form-control" id="room_id" value="<#if roomId??>${roomId}</#if>">
                    </div>
                  </div>
                  <!-- /.form-group -->
                  <div class="form-group">
                    <label>Number Player</label>
                    <input type="hidden" value="<#if numberUser??>${numberUser}</#if>" class="value-number-player">
                    <select class="form-control select2" id="number_players" style="width: 100%;">
                      <option selected="selected" value="-1">Tất cả</option>
                      <option value="2">2</option>
                      <option value="3">3</option>
                      <option value="4">4</option>
                    </select>
                  </div>
                  <!-- /.form-group -->
                  <div class="form-group">
                    <label>Channel</label>
                    <input type="hidden" value="<#if levelId??>${levelId}</#if>" class="value-channel-id">
                    <select class="form-control select2" id="channel_id" style="width: 100%;">
                      <option selected="selected" value="-1">Tất cả</option>
                      <option value="0">Bình Dân</option>
                      <option value="1">Đại Gia</option>
                      <option value="2">VIP</option>
                    </select>
                  </div>
                  <!-- /.form-group -->
                </div>
                <!-- /.col -->
              </div>
              <!-- /.row -->
            </div>
            <!-- /.box-body -->
            <div class="box-footer">
              <button type="button" class="btn bg-purple margin btn-search-game-log">Search</button>
            </div>
          </div>
          <!-- /.box -->

          <!-- content result -->
          <div class="box">
            <div class="box-header">
              <i class="ion ion-clipboard"></i>
              <h3 class="box-title">Results</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table id="tb_result" class="table table-bordered table-striped">
                <thead>
                <tr>
                  <th>Game</th>
                  <th>Channel</th>
                  <th>Room</th>
                  <th>Owner</th>
                  <th>Player</th>
                  <th>Bet Money</th>
                  <th>PlayTime</th>
                  <th>StartDate</th>
                  <th></th>
                </tr>
                </thead>
                <tbody>
                  <#if list_data??>
                    <#if list_data?has_content>
                      <#list list_data as item>
                        <tr>
                          <td>
                            <#if item.gameId==2>TLMN</#if>
                            <#if item.gameId==7>TLMN - NAT</#if>
                            <#if item.gameId==8>Mậu Binh</#if>
                            <#if item.gameId==19>TLMN - Đếm lá</#if>
                            <#if item.gameId==20>TLMN - Đếm lá NAT</#if>
                          </td>
                          <td>
                            <#if item.levelId==0>Bình dân</#if>
                            <#if item.levelId==1>Đại gia</#if>
                            <#if item.levelId==2>VIP</#if>
                            <#if item.levelId==3>Đấu trường</#if>
                          </td>
                          <td>${item.roomId}</td>
                          <td>
                            <#list item.playerIds?split(" ") as x>
                             <#if x == item.ownerId?c>
                              <#list item.players?split(" ") as y>
                                <#if x?index ==  y?index>
                                  ${y}
                                </#if>
                              </#list>
                             </#if>
                            </#list>
                          </td>
                          <td>${item.players}</td>
                          <td class="format-decimal">${item.betMoney}</td>
                          <td>${item.duration}</td>
                          <td>${item.startDate}</td>
                          <td>
                            <#if item.gameId==8>
                              <a href="/detail_card_game?ela_id=${item.elasticId}" class="btn btn-block btn-info btn-sm">Chi Tiết</a>
                            </#if>
                          </td>
                        </tr>
                      </#list>
                    <#else>
                      <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td>NOT FOUND DATA</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                      </tr>
                    </#if>
                  <#else>
                      <#if msg_error??>
                        <tr>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td>msg_error</td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                        </tr>
                      <#else>
                        <tr>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td>NOT FOUND DATA</td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                        </tr>
                      </#if>
                  </#if>
                </tbody>
                <input type="hidden" value="<#if total_data??>${total_data}</#if>" class="total-page">
                <input type="hidden" value="<#if page_size??>${page_size}</#if>" class="page-size">
              </table>
            </div>
            <div class="text-center">
              <ul class="pagination-sm" id="pagination"></ul>
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

    <#include "script.ftl">
    <script src="${root_url}custom/js/logCardGamePage.js"></script>
  </body>

</html>
