import 'package:ditonton/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TvDetail extends Equatable {
  final bool? isAdult;
  final String? backdropPath;
  final List<CreatedBy>? createdBy;
  final List<int>? episodeRuntime;
  final String? firstAirDate;
  final List<Genre>? genres;
  final String? homepage;
  final int id;
  final List<String>? languages;
  final String? lastAirDate;
  final LastEpisodeToAir? lastEpisodeToAir;
  final String? name;
  final List<Network>? networks;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<Network>? productionCompanies;
  final List<ProductionCountries>? productionCountries;
  final List<Season>? seasons;
  final List<SpokenLanguage>? spokenLanguage;
  final String? status;
  final String? tagline;
  final String? type;
  final double? voteAverage;
  final int? voteCount;

  TvDetail({
    required this.isAdult,
    required this.backdropPath,
    required this.createdBy,
    required this.episodeRuntime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.languages,
    required this.lastAirDate,
    required this.lastEpisodeToAir,
    required this.name,
    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguage,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  List<Object?> get props => [
        isAdult,
        backdropPath,
        createdBy,
        episodeRuntime,
        firstAirDate,
        genres,
        homepage,
        id,
        languages,
        lastAirDate,
        lastEpisodeToAir,
        name,
        networks,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        productionCompanies,
        productionCountries,
        seasons,
        spokenLanguage,
        status,
        tagline,
        type,
        voteAverage,
        voteCount,
      ];
}

class CreatedBy extends Equatable {
  final int id;
  final String? creditId;
  final String? name;
  final String? profilePath;

  CreatedBy({
    required this.id,
    required this.creditId,
    required this.name,
    required this.profilePath,
  });

  @override
  List<Object?> get props => [
        id,
        creditId,
        name,
        profilePath,
      ];
}

class LastEpisodeToAir extends Equatable {
  final String? airDate;
  final int? episodeNumber;
  final int id;
  final String? name;
  final String? overview;
  final int? runtime;
  final int? seasonNumber;
  final int? showId;
  final String? stillPath;
  final double? voteAverage;
  final int? voteCount;

  LastEpisodeToAir({
    required this.airDate,
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.runtime,
    required this.seasonNumber,
    required this.showId,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  List<Object?> get props => [
        airDate,
        episodeNumber,
        id,
        name,
        overview,
        runtime,
        seasonNumber,
        showId,
        stillPath,
        voteAverage,
        voteCount,
      ];
}

class Network extends Equatable {
  final int id;
  final String? name;
  final String? logoPath;
  final String? originCountry;

  Network({
    required this.id,
    required this.name,
    required this.logoPath,
    required this.originCountry,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        logoPath,
        originCountry,
      ];
}

class ProductionCountries extends Equatable {
  final String? iso;
  final String? name;

  ProductionCountries({
    required this.iso,
    required this.name,
  });

  @override
  List<Object?> get props => [
        iso,
        name,
      ];
}

class Season extends Equatable {
  final String? airDate;
  final int? episodeCount;
  final int id;
  final String? name;
  final String? overview;
  final String? posterPath;
  final int? seasonNumber;

  Season({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  @override
  List<Object?> get props => [
        airDate,
        episodeCount,
        id,
        name,
        overview,
        posterPath,
        seasonNumber,
      ];
}

class SpokenLanguage extends Equatable {
  final String? englishName;
  final String? iso;
  final String? name;

  SpokenLanguage({
    required this.englishName,
    required this.iso,
    required this.name,
  });

  @override
  List<Object?> get props => [
    englishName,
    iso,
    name
  ];
}
