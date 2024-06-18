enum TsPaginatedFetchStatus {
  /// Initial fetch is success
  success,

  /// Initial fetch is loading
  loading,

  /// Initital fetch has error
  error,

  /// Current more fetch is success
  moreSuccess,

  /// Current more fetch is loading
  moreLoading,

  /// Current more fetch has error
  moreError,

  /// No more data to fetch
  noMoreData,
}

extension FetchStatusExtension on TsPaginatedFetchStatus {
  bool get isSuccess => this == TsPaginatedFetchStatus.success;
  bool get isLoading => this == TsPaginatedFetchStatus.loading;
  bool get isError => this == TsPaginatedFetchStatus.error;
  bool get isMoreSuccess => this == TsPaginatedFetchStatus.moreSuccess;
  bool get isMoreLoading => this == TsPaginatedFetchStatus.moreLoading;
  bool get isMoreError => this == TsPaginatedFetchStatus.moreError;
  bool get isNoMoreData => this == TsPaginatedFetchStatus.noMoreData;
}
