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
            Promotion
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li><a href="#">Payment</a></li>
            <li class="active">Promotion</li>
          </ol>
        </section>

        <!-- Main content -->
        <section class="content">
          <div class="box box-default">
            <div class="box-header with-border">
              <h3 class="box-title">Search Form</h3>

              <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
              </div>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <div class="row">
                <div class="col-md-6">
                  <!-- Date and time range -->
                  <div class="form-group">
                    <!-- /.input group -->
                    <div class="row">
                      <input type="hidden" value="<#if fromDate??>${fromDate}</#if>" id="start_time">
                      <input type="hidden" value="<#if toDate??>${toDate}</#if>" id="end_time">
                      <div class="col-xs-12 padding-0">
                        <div class="col-xs-4">
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
                        <div class="col-xs-4">
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
                      </div>
                      <div class="col-xs-12 padding-0">
                        <div class="col-xs-4">
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
                        <div class="col-xs-4">
                          <div class="bootstrap-timepicker">
                            <div class="form-group">
                              <label>hh:mm:ss:</label>
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
                          <div class="text-right">
                            <button type="button" class="btn bg-purple margin btn-search" style="margin: 0px;">Search</button>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <!-- /.form group -->
                </div>
                <!-- /.col -->
              </div>
              <!-- /.row -->
            </div>
            <!-- /.box-body -->
          </div>
          <!-- content result -->
          <div class="box">
            <div class="box-header">
              <i class="ion ion-clipboard"></i>
              <h3 class="box-title">Result Search</h3>
              <a class="pull-right btn btn-primary btn-add-page btn-sm">
                Add
              </a>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table id="tb_result" class="table table-bordered table-striped">
                <thead>
                <tr>
                  <th>Id</th>
                  <th>Title</th>
                  <th>Priority</th>
                  <th>Status</th>
                  <th>FromDate</th>
                  <th>ToDate</th>
                  <th class="text-right">Action</th>
                </tr>
                </thead>
                <tbody>
                  <#if promotions??>
                    <#if promotions?has_content>
                      <#list promotions as promotion>
                        <tr>
                          <td><#if promotion.promotionId??>${promotion.promotionId}</#if></td>
                          <td><#if promotion.promotionName??>${promotion.promotionName}</#if></td>
                          <td><#if promotion.priority??>${promotion.priority}</#if></td>
                          <td><#if promotion.status??>${promotion.status}</#if></td>
                          <td class="format-date"><#if promotion.dateBegin??>${promotion.dateBegin}</#if></td>
                          <td class="format-date"><#if promotion.dateEnd??>${promotion.dateEnd}</#if></td>
                          <td>
                            <a class="btn btn-info btn-sm pull-right btn-detail" data-promo-id="<#if promotion.promotionId??>${promotion.promotionId}</#if>">
                              Edit
                            </a>
                          </td>
                        </tr>
                      </#list>
                    <#else>
                      <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td>NOT FOUND DATA</td>
                        <td></td>
                        <td></td>
                        <td></td>
                      </tr>
                    </#if>
                  <#else>
                    <tr>
                      <td></td>
                      <td></td>
                      <td></td>
                      <td>NOT FOUND DATA</td>
                      <td></td>
                      <td></td>
                      <td></td>
                    </tr>
                  </#if>
                </tbody>
                <input type="hidden" value="<#if totalPage??>${totalPage}</#if>" class="total-page">
                <input type="hidden" value="<#if pageSize??>${pageSize}</#if>" class="page-size">
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

      <div class="modal fade" id="modal_promotion">
        <div class="modal-dialog modal-lg">
          <div class="modal-content">
            <!-- render html edit or update -->
          </div>
          <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
      </div>
      <!-- /.modal -->

      <!-- footer -->
      <#include "footer.ftl">
      <!-- end footer -->
    </div>
    <!-- ./wrapper -->

    <#include "script.ftl">
    <script src="${root_url}custom/js/list_promotion.js"></script>
  </body>

</html>
