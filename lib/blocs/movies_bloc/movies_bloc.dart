import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:marvel_app_flutter/blocs/movies_bloc/movies_events.dart';
import 'package:marvel_app_flutter/blocs/movies_bloc/movies_state.dart';
import 'package:marvel_app_flutter/data/remote/api_client/movies_api_client.dart';
import 'package:marvel_app_flutter/data/remote/entity/movie_response/movie_response.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final _moviesApiClient = MoviesApiClient();

  MoviesBloc(MoviesState initialState) : super(initialState) {
    on<MoviesEvent>((event, emit) async {
      if (event is MoviesLoadNextPageEvent) {
        await _onLoadNextPage(event, emit);
      } else if (event is MoviesResetPageEvent) {
        await _onResetPage(event, emit);
      } else if (event is MoviesSearchPageEvent) {
        await _onSearch(event, emit);
      }
    }, transformer: sequential());
  }

  Future<void> _onLoadNextPage(
      MoviesLoadNextPageEvent event, Emitter<MoviesState> emit) async {
    if (state.isSearching) {
      final newContainer =
          await _loadNextPage(state.searchMovies, (nextPage) async {
        final result = await _moviesApiClient.searchMovies(
          state.query,
          nextPage,
          event.locale,
        );
        return result;
      });
      if (newContainer != null) {
        final newState = state.copyWith(searchMovies: newContainer);
        emit(newState);
      }
    } else {
      final newContainer =
          await _loadNextPage(state.allMovies, (nextPage) async {
        final result = await _moviesApiClient.getMovies(
          nextPage,
          event.locale,
        );
        return result;
      });
      if (newContainer != null) {
        final newState = state.copyWith(allMovies: newContainer);
        emit(newState);
      }
    }
  }

  Future<MoviesDataContainer?> _loadNextPage(
    MoviesDataContainer container,
    Future<MovieResponse> Function(int) loader,
  ) async {
    if (container.isComplete) return null;
    final nextPage = container.currentPage + 1;
    final result = await loader(nextPage);
    final movies = container.movies.toList();
    movies.addAll(result.results);
    final newContainer = container.copyWith(
      movies: movies,
      currentPage: result.page,
      totalPage: result.totalPages,
    );
    return newContainer;
  }

  Future<void> _onResetPage(
      MoviesResetPageEvent event, Emitter<MoviesState> emit) async {
    emit(const MoviesState.initial());
  }

  Future<void> _onSearch(
      MoviesSearchPageEvent event, Emitter<MoviesState> emit) async {
    if (state.searchMovies == event.query) return;
    final newState = state.copyWith(
      query: event.query,
      searchMovies: const MoviesDataContainer.initial(),
    );
    emit(newState);
  }
}
