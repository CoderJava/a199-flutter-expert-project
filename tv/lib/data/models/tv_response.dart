import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tv/data/models/tv_model.dart';

part 'tv_response.g.dart';

@JsonSerializable()
class TvResponse extends Equatable {
  @JsonKey(name: 'results')
  final List<TvModel> tvList;

  const TvResponse({required this.tvList});

  factory TvResponse.fromJson(Map<String, dynamic> json) => _$TvResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TvResponseToJson(this);

  @override
  List<Object?> get props => [
    tvList,
  ];
}