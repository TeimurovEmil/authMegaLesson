import 'dart:convert';

List<PostModel> statisticFromJson(String str) =>
    List<PostModel>.from(json.decode(str).map((x) => PostModel.fromJson(x)));

String statisticToJson(List<PostModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostModel {
  PostModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  final int userId;
  final int id;
  final String title;
  final String body;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        userId: json["userId"] == null ? null : json["userId"],
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        body: json["body"] == null ? null : json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId == null ? null : userId,
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "body": body == null ? null : body,
      };
}
