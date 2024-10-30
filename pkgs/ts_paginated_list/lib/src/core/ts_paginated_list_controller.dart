import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ts_paginated_list/ts_paginated_list.dart';

class TsPaginatedListController<T> extends GetxController {
  final TsPaginatedListSettings<T> settings;
  late final ScrollController scrollController;

  TsPaginatedListController(this.settings) {
    scrollController = settings.scrollController;
  }

  int _currentPage = 0;
  final _data = <T>[].obs;
  final _fetchStatus = TsPaginatedFetchStatus.loading.obs;

  List<T> get currentData => _data.toList();
  TsPaginatedFetchStatus get fetchStatus => _fetchStatus.value;

  @override
  void onInit() {
    settings.onCreated?.call(this);
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    _data.listen((data) {
      settings.onDataUpdate?.call(data);
    });
    initialFetch();
    scrollController.addListener(_scrollListener);
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    super.onClose();
  }

  /// This method will clear the current data, reset the current page to the
  /// initial page, and fetch the initial data.
  Future<void> initialFetch() async {
    _clear();
    _setCurrenPage(settings.initialPage);
    _fetchStatus.value = TsPaginatedFetchStatus.loading;
    final result = await settings.fetchData(
      _currentPage,
      settings.limit,
    );
    if (result.isSuccess) {
      _data.addAll(result.data);
      _setCurrenPage(_currentPage + 1);
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

  /// Fetch more data. If `force` is true, it will fetch even if the status
  /// is `TsPaginationFetchStatus.noMoreData`.
  Future<void> fetchMoreData({
    bool force = false,
  }) async {
    if (!force && _fetchStatus.value.isNoMoreData) return;
    _fetchStatus.value = TsPaginatedFetchStatus.moreLoading;
    final result = await settings.fetchData(
      _currentPage,
      settings.limit,
    );
    if (result.isSuccess) {
      _data.addAll(result.data);
      _setCurrenPage(_currentPage + 1);
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

  void _clear() {
    _data.clear();
    _setCurrenPage(settings.initialPage);
    _fetchStatus.value = TsPaginatedFetchStatus.loading;
  }

  void _setCurrenPage(int page) {
    _currentPage = page;
    settings.onPageChange?.call(_currentPage);
  }

  void _scrollListener() {
    if (_fetchStatus.value.isNoMoreData) {
      if (settings.removeListenerIfNoMoreData) {
        scrollController.removeListener(_scrollListener);
      }
      return;
    }
    if (_fetchStatus.value.isSuccess || _fetchStatus.value.isMoreSuccess) {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - settings.startFetchBeforePixels) {
        fetchMoreData();
      }
    }
  }
}
