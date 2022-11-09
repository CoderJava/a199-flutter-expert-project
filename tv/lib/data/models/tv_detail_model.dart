import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tv/data/models/genre_model.dart';
import 'package:tv/domain/entities/tv_detail.dart';

part 'tv_detail_model.g.dart';

@JsonSerializable()
class TvDetailModel extends Equatable {
  @JsonKey(name: 'adult')
  final bool? isAdult;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'created_by')
  final List<CreatedByModel>? createdBy;
  @JsonKey(name: 'episode_run_time')
  final List<int>? episodeRuntime;
  @JsonKey(name: 'first_air_date')
  final String? firstAirDate;
  @JsonKey(name: 'genres')
  final List<GenreModel>? genres;
  @JsonKey(name: 'homepage')
  final String? homepage;
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'languages')
  final List<String>? languages;
  @JsonKey(name: 'last_air_date')
  final String? lastAirDate;
  @JsonKey(name: 'last_episode_to_air')
  final LastEpisodeToAirModel? lastEpisodeToAir;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'networks')
  final List<NetworkModel>? networks;
  @JsonKey(name: 'number_of_episodes')
  final int? numberOfEpisodes;
  @JsonKey(name: 'number_of_seasons')
  final int? numberOfSeasons;
  @JsonKey(name: 'origin_country')
  final List<String>? originCountry;
  @JsonKey(name: 'original_language')
  final String? originalLanguage;
  @JsonKey(name: 'original_name')
  final String? originalName;
  @JsonKey(name: 'overview')
  final String? overview;
  @JsonKey(name: 'popularity')
  final double? popularity;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'production_companies')
  final List<NetworkModel>? productionCompanies;
  @JsonKey(name: 'production_countries')
  final List<ProductionCountriesModel>? productionCountries;
  @JsonKey(name: 'seasons')
  final List<SeasonModel>? seasons;
  @JsonKey(name: 'spoken_language')
  final List<SpokenLanguageModel>? spokenLanguage;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'tagline')
  final String? tagline;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'vote_average')
  final double? voteAverage;
  @JsonKey(name: 'vote_count')
  final int? voteCount;

  const TvDetailModel({
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

  factory TvDetailModel.fromJson(Map<String, dynamic> json) => _$TvDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$TvDetailModelToJson(this);

  TvDetail toEntity() {
    return TvDetail(
      isAdult: isAdult,
      backdropPath: backdropPath,
      createdBy: createdBy?.map((e) => e.toEntity()).toList(),
      episodeRuntime: episodeRuntime,
      firstAirDate: firstAirDate,
      genres: genres?.map((e) => e.toEntity()).toList(),
      homepage: homepage,
      id: id,
      languages: languages,
      lastAirDate: lastAirDate,
      lastEpisodeToAir: lastEpisodeToAir?.toEntity(),
      name: name,
      networks: networks?.map((e) => e.toEntity()).toList(),
      numberOfEpisodes: numberOfEpisodes,
      numberOfSeasons: numberOfSeasons,
      originCountry: originCountry,
      originalLanguage: originalLanguage,
      originalName: originalName,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      productionCompanies: productionCompanies?.map((e) => e.toEntity()).toList(),
      productionCountries: productionCountries?.map((e) => e.toEntity()).toList(),
      seasons: seasons?.map((e) => e.toEntity()).toList(),
      spokenLanguage: spokenLanguage?.map((e) => e.toEntity()).toList(),
      status: status,
      tagline: tagline,
      type: type,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

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

@JsonSerializable()
class CreatedByModel extends Equatable {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'credit_id')
  final String? creditId;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'profile_path')
  final String? profilePath;

  const CreatedByModel({
    required this.id,
    required this.creditId,
    required this.name,
    required this.profilePath,
  });

  factory CreatedByModel.fromJson(Map<String, dynamic> json) => _$CreatedByModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreatedByModelToJson(this);

  CreatedBy toEntity() {
    return CreatedBy(
      id: id,
      creditId: creditId,
      name: name,
      profilePath: profilePath,
    );
  }

  @override
  List<Object?> get props => [
        id,
        creditId,
        name,
        profilePath,
      ];
}

@JsonSerializable()
class LastEpisodeToAirModel extends Equatable {
  @JsonKey(name: 'air_date')
  final String? airDate;
  @JsonKey(name: 'episode_number')
  final int? episodeNumber;
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'overview')
  final String? overview;
  @JsonKey(name: 'runtime')
  final int? runtime;
  @JsonKey(name: 'season_number')
  final int? seasonNumber;
  @JsonKey(name: 'show_id')
  final int? showId;
  @JsonKey(name: 'still_path')
  final String? stillPath;
  @JsonKey(name: 'vote_average')
  final double? voteAverage;
  @JsonKey(name: 'vote_count')
  final int? voteCount;

  const LastEpisodeToAirModel({
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

  factory LastEpisodeToAirModel.fromJson(Map<String, dynamic> json) => _$LastEpisodeToAirModelFromJson(json);

  Map<String, dynamic> toJson() => _$LastEpisodeToAirModelToJson(this);

  LastEpisodeToAir toEntity() {
    return LastEpisodeToAir(
      airDate: airDate,
      episodeNumber: episodeNumber,
      id: id,
      name: name,
      overview: overview,
      runtime: runtime,
      seasonNumber: seasonNumber,
      showId: showId,
      stillPath: stillPath,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

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

@JsonSerializable()
class NetworkModel extends Equatable {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'logo_path')
  final String? logoPath;
  @JsonKey(name: 'origin_country')
  final String? originCountry;

  const NetworkModel({
    required this.id,
    required this.name,
    required this.logoPath,
    required this.originCountry,
  });

  factory NetworkModel.fromJson(Map<String, dynamic> json) => _$NetworkModelFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkModelToJson(this);

  Network toEntity() {
    return Network(
      id: id,
      name: name,
      logoPath: logoPath,
      originCountry: originCountry,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        logoPath,
        originCountry,
      ];
}

@JsonSerializable()
class ProductionCountriesModel extends Equatable {
  @JsonKey(name: 'iso_3166_1')
  final String? iso;
  @JsonKey(name: 'name')
  final String? name;

  const ProductionCountriesModel({
    required this.iso,
    required this.name,
  });

  factory ProductionCountriesModel.fromJson(Map<String, dynamic> json) => _$ProductionCountriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCountriesModelToJson(this);

  ProductionCountries toEntity() {
    return ProductionCountries(
      iso: iso,
      name: name,
    );
  }

  @override
  List<Object?> get props => [
        iso,
        name,
      ];
}

@JsonSerializable()
class SeasonModel extends Equatable {
  @JsonKey(name: 'air_date')
  final String? airDate;
  @JsonKey(name: 'episode_count')
  final int? episodeCount;
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'overview')
  final String? overview;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'season_number')
  final int? seasonNumber;

  const SeasonModel({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  factory SeasonModel.fromJson(Map<String, dynamic> json) => _$SeasonModelFromJson(json);

  Map<String, dynamic> toJson() => _$SeasonModelToJson(this);

  Season toEntity() {
    return Season(
      airDate: airDate,
      episodeCount: episodeCount,
      id: id,
      name: name,
      overview: overview,
      posterPath: posterPath,
      seasonNumber: seasonNumber,
    );
  }

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

@JsonSerializable()
class SpokenLanguageModel extends Equatable {
  @JsonKey(name: 'english_name')
  final String? englishName;
  @JsonKey(name: 'iso_639_1')
  final String? iso;
  @JsonKey(name: 'name')
  final String? name;

  const SpokenLanguageModel({
    required this.englishName,
    required this.iso,
    required this.name,
  });

  factory SpokenLanguageModel.fromJson(Map<String, dynamic> json) => _$SpokenLanguageModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpokenLanguageModelToJson(this);

  SpokenLanguage toEntity() {
    return SpokenLanguage(
      englishName: englishName,
      iso: iso,
      name: name,
    );
  }

  @override
  List<Object?> get props => [
        englishName,
        iso,
        name,
      ];
}
