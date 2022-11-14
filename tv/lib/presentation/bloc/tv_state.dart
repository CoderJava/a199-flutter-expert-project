part of 'tv_bloc.dart';

abstract class TvState {}

class InitialTvState extends TvState {

  @override
  String toString() {
    return 'InitialTvState{}';
  }
}

class LoadingTvState extends TvState {

  @override
  String toString() {
    return 'LoadingTvState{}';
  }
}

class FailureTvState extends TvState {
  final String message;

  FailureTvState({required this.message});

  @override
  String toString() {
    return 'FailureTvState{message: $message}';
  }
}

class SuccessLoadDataHomeTvState extends TvState {
  final List<Tv> nowPlayingTv;
  final List<Tv> popularTv;
  final List<Tv> topRatedTv;

  SuccessLoadDataHomeTvState({
    required this.nowPlayingTv,
    required this.popularTv,
    required this.topRatedTv,
  });

  @override
  String toString() {
    return 'SuccessLoadDataHomeTvState{nowPlayingTv: $nowPlayingTv, popularTv: $popularTv, '
        'topRatedTv: $topRatedTv}';
  }
}

class SuccessLoadDataNowPlayingTvState extends TvState {
  final List<Tv> nowPlayingTv;

  SuccessLoadDataNowPlayingTvState({required this.nowPlayingTv});

  @override
  String toString() {
    return 'SuccessLoadDataNowPlayingTvState{nowPlayingTv: $nowPlayingTv}';
  }
}

class SuccessLoadDataPopularTvState extends TvState {
  final List<Tv> popularTv;

  SuccessLoadDataPopularTvState({required this.popularTv});

  @override
  String toString() {
    return 'SuccessLoadDataPopularTvState{popularTv: $popularTv}';
  }
}

class SuccessLoadDataTopRatedTvState extends TvState {
  final List<Tv> topRatedTv;

  SuccessLoadDataTopRatedTvState({required this.topRatedTv});

  @override
  String toString() {
    return 'SuccessLoadDataTopRatedTvState{topRatedTv: $topRatedTv}';
  }
}

class SuccessLoadDataDetailTvState extends TvState {
  final TvDetail? movieDetail;
  final List<Tv> movieRecommendations;

  SuccessLoadDataDetailTvState({
    required this.movieDetail,
    required this.movieRecommendations,
  });

  @override
  String toString() {
    return 'SuccessLoadDataDetailTvState{movieDetail: $movieDetail, movieRecommendations: $movieRecommendations}';
  }
}

class SuccessSearchTvState extends TvState {
  final List<Tv> searchResult;

  SuccessSearchTvState({required this.searchResult});

  @override
  String toString() {
    return 'SuccessSearchTvState{searchResult: $searchResult}';
  }
}
