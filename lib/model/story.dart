class StoryModel {
  final String title;
  final String image;
  final String id;
  final String url;

  StoryModel(this.id, this.title, {this.image, this.url});

  StoryModel.fromJson(Map<String, dynamic> json)
      : this(
          json['id'].toString(),
          json['title'].toString(),
          image: json['image'] != null
              ? json['image'].toString()
              : (json['images'] != null ? json['images'][0].toString() : null),
          url: json['url'] != null
              ? json['url'].toString()
              : (json['url'] != null ? json['url'][0].toString() : null),
        );

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'image': image, 'url': url};
  }
}
