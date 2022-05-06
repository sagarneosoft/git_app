part of 'local_listing_bloc.dart';

abstract class LocalListingEvent extends Equatable {
  const LocalListingEvent();
  @override
  List<Object?> get props => [];
}

class UserSaveEvent extends LocalListingEvent {
  final User user;
  const UserSaveEvent(this.user);
}

class UserEventDelete extends LocalListingEvent {
  final User user;
  const UserEventDelete(this.user);
}

class LocalEventsLoaded extends LocalListingEvent {}
