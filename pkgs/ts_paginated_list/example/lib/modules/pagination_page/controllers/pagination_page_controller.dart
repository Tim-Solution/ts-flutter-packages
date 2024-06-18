import 'dart:math';

import 'package:get/get.dart';
import 'package:ts_pagination_list_example/data/models/dummy_model.dart';
import 'package:ts_pagination_list_example/data/repositoryes/dummy_data_repository.dart';

import 'package:ts_paginated_list/ts_paginated_list.dart';

class PaginationPageController extends GetxController {
  Future<TsPaginatedListResult<DummyModel>> fetchData(
    int page,
    int limit,
  ) async {
    final response = await DummyDataRepository.getDummyData(
      page: page,
      limit: limit,
    );

    return TsPaginatedListResult(
      data: response,
      isSuccess: Random().nextBool(),
    );
  }
}
