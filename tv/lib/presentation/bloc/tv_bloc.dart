import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';
import 'package:tv/domain/usecases/get_watchlist_status_tv.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/save_watchlist_tv.dart';
import 'package:tv/domain/usecases/search_tv.dart';

part 'tv_event.dart';

part 'tv_state.dart';

class TvBloc extends Bloc<TvEvent, TvState> {
  final GetNowPlayingTv getNowPlayingTv;
  final GetPopularTv getPopularTv;
  final GetTopRatedTv getTopRatedTv;
  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetWatchlistStatusTv getWatchListStatusTv;
  final SaveWatchlistTv saveWatchlistTv;
  final RemoveWatchlistTv removeWatchlistTv;
  final SearchTv searchTv;
  final GetWatchlistTv getWatchlistTv;

  TvBloc({
    required this.getNowPlayingTv,
    required this.getPopularTv,
    required this.getTopRatedTv,
    required this.getTvDetail,
    required this.getTvRecommendations,
    required this.getWatchListStatusTv,
    required this.saveWatchlistTv,
    required this.removeWatchlistTv,
    required this.searchTv,
    required this.getWatchlistTv,
  }) : super(InitialTvState()) {
    on<LoadDataHomeTvEvent>(_onLoadDataHomeTvEvent);

    on<LoadDataNowPlayingTvEvent>(_onLoadDataNowPlayingTvEvent);

    on<LoadDataPopularTvEvent>(_onLoadDataPopularTvEvent);

    on<LoadDataTopRatedTvEvent>(_onLoadDataTopRatedTvEvent);

    on<LoadDataDetailTvEvent>(_onLoadDataDetailTvEvent);

    on<SearchTvEvent>(_onSearchTvEvent);
  }

  FutureOr<void> _onLoadDataHomeTvEvent(
    LoadDataHomeTvEvent event,
    Emitter<TvState> emit,
  ) async {
    emit(LoadingTvState());
    final resultNowPlayingTv = await getNowPlayingTv.execute();
    final resultFoldNowPlayingTv = resultNowPlayingTv.fold(
      (failure) => failure,
      (response) => response,
    );
    if (resultFoldNowPlayingTv is Failure) {
      final errorMessage = resultFoldNowPlayingTv.message;
      emit(FailureTvState(message: errorMessage));
      return;
    }
    final nowPlayingTv = <Tv>[];
    if (resultFoldNowPlayingTv is List<Tv>) {
      nowPlayingTv.addAll(resultFoldNowPlayingTv);
    }

    final resultPopularTv = await getPopularTv.execute();
    final resultFoldPopularTv = resultPopularTv.fold(
      (failure) => failure,
      (response) => response,
    );
    if (resultFoldPopularTv is Failure) {
      final errorMessage = resultFoldPopularTv.message;
      emit(FailureTvState(message: errorMessage));
      return;
    }
    final popularTv = <Tv>[];
    if (resultFoldPopularTv is List<Tv>) {
      popularTv.addAll(resultFoldPopularTv);
    }

    final resultTopRatedTv = await getTopRatedTv.execute();
    final resultFoldTopRatedTv = resultTopRatedTv.fold(
      (failure) => failure,
      (response) => response,
    );
    if (resultFoldTopRatedTv is Failure) {
      final errorMessage = resultFoldTopRatedTv.message;
      emit(FailureTvState(message: errorMessage));
      return;
    }
    final topRatedTv = <Tv>[];
    if (resultFoldTopRatedTv is List<Tv>) {
      topRatedTv.addAll(resultFoldTopRatedTv);
    }
    emit(
      SuccessLoadDataHomeTvState(
        nowPlayingTv: nowPlayingTv,
        popularTv: popularTv,
        topRatedTv: topRatedTv,
      ),
    );
  }

  FutureOr<void> _onLoadDataNowPlayingTvEvent(
    LoadDataNowPlayingTvEvent event,
    Emitter<TvState> emit,
  ) async {
    emit(LoadingTvState());
    final resultNowPlayingTv = await getNowPlayingTv.execute();
    emit(
      resultNowPlayingTv.fold(
        (failure) => FailureTvState(message: failure.message),
        (response) => SuccessLoadDataNowPlayingTvState(nowPlayingTv: response),
      ),
    );
  }

  FutureOr<void> _onLoadDataPopularTvEvent(
    LoadDataPopularTvEvent event,
    Emitter<TvState> emit,
  ) async {
    emit(LoadingTvState());
    final resultPopularTv = await getPopularTv.execute();
    emit(
      resultPopularTv.fold(
        (failure) => FailureTvState(message: failure.message),
        (response) => SuccessLoadDataPopularTvState(popularTv: response),
      ),
    );
  }

  FutureOr<void> _onLoadDataTopRatedTvEvent(
    LoadDataTopRatedTvEvent event,
    Emitter<TvState> emit,
  ) async {
    emit(LoadingTvState());
    final resultTopRatedTv = await getTopRatedTv.execute();
    emit(
      resultTopRatedTv.fold(
        (failure) => FailureTvState(message: failure.message),
        (response) => SuccessLoadDataTopRatedTvState(topRatedTv: response),
      ),
    );
  }

  FutureOr<void> _onLoadDataDetailTvEvent(
    LoadDataDetailTvEvent event,
    Emitter<TvState> emit,
  ) async {
    emit(LoadingTvState());
    final id = event.id;
    final resultDetailTv = await getTvDetail.execute(id);
    final resultFoldDetailTv = resultDetailTv.fold(
      (failure) => failure,
      (response) => response,
    );
    if (resultFoldDetailTv is Failure) {
      emit(FailureTvState(message: resultFoldDetailTv.message));
      return;
    }
    TvDetail? movieDetail;
    if (resultFoldDetailTv is TvDetail) {
      movieDetail = resultFoldDetailTv;
    }

    final resultTvRecommendations = await getTvRecommendations.execute(id);
    final resultFoldTvRecommendations = resultTvRecommendations.fold(
      (failure) => failure,
      (response) => response,
    );
    if (resultFoldTvRecommendations is Failure) {
      emit(FailureTvState(message: resultFoldTvRecommendations.message));
      return;
    }
    final movieRecommendations = <Tv>[];
    if (resultFoldTvRecommendations is List<Tv>) {
      movieRecommendations.addAll(resultFoldTvRecommendations);
    }

    emit(
      SuccessLoadDataDetailTvState(
        movieDetail: movieDetail,
        movieRecommendations: movieRecommendations,
      ),
    );
  }

  FutureOr<void> _onSearchTvEvent(SearchTvEvent event, Emitter<TvState> emit) async {
    emit(LoadingTvState());
    final resultSearchTv = await searchTv.execute(event.query);
    emit(
      resultSearchTv.fold(
        (failure) => FailureTvState(message: failure.message),
        (response) => SuccessSearchTvState(searchResult: response),
      ),
    );
  }
}
