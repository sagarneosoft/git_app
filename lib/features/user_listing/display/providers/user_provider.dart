import 'package:flutter/material.dart';
import 'package:github_user_listing_demo/core/di/repository_module.dart';
import 'package:github_user_listing_demo/core/errors/failure.dart';
import 'package:github_user_listing_demo/core/usecase/usecase_params.dart';
import 'package:github_user_listing_demo/features/user_listing/data/models/user.dart';
import 'package:github_user_listing_demo/features/user_listing/domain/usecase/user_local_usecase.dart';
import 'package:github_user_listing_demo/features/user_listing/domain/usecase/user_usecase.dart';
import 'package:riverpod/riverpod.dart';
import 'package:collection/collection.dart';
enum UIState {
  loading, error, success,
}

class UserProvider extends ChangeNotifier{

  int startFrom = 0;

  List<User> users =[];
  Failure? error;

  Stream<List<User>>? databaseUsers;

  UIState uiState;
  UserProvider({this.uiState = UIState.loading});

  void fetchUsers() async {
   var result =  await UserUseCase(repository:ProviderContainer().read(repositoryProvider)).call(UserUseCaseParams(since: users.length,),);
   result.fold((failure) {
     error = failure;
     uiState = UIState.error;
     notifyListeners();
     }, (onData) {
     users.addAll(onData);
     uiState = UIState.success;
     notifyListeners();
   });
    print("Fetching stremed user");
    getStreamedUser();
  }

  void changeUserState(User usr,{bool state = false}){
  var user = usr;
   if(state !=true) {
     var currUser = users.firstWhereOrNull((element) => element.id == usr.id);
     if(currUser != null)
       {
         user = currUser;
       }
   }
   user.isSelected = state;
   notifyListeners();
  }

  void changeCheckboxState(User usr,)
  {
    usr.isSelected = false;
    notifyListeners();
  }
  
  void saveUser(User user) async {
    var result = await UserLocalUseCase(userListingRepository: ProviderContainer().read(repositoryProvider)).call(user);
    result.fold((failure) {}, (onData) {
      debugPrint("User saved Success : ${onData.toString()}");
      var user =  users.firstWhere((element) => element.id == onData.id);
      user.isSelected = true;
      notifyListeners();
    });
  }

  void deleteUser(User user) async{
    var result = await UserLocalUseCase(userListingRepository: ProviderContainer().read(repositoryProvider)).exc(user.id);
    result.fold((failure) {}, (onData) {
      debugPrint('User deleted Success : $onData');
      changeUserState(user);
    });
  }

  void getStreamedUser()async{
    var result = await UserLocalUseCase(userListingRepository: ProviderContainer().read(repositoryProvider)).execute();
    result.fold((l) {
        error = l;
        notifyListeners();
    }, (r) {
      databaseUsers = r;
      notifyListeners();
      r.listen((event) {
        for (var element in event) {
        var item  = users.firstWhereOrNull((item) => item.id == element.id,);
        if(item != null)
          {
            changeUserState(item, state: true);
          }
        }
      });
    });
  }
}