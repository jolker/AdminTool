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
                        SpecialDeal
                        </h1>
              <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
                <li><a href="#">Payment</a></li>
                <li class="active">SpecialDeal</li>
              </ol>
            </section>
            <section class="content">
              <div class="box">
                <div class="box-header">
                  <i class="ion ion-clipboard"></i>
                  <h3 class="box-title">Search From</h3>
                  <div class="box-tools pull-right">
                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                  </div>
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                  <div class="row">
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
                              <div class='input-group date'>
                                <input type='text' class="form-control" id='pick_start_date' />
                                <span class="input-group-addon">
                                                            <span class="glyphicon glyphicon-calendar"></span>
                                </span>
                              </div>
                            </div>
                          </div>
                          <div class="col-xs-6">
                            <div class="bootstrap-timepicker">
                              <div class="form-group">
                                <label>hh:mm:ss:</label>
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
                              <div class='input-group date'>
                                <input type='text' class="form-control" id='pick_end_date' />
                                <span class="input-group-addon">
                                                            <span class="glyphicon glyphicon-calendar"></span>
                                </span>
                              </div>
                            </div>
                          </div>
                          <div class="col-xs-6">
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
                          </div>
                        </div>
                      </div>
                      <!-- /.form group -->
                    </div>
                    <!-- /.col -->
                    <div class="col-md-4">
                      <div class="row">
                        <div class="col-xs-6">
                          <div class="form-group">
                            <label>Status</label>
                            <input type="hidden" value="<#if status??>${status}</#if>" class="value-status-type">
                            <!-- <select class="form-control select2" id="product_type" style="width: 100%;"> -->
                            <select class="form-control " id="status" name="status">
                              <option  value="ALL" <#if status??><#if status=="ALL">selected</#if></#if>

                                       >ALL</option>
                                                    <option value="ACTIVE"
                               <#if status??>
                                 <#if status=="ACTIVE">selected
                                 </#if>
                                 </#if>
                                                            >ACTIVE</option>
                                                    <option value="INACTIVE"
                               <#if status??>
                               <#if status=="INACTIVE">selected</#if>
                               </#if>
                                                            >INACTIVE</option>

                                                    </select>

                          </div>
                          <!-- /.form-group -->
                          <div class="form-group">
                            <label>UserId</label>
                            <div class="input-group">
                              <span class="input-group-addon">@</span>
                              <input type="number" min="0" class="form-control " placeholder="" id="user_id" value="<#if userId??>${userId}</#if>" />
                            </div>
                          </div>
                          <!-- /.form-group -->
                        </div>
                        <div class="col-xs-6">

                        </div>
                      </div>
                    </div>
                    <div class=" col-md-12 " style="margin-top:-15px">
                      <div class=" col-md-6">
                        <div class="pull-right">
                          <button type="button" class="btn bg-purple btn-search">Search</button>
                        </div>
                      </div>
                    </div>
                  </div>
                  <!-- /.row -->
                </div>
              </div>
              <div class="box">

                <div class="box-header">
                  <i class="ion ion-clipboard"></i>
                  <h3 class="box-title">Result Search</h3>
                  <!-- <a class="pull-right btn btn-primary btn-add-page" data-toggle="modal" data-target="#myModal">
                            Add
                          </a> -->
                  <a class="pull-right btn btn-primary btn-add-page">
                                Add
                                </a>
                </div>
                <div class="box-body">
                  <!-- data special deal-->
                  <table id="tb_result" class="table table-bordered table-striped">
                    <thead>
                      <tr>
                        <th>Id</th>
                        <th>UserId</th>
                        <th>UserName</th>
                        <th>Status</th>
                        <th>Purchased</th>
                        <th>Ncoin</th>
                        <th>FromDate</th>
                        <th>ToDate</th>
                        <th>Description</th>
                        <th>CreatedAt</th>
                        <th>Action</th>
                      </tr>
                    </thead>
                    <tbody>
                      <#if specialDeals??>
                        <#if specialDeals?has_content>

                          <#list specialDeals as item>
                            <tr>
                              <td>${item.specialDealId}</td>
                              <td>${item.userId}</td>
                              <td>${item.userName}</td>
                              <td>${item.status}</td>
                              <td>${item.purchased}</td>
                              <td>${item.currentNCoin}</td>
                              <td><span class="date-create-${item.specialDealId} format-date">${item.dateBegin}</span></td>
                              <td><span class="date-update-${item.specialDealId} format-date">${item.dateEnd}</span></td>
                              <td>${item.description}</td>
                              <td><span class="date-update-${item.specialDealId} format-date">${item.dateCreated}</span></td>
                              <td style="text-align:center">
                                <a class="btn btn-info btn-sm btn-detail" data-special-deal-id="<#if item.specialDealId??>${item.specialDealId}</#if>">
                                                Edit
                                                </a>
                              </td>
                            </tr>

                          </#list>
                          <#else>
                            <tr>
                              <td colspan="10" class="text-center">NOT FOUND DATA</td>
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
                                <td colspan="10">Không Có Dữ Liệu</td>
                              </tr>
                          </#if>
                      </#if>
                    </tbody>
                    <input type="hidden" value="<#if totalPage??>${totalPage}</#if>" class="total-page">
                    <input type="hidden" value="<#if pageSize??>${pageSize}</#if>" class="page-size">
                  </table>
                </div>
                  <!-- paging -->
                  <div class="text-center">
                    <ul class="pagination-sm" id="pagination"></ul>
                  </div>
              </div>
            </section>
          </div>
          <!-- Modal -->
          <div class="modal fade" id="modal_special_deal">
            <div class="modal-dialog modal-lg">
              <div class="modal-content">
                <!-- render html edit or update -->
              </div>
              <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
          </div>
          <!-- /.modal -->


          <!-- /.content-wrapper -->
          <!-- footer -->
          <#include "footer.ftl">
            <!-- end footer -->
    </div>
    <!-- ./wrapper -->
    <#include "script.ftl">
      <!-- <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> -->
      <!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->
      <script src="${root_url}custom/js/list_special_deal.js"></script>
      <!-- <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> -->
  </body>

</html>
