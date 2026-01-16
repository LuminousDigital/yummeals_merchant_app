import 'package:flutter/material.dart';
import 'package:foodking_admin/app/data/model/response/customers_model.dart';
import 'package:foodking_admin/app/data/model/response/sales_report_model.dart'
    as sales;
import 'package:foodking_admin/app/data/repository/sales_report_repo.dart';
import 'package:get/get.dart';
import '../../../data/api/server.dart';

class SalesController extends GetxController {
  static Server server = Server();
  final salesReportModel = sales.SalesReportModel().obs;
  final salesList = <sales.Data>[].obs;
  CustomersModel? customersModel;
  RxList<sales.SalesReportModel> salesReportMap =
      <sales.SalesReportModel>[].obs;
  RxList<CustomersModel> customersMap = <CustomersModel>[].obs;

  ScrollController scrollController = ScrollController();

  int paginate = 1;
  final page = 1.obs;
  final itemPerPage = 10.obs;
  final isLoading = false.obs;
  final lastPage = 1.obs;
  bool hasMoreData = false;

  var report;

  @override
  void onInit() {
    // final box = GetStorage();
    // bool isLogedIn = box.read('isLogedIn');
    // if (isLogedIn) {
    //   getSalesReportList();
    //   getCustomersList();
    // }

    super.onInit();
  }

  getSalesReportList() async {
    salesReportModel.value = await SalesReportRepo.getSalesReport(
      page: page.value,
      paginate: paginate,
      perPage: itemPerPage.value,
    );

    lastPage.value = salesReportModel.value.meta!.lastPage!.toInt();

    if (page <= lastPage.value) {
      hasMoreData = true;
      page.value++;
    } else {
      hasMoreData = false;
    }

    salesList.value += salesReportModel.value.data!;

    refresh();
  }

  void loadMoreSalesData() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getSalesReportList();
      }
    });
  }

  getSalesReportListByFilter({
    required String order_serial_no,
    required String status,
    required String user_id,
    required String order_datetime,
  }) async {
    salesReportModel.value = await SalesReportRepo.getSalesReportByFilter(
        order_serial_no: order_serial_no,
        status: status,
        user_id: user_id,
        order_datetime: order_datetime);

    salesReportMap.add(salesReportModel.value);

    refresh();
  }

  getCustomersList() async {
    customersModel = await SalesReportRepo.getCustomers();

    customersMap.add(customersModel!);

    refresh();
  }

  void resetState() {
    salesList.clear();
    page.value = 1;
    lastPage.value = 1;
    hasMoreData = false;
  }
}
