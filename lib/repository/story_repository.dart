import 'dart:convert';
import 'package:nytimes/constants.dart';
import 'package:nytimes/models/story.dart';
import 'package:http/http.dart'as http;

class TopStoryRepository{
  Future<List<Story>> fetchStories() async {
    List<Story> stories=[];
    var response=await http.get("https://api.nytimes.com/svc/topstories/v2/world.json?api-key=$ApiKey");
    if(response.statusCode==200){
      var data=json.decode(response.body);
      var result=data["results"];
      result.map((story)=>stories.add(Story.fromJson(story))).toList();
      return stories;
    }
  }
}