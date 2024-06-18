import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ts_pagination_list_example/modules/pagination_body/controllers/pagination_body_view.dart';

import 'package:ts_paginated_list/ts_paginated_list.dart';

class PaginationBodyView extends GetView<PaginationBodyController> {
  const PaginationBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Pagination List',
          style: TextStyle(fontSize: 14),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TsPaginatedList(
          TsPaginatedListSettings.list(
            initialPage: 0,
            limit: 10,
            leadingSpacing: 10,
            fetchData: controller.fetchData,
            builder: (context, item, _) {
              return Card(
                child: ListTile(
                  title: Text(
                    item.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    item.description,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
