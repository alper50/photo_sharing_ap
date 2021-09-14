part of 'page1_bloc.dart';

abstract class Page1State extends Equatable {
  const Page1State();

  @override
  List<Object> get props => [];
}

class Page1Initial extends Page1State {}

class LoadingData extends Page1State {}

class Fetched extends Page1State {
  final List<Object> posts;
  final bool hasreachedmax;
  Fetched({this.posts, this.hasreachedmax});

  Fetched copyWith({List<Object> posts, bool hasreachedmax}) {
    return Fetched(
      posts: posts ?? this.posts,
      hasreachedmax: hasreachedmax ?? this.hasreachedmax,
    );
  }
}

class FetchError extends Page1State {}

class StorageError extends Page1State {}

class DummyState extends Page1State {}
