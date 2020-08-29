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
              ? json['image']
              : (json['images'] != null ? json['images'][0] : null),
          url: json['url'] != null
              ? json['url']
              : (json['url'] != null ? json['url'][0] : null),
        );

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'image': image, 'url': url};
  }
}
