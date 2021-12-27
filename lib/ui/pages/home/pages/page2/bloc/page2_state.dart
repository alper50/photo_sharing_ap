part of 'page2_bloc.dart';

abstract class Page2State extends Equatable {
  const Page2State();
  
  @override
  List<Object> get props => [];
}

class Page2Initial extends Page2State {}
class Page2Loading extends Page2State {}
class Page2SearchNotFound extends Page2State {}
class Page2SearchFound extends Page2State {
  final List<GroupModel> groups;

  Page2SearchFound(this.groups);

   @override
  List<Object> get props => [groups];
}

class Page2Fetched extends Page2State {
  final bool hasreachedmax;
  final List<GroupModel> groups;
  Page2Fetched({this.hasreachedmax,this.groups});

  Page2Fetched copyWith({List<Object> posts, bool hasreachedmax}) {
    return Page2Fetched(
      hasreachedmax: hasreachedmax ?? this.hasreachedmax,
      groups: groups ?? this.groups,
    );
  }
}

class Page2Error extends Page2State {
  final dynamic error;

  Page2Error({this.error});

  @override
  List<Object> get props => [error];
}