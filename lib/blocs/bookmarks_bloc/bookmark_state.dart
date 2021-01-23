part of 'bookmark_bloc.dart';

abstract class BookmarkState extends Equatable {
  const BookmarkState();
}

class BookmarkInitial extends BookmarkState {
  @override
  List<Object> get props => [];
}
