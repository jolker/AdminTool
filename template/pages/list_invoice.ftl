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
            Invoice
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li><a href="#">Payment</a></li>
            <li class="active">Invoice</li>
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
                      <div class="col-xs-4">
                        <div class="form-group">
                          <label>FromDate</label>
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
                      <div class="col-xs-4">
                        <div class="form-group">
                          <label>ProductType</label>
                          <input type="hidden" value="<#if productType??>${productType}</#if>" class="value-product-type">
                          <select class="form-control select2" id="product_type" style="width: 100%;">
                            <option selected="selected" value="">All</option>
                            <option value="INAPP">INAPP</option>
                            <option value="CARD">CARD</option>
                            <option value="SMS">SMS</option>
                          </select>
                        </div>
                        <!-- /.form-group -->
                      </div>
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
                      <div class="col-xs-4">
                        <div class="form-group">
                          <label>UserId</label>
                          <div class="input-group">
                            <span class="input-group-addon">@</span>
                            <input type="number" class="form-control" placeholder="" id="user_id" value="<#if userId??>${userId}</#if>">
                          </div>
                        </div>
                        <!-- /.form-group -->
                        <div class="text-right">
                          <button type="button" class="btn bg-purple margin btn-search" style="margin: 0px;">Search</button>
                        </div>
                      </div>
                    </div>
                  </div>
                  <!-- /.form group -->
                </div>
              </div>
              <!-- /.row -->
            </div>
            <!-- /.box-body -->
          </div>
          <!-- content result -->
          <div class="box">
            <div class="box-header">
              <i class="ion ion-clipboard"></i>
              <h3 class="box-title">Result Search </h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table id="tb_result" class="table table-bordered table-striped">
                <thead>
                <tr>
                  <th>Id</th>
                  <th>userId</th>
                  <th>UserGroup</th>
                  <th>Status</th>
                  <th>partnerStatus</th>
                  <th>Amount</th>
                  <th>PurchasedDate</th>
                  <th>AppPackageId</th>
                  <th class="text-center" style="width: 20%;">Action</th>
                </tr>
                </thead>
                <tbody>
                  <#if invoices??>
                    <#if invoices?has_content>
                      <#list invoices as invoice>
                        <tr>
                          <td><#if invoice.invoiceId??>${invoice.invoiceId}</#if></td>
                          <td><#if invoice.userId??>${invoice.userId}</#if></td>
                          <td><#if invoice.userGroup??>${invoice.userGroup}</#if></td>
                          <td>
                            <#if invoice.status??>
                              <#if invoice.status == 0>
                                ERROR
                              <#else>
                                COMPLETED
                              </#if>
                            </#if>
                          </td>
                          <td>
                            <#if invoice.partnerStatus??>
                              <#if invoice.partnerStatus == 0>
                                ERROR
                              <#else>
                                COMPLETED
                              </#if>
                            </#if>
                          </td>
                          <td><#if invoice.amount??>${invoice.amount}</#if></td>
                          <td class="format-date"><#if invoice.purchasedDate??>${invoice.purchasedDate}</#if></td>
                          <td><#if invoice.appPackageId??>${invoice.appPackageId}</#if></td>
                          <td class="text-center">
                            <a class="btn btn-info btn-sm btn-detail" data-invoice-id="<#if invoice.invoiceId??>${invoice.invoiceId}</#if>">
                              View
                            </a>
                            <a class="btn bg-olive btn-sm btn-reprocess <#if invoice.status == 1>disabled</#if>" data-invoice-id="<#if invoice.invoiceId??>${invoice.invoiceId}</#if>">
                              ReProcess
                            </a>
                            <a class="btn btn-warning btn-sm btn-refund <#if invoice.status == 0 || invoice.amount == 0>disabled</#if>" data-invoice-id="<#if invoice.invoiceId??>${invoice.invoiceId}</#if>">
                              Refund
                            </a>
                          </td>
                        </tr>
                      </#list>
                    <#else>
                      <tr>
                        <td></td>
                        <td></td>
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

        <div class="modal fade" id="modal_edit">
          <div class="modal-dialog modal-lg">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title text-center">Invoice Info</h4>
              </div>
              <div class="modal-body" style="background: #ecf0f5;">
              </div>
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
    <script src="${root_url}custom/js/list_invoice.js"></script>
  </body>

</html>
