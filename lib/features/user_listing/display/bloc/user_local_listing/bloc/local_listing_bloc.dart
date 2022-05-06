import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_listing_demo/core/di/repository_module.dart';
import 'package:github_user_listing_demo/features/user_listing/data/models/user.dart';
import 'package:github_user_listing_demo/features/user_listing/domain/usecase/user_local_usecase.dart';
import 'package:riverpod/riverpod.dart';
import 'package:collection/collection.dart';

part 'local_listing_event.dart';
part 'local_listing_state.dart';

class LocalListingBloc extends Bloc<LocalListingEvent, LocalListingState> {
  Stream<List<User>>? databaseUsers;
  LocalListingBloc(LocalListingState initialState)
      : super(LocalListingState.initial()) {
    on<LocalListingEvent>((event, emit) async {
      if (state.uiState == LocalState.initial) {
        var result = await UserLocalUseCase(
                userListingRepository:
                    ProviderContainer().read(repositoryProvider))
            .execute();
        result.fold((l) {
          emit(state.copyWith(
            state: LocalState.error,
          ));
        }, (r) {
          emit(state.copyWith(state: LocalState.success, users: r));

          // r.listen((event) {
          //   for (var element in event) {
          //     var item  = users.firstWhereOrNull((item) => item.id == element.id,);
          //     if(item != null)
          //     {
          //       //changeUserState(item, state: true);
          //     }
          //   }
          // });
        });
      }
    });

    on<UserEventDelete>((event, emit) async {
      var result = await UserLocalUseCase(
              userListingRepository:
                  ProviderContainer().read(repositoryProvider))
          .exc(event.user.id);
      result.fold((failure) {}, (onData) {
        emit(state.copyWith(users: state.users));
      });
    });

    on<UserSaveEvent>((event, emit) async {
      var result = await UserLocalUseCase(
              userListingRepository:
                  ProviderContainer().read(repositoryProvider))
          .call(event.user);
      result.fold((failure) {}, (onData) {
        emit(state.copyWith(users: state.users));
      });
    });
  }
}
