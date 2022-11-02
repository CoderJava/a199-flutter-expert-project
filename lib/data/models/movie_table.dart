import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_table.g.dart';

@JsonSerializable()
class MovieTable extends Equatable {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'posterPath')
  final String? posterPath;
  @JsonKey(name: 'overview')
  final String? overview;

  MovieTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
  });

  factory MovieTable.fromEntity(MovieDetail movie) => MovieTable(
        id: movie.id,
        title: movie.title,
        posterPath: movie.posterPath,
        overview: movie.overview,
      );

  factory MovieTable.fromJson(Map<String, dynamic> json) => _$MovieTableFromJson(json);

  Map<String, dynamic> toJson() => _$MovieTableToJson(this);

  Movie toEntity() => Movie.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        title: title,
      );

  @override
  List<Object?> get props => [
        id,
        title,
        posterPath,
        overview,
      ];
}
