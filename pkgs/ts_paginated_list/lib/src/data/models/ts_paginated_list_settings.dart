import 'package:flutter/material.dart';

import 'package:ts_paginated_list/ts_paginated_list.dart';

class TsPaginatedListSettings<T> {
  /// The controller for the list which will be listening to the scroll events.
  final ScrollController scrollController;

  /// Function to fetch data. The function should return a [Future] of
  /// [TsPaginatedListResult].
  ///
  /// Example:
  ///
  /// ```dart
  /// Future<TsPaginatedListResult<String>> fetchData(int page, int limit) async {
  ///   final response = await http.get(
  ///     'https://api.example.com/data?page=$page&limit=$limit',
  ///   );
  ///   return TsPaginatedListResult(
  ///     data: jsonDecode(response.body) as List<String>,
  ///     isSuccess: response.statusCode == 200,
  ///   );
  /// }
  /// ```
  final Future<TsPaginatedListResult<T>> Function(int page, int limit) fetchData;

  /// The number of items to fetch in each request.
  final int limit;

  /// Pass initial page for fetching data. Default is 0.
  final int initialPage;

  /// The widget to display when fetching the initial data.
  final Widget? loadingWidget;

  /// The widget to display when fetching more data.
  final Widget? loadingMoreWidget;

  /// Function to build the widget for each item in the list.
  final Widget Function(BuildContext context, T item, int index) builder;

  /// The widget to display when the initial fetch has an error.
  final Widget Function(Future Function() reload)? loadingErrorWidget;

  /// The widget to display when the fetch more has an error.
  final Widget Function(Future Function() reload)? loadingMoreErrorWidget;

  /// The widget to display when there is no result.
  final Widget? noResultWidget;

  /// The direction in which the list should scroll.
  ///
  /// Default is [Axis.vertical].
  final Axis scrollDirection;

  /// The physics of the scroll view.
  final ScrollPhysics? scrollBehavior;

  /// Whether the list should shrink-wrap its contents.
  final bool? shrinkWrap;

  /// If true, the listener will be removed when there is no more data to fetch.
  final bool removeListenerIfNoMoreData;

  /// The delegate to use for the grid.
  final SliverGridDelegate? gridDelegate;

  /// Spacing before the list.
  final double? leadingSpacing;

  /// Spacing after the list.
  final double? trailingSpacing;

  /// The number of pixels before the end of the list at which point the
  /// [fetchMoreData] callback will be triggered.
  final double startFetchBeforePixels;

  /// If true, the list will not be disposed when navigating to another page, or
  /// you use list inside pageview, etc. Default is false.
  final bool keepAlive;

  /// Callback when the list is created. Can be used to access the controller
  /// data and methods.
  final Function(TsPaginatedListController<T> controller)? onCreated;

  /// Callback when the page changes.
  final Function(int page)? onPageChange;

  /// Callback when the data is updated.
  final Function(List<T> data)? onDataUpdate;

  final bool _isGrid;
  final bool _isInsideListScroll;

  TsPaginatedListSettings.list({
    required this.initialPage,
    required this.limit,
    required this.fetchData,
    required this.builder,
    this.loadingWidget,
    this.loadingMoreWidget,
    this.loadingErrorWidget,
    this.loadingMoreErrorWidget,
    this.noResultWidget,
    this.scrollDirection = Axis.vertical,
    this.scrollBehavior,
    this.startFetchBeforePixels = 150,
    this.shrinkWrap,
    this.leadingSpacing,
    this.trailingSpacing,
    this.removeListenerIfNoMoreData = false,
    this.keepAlive = false,
    this.onCreated,
    this.onPageChange,
    this.onDataUpdate,
  })  : _isInsideListScroll = false,
        scrollController = ScrollController(),
        _isGrid = false,
        gridDelegate = null;

  TsPaginatedListSettings.grid({
    required this.initialPage,
    required this.limit,
    required this.fetchData,
    required this.builder,
    this.loadingWidget,
    this.loadingMoreWidget,
    this.loadingErrorWidget,
    this.loadingMoreErrorWidget,
    this.noResultWidget,
    this.scrollBehavior,
    this.startFetchBeforePixels = 150,
    this.shrinkWrap,
    this.removeListenerIfNoMoreData = false,
    this.keepAlive = false,
    this.gridDelegate,
    this.leadingSpacing,
    this.trailingSpacing,
    this.onCreated,
    this.onPageChange,
    this.onDataUpdate,
  })  : scrollController = ScrollController(),
        scrollDirection = Axis.vertical,
        _isInsideListScroll = false,
        _isGrid = true;

  TsPaginatedListSettings.insideListScrollAsList({
    required this.scrollController,
    required this.initialPage,
    required this.limit,
    required this.fetchData,
    required this.builder,
    this.loadingWidget,
    this.loadingMoreWidget,
    this.loadingErrorWidget,
    this.loadingMoreErrorWidget,
    this.noResultWidget,
    this.scrollDirection = Axis.vertical,
    this.startFetchBeforePixels = 150,
    this.shrinkWrap,
    this.removeListenerIfNoMoreData = false,
    this.keepAlive = false,
    this.leadingSpacing,
    this.trailingSpacing,
    this.onCreated,
    this.onPageChange,
    this.onDataUpdate,
  })  : scrollBehavior = null,
        gridDelegate = null,
        _isInsideListScroll = true,
        _isGrid = false;

  TsPaginatedListSettings.insideListScrollAsGrid({
    required this.scrollController,
    required this.initialPage,
    required this.limit,
    required this.fetchData,
    required this.builder,
    this.loadingWidget,
    this.loadingMoreWidget,
    this.loadingErrorWidget,
    this.loadingMoreErrorWidget,
    this.noResultWidget,
    this.scrollDirection = Axis.vertical,
    this.startFetchBeforePixels = 150,
    this.shrinkWrap,
    this.removeListenerIfNoMoreData = false,
    this.keepAlive = false,
    this.gridDelegate,
    this.leadingSpacing,
    this.trailingSpacing,
    this.onCreated,
    this.onPageChange,
    this.onDataUpdate,
  })  : scrollBehavior = null,
        _isInsideListScroll = true,
        _isGrid = true;

  bool get isGrid => _isGrid;
  bool get isInsideListScroll => _isInsideListScroll;
  bool get isHorizontal => scrollDirection == Axis.horizontal;
}
