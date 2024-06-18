import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ts_pagination_list_example/modules/pagination_page/controllers/pagination_page_controller.dart';

import 'package:ts_paginated_list/ts_paginated_list.dart';

class PaginationPageView extends GetView<PaginationPageController> {
  const PaginationPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Pagination Page View',
          style: TextStyle(fontSize: 14),
        ),
      ),
      body: TsPaginatedPageView(
        TsPaginatedPageSettings(
          initialPage: 0,
          limit: 5,
          fetchData: controller.fetchData,
          builder: (context, item, _) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.title.toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      item.description,
                      style: const TextStyle(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
