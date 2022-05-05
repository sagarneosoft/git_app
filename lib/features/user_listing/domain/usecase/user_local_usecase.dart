import 'package:dartz/dartz.dart';
import 'package:github_user_listing_demo/core/errors/failure.dart';
import 'package:github_user_listing_demo/features/user_listing/data/models/user.dart';
import 'package:github_user_listing_demo/features/user_listing/domain/repository/user_listing_repository.dart';

class UserLocalUseCase{
  UserListingRepository userListingRepository;

  UserLocalUseCase({required this.userListingRepository});


  Future<Either<Failure, User>> call(User user) async{
    return await userListingRepository.saveUser(user);
  }

  Future<Either<Failure, Stream<List<User>>>> execute() async{
    return await userListingRepository.getStreamedUser();
  }

  Future<Either<Failure, bool>> exc(int userId) async{
    return await userListingRepository.deleteUser(userId);
  }



}