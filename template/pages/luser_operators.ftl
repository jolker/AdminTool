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
            User Operators
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li class="active">User Operators</li>
          </ol>
        </section>

        <!-- Main content -->
        <section class="content">
          <!-- content result -->
          <div class="box">
            <div class="box-header">
              <i class="ion ion-clipboard"></i>
              <a class="pull-right btn btn-primary btn-sm btn-add-page">
                Add
              </a>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table id="tb_result" class="table table-bordered table-striped">
                <thead>
                <tr>
                  <th>Id</th>
                  <th>userName</th>
                  <th>status</th>
                  <th>role</th>
                  <th>expiredAt</th>
                  <th>createdAt</th>
                  <th>updatedAt</th>
                  <th class="text-right">Action</th>
                </tr>
                </thead>
                <tbody>
                  <#if userOpsList??>
                    <#if userOpsList?has_content>
                      <#list userOpsList as user>
                        <tr>
                          <td><#if user.id??>${user.id}</#if></td>
                          <td><#if user.userName??>${user.userName}</#if></td>
                          <td><#if user.status??>${user.status}</#if></td>
                          <td><#if user.role??>${user.role}</#if></td>
                          <td><#if user.expiredAt??>${user.expiredAt?string('yyyy-MM-dd HH:mm:ss')}</#if></td>
                          <td><#if user.createdAt??>${user.createdAt?string('yyyy-MM-dd HH:mm:ss')}</#if></td>
                          <td><#if user.updatedAt??>${user.updatedAt?string('yyyy-MM-dd HH:mm:ss')}</#if></td>
                          <td>
                            <a class="btn btn-info btn-sm pull-right btn-detail disabled" data-promo-id="<#if user.id??>${user.id}</#if>">
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

      <div class="modal fade" id="modal_user_oper">
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
    <script src="${root_url}custom/js/luser_operators.js"></script>
  </body>

</html>
