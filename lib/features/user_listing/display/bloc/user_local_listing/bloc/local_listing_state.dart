part of 'local_listing_bloc.dart';

enum LocalState { initial, loading, success, error }

class LocalListingState extends Equatable {
  const LocalListingState({
    required this.uiState,
    this.users,
  });
  final LocalState uiState;
  final Stream<List<User>>? users;

  factory LocalListingState.initial() {
    return const LocalListingState(uiState: LocalState.initial);
  }

  @override
  List<Object> get props => [];

  LocalListingState copyWith({
    LocalState? state,
    Stream<List<User>>? users,
  }) {
    return LocalListingState(
      uiState: state ?? this.uiState,
      users: users ?? this.users,
    );
  }

  @override
  bool get stringify => true;
}
