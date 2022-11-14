import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status_movie.dart';
import 'package:movie/domain/usecases/remove_watchlist_movie.dart';
import 'package:movie/domain/usecases/save_watchlist_movie.dart';
import 'package:movie/domain/usecases/search_movies.dart';

part 'movie_event.dart';

part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatusMovie getWatchListStatusMovie;
  final SaveWatchlistMovie saveWatchlistMovie;
  final RemoveWatchlistMovie removeWatchlistMovie;
  final SearchMovies searchMovies;
  final GetWatchlistMovies getWatchlistMovies;

  MovieBloc({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatusMovie,
    required this.saveWatchlistMovie,
    required this.removeWatchlistMovie,
    required this.searchMovies,
    required this.getWatchlistMovies,
  }) : super(InitialMovieState()) {
    on<LoadDataHomeMovieEvent>(_onLoadDataHomeMovieEvent);

    on<LoadDataNowPlayingMovieEvent>(_onLoadDataNowPlayingMovieEvent);

    on<LoadDataPopularMovieEvent>(_onLoadDataPopularMovieEvent);

    on<LoadDataTopRatedMovieEvent>(_onLoadDataTopRatedMovieEvent);

    on<LoadDataDetailMovieEvent>(_onLoadDataDetailMovieEvent);

    on<SearchMovieEvent>(_onSearchMovieEvent);
  }

  FutureOr<void> _onLoadDataHomeMovieEvent(
    LoadDataHomeMovieEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(LoadingMovieState());
    final resultNowPlayingMovies = await getNowPlayingMovies.execute();
    final resultFoldNowPlayingMovies = resultNowPlayingMovies.fold(
      (failure) => failure,
      (response) => response,
    );
    if (resultFoldNowPlayingMovies is Failure) {
      final errorMessage = resultFoldNowPlayingMovies.message;
      emit(FailureMovieState(message: errorMessage));
      return;
    }
    final nowPlayingMovies = <Movie>[];
    if (resultFoldNowPlayingMovies is List<Movie>) {
      nowPlayingMovies.addAll(resultFoldNowPlayingMovies);
    }

    final resultPopularMovies = await getPopularMovies.execute();
    final resultFoldPopularMovies = resultPopularMovies.fold(
      (failure) => failure,
      (response) => response,
    );
    if (resultFoldPopularMovies is Failure) {
      final errorMessage = resultFoldPopularMovies.message;
      emit(FailureMovieState(message: errorMessage));
      return;
    }
    final popularMovies = <Movie>[];
    if (resultFoldPopularMovies is List<Movie>) {
      popularMovies.addAll(resultFoldPopularMovies);
    }

    final resultTopRatedMovies = await getTopRatedMovies.execute();
    final resultFoldTopRatedMovies = resultTopRatedMovies.fold(
      (failure) => failure,
      (response) => response,
    );
    if (resultFoldTopRatedMovies is Failure) {
      final errorMessage = resultFoldTopRatedMovies.message;
      emit(FailureMovieState(message: errorMessage));
      return;
    }
    final topRatedMovies = <Movie>[];
    if (resultFoldTopRatedMovies is List<Movie>) {
      topRatedMovies.addAll(resultFoldTopRatedMovies);
    }
    emit(
      SuccessLoadDataHomeMovieState(
        nowPlayingMovies: nowPlayingMovies,
        popularMovies: popularMovies,
        topRatedMovies: topRatedMovies,
      ),
    );
  }

  FutureOr<void> _onLoadDataNowPlayingMovieEvent(
    LoadDataNowPlayingMovieEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(LoadingMovieState());
    final resultNowPlayingMovies = await getNowPlayingMovies.execute();
    emit(
      resultNowPlayingMovies.fold(
        (failure) => FailureMovieState(message: failure.message),
        (response) => SuccessLoadDataNowPlayingMovieState(nowPlayingMovies: response),
      ),
    );
  }

  FutureOr<void> _onLoadDataPopularMovieEvent(
    LoadDataPopularMovieEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(LoadingMovieState());
    final resultPopularMovies = await getPopularMovies.execute();
    emit(
      resultPopularMovies.fold(
        (failure) => FailureMovieState(message: failure.message),
        (response) => SuccessLoadDataPopularMovieState(popularMovies: response),
      ),
    );
  }

  FutureOr<void> _onLoadDataTopRatedMovieEvent(
    LoadDataTopRatedMovieEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(LoadingMovieState());
    final resultTopRatedMovies = await getTopRatedMovies.execute();
    emit(
      resultTopRatedMovies.fold(
        (failure) => FailureMovieState(message: failure.message),
        (response) => SuccessLoadDataTopRatedMovieState(topRatedMovies: response),
      ),
    );
  }

  FutureOr<void> _onLoadDataDetailMovieEvent(
    LoadDataDetailMovieEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(LoadingMovieState());
    final id = event.id;
    final resultDetailMovie = await getMovieDetail.execute(id);
    final resultFoldDetailMovie = resultDetailMovie.fold(
      (failure) => failure,
      (response) => response,
    );
    if (resultFoldDetailMovie is Failure) {
      emit(FailureMovieState(message: resultFoldDetailMovie.message));
      return;
    }
    MovieDetail? movieDetail;
    if (resultFoldDetailMovie is MovieDetail) {
      movieDetail = resultFoldDetailMovie;
    }

    final resultMovieRecommendations = await getMovieRecommendations.execute(id);
    final resultFoldMovieRecommendations = resultMovieRecommendations.fold(
      (failure) => failure,
      (response) => response,
    );
    if (resultFoldMovieRecommendations is Failure) {
      emit(FailureMovieState(message: resultFoldMovieRecommendations.message));
      return;
    }
    final movieRecommendations = <Movie>[];
    if (resultFoldMovieRecommendations is List<Movie>) {
      movieRecommendations.addAll(resultFoldMovieRecommendations);
    }

    emit(
      SuccessLoadDataDetailMovieState(
        movieDetail: movieDetail,
        movieRecommendations: movieRecommendations,
      ),
    );
  }

  FutureOr<void> _onSearchMovieEvent(SearchMovieEvent event, Emitter<MovieState> emit) async {
    emit(LoadingMovieState());
    final resultSearchMovies = await searchMovies.execute(event.query);
    emit(
      resultSearchMovies.fold(
        (failure) => FailureMovieState(message: failure.message),
        (response) => SuccessSearchMovieState(searchResult: response),
      ),
    );
  }
}
