![TsPaginatedListCover](https://github.com/Tim-Solution/ts-paginated-list/assets/89051381/0277fc15-441f-4297-994a-7b9d86d5d405)

More about applying the package in the application below. 

Notes:
- For state managment in this package, we use the [GetX](https://pub.dev/packages/get) package. It will not be 
a problem if you use something else for state management in your project!

## Features
TsPaginatedList has the following features. 

- **TsPaginatedList**: Using the widget directly, for example as a Scaffold body.
- **TsPaginatedPageView**: Using the widget similar to PageView, but with pagination.
- **TsPaginatedListInsideScroll**: Using the widget inside a scroll, for example in a ListView, SingleChildScrollView, CustomScrollView, etc.

## Usage
For more details on how to use the package, please visit the example folder. Please note that
examples below are just a basic example of how to use the package. There are many configurations
that can be done to customize the usage of the package.


### TsPaginated Request Example
```dart
/// This is basic example of how to make a request for fetching data.
///
/// The example below can be used for any TsPaginated widget...
Future<TsPaginatedListResult<ModelName>> fetchData(int page, int limit) async {
  final response = await http.get('https://api.example.com/data?page=$page&limit=$pageSize');

  final data = json.decode(response.body);
  final items = data['items'].map((item) => ModelName.fromJson(item)).toList();

  return TsPaginatedListResult(
    data: items,
    isSuccess: response.statusCode == 200,
  );
}
```

### TsPaginatedList
```dart
  Scaffold(
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TsPaginatedList(
        TsPaginatedListSettings.list(
          initialPage: 0,
          limit: 10,
          leadingSpacing: 10,
          fetchData: fetchData, // Function for fetching data
          builder: (context, item, index) {
            return YourWidget(item: item);
          },
        ),
      ),
    ),
  );
```

### TsPaginatedListInsideScroll
```dart
  // Using inside CustomScrollView...

  CustomScrollView(
    controller: scrollController, // This must be set
    slivers: [
      YourWidget1(),
      YourWidget2(),
      TsPaginatedListInsideScroll.sliver(
        TsPaginatedListSettings.insideListScrollAsList(
          scrollController: scrollController, // This must be set
          initialPage: 0,
          limit: 5,
          fetchData: controller.fetchData,
          builder: (context, item, index) {
            return YourWidget(item: item);
          },
        ),
      ),
    ],
  );

  // Or using inside ListView/SingleChildScrollView...

  ListView(
    controller: scrollController, // This must be set
    children: [
      YourWidget1(),
      YourWidget2(),
      TsPaginatedListInsideScroll.nonSliver(
        TsPaginatedListSettings.insideListScrollAsList(
          scrollController: scrollController, // This must be set
          initialPage: 0,
          limit: 5,
          fetchData: controller.fetchData,
          builder: (context, item, index) {
            return YourWidget(item: item);
          },
        ),
      ),
    ],
  );
```

### TsPaginatedPageView
```dart
  Scaffold(
    body: TsPaginatedPageView(
      TsPaginatedPageSettings(
        initialPage: 0,
        limit: 5,
        fetchData: controller.fetchData,
        builder: (context, item, index) {
          return YourWidget(item: item);
        },
      ),
    ),
  );
```

## Notes / Known Issues 
- If you want to use 2 TsPaginatedListInsideScroll widgets inside one list, that is currently not supported and is expected to not work properly at the moment. You will most likely have errors. (We plan to implement that soon)

## Links | You probably don't need to read this..
- If you reading this on pub.dev, please visit the [GitHub repository](https://github.com/Tim-Solution/ts-flutter-packages/tree/main/pkgs/ts_paginated_list) for more details.
- If you reading this on github, please visit the [pub.dev page](https://pub.dev/packages/ts_paginated_list) for more details.

