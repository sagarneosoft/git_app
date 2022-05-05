import 'package:dartz/dartz.dart';
import 'package:github_user_listing_demo/core/errors/exceptions.dart';
import 'package:github_user_listing_demo/core/errors/failure.dart';

Future<Either<Failure, T>> safeDbCall<T>(Future<T> dbCall) async {
  try {
    final originalResponse = await dbCall;
    return Right(originalResponse);
  } catch (exception) {
    if(exception is CacheException){
      return Left(
      CacheFailure(
        errorMessage: "Database Error"
      )
      );
    }
    return Left(
        CacheFailure(
            errorMessage: "Database Error"
        )
    );
  }
}