import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_image_to_byte/network_image_to_byte.dart';
import 'package:nytimes/blocs/top_stroies_bloc/top_story_bloc.dart';
import 'package:nytimes/models/bookmark.dart';
import 'package:nytimes/repository/story_repository.dart';
import 'package:nytimes/ui/stories_list.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:hive/hive.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);

 await Hive.openBox("bookmarks");
  Hive.registerAdapter(BookmarkAdapter());

  print(Hive.isAdapterRegistered(1));
  runApp(MaterialApp(
    home: BlocProvider(
      create: (context)=>TopStoryBloc(TopStoryInitial(), TopStoryRepository()),
      child: MyApp(),
  )));

}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin{
TopStoryBloc bloc;
TabController _controller;
int _selectedIndex = 0;
List<Widget> list = [
  Tab(icon: Icon(Icons.list_alt)),
  Tab(icon: Icon(Icons.bookmark)),
];
@override
void initState() {
  bloc=BlocProvider.of<TopStoryBloc>(context);
  bloc.add(DoFetch());
  // Create TabController for getting the index of current tab
  _controller = TabController(length: list.length, vsync: this);
  _controller.addListener(() {
    setState(() {
      _selectedIndex = _controller.index;
    });
    print("Selected Index: " + _controller.index.toString());
  });
  // TODO: implement initState
  super.initState();
}
@override
void dispose() {
  bloc.close();
  // TODO: implement dispose
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("test"),

        bottom:TabBar(
          onTap: (index) {
            // Should not used it as it only called when tab options are clicked,
            // not when user swapped
          },
          controller: _controller,
          tabs: list,
        ) ,
      ),
      body: TabBarView(
        controller: _controller,
        children: [
         StoryList(),
          Center(
              child: Text(
                _selectedIndex.toString(),
                style: TextStyle(fontSize: 40),
              )),
        ],
      ),

    );
  }
}
