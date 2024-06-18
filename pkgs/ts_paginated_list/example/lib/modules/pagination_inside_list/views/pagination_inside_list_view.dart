import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ts_pagination_list_example/modules/pagination_inside_list/controllers/pagination_inside_list_controller.dart';

import 'package:ts_paginated_list/ts_paginated_list.dart';

class PaginationInsideListView extends GetView<PaginationInsideListController> {
  const PaginationInsideListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Pagination Inside List',
          style: TextStyle(fontSize: 14),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomScrollView(
          controller: controller.scrollController,
          slivers: [
            const SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Text(
                    'Example of usage of pagination inside a list.',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'This example shows how to use the TsPaginationList inside a list.',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
            TsPaginatedListInsideScroll.sliver(
              TsPaginatedListSettings.insideListScrollAsList(
                scrollController: controller.scrollController,
                initialPage: 0,
                limit: 5,
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
          ],
        ),
      ),
    );
  }
}
