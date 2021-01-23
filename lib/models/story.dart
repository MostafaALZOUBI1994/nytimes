import 'package:nytimes/models/photo.dart';

class Story {
  String title;
  String abstract;
  String url;
  String publishedDate;
  List<Multimedia> multimedia;
  Story(
      {
        this.title,
        this.abstract,
        this.url,
        this.publishedDate,
        this.multimedia,
   });

  Story.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    abstract = json['abstract'];
    url = json['url'];
    publishedDate = json['published_date'];
    if (json['multimedia'] != null) {
      multimedia = new List<Multimedia>();
      json['multimedia'].forEach((v) {
        multimedia.add(new Multimedia.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['abstract'] = this.abstract;
    data['url'] = this.url;
    data['published_date'] = this.publishedDate;
    if (this.multimedia != null) {
      data['multimedia'] = this.multimedia.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


