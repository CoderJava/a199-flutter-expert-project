import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'genre_model.g.dart';

@JsonSerializable()
class GenreModel extends Equatable {
  const GenreModel({
    required this.id,
    required this.name,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;

  factory GenreModel.fromJson(Map<String, dynamic> json) => _$GenreModelFromJson(json);

  Map<String, dynamic> toJson() => _$GenreModelToJson(this);

  Genre toEntity() {
    return Genre(
      id: id,
      name: name,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
