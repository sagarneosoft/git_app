part of 'listing_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
  @override
  List<Object?> get props => [];
}

class UserFetched extends UserEvent {}

class UserUpdated extends UserEvent {
  final User user;
  const UserUpdated(this.user);
}
