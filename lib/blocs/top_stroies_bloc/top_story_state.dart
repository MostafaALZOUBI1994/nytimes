part of 'top_story_bloc.dart';

class TopStoryState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TopStoryInitial extends TopStoryState {
}

class LoadingState extends TopStoryState{}
class FetchSuccess extends TopStoryState{
  List<Story>  stroies;
  FetchSuccess({this.stroies});
}
class ErrorState extends TopStoryState{
  String messege;
  ErrorState({this.messege});
}