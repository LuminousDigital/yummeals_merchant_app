import 'package:flutter/material.dart';
import 'package:foodking_admin/app/data/model/response/company_info_model.dart';
import 'package:foodking_admin/app/data/model/response/deliveryboy_model.dart';
import 'package:foodking_admin/app/data/model/response/order_details_model.dart';
import 'package:foodking_admin/app/data/model/response/pos_order_details_model.dart';
import 'package:foodking_admin/app/data/model/response/pos_orders_model.dart'
    as pos;
import 'package:foodking_admin/app/data/repository/company_info_repo.dart';
import 'package:foodking_admin/app/data/repository/order_details_repo.dart';
import 'package:foodking_admin/app/data/repository/pos_order_details_repo.dart';
import 'package:foodking_admin/app/data/repository/pos_orders_repo.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/api/server.dart';

class POSOrderController extends GetxController {
  static Server server = Server();
  final posOrdersModel = pos.POSOrdersModel().obs;
  OrderDetailsModel? orderDetailsModel;
  final posOrdersList = <pos.Data>[].obs;
  POSOrderDetailsModel? posOrderDetailsModel;
  DeliveryBoyModel? deliveryBoyModel;
  CompanyInfo? companyInfo;
  RxList<pos.POSOrdersModel> posOrdersMap = <pos.POSOrdersModel>[].obs;
  RxList<OrderDetailsModel> orderDetailsMap = <OrderDetailsModel>[].obs;
  RxList<POSOrderDetailsModel> posOrderDetailsMap =
      <POSOrderDetailsModel>[].obs;
  RxList<DeliveryBoyModel> deliveryBoyMap = <DeliveryBoyModel>[].obs;
  RxList<CompanyInfo> companyInfoMap = <CompanyInfo>[].obs;

  ScrollController scrollController = ScrollController();

  int paginate = 1;
  final page = 1.obs;
  final itemPerPage = 10.obs;
  final isLoading = false.obs;
  final lastPage = 1.obs;
  bool hasMoreData = false;

  final box = GetStorage();
  bool loader = false;
  bool orderDetailsLoader = false;
  int? orderId;

  var report;

  @override
  void onInit() {
    final box = GetStorage();
    if (box.read('isLogedIn') == true && box.read('isLogedIn') != null) {
      getPOSOrdersList();
    }
    super.onInit();
  }

  getPOSOrdersList() async {
    posOrdersModel.value = await POSOrdersRepo.getPOSOrders(
      page: page.value,
      paginate: paginate,
      perPage: itemPerPage.value,
    );

    lastPage.value = posOrdersModel.value.meta?.lastPage?.toInt() ?? 1;

    if (page <= lastPage.value) {
      hasMoreData = true;
      page.value++;
    } else {
      hasMoreData = false;
    }

    posOrdersList.value += posOrdersModel.value.data!;

    refresh();
  }

  void loadMorePOSData() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getPOSOrdersList();
      }
    });
  }

  getPOSOrdersListByFilter({
    required String order_serial_no,
    required String status,
    required String user_id,
    required String order_datetime,
  }) async {
    posOrdersList.clear();
    posOrdersModel.value = await POSOrdersRepo.getPOSOrdersByFilter(
      order_serial_no: order_serial_no,
      status: status,
      user_id: user_id,
      order_datetime: order_datetime,
    );

    posOrdersList.value += posOrdersModel.value.data!;

    posOrdersMap.add(posOrdersModel.value);

    refresh();
  }

  getOrderDetails({required int id}) async {
    orderDetailsModel = await OrderDetailsRepo.getOrderDetails(id: id);

    orderDetailsMap.add(orderDetailsModel!);

    refresh();
  }

  getPOSOrderDetails({required int id}) async {
    posOrderDetailsModel = await POSOrderDetailsRepo.getPOSOrderDetails(id: id);

    posOrderDetailsMap.add(posOrderDetailsModel!);

    refresh();
  }

  getDeliveryBoyList() async {
    deliveryBoyModel = await OrderDetailsRepo.getDeliveryBoy();

    deliveryBoyMap.add(deliveryBoyModel!);

    refresh();
  }

  getCompanyInfo() async {
    companyInfo = await CompanyInfoRepo.getCompanyInfo();

    companyInfoMap.add(companyInfo!);

    refresh();
  }

  void resetState() {
    posOrdersList.clear();
    page.value = 1;
    lastPage.value = 1;
    hasMoreData = false;
  }
}
