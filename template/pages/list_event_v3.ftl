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
              <h1>Event V3</h1>
             <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
                <li class="active">Event V3</li>
              </ol>
            </section>
            <section class="content">

              <div class="box box-default">
                <div class="box-header with-border">
                  <h3 class="box-title">Search From</h3>

                  <div class="box-tools pull-right">
                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                  </div>
                </div>
              <!-- /.box-header -->
                <div class="box-body">
                  <div class="row">
                    <input type="hidden" value="<#if fromDate??>${fromDate}</#if>" id="start_time">
                    <input type="hidden" value="<#if toDate??>${toDate}</#if>" id="end_time">
                    <div class="col-md-4" style="margin-left:-15px">
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
                      <div class="col-xs-6"></div>
                      <div class="col-xs-6">
                        <div class="pull-right text-right">
                          <button type="button" class="btn bg-purple  btn-search">Search</button>
                        </div>
                      </div>
                    </div>


                  </div>
               </div>

             </div>


          <div class="box">
            <div class="box-header">
              <i class="ion ion-clipboard"></i>
              <h3 class="box-title">Result Search</h3>
              <a class="pull-right btn btn-primary btn-add-page">
                Add
              </a>
            </div>
              <div class="box-body">
                <table id="tb_result" class="table table-bordered table-striped">
                  <thead>
                    <tr>
                      <th>Id</th>
                      <th>Title</th>
                      <th>Status</th>
                      <th>Priority</th>
                      <th>Frequency</th>
                      <th>Type</th>
                      <th>UserGroup</th>
                      <th>PaymentType</th>
                      <th>FromDate</th>
                      <th>ToDate</th>

                      <th>Action</th>
                    </tr>
                  </thead>
                  <tbody>
                    <#if list_data??>
                      <#if list_data?has_content>

                        <#list list_data as item>
                          <tr>

                            <td>${item.eventId}</td>
                            <td>${item.title}</td>
                            <td>${item.eventStatus}</td>
                            <td>${item.priority}</td>
                            <td>${item.frequency}</td>
                            <td>${item.eventType}</td>
                            <td>${item.eventUserGroup}</td>
                            <td>${item.paymentType}</td>
                            <td><span class="date-create-${item.eventId} format-date">${item.dateBegin}</span></td>
                            <td><span class="date-update-${item.eventId} format-date">${item.dateEnd}</span></td>

                            <td class="text-center">
                              <a class="btn btn-info btn-sm  btn-detail" data-event-id="<#if item.eventId??>${item.eventId}</#if>">
                            Edit
                          </a>
                            </td>
                          </tr>

                        </#list>
                        <#else>
                          <tr>
                            <td colspan="12" class="text-center">NOT FOUND DATA</td>
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
                              <td colspan="10">NOT FOUND DATA</td>
                            </tr>
                        </#if>
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
          </section >
          </div>

          <!-- /.content-wrapper -->
          <div class="modal fade" id="modal_event">
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
      <!-- <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> -->
      <script src="${root_url}custom/js/list_event.js"></script>
      <!-- <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> -->
  </body>

</html>
