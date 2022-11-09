import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';

part 'tv_table.g.dart';

@JsonSerializable()
class TvTable extends Equatable {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'posterPath')
  final String? posterPath;
  @JsonKey(name: 'overview')
  final String? overview;

  const TvTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory TvTable.fromJson(Map<String, dynamic> json) => _$TvTableFromJson(json);

  Map<String, dynamic> toJson() => _$TvTableToJson(this);

  factory TvTable.fromEntity(TvDetail tv) {
    return TvTable(
      id: tv.id,
      name: tv.name,
      posterPath: tv.posterPath,
      overview: tv.overview,
    );
  }

  Tv toEntity() => Tv.watchlist(
    id: id,
    overview: overview,
    posterPath: posterPath,
    name: name,
  );

  @override
  List<Object?> get props => [
        id,
        name,
        posterPath,
        overview,
      ];
}
