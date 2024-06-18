import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ts_paginated_list/src/common/keep_alive_widget.dart';
import 'package:ts_paginated_list/src/common/loading_indicator.dart';
import 'package:ts_paginated_list/ts_paginated_list.dart';

class TsPaginatedPageView<T> extends StatelessWidget {
  final TsPaginatedPageSettings<T> settings;

  const TsPaginatedPageView(this.settings, {super.key});

  @override
  Widget build(BuildContext context) {
    return KeepAliveWidget(
      keepAlive: settings.keepAlive,
      child: GetBuilder(
        tag: UniqueKey().toString(),
        init: TsPaginatedPageController(settings),
        builder: (controller) {
          return Obx(() {
            final fetchStatus = controller.fetchStatus;

            if (fetchStatus.isLoading) {
              return settings.loadingPageWidget ??
                  const Center(child: TsLoadingIndicator());
            }

            if (fetchStatus.isError) {
              return settings.loadingErrorWidget
                      ?.call(controller.initialFetch) ??
                  Center(
                    child: IconButton(
                      onPressed: controller.initialFetch,
                      icon: const Icon(Icons.replay),
                    ),
                  );
            }

            return PageView.builder(
              scrollDirection: settings.scrollDirection,
              physics: settings.scrollPhysics ?? const ClampingScrollPhysics(),
              controller: controller.pageController,
              onPageChanged: controller.onPageChanged,
              itemCount: fetchStatus.isMoreLoading || fetchStatus.isMoreError
                  ? controller.currentData.length + 1
                  : controller.currentData.length,
              itemBuilder: (context, index) {
                if ((fetchStatus.isMoreLoading || fetchStatus.isMoreError) &&
                    index == controller.currentData.length) {
                  if (fetchStatus.isMoreLoading) {
                    return settings.additionalLoadingWidget ??
                        const Center(child: TsLoadingIndicator());
                  }

                  if (fetchStatus.isMoreError) {
                    return settings.loadingMoreErrorWidget
                            ?.call(controller.fetchMoreData) ??
                        Center(
                          child: IconButton(
                            onPressed: controller.fetchMoreData,
                            icon: const Icon(Icons.replay),
                          ),
                        );
                  }
                }

                return settings.builder(
                  context,
                  controller.currentData[index],
                  index,
                );
              },
            );
          });
        },
      ),
    );
  }
}
