import 'package:freezed_annotation/freezed_annotation.dart';

// part 'models.freezed.dart';
part 'models.g.dart';

@JsonSerializable()
class Response {
  final bool success;
  final String content;

  Response({required this.success, required this.content});

  factory Response.fromJson(Map<String, dynamic> json) =>
      _$ResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseToJson(this);
}

@JsonSerializable()
class Content {
  final String action;
  final String text;

  Content({required this.action, required this.text});

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);
  Map<String, dynamic> toJson() => _$ContentToJson(this);
}

// @JsonSerializable()
// class ResponseContent {
//   final List<Content> content;

//   ResponseContent({required this.content});

//   factory ResponseContent.fromJson(List<dynamic> json) =>
//       _$ResponseContentFromJson(json);
//   Map<String, dynamic> toJson() => _$ResponseContentToJson(this);
// }
