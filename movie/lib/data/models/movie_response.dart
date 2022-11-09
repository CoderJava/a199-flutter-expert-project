import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie/data/models/movie_model.dart';

part 'movie_response.g.dart';

@JsonSerializable()
class MovieResponse extends Equatable {
  @JsonKey(name: 'results')
  final List<MovieModel> movieList;

  const MovieResponse({required this.movieList});

  factory MovieResponse.fromJson(Map<String, dynamic> json) => _$MovieResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieResponseToJson(this);

  @override
  List<Object> get props => [
        movieList,
      ];
}
