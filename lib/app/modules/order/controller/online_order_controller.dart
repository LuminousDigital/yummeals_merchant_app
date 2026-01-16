import 'package:flutter/material.dart';
import 'package:foodking_admin/app/data/model/response/company_info_model.dart';
import 'package:foodking_admin/app/data/model/response/deliveryboy_model.dart';
import 'package:foodking_admin/app/data/model/response/online_orders_model.dart'
    as online;
import 'package:foodking_admin/app/data/model/response/order_details_model.dart';
import 'package:foodking_admin/app/data/repository/company_info_repo.dart';
import 'package:foodking_admin/app/data/repository/online_orders_repo.dart';
import 'package:foodking_admin/app/data/repository/order_details_repo.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/api/server.dart';

class OnlineOrderController extends GetxController {
  static Server server = Server();
  final onlineOrdersModel = online.OnlineOrdersModel().obs;
  final onlineOrdersList = <online.Data>[].obs;
  final onlineOrderLoader = false.obs;
  OrderDetailsModel? orderDetailsModel;
  DeliveryBoyModel? deliveryBoyModel;
  CompanyInfo? companyInfo;
  RxList<online.OnlineOrdersModel> onlineOrdersMap =
      <online.OnlineOrdersModel>[].obs;
  RxList<OrderDetailsModel> orderDetailsMap = <OrderDetailsModel>[].obs;
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
  String? orderUuid;

  var report;

  @override
  void onInit() {
    final box = GetStorage();
    if (box.read('isLogedIn') == true && box.read('isLogedIn') != null) {
      getOnlineOrdersList();
    }
    super.onInit();
  }

  getOnlineOrdersList() async {
    onlineOrderLoader.value = true;
    onlineOrdersModel.value = await OnlineOrdersRepo.getOnlineOrders(
      page: page.value.toString(),
      paginate: paginate.toString(),
      perPage: itemPerPage.toString(),
    );

    lastPage.value = onlineOrdersModel.value.meta!.lastPage!.toInt();
    onlineOrderLoader.value = false;
    if (page <= lastPage.value) {
      hasMoreData = true;
      page.value++;
    } else {
      hasMoreData = false;
    }

    onlineOrdersList.value += onlineOrdersModel.value.data ?? [];

    refresh();
    onlineOrderLoader.value = false;
  }

  void loadMoreOnlineData() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getOnlineOrdersList();
      }
    });
  }

  getOnlineOrdersListByFilter({
    required String order_serial_no,
    required String status,
    required String user_id,
    required String order_datetime,
  }) async {
    onlineOrdersList.clear();
    onlineOrdersModel.value = await OnlineOrdersRepo.getOnlineOrdersByFilter(
      order_serial_no: order_serial_no,
      status: status,
      user_id: user_id,
      order_datetime: order_datetime,
    );

    onlineOrdersList.value += onlineOrdersModel.value.data!;

    onlineOrdersMap.add(onlineOrdersModel.value);

    refresh();
  }

  getOrderDetailsByUuid({required String uuid}) async {
    orderDetailsModel = await OrderDetailsRepo.getOrderDetailsByUuid(
      uuid: uuid,
    );

    orderDetailsMap.add(orderDetailsModel!);

    refresh();
  }

  getOrderDetails({required int id}) async {
    orderDetailsModel = await OrderDetailsRepo.getOrderDetails(id: id);

    orderDetailsMap.add(orderDetailsModel!);

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
    onlineOrdersList.clear();
    page.value = 1;
    lastPage.value = 1;
    hasMoreData = false;
  }
}
