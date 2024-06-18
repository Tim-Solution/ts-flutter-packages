import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ts_pagination_list_example/routes/app_pages.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TsPaginationList Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TsPaginationListExample(),
      getPages: AppPages.routes,
    );
  }
}

class TsPaginationListExample extends StatelessWidget {
  const TsPaginationListExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.toNamed(Routes.paginationBody),
                child: const Text('Pagination list in body'),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.toNamed(Routes.paginationInsideList),
                child: const Text('Pagination list existing scroll view'),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.toNamed(Routes.paginationPage),
                child: const Text('Pagination page view'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
