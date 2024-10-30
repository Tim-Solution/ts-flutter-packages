import 'package:flutter/material.dart';

import 'package:ts_paginated_list/src/data/models/ts_paginated_list_result.dart';

class TsPaginatedPageSettings<T> {
  /// The initial page to fetch.
  final int initialPage;

  /// The number of items to fetch in each request.
  final int limit;

  /// Represents the number of items remaining in the list when the fetch more
  /// should be called.
  ///
  /// Default is 3.
  final int fetchMoreWhenRemaining;

  /// The physics for the page view.
  final ScrollPhysics? scrollPhysics;

  /// Scroll direction for the page view.
  final Axis scrollDirection;

  /// Keep the widget alive when navigating to another page or somehting similar.
  final bool keepAlive;

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

  /// Function to build the widget for each item in the list.
  final Widget Function(BuildContext context, T item, int index) builder;

  /// The widget to display when there is no result.
  final Widget? noResultWidget;

  /// This page will be shown when the data is being fetched.
  final Widget? loadingPageWidget;

  /// This page will be shown when the data is being fetched.
  final Widget? additionalLoadingWidget;

  /// The widget to display when the initial fetch has an error.
  final Widget Function(Future Function() reload)? loadingErrorWidget;

  /// The widget to display when the fetch more has an error.
  final Widget Function(Future Function() reload)? loadingMoreErrorWidget;

  TsPaginatedPageSettings({
    required this.initialPage,
    required this.limit,
    required this.fetchData,
    required this.builder,
    this.fetchMoreWhenRemaining = 3,
    this.keepAlive = false,
    this.scrollDirection = Axis.vertical,
    this.scrollPhysics,
    this.noResultWidget,
    this.loadingPageWidget,
    this.additionalLoadingWidget,
    this.loadingErrorWidget,
    this.loadingMoreErrorWidget,
  });
}
