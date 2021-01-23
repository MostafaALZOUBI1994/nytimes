import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nytimes/models/story.dart';
import 'package:nytimes/repository/story_repository.dart';

part 'top_story_event.dart';
part 'top_story_state.dart';

class TopStoryBloc extends Bloc<TopStoryEvent, TopStoryState> {
  TopStoryRepository repo;
  TopStoryBloc(TopStoryState TopStoryInitial,this.repo) : super(TopStoryInitial);

  @override
  Stream<TopStoryState> mapEventToState(
      TopStoryEvent event,
      ) async* {
    if(event is DoFetch){
      yield LoadingState();
      try{
        var story=await repo.fetchStories();
        yield FetchSuccess(stroies: story);
      }catch(e){
        yield ErrorState(messege: e.toString());
      }
    }
  }
}
