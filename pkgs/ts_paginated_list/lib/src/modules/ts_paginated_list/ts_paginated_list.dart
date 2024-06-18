import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ts_paginated_list/src/common/keep_alive_widget.dart';
import 'package:ts_paginated_list/src/common/loading_indicator.dart';
import 'package:ts_paginated_list/src/common/sliver_sized_box.dart';
import 'package:ts_paginated_list/src/config/package_constants.dart';
import 'package:ts_paginated_list/ts_paginated_list.dart';

class TsPaginatedList<T> extends StatelessWidget {
  final TsPaginatedListSettings<T> settings;

  const TsPaginatedList(this.settings, {super.key});

  @override
  Widget build(BuildContext context) {
    return KeepAliveWidget(
      keepAlive: settings.keepAlive,
      child: GetBuilder(
        tag: UniqueKey().toString(),
        init: TsPaginatedListController(settings),
        builder: (controller) {
          return Obx(() {
            final status = controller.fetchStatus;

            if (status.isLoading) {
              return settings.loadingWidget ??
                  const Center(child: TsLoadingIndicator());
            }

            if (status.isError) {
              return settings.loadingErrorWidget
                      ?.call(controller.initialFetch) ??
                  Center(
                    child: IconButton(
                      onPressed: controller.initialFetch,
                      icon: const Icon(Icons.replay),
                    ),
                  );
            }

            return CustomScrollView(
              controller: controller.scrollController,
              scrollDirection: settings.scrollDirection,
              shrinkWrap: settings.shrinkWrap ?? false,
              slivers: [
                if (settings.leadingSpacing != null)
                  settings.isHorizontal
                      ? SliverSizedBox.width(settings.leadingSpacing)
                      : SliverSizedBox.height(settings.leadingSpacing),
                Obx(
                  () => (controller.fetchStatus.isSuccess ||
                              controller.fetchStatus.isMoreSuccess ||
                              controller.fetchStatus.isNoMoreData) &&
                          controller.currentData.isEmpty
                      ? SliverFillRemaining(
                          hasScrollBody: false,
                          child: settings.noResultWidget ??
                              const Center(child: Text('No result')),
                        )
                      : settings.isGrid
                          ? SliverGrid.builder(
                              itemCount: controller.currentData.length,
                              gridDelegate: settings.gridDelegate ??
                                  PackageConstants.defaultGridDelegate(
                                    context,
                                  ),
                              itemBuilder: (context, index) {
                                return settings.builder(
                                  context,
                                  controller.currentData[index],
                                  index,
                                );
                              },
                            )
                          : SliverList.builder(
                              itemCount: controller.currentData.length,
                              itemBuilder: (context, index) {
                                return settings.builder(
                                  context,
                                  controller.currentData[index],
                                  index,
                                );
                              },
                            ),
                ),
                Obx(() => controller.fetchStatus.isMoreLoading
                    ? SliverToBoxAdapter(
                        child: settings.loadingMoreWidget ??
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: settings.isHorizontal ? 50 : 0,
                                vertical: settings.isHorizontal ? 0 : 50,
                              ),
                              child: const Center(child: TsLoadingIndicator()),
                            ),
                      )
                    : const SliverSizedBox.shrink()),
                Obx(
                  () => controller.fetchStatus.isMoreError
                      ? SliverToBoxAdapter(
                          child: settings.loadingMoreErrorWidget
                                  ?.call(controller.fetchMoreData) ??
                              SizedBox(
                                width: settings.isHorizontal ? 150 : null,
                                height: settings.isHorizontal ? null : 150,
                                child: Center(
                                  child: IconButton(
                                    onPressed: controller.fetchMoreData,
                                    icon: const Icon(Icons.replay),
                                  ),
                                ),
                              ),
                        )
                      : const SliverSizedBox.shrink(),
                ),
                if (settings.trailingSpacing != null)
                  settings.isHorizontal
                      ? SliverSizedBox.width(settings.trailingSpacing)
                      : SliverSizedBox.height(settings.trailingSpacing),
              ],
            );
          });
        },
      ),
    );
  }
}
