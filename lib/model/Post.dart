class Post{
  String title;
  String description;
  String subtitle;
  String imgUrl;

  Post({
    required this.title,
    required this.description,
    required this.subtitle,
    required this.imgUrl
  });

  factory Post.fromJson(Map<String, dynamic> json){
    return Post(
      title: json['title'],
      description: json['description'],
      subtitle: json['subtitle'],
      imgUrl: json['imgUrl']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'title': title,
      'description': description,
      'subtitle': subtitle,
      'imgUrl': imgUrl
    };
  }
}