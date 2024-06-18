import 'package:get/get.dart';
import 'package:ts_pagination_list_example/modules/pagination_page/controllers/pagination_page_controller.dart';

class PaginationPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaginationPageController>(
      () => PaginationPageController(),
    );
  }
}
