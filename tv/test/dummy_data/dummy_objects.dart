import 'package:core/core.dart';
import 'package:tv/data/models/tv_table.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';

final testTv = Tv(
  backdropPath: 'backdropPath',
  firstAirDate: 'firstAirDate',
  genreIds: const [1,2],
  id: 1,
  name: 'name',
  originalCountry: const ['originalCountry'],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1.0,
  posterPath: 'posterPath',
  voteAverage: 1.0,
  voteCount: 1,
);

final testTvList = [testTv];

const testTvDetail = TvDetail(
  isAdult: false,
  backdropPath: 'backdropPath',
  createdBy: [
    CreatedBy(
      id: 1,
      creditId: 'creditId',
      name: 'name',
      profilePath: 'profilePath',
    ),
  ],
  episodeRuntime: [1],
  firstAirDate: 'firstAirDate',
  genres: [
    Genre(
      id: 1,
      name: 'name',
    ),
  ],
  homepage: 'homepage',
  id: 1,
  languages: ['languages'],
  lastAirDate: 'lastAirDate',
  lastEpisodeToAir: LastEpisodeToAir(
    airDate: 'airDate',
    episodeNumber: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    runtime: 1,
    seasonNumber: 1,
    showId: 1,
    stillPath: 'stillPath',
    voteAverage: 1.0,
    voteCount: 1,
  ),
  name: 'name',
  networks: [
    Network(
      id: 1,
      name: 'name',
      logoPath: 'logoPath',
      originCountry: 'originCountry',
    ),
  ],
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  originCountry: ['originCountry'],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1.0,
  posterPath: 'posterPath',
  productionCompanies: [
    Network(
      id: 1,
      name: 'name',
      logoPath: 'logoPath',
      originCountry: 'originCountry',
    ),
  ],
  productionCountries: [
    ProductionCountries(
      iso: 'iso',
      name: 'name',
    ),
  ],
  seasons: [
    Season(
      airDate: 'airDate',
      episodeCount: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 1,
    ),
  ],
  spokenLanguage: [
    SpokenLanguage(
      englishName: 'englishName',
      iso: 'iso',
      name: 'name',
    ),
  ],
  status: 'status',
  tagline: 'tagline',
  type: 'type',
  voteAverage: 1.0,
  voteCount: 1,
);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
