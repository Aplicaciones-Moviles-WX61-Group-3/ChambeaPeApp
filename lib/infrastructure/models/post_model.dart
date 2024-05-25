class PostModel {
  int id;
  String title;
  String description;
  String subtitle;
  String imgUrl;

  PostModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.subtitle,
      required this.imgUrl});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        subtitle: json['subtitle'],
        imgUrl: json['imgUrl']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'subtitle': subtitle,
      'imgUrl': imgUrl
    };
  }
}
