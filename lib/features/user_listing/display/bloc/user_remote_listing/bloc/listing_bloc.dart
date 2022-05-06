import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:github_user_listing_demo/core/di/repository_module.dart';
import 'package:github_user_listing_demo/core/usecase/usecase_params.dart';
import 'package:github_user_listing_demo/features/user_listing/data/models/user.dart';
import 'package:github_user_listing_demo/features/user_listing/domain/usecase/user_usecase.dart';
import 'package:riverpod/riverpod.dart';
import 'package:stream_transform/stream_transform.dart';
part 'listing_event.dart';

part 'listing_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ListingBloc extends Bloc<UserEvent, UserState> {
  ListingBloc(UserState initialState) : super(const UserState()) {
    on<UserFetched>(
      _onUserFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<UserUpdated>(_onUserUpdated);
  }

  Future<void> _onUserFetched(
      UserFetched event, Emitter<UserState> emit) async {
    if (state.hasReachedMax) return;

    if (state.status == UserStatus.initial) {
      final result = await UserUseCase(
              repository: ProviderContainer().read(repositoryProvider))
          .call(
        UserUseCaseParams(
          since: state.users.length,
        ),
      );
      result.fold((l) {
        emit(state.copyWith(status: UserStatus.failure, users: []));
      }, (r) {
        emit(state.copyWith(
            status: UserStatus.success, users: r, hasReachedMax: false));
      });
    }

    final data = await UserUseCase(
            repository: ProviderContainer().read(repositoryProvider))
        .call(
      UserUseCaseParams(
        since: state.users.length,
      ),
    );
    data.fold((l) {
      emit(state.copyWith(status: UserStatus.failure, users: []));
    }, (r) {
      emit(state.copyWith(
          status: UserStatus.success,
          users: List.of(state.users)..addAll(r),
          hasReachedMax: false));
    });
  }

  Future<void> _onUserUpdated(
      UserUpdated event, Emitter<UserState> emit) async {
   
    emit(state.copyWith(
      status: UserStatus.success,
      users: state.users,
    ));
   
  }
}
