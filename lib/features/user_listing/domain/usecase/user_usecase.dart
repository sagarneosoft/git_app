import 'package:dartz/dartz.dart';
import 'package:github_user_listing_demo/core/errors/failure.dart';
import 'package:github_user_listing_demo/core/usecase/usecase_params.dart';
import 'package:github_user_listing_demo/features/user_listing/data/models/user.dart';
import 'package:github_user_listing_demo/features/user_listing/domain/repository/user_listing_repository.dart';

class UserUseCase{
  final UserListingRepository repository;
  UserUseCase({required this.repository});


  Future<Either<Failure, List<User>>> call(UserUseCaseParams params) async{
    return await repository.getUsers(params.since);
  }
}