import 'package:foodking_admin/app/data/model/response/branch_model.dart';
import 'package:foodking_admin/app/data/model/response/order_summary_model.dart';
import 'package:foodking_admin/app/data/model/response/sales_summary_model.dart';
import 'package:foodking_admin/app/data/model/response/statistics_model.dart';
import 'package:foodking_admin/app/data/model/response/top_customers_model.dart';
import 'package:foodking_admin/app/data/repository/branch_repo.dart';
import 'package:foodking_admin/app/data/repository/my_orders_summary_repo.dart';
import 'package:foodking_admin/app/data/repository/my_sales_summary_repo.dart';
import 'package:foodking_admin/app/data/repository/my_top_customers_repo.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/api/server.dart';
import '../../../data/repository/my_statistics_repo.dart';

final box = GetStorage();

class HomeController extends GetxController {
  static Server server = Server();
  StatisticsModel? statisticsModel;
  SalesSummaryModel? salesSummaryModel;
  OrderSummaryModel? orderSummaryModel;
  TopCustomersModel? topCustomersModel;
  BranchModel? branchModel;
  RxList<StatisticsModel> statisticsMap = <StatisticsModel>[].obs;
  RxList<SalesSummaryModel> salesSummaryMap = <SalesSummaryModel>[].obs;
  RxList<OrderSummaryModel> orderSummaryMap = <OrderSummaryModel>[].obs;
  RxList<TopCustomersModel> topCustomersMap = <TopCustomersModel>[].obs;
  RxList<BranchModel> branchMap = <BranchModel>[].obs;

  final topicNameFirebase = false.obs;

  @override
  void onInit() {
    final box = GetStorage();
    if (box.read('isLogedIn') == true && box.read('isLogedIn') != null) {
      getStatisticsList();
      getSalesSummaryList();
      getOrdersSummaryList();
      getTopCustomersList();
      getBranchList();
    }
    super.onInit();
  }

  getStatisticsList() async {
    statisticsModel = await MyStatisticsRepo.getMyStatistics();

    statisticsMap.add(statisticsModel!);

    refresh();
  }

  getStatisticsListByDate(
      {required String first_date, required String last_date}) async {
    statisticsModel = await MyStatisticsRepo.getMyStatisticsByDate(
        first_date: first_date, last_date: last_date);

    statisticsMap.add(statisticsModel!);

    refresh();
  }

  getSalesSummaryList() async {
    salesSummaryModel = await MySalesSummaryRepo.getSalesSummary();

    salesSummaryMap.add(salesSummaryModel!);

    refresh();
  }

  getSalesSummaryListByDate(
      {required String first_date, required String last_date}) async {
    salesSummaryModel = await MySalesSummaryRepo.getSalesSummaryByDate(
        first_date: first_date, last_date: last_date);

    salesSummaryMap.add(salesSummaryModel!);

    refresh();
  }

  getOrdersSummaryList() async {
    orderSummaryModel = await MyOrdersSummaryRepo.getOrdersSummary();

    orderSummaryMap.add(orderSummaryModel!);

    refresh();
  }

  getOrdersSummaryListByDate(
      {required String first_date, required String last_date}) async {
    orderSummaryModel = await MyOrdersSummaryRepo.getOrdersSummaryByDate(
        first_date: first_date, last_date: last_date);

    orderSummaryMap.add(orderSummaryModel!);

    refresh();
  }

  getTopCustomersList() async {
    topCustomersModel = await MyTopCustomersRepo.getTopCustomers();

    topCustomersMap.add(topCustomersModel!);

    refresh();
  }

  getBranchList() async {
    branchModel = await BranchRepo.getBranch();

    branchMap.add(branchModel!);

    refresh();
  }
}
