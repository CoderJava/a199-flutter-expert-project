import 'package:ditonton/data/models/genre_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tv_detail_model.g.dart';

@JsonSerializable()
class TvDetailModel extends Equatable {
  @JsonKey(name: 'adult')
  final bool? isAdult;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'created_by')
  final List<CreatedBy>? createdBy;
  @JsonKey(name: 'episode_run_time')
  final List<int>? episodeRuntime;
  @JsonKey(name: 'first_air_date')
  final String? firstAirDate;
  @JsonKey(name: 'genres')
  final List<GenreModel>? genres;
  @JsonKey(name: 'homepage')
  final String? homepage;
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'languages')
  final List<String>? languages;
  @JsonKey(name: 'last_air_date')
  final String? lastAirDate;
  @JsonKey(name: 'last_episode_to_air')
  final LastEpisodeToAir lastEpisodeToAir;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'networks')
  final List<Network>? networks;
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
  final List<Network>? productionCompanies;
  @JsonKey(name: 'production_countries')
  final List<ProductionCountries>? productionCountries;
  @JsonKey(name: 'seasons')
  final List<Season> seasons;
  @JsonKey(name: 'spoken_language')
  final List<SpokenLanguage>? spokenLanguage;
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

  TvDetailModel({
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
class CreatedBy extends Equatable {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'credit_id')
  final String? creditId;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'profile_path')
  final String? profilePath;

  CreatedBy({
    required this.id,
    required this.creditId,
    required this.name,
    required this.profilePath,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => _$CreatedByFromJson(json);

  Map<String, dynamic> toJson() => _$CreatedByToJson(this);

  @override
  List<Object?> get props => [
        id,
        creditId,
        name,
        profilePath,
      ];
}

@JsonSerializable()
class LastEpisodeToAir extends Equatable {
  @JsonKey(name: 'air_date')
  final String? airDate;
  @JsonKey(name: 'episode_number')
  final int? episodeNumber;
  @JsonKey(name: 'id')
  final int? id;
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

  LastEpisodeToAir({
    this.airDate,
    this.episodeNumber,
    this.id,
    this.name,
    this.overview,
    this.runtime,
    this.seasonNumber,
    this.showId,
    this.stillPath,
    this.voteAverage,
    this.voteCount,
  });

  factory LastEpisodeToAir.fromJson(Map<String, dynamic> json) => _$LastEpisodeToAirFromJson(json);

  Map<String, dynamic> toJson() => _$LastEpisodeToAirToJson(this);

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
class Network extends Equatable {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'logo_path')
  final String? logoPath;
  @JsonKey(name: 'origin_country')
  final String? originCountry;

  Network({
    required this.id,
    required this.name,
    required this.logoPath,
    required this.originCountry,
  });

  factory Network.fromJson(Map<String, dynamic> json) => _$NetworkFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        logoPath,
        originCountry,
      ];
}

@JsonSerializable()
class ProductionCountries extends Equatable {
  @JsonKey(name: 'iso_3166_1')
  final String? iso;
  @JsonKey(name: 'name')
  final String? name;

  ProductionCountries({
    required this.iso,
    required this.name,
  });

  factory ProductionCountries.fromJson(Map<String, dynamic> json) => _$ProductionCountriesFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCountriesToJson(this);

  @override
  List<Object?> get props => [
        iso,
        name,
      ];
}

@JsonSerializable()
class Season extends Equatable {
  @JsonKey(name: 'air_date')
  final String? airDate;
  @JsonKey(name: 'episode_count')
  final int? episodeCount;
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'overview')
  final String? overview;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'season_number')
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

  factory Season.fromJson(Map<String, dynamic> json) => _$SeasonFromJson(json);

  Map<String, dynamic> toJson() => _$SeasonToJson(this);

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
class SpokenLanguage extends Equatable {
  @JsonKey(name: 'english_name')
  final String? englishName;
  @JsonKey(name: 'iso_639_1')
  final String? iso;
  @JsonKey(name: 'name')
  final String? name;

  SpokenLanguage({
    required this.englishName,
    required this.iso,
    required this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => _$SpokenLanguageFromJson(json);

  Map<String, dynamic> toJson() => _$SpokenLanguageToJson(this);

  @override
  List<Object?> get props => [
        englishName,
        iso,
        name,
      ];
}
