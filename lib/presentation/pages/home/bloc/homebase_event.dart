part of 'homebase_bloc.dart';

abstract class HomebaseEvent extends Equatable {
  const HomebaseEvent();

  @override
  List<Object> get props => [];
}
class HomeInitialEvent extends HomebaseEvent{}
class RefreshConnectionEvent extends HomebaseEvent{}