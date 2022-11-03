import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

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

  TvTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory TvTable.fromJson(Map<String, dynamic> json) => _$TvTableFromJson(json);

  Map<String, dynamic> toJson() => _$TvTableToJson(this);

  @override
  List<Object?> get props => [
    id,
    name,
    posterPath,
    overview,
  ];
}