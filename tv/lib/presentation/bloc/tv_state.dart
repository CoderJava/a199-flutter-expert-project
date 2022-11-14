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
  final TvDetail? tvDetail;
  final List<Tv> tvRecommendations;
  final bool isAddedToWatchlist;

  SuccessLoadDataDetailTvState({
    required this.tvDetail,
    required this.tvRecommendations,
    required this.isAddedToWatchlist,
  });

  @override
  String toString() {
    return 'SuccessLoadDataDetailTvState{movieDetail: $tvDetail, movieRecommendations: $tvRecommendations, '
        'isAddedToWatchlist: $isAddedToWatchlist}';
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

class SuccessLoadDataWatchlistTvState extends TvState {
  final List<Tv> watchlistTv;

  SuccessLoadDataWatchlistTvState({required this.watchlistTv});

  @override
  String toString() {
    return 'SuccessLoadDataWatchlistTvState{watchlistTv: $watchlistTv}';
  }
}

class SuccessUpdateWatchlistStatusTvState extends TvState {
  final String message;
  final bool isAddedToWatchlist;

  SuccessUpdateWatchlistStatusTvState({
    required this.message,
    required this.isAddedToWatchlist,
  });

  @override
  String toString() {
    return 'SuccessUpdateWatchlistStatusTvState{message: $message, isAddedToWatchlist: $isAddedToWatchlist}';
  }
}
