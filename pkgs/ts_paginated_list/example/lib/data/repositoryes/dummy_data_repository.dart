import 'dart:developer' as dev;
import 'dart:math';

import 'package:ts_pagination_list_example/data/models/dummy_model.dart';

/// This is a dummy repository to simulate the data fetching for pagination.
class DummyDataRepository {
  static Future<List<DummyModel>> getDummyData({
    required int page,
    required int limit,
  }) async {
    dev.log(
      '\x1B[38;2;255;0;0;mGetting dummy data for page: $page, limit: $limit',
    );

    await Future.delayed(Duration(seconds: Random().nextInt(2) + 1));

    final List<DummyModel> dummyData = <DummyModel>[];

    for (int i = 0; i < limit; i++) {
      final int index = i + (page * limit) + 1;
      dummyData.add(
        DummyModel(
          title: 'Title $index',
          description: _getDummyDescription,
        ),
      );
    }

    if (page >= 3) {
      /// For simulate the end of the pagination
      return dummyData.sublist(0, dummyData.length - 1);
    }

    dev.log(
      '\x1B[38;2;255;0;0;mGot dummy data for page: $page, limit: $limit, dataLength: ${dummyData.length}',
    );

    return dummyData;
  }

  static String get _getDummyDescription {
    return 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.';
  }
}
