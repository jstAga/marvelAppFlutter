abstract class MoviesEvent {}

class MoviesLoadNextPageEvent extends MoviesEvent {
  final String locale;

  MoviesLoadNextPageEvent({required this.locale});
}

class MoviesResetPageEvent extends MoviesEvent {

  MoviesResetPageEvent();
}

class MoviesSearchPageEvent extends MoviesEvent {
  final String query;

  MoviesSearchPageEvent({required this.query});
}
