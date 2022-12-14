class PostModel {
  late int userId;
  late int id;
  late String title;
  late String body;

  PostModel(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

  PostModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  @override
  String toString() {
    return super.toString();
  }
}
