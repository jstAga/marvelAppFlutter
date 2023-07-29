class BasePagingResponse<T> {
  BasePagingResponse({
    required this.data,
    required this.currentPage,
    required this.totalPages,
  });

  final List <T> data;
  final int currentPage;
  final int? totalPages;
}

typedef BasePagingLoad<T> = Future<BasePagingResponse<T>> Function(int);

class BasePaging<T> {
  final _data = <T>[];
  final BasePagingLoad<T> load;
  bool _isLoading = false;
  late int _currentPage;
  late int _totalPages;

  List<T> get data => _data;

  BasePaging({required this.load});

  Future<void> getNextPage() async {
    if (_isLoading || _currentPage >= _totalPages) return;
    _isLoading = true;
    final nextPage = _currentPage + 1;
    try {
      final result = await load(nextPage);
      _data.addAll(result.data);
      _currentPage = result.currentPage;
      _totalPages = result.totalPages ?? 0;
      print(result.totalPages);
      _isLoading = false;
    } catch (e) {
      _isLoading = false;
    }
  }

  Future<void> reset() async {
    _currentPage = 0;
    _totalPages = 1;
    _data.clear();
    await getNextPage();
  }
}
