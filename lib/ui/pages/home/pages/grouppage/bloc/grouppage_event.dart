part of 'grouppage_bloc.dart';

abstract class GrouppageEvent extends Equatable {
  const GrouppageEvent();

  @override
  List<Object> get props => [];
}
class ShowInitialPostEvent extends GrouppageEvent{}
class ShowPostEvent extends GrouppageEvent{}
class ShowMemberEvent extends GrouppageEvent{}
class JoinGroupEvent extends GrouppageEvent{}