/// Custom class to handle paginated list results.
class TsPaginatedListResult<T> {
  /// List of data
  final List<T> data;

  /// Status of the fetch.
  ///
  /// Example:
  ///
  /// ```dart
  /// // ...
  /// final response = await http.get('https://api.example.com/data');
  /// final isSuccess = response.statusCode == 200;
  /// // ...
  /// ```
  final bool isSuccess;

  /// If you do not pass hasNext, the controller will check whether the next
  /// page should be fetched by checking whether the limit is greater than the
  /// length of the data.
  ///
  /// If your endpoint or source to use gives information about whether the
  /// next page is available, you can pass hasNext. In that case, fetching the
  /// next page will not happen if `hasNext == false`, otherwise, it will.
  ///
  /// This is super useful if you want to ensure that you reduce the
  /// unnecessary number of requests.
  final bool? hasNext;

  /// Example:
  ///
  /// ```dart
  /// final result = TsPaginationListResult<int>(
  ///   data: [1, 2, 3],
  ///   isSuccess: true,
  ///   hasNext: false,
  /// );
  /// ```
  TsPaginatedListResult({
    required this.data,
    required this.isSuccess,
    this.hasNext,
  });
}
