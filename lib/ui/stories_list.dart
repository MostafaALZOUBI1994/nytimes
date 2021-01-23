import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nytimes/blocs/top_stroies_bloc/top_story_bloc.dart';
import 'package:nytimes/models/bookmark.dart';
import 'package:nytimes/repository/bookmark_repository.dart';
import 'package:path_provider/path_provider.dart';

class StoryList extends StatefulWidget {
  @override
  _StoryListState createState() => _StoryListState();
}

class _StoryListState extends State<StoryList> {
  Box<String> friendsBox;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    friendsBox = Hive.box<String>("friends");
  }

  @override
  Widget build(BuildContext context) {
  //  final Box<Bookmark> bookmarkBox = Hive.box('bookmarks');
    return  Center(
      child: BlocBuilder<TopStoryBloc,TopStoryState>(
        builder: (context,state){
          if(state is TopStoryInitial){
            return CircularProgressIndicator();
          }
          else if(state is LoadingState){
            return CircularProgressIndicator();
          }
          else if(state is FetchSuccess){
            return ListView.builder(itemCount: state.stroies.length,itemBuilder: (context,index){
              return ListTile(
                leading: CircleAvatar(backgroundImage: NetworkImage(state.stroies[index].multimedia[1].url),),
                title: Text(state.stroies[index].title),
                subtitle:Text(state.stroies[index].publishedDate) ,
                trailing: IconButton(icon: Icon(Icons.favorite),onPressed: () async {
                 Uint8List i=await networkImageToByte("https://flutter.io/images/flutter-mark-square-100.png");

                 final newBookmark =Bookmark(state.stroies[index].title, state.stroies[index].abstract, "f", "publishedDate", i);
                 addBookmark(newBookmark);
                  /*
                  print(bookmarkBox.isOpen);
                  bookmarkBox.add(Bookmark(state.stroies[index].title,state.stroies[index].abstract, state.stroies[index].url,state.stroies[index].publishedDate,image));


                   */
                },),
              );
            },);
          }
          else if(state is ErrorState){
            return ErrorWidget(state.messege.toString());
          }
        },
      ),
    );
  }
  void addBookmark(Bookmark contact) {
     final bookmarksBox= Hive.box('bookmarks');
    bookmarksBox.add(contact);
  }
}
