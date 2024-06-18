import 'package:get/get.dart';
import 'package:ts_pagination_list_example/modules/pagination_body/controllers/pagination_body_view.dart';

class PaginationBodyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaginationBodyController>(
      () => PaginationBodyController(),
    );
  }
}
