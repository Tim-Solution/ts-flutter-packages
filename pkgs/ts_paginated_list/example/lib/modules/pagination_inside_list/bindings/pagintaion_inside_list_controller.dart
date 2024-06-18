import 'package:get/get.dart';
import 'package:ts_pagination_list_example/modules/pagination_inside_list/controllers/pagination_inside_list_controller.dart';

class PaginationInsideListBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaginationInsideListController>(
      () => PaginationInsideListController(),
    );
  }
}
