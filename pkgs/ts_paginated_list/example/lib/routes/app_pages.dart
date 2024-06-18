import 'package:get/get.dart';
import 'package:ts_pagination_list_example/modules/pagination_body/bindings/pagination_body_bindings.dart';
import 'package:ts_pagination_list_example/modules/pagination_body/views/pagination_body_view.dart';
import 'package:ts_pagination_list_example/modules/pagination_inside_list/bindings/pagintaion_inside_list_controller.dart';
import 'package:ts_pagination_list_example/modules/pagination_inside_list/views/pagination_inside_list_view.dart';
import 'package:ts_pagination_list_example/modules/pagination_page/bindings/pagination_page_bindings.dart';
import 'package:ts_pagination_list_example/modules/pagination_page/views/pagination_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final List<GetPage> routes = [
    GetPage(
      name: Routes.paginationBody,
      page: () => const PaginationBodyView(),
      binding: PaginationBodyBindings(),
    ),
    GetPage(
      name: Routes.paginationInsideList,
      page: () => const PaginationInsideListView(),
      binding: PaginationInsideListBindings(),
    ),
    GetPage(
      name: Routes.paginationPage,
      page: () => const PaginationPageView(),
      binding: PaginationPageBindings(),
    ),
  ];
}
