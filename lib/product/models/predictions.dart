// To parse this JSON data, do
//
//     final predictions = predictionsFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'predictions.g.dart';

String predictionsToJson(Predictions data) => json.encode(data.toJson());

@JsonSerializable()
class Predictions {
  @JsonKey(name: "predictions")
  List<Prediction>? predictions;
  @JsonKey(name: "status")
  String? status;

  Predictions({
    this.predictions,
    this.status,
  });

  factory Predictions.fromJson(Map<String, dynamic> json) =>
      _$PredictionsFromJson(json);

  Map<String, dynamic> toJson() => _$PredictionsToJson(this);
}

@JsonSerializable()
class Prediction {
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "matched_substrings")
  List<MatchedSubstring>? matchedSubstrings;
  @JsonKey(name: "place_id")
  String? placeId;
  @JsonKey(name: "reference")
  String? reference;
  @JsonKey(name: "structured_formatting")
  StructuredFormatting? structuredFormatting;
  @JsonKey(name: "terms")
  List<Term>? terms;
  @JsonKey(name: "types")
  List<String>? types;

  Prediction({
    this.description,
    this.matchedSubstrings,
    this.placeId,
    this.reference,
    this.structuredFormatting,
    this.terms,
    this.types,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) =>
      _$PredictionFromJson(json);

  Map<String, dynamic> toJson() => _$PredictionToJson(this);
}

@JsonSerializable()
class MatchedSubstring {
  @JsonKey(name: "length")
  int? length;
  @JsonKey(name: "offset")
  int? offset;

  MatchedSubstring({
    this.length,
    this.offset,
  });

  factory MatchedSubstring.fromJson(Map<String, dynamic> json) =>
      _$MatchedSubstringFromJson(json);

  Map<String, dynamic> toJson() => _$MatchedSubstringToJson(this);
}

@JsonSerializable()
class StructuredFormatting {
  @JsonKey(name: "main_text")
  String? mainText;
  @JsonKey(name: "main_text_matched_substrings")
  List<MatchedSubstring>? mainTextMatchedSubstrings;
  @JsonKey(name: "secondary_text")
  String? secondaryText;

  StructuredFormatting({
    this.mainText,
    this.mainTextMatchedSubstrings,
    this.secondaryText,
  });

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) =>
      _$StructuredFormattingFromJson(json);

  Map<String, dynamic> toJson() => _$StructuredFormattingToJson(this);
}

@JsonSerializable()
class Term {
  @JsonKey(name: "offset")
  int? offset;
  @JsonKey(name: "value")
  String? value;

  Term({
    this.offset,
    this.value,
  });

  factory Term.fromJson(Map<String, dynamic> json) => _$TermFromJson(json);

  Map<String, dynamic> toJson() => _$TermToJson(this);
}
