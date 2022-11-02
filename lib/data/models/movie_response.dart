import 'package:ditonton/data/models/movie_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_response.g.dart';

@JsonSerializable()
class MovieResponse extends Equatable {
  @JsonKey(name: 'results')
  final List<MovieModel> movieList;

  MovieResponse({required this.movieList});

  factory MovieResponse.fromJson(Map<String, dynamic> json) => _$MovieResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieResponseToJson(this);

  @override
  List<Object> get props => [
        movieList,
      ];
}
