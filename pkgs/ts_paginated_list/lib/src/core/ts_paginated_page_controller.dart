import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import 'package:ts_paginated_list/src/data/enums/ts_paginated_fetch_status.dart';
import 'package:ts_paginated_list/src/data/models/ts_paginated_page_settings.dart';

class TsPaginatedPageController<T> extends GetxController {
  final TsPaginatedPageSettings<T> settings;

  TsPaginatedPageController(this.settings);

  int _currentFetchPage = 0;
  final _pageController = PageController();
  final _currentPage = 0.obs;
  final _data = <T>[].obs;
  final _fetchStatus = TsPaginatedFetchStatus.loading.obs;

  int get currentPage => _currentPage.value;
  List<T> get currentData => _data.toList();
  PageController get pageController => _pageController;
  TsPaginatedFetchStatus get fetchStatus => _fetchStatus.value;

  @override
  void onReady() {
    _currentPage.listen(_pageListener);
    initialFetch();
    super.onReady();
  }

  Future<void> initialFetch() async {
    _currentFetchPage = settings.initialPage;
    _data.clear();
    _fetchStatus.value = TsPaginatedFetchStatus.loading;
    final result = await settings.fetchData(
      _currentFetchPage,
      settings.limit,
    );
    if (result.isSuccess) {
      _data.addAll(result.data);
      _currentFetchPage++;
      if (result.hasNext != null) {
        if (result.hasNext!) {
          _fetchStatus.value = TsPaginatedFetchStatus.success;
        } else {
          _fetchStatus.value = TsPaginatedFetchStatus.noMoreData;
        }
      } else {
        if (settings.limit > result.data.length) {
          _fetchStatus.value = TsPaginatedFetchStatus.noMoreData;
        } else {
          _fetchStatus.value = TsPaginatedFetchStatus.success;
        }
      }
    } else {
      _fetchStatus.value = TsPaginatedFetchStatus.error;
    }
  }

  Future<void> fetchMoreData() async {
    _fetchStatus.value = TsPaginatedFetchStatus.moreLoading;
    final result = await settings.fetchData(
      _currentFetchPage,
      settings.limit,
    );
    if (result.isSuccess) {
      _data.addAll(result.data);
      _currentFetchPage++;
      if (result.hasNext != null) {
        if (result.hasNext!) {
          _fetchStatus.value = TsPaginatedFetchStatus.moreSuccess;
        } else {
          _fetchStatus.value = TsPaginatedFetchStatus.noMoreData;
        }
      } else {
        if (settings.limit > result.data.length) {
          _fetchStatus.value = TsPaginatedFetchStatus.noMoreData;
        } else {
          _fetchStatus.value = TsPaginatedFetchStatus.moreSuccess;
        }
      }
    } else {
      _fetchStatus.value = TsPaginatedFetchStatus.moreError;
    }
  }

  /// Remove specific item from the data list.
  void removeFromData(T item) {
    _data.remove(item);
  }

  /// Replace item in the data list.
  void replaceInData(int index, T item) {
    _data[index] = item;
  }

  /// Remove items from the data list where is the provided condition.
  void removeFromDataWhere(bool Function(T) condition) {
    _data.removeWhere(condition);
  }

  /// Manually add item to the data list.
  void addToData(T item) {
    _data.add(item);
  }

  /// Manually insert item to the data list at specific index.
  void insertToData(int index, T item) {
    _data.insert(index, item);
  }

  /// Sort current data list.
  void sortData([int Function(T, T)? compare]) {
    _data.sort(compare);
    _data.refresh();
  }

  /// Get index of specific item in the data list.
  ///
  /// Returns -1 if the item is not found.
  int indexOf(T item) => _data.indexOf(item);

  void onPageChanged(int p) => _currentPage.trigger(p);

  void _pageListener(int page) {
    if (!_fetchStatus.value.isMoreSuccess && !_fetchStatus.value.isSuccess) {
      return;
    }
    if (page >= _data.length - settings.fetchMoreWhenRemaining) {
      fetchMoreData();
    }
  }
}
