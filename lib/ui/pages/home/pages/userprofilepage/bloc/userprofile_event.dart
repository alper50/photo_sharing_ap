part of 'userprofile_bloc.dart';

abstract class UserprofileEvent extends Equatable {
  const UserprofileEvent();

  @override
  List<Object?> get props => [];
}

class InitialEvent extends UserprofileEvent{
  final String? nickname;

  InitialEvent(this.nickname);

    @override
  List<Object?> get props => [nickname];
}