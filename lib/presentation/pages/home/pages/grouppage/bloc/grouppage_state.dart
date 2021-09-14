part of 'grouppage_bloc.dart';

abstract class GrouppageState extends Equatable {
  const GrouppageState();
  
  @override
  List<Object> get props => [];
}

class GrouppageInitial extends GrouppageState {}
class Loading extends GrouppageState{}
class InitialLoading extends GrouppageState{}
class ShowPostState extends GrouppageState{}
class ShowMemberState extends GrouppageState{}

