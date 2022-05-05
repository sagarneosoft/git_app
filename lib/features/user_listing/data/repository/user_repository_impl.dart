import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:github_user_listing_demo/core/db/floor/local/user_db_entity.dart';
import 'package:github_user_listing_demo/core/db/floor/utils/safe_db_call.dart';
import 'package:github_user_listing_demo/core/errors/failure.dart';
import 'package:github_user_listing_demo/core/network/rest/utils/safe_api_call.dart';
import 'package:github_user_listing_demo/features/user_listing/data/datasource/local/user_local_data_source.dart';
import 'package:github_user_listing_demo/features/user_listing/data/datasource/remote/user_remote_datasource.dart';
import 'package:github_user_listing_demo/features/user_listing/data/models/user.dart';
import 'package:github_user_listing_demo/features/user_listing/domain/repository/user_listing_repository.dart';

class UserListingRepositoryImpl extends UserListingRepository{
  final UserListingDataSource userListingDataSource;
  final UserLocalDS localDS;

  UserListingRepositoryImpl({required this.userListingDataSource, required this.localDS});

  @override
  Future<Either<Failure, List<User>>> getUsers(int fromId) async{

    var result  = await safeApiCall(userListingDataSource.fetchUsers(fromId));

   return result.fold((l) {
      return Left(l);
      }, (r) {
      return  Right(r.data.map((item) => item.transform()).toList());
    });

   //  try{
   //  var result  = await userListingDataSource.fetchUsers(fromId);
   //  return Right(result.data.map((item) => item.transform()).toList());
   // } on ServerException{
   //   return Left(ServerFailure(errorMessage: "Error from server side"));
   // } on SocketException{
   //   return Left(ServerFailure(errorMessage: "No Internet connection"));
   // }
  }
  @override
  Future<Either<Failure, User>> saveUser(User user) async{
     final result = await  safeDbCall(localDS.saveUser(UserDBEntity().restore(user)));
     return result.fold((l) => Left(CacheFailure(errorMessage: "Local error")), (r) => Right(user));

  }

  @override
  Future<Either<Failure, Stream<List<User>>>> getStreamedUser() async{
    final result =  await safeDbCall(localDS.getStreamedUser());
    return result.fold((l){
      return Left(l);
    }, (r) {
      return Right(
        r.map((event) => event.map((e) => e.transform()).toList(growable: true)),
      );
    });
  }

  @override
  Future<Either<Failure, bool>> deleteUser(int userId) async{
   final result = await safeDbCall( localDS.deleteUser(userId));
   return result.fold((l) => Left(CacheFailure(errorMessage: "Local error")), (r) => Right(r));

  }
}