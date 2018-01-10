<div class="box-body">
  <div class="row">
    <#if invoice??>
      <!-- <div class="box">
        <div class="box-body">
          <table class="table table-bordered">
            <tr>
              <th>invoiceId</th>
              <th>userId</th>
              <th>userName</th>
              <th>userIp</th>
              <th>userGroup</th>
              <th>sourceName</th>
              <th>marketingCampaign</th>
              <th>nCoinPromotion</th>
            </tr>
            <tr>
              <td>
                <#if invoice.invoiceId??>${invoice.invoiceId}</#if>
              </td>
              <td>
                <#if invoice.userId??>${invoice.userId}</#if>
              </td>
              <td>
                <#if invoice.userName??>${invoice.userName}</#if>
              </td>
              <td>
                <#if invoice.userIp??>${invoice.userIp}</#if>
              </td>
              <td>
                <#if invoice.userGroup??>${invoice.userGroup}</#if>
              </td>
              <td>
                <#if invoice.sourceName??>${invoice.sourceName}</#if>
              </td>
              <td>
                <#if invoice.marketingCampaign??>${invoice.marketingCampaign}</#if>
              </td>
              <td>
                <#if invoice.nCoinPromotion??>${invoice.nCoinPromotion}</#if>
              </td>
            </tr>
          </table>
        </div>
      </div>
      <div class="box">
        <div class="box-body">
          <table class="table table-bordered">
            <tr>
              <th>localCampaign</th>
              <th>appPackageId</th>
              <th>appPlatform</th>
              <th>nCoinBefore</th>
              <th>userRetention</th>
              <th>productId</th>
              <th>productKey</th>
              <th>productType</th>
            </tr>
            <tr>
              <td>
                <#if invoice.localCampaign??>${invoice.localCampaign}</#if>
              </td>
              <td>
                <#if invoice.appPackageId??>${invoice.appPackageId}</#if>
              </td>
              <td>
                <#if invoice.appPlatform??>${invoice.appPlatform}</#if>
              </td>
              <td>
                <#if invoice.nCoinBefore??>${invoice.nCoinBefore}</#if>
              </td>
              <td>
                <#if invoice.userRetention??>${invoice.userRetention}</#if>
              </td>
              <td>
                <#if invoice.productId??>${invoice.productId}</#if>
              </td>
              <td>
                <#if invoice.productKey??>${invoice.productKey}</#if>
              </td>
              <td>
                <#if invoice.productType??>${invoice.productType}</#if>
              </td>
            </tr>
          </table>
        </div>
      </div> -->
      <!-- <div class="box">
        <div class="box-body">
          <table class="table table-bordered">
            <tr>
              <th>data</th>
              <th>amount</th>
              <th>nCoinPaid</th>
              <th>refId</th>
            </tr>
            <tr>
              <td>
                <#if invoice.data??>${invoice.data}</#if>
              </td>
              <td>
                <#if invoice.amount??>${invoice.amount}</#if>
              </td>
              <td>
                <#if invoice.nCoinPaid??>${invoice.nCoinPaid}</#if>
              </td>
              <td>
                <#if invoice.refId??>${invoice.refId}</#if>
              </td>
            </tr>
          </table>
        </div>
      </div> -->
      <!-- /.box -->
      <!-- <div class="box">
        <div class="box-body">
          <table class="table table-bordered">
            <tr>
              <th>purchasedDate</th>
              <th>completedDate</th>
              <th>partnerId</th>
              <th>partnerStatus</th>
              <th>promotionType</th>
              <th>promotionRate</th>
              <th>status</th>
            </tr>
            <tr>
              <td><span class="format-date-detail-invoice"><#if invoice.purchasedDate??>${invoice.purchasedDate}</#if></span></td>
              <td><span class="format-date-detail-invoice"><#if invoice.completedDate??>${invoice.completedDate}</#if></span></td>
              <td>
                <#if invoice.partnerId??>${invoice.partnerId}</#if>
              </td>
              <td>
                <#if invoice.partnerStatus??>${invoice.partnerStatus}</#if>
              </td>
              <td>
                <#if invoice.promotionType??>${invoice.promotionType}</#if>
              </td>
              <td>
                <#if invoice.promotionRate??>${invoice.promotionRate}</#if>
              </td>
              <td>
                <#if invoice.status??>
                  <#if invoice.status==0>
                    COMPLETE
                    <#else>
                      ERROR
                  </#if>
                </#if>
              </td>
            </tr>
          </table>
        </div>
      </div> -->
      <!-- /.box -->
      <div class="box" style="width: 80%; margin: 0 auto;">
        <div class="box-body">
          <table class="table table-bordered table-detail-invoice">
            <tr>
              <th>invoiceId</th>
              <td>
                <#if invoice.invoiceId??>${invoice.invoiceId}</#if>
              </td>
            </tr>
            <tr>
              <th>userId</th>
              <td>
                <#if invoice.userId??>${invoice.userId}</#if>
              </td>
            </tr>
            <tr>
              <th>userName</th>
              <td>
                <#if invoice.userName??>${invoice.userName}</#if>
              </td>
            </tr>
            <tr>
              <th>status</th>
              <td>
                <#if invoice.status??>
                  <#if invoice.status == 0>
                    ERROR
                  <#else>
                    COMPLETED
                  </#if>
                </#if>
              </td>
            </tr>
            <tr>
              <th>amount</th>
              <td>
                <#if invoice.amount??>${invoice.amount}</#if>
              </td>
            </tr>
            <tr>
              <th>nCoinPaid</th>
              <td>
                <#if invoice.nCoinPaid??>${invoice.nCoinPaid}</#if>
              </td>
            </tr>
            <tr>
              <th>nCoinPromotion</th>
              <td>
                <#if invoice.nCoinPromotion??>${invoice.nCoinPromotion}</#if>
              </td>
            </tr>
            <tr>
              <th>nCoinBefore</th>
              <td>
                <#if invoice.nCoinBefore??>${invoice.nCoinBefore}</#if>
              </td>
            </tr>
            <tr>
              <th>purchasedDate</th>
              <td><span class="format-date-detail-invoice"><#if invoice.purchasedDate??>${invoice.purchasedDate}</#if></span></td>
            </tr>
            <tr>
              <th>completedDate</th>
              <td><span class="format-date-detail-invoice"><#if invoice.completedDate??>${invoice.completedDate}</#if></span></td>
            </tr>
            <tr>
              <th>partnerId</th>
              <td>
                <#if invoice.partnerId??>${invoice.partnerId}</#if>
              </td>
            </tr>
            <tr>
              <th>partnerStatus</th>
              <td>
                <#if invoice.partnerStatus??>
                  <#if invoice.partnerStatus == 0>
                    ERROR
                  <#else>
                    COMPLETED
                  </#if>
                </#if>
              </td>
            </tr>
            <tr>
              <th>appPlatform</th>
              <td>
                <#if invoice.appPlatform??>${invoice.appPlatform}</#if>
              </td>
            </tr>
            <tr>
              <th>appPackageId</th>
              <td>
                <#if invoice.appPackageId??>${invoice.appPackageId}</#if>
              </td>
            </tr>
            <tr>
              <th>promotionType</th>
              <td>
                <#if invoice.promotionType??>${invoice.promotionType}</#if>
              </td>
            </tr>
            <tr>
              <th>promotionRate</th>
              <td>
                <#if invoice.promotionRate??>${invoice.promotionRate}</#if>
              </td>
            </tr>
            <tr>
              <th>userGroup</th>
              <td>
                <#if invoice.userGroup??>${invoice.userGroup}</#if>
              </td>
            </tr>
            <tr>
              <th>userIp</th>
              <td>
                <#if invoice.userIp??>${invoice.userIp}</#if>
              </td>
            </tr>
            <tr>
              <th>userRetention</th>
              <td>
                <#if invoice.userRetention??>${invoice.userRetention}</#if>
              </td>
            </tr>
            <tr>
              <th>productId</th>
              <td>
                <#if invoice.productId??>${invoice.productId}</#if>
              </td>
            </tr>
            <tr>
              <th>productType</th>
              <td>
                <#if invoice.productType??>${invoice.productType}</#if>
              </td>
            </tr>
            <tr>
              <th>productKey</th>
              <td>
                <#if invoice.productKey??>${invoice.productKey}</#if>
              </td>
            </tr>
            <tr>
              <th>sourceName</th>
              <td>
                <#if invoice.sourceName??>${invoice.sourceName}</#if>
              </td>
            </tr>
            <tr>
              <th>localCampaign</th>
              <td>
                <#if invoice.localCampaign??>${invoice.localCampaign}</#if>
              </td>
            </tr>
            <tr>
              <th>marketingCampaign</th>
              <td>
                <#if invoice.marketingCampaign??>${invoice.marketingCampaign}</#if>
              </td>
            </tr>
            <tr>
              <th>refId</th>
              <td>
                <#if invoice.refId??>${invoice.refId}</#if>
              </td>
            </tr>
            <tr>
              <th>data</th>
              <td>
                <#if invoice.data??>${invoice.data}</#if>
              </td>
            </tr>
          </table>
        </div>
      </div>
      <#else>
        <h3>NOT FOUND DATA</h3>
    </#if>
  </div>
</div>
