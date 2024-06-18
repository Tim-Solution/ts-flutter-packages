import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ts_paginated_list/src/common/keep_alive_widget.dart';
import 'package:ts_paginated_list/src/common/loading_indicator.dart';
import 'package:ts_paginated_list/src/config/package_constants.dart';
import 'package:ts_paginated_list/ts_paginated_list.dart';

class TsPaginatedListInsideScroll<T> extends StatelessWidget {
  final bool _isSliver;
  final TsPaginatedListSettings<T> settings;

  /// Please use this constructor when you want to have pagination list inside
  /// `CustomScrollView`.
  TsPaginatedListInsideScroll.sliver(this.settings, {super.key})
      : assert(
          settings.isInsideListScroll,
          'Please pass TsPaginatedListSettings.insideListScroll...',
        ),
        _isSliver = true;

  /// Please use this constructor when you want to have pagination list inside
  /// `ListView`, `SingleChildScrollView`, etc.
  TsPaginatedListInsideScroll.nonSliver(this.settings, {super.key})
      : assert(
          settings.isInsideListScroll,
          'Please pass TsPaginatedListSettings.insideListScroll...',
        ),
        _isSliver = false;

  @override
  Widget build(BuildContext context) {
    return _isSliver
        ? SliverToBoxAdapter(child: _buildChild(context))
        : _buildChild(context);
  }

  Widget _buildChild(BuildContext context) {
    return KeepAliveWidget(
      keepAlive: settings.keepAlive,
      child: GetBuilder(
        tag: UniqueKey().toString(),
        init: TsPaginatedListController(settings),
        builder: (controller) {
          return Obx(
            () {
              final status = controller.fetchStatus;

              if (status.isLoading) {
                return settings.loadingWidget ??
                    const Center(child: TsLoadingIndicator());
              }

              if (status.isError) {
                return settings.loadingErrorWidget
                        ?.call(controller.initialFetch) ??
                    IconButton(
                      onPressed: controller.initialFetch,
                      icon: const Icon(Icons.replay),
                    );
              }

              return Column(
                children: [
                  if (settings.leadingSpacing != null)
                    settings.isHorizontal
                        ? SizedBox(width: settings.leadingSpacing)
                        : SizedBox(height: settings.leadingSpacing),
                  Obx(
                    () => (controller.fetchStatus.isSuccess ||
                                controller.fetchStatus.isMoreSuccess ||
                                controller.fetchStatus.isNoMoreData) &&
                            controller.currentData.isEmpty
                        ? settings.noResultWidget ??
                            const Center(child: Text('No result'))
                        : settings.isGrid
                            ? GridView.builder(
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: settings.scrollDirection,
                                shrinkWrap: true,
                                gridDelegate: settings.gridDelegate ??
                                    PackageConstants.defaultGridDelegate(
                                      context,
                                    ),
                                itemCount: controller.currentData.length,
                                itemBuilder: (context, index) {
                                  return settings.builder(
                                    context,
                                    controller.currentData[index],
                                    index,
                                  );
                                },
                              )
                            : ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: settings.scrollDirection,
                                shrinkWrap: true,
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
                  Obx(
                    () => controller.fetchStatus.isMoreLoading
                        ? settings.loadingMoreWidget ??
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: settings.isHorizontal ? 50 : 0,
                                vertical: settings.isHorizontal ? 0 : 50,
                              ),
                              child: const Center(child: TsLoadingIndicator()),
                            )
                        : const SizedBox.shrink(),
                  ),
                  Obx(
                    () => controller.fetchStatus.isMoreError
                        ? settings.loadingMoreErrorWidget
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
                            )
                        : const SizedBox.shrink(),
                  ),
                  if (settings.trailingSpacing != null)
                    settings.isHorizontal
                        ? SizedBox(width: settings.trailingSpacing)
                        : SizedBox(height: settings.trailingSpacing),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
