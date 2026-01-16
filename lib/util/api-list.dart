// ignore_for_file: file_names

class APIList {
  //   static String? licenseCode = "b6d68vy2-m7g5-20r0-5275-h103w73453q120";
  static String? baseUrl = "https://staging.yummealsapp.com";
  static String? baseUrlApi = "https://staging.yummealsapp.com";
  static String? licenseCode = "z8p53xn6-n2f5-29w7-7193-s500c15553h171620";
  static String? login = "${baseUrl!}/api/auth/login";
  static String? profile = "${baseUrl!}/api/profile";
  static String? changeProfileImage = "${baseUrl!}/api/profile/change-image";
  static String? updateProfile = "${baseUrl!}/api/profile/update";
  static String? changePassword = "${baseUrl!}/api/profile/change-password";
  static String? branch = "${baseUrl!}/api/frontend/branch";
  static String? orderDetails = "${baseUrl!}/api/admin/online-order/show/";
  static String? posOorderDetails = "${baseUrl!}/api/admin/pos-order/show/";
  static String? changeOnlinePaymentStatus =
      "${baseUrl!}/api/admin/online-order/change-payment-status/";
  static String? changeOnlineOrderStatus =
      "${baseUrl!}/api/admin/online-order/change-status/";
  static String? changeOnlineOrderDeliveryBoy =
      "${baseUrl!}/api/admin/online-order/select-delivery-boy/";
  static String? changePosOrderDeliveryBoy =
      "${baseUrl!}/api/admin/pos-order/select-delivery-boy/";
  static String? changePosPaymentStatus =
      "${baseUrl!}/api/admin/pos-order/change-payment-status/";
  static String? changePosOrderStatus =
      "${baseUrl!}/api/admin/pos-order/change-status/";
  static String? configuration = "${baseUrl!}/api/frontend/setting";
  static String? countryInfo = "${baseUrl!}/api/frontend/country-code/show/";
  static String? cancelOrder = "${baseUrl!}/api/frontend/order/change-status/";
  static String? activeOrder =
      "${baseUrl!}/api/frontend/order?excepts=13|16|19|22?order_by=asc";
  static String? token = "${baseUrl!}/api/frontend/device-token/mobile";
  static String? refreshToken = "${baseUrl!}/api/refresh-token?token=";
  static String? pages = "${baseUrl!}/api/frontend/page";
  static String? language = "${baseUrl!}/api/frontend/language";
  static String? orderStatistics =
      "${baseUrl!}/api/admin/dashboard/order-statistics";
  static String? salesSummary = "${baseUrl!}/api/admin/dashboard/sales-summary";
  static String? ordersSummary =
      "${baseUrl!}/api/admin/dashboard/order-summary";
  static String? topCustomers = "${baseUrl!}/api/admin/dashboard/top-customers";
  static String? salesReport = "${baseUrl!}/api/admin/sales-report";
  static String? salesReportExport =
      "${baseUrl!}/api/admin/sales-report/export";
  static String? customers = "${baseUrl!}/api/admin/customer";
  static String? deliveryboys = "${baseUrl!}/api/admin/delivery-boy";
  static String? onlineOrders = "${baseUrl!}/api/admin/online-order";
  static String? posOrders = "${baseUrl!}/api/admin/pos-order";
  static String? changeBranch = "${baseUrl!}/api/admin/default-access";
  static String? onlineFile = "${baseUrl!}/api/admin/online-order/export";
  static String? posFile = "${baseUrl!}/api/admin/pos-order/export";
  static String? companyInfo = "${baseUrl!}/api/admin/setting/company";
}
