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
            Dashboard
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li class="active">Dashboard</li>
          </ol>
        </section>
        <!-- Main content -->
        <div class="pad margin no-print">
          <div class="callout callout-info" style="margin-bottom: 0!important;">
            <h4><i class="fa fa-info"></i> Note:</h4>
              Nplay Admin
            </div>
        </div>
        <!-- /.content -->
      </div>
      <!-- /.content-wrapper -->

      <!-- footer -->
      <#include "footer.ftl">
      <!-- end footer -->
    </div>
    <!-- ./wrapper -->

    <#include "script.ftl">
    <script src="${root_url}custom/js/home.js"></script>
  </body>

</html>
