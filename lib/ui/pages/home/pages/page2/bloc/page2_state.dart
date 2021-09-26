part of 'page2_bloc.dart';

abstract class Page2State extends Equatable {
  const Page2State();
  
  @override
  List<Object> get props => [];
}

class Page2Initial extends Page2State {}
class Loading extends Page2State {}
class Page2Fetched extends Page2State {
  final bool hasreachedmax;
  final int mockdata;
  Page2Fetched({this.hasreachedmax,this.mockdata});

  Page2Fetched copyWith({List<Object> posts, bool hasreachedmax}) {
    return Page2Fetched(
      hasreachedmax: hasreachedmax ?? this.hasreachedmax,
      mockdata: mockdata ?? this.mockdata,
    );
  }
}