import 'package:ditonton/data/models/tv_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tv_response.g.dart';

@JsonSerializable()
class TvResponse extends Equatable {
  @JsonKey(name: 'results')
  final List<TvModel> tvList;

  TvResponse({required this.tvList});

  factory TvResponse.fromJson(Map<String, dynamic> json) => _$TvResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TvResponseToJson(this);

  @override
  List<Object?> get props => [
    tvList,
  ];
}