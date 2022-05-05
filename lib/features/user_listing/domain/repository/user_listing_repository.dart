import 'package:dartz/dartz.dart';
import 'package:github_user_listing_demo/core/errors/failure.dart';
import 'package:github_user_listing_demo/features/user_listing/data/models/user.dart';

abstract class UserListingRepository {
  Future<Either<Failure,List<User>>> getUsers(int fromId);

  ///Local database
  Future<Either<Failure, User>> saveUser(User user);
  Future<Either<Failure,bool>> deleteUser(int userId);
  Future<Either<Failure, Stream<List<User>>>> getStreamedUser();
}




