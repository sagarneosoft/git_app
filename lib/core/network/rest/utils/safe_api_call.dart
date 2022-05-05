

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:github_user_listing_demo/core/errors/failure.dart';
import 'package:retrofit/retrofit.dart';

Future<Either<Failure, T>> safeApiCall<T>(Future<T> apiCall) async {
  try {
    final originalResponse = await apiCall;
    final eitherResponse = originalResponse as HttpResponse<dynamic>;
    if (!eitherResponse.isSuccessful()) {
      return Left(ServerFailure(errorMessage: "Server error"));
    } else {
      print("original response $originalResponse");
      return Right(originalResponse);
    }
  } catch (throwable) {
    print(throwable.toString());
    switch (throwable.runtimeType) {

      case DioError:
        switch (throwable) {
          case DioErrorType.connectTimeout:

            break;
          case DioErrorType.sendTimeout:

            break;
          case DioErrorType.receiveTimeout:

            break;
          case DioErrorType.response:
            if (throwable is DioError) {
              return Left(ServerFailure(errorMessage: "Server error"));
            }
            break;
          case DioErrorType.cancel:
            break;
          case DioErrorType.other:
            return Left(
              ServerFailure(
                  errorMessage:
                  "Connection to API server failed due to internet connection",
                 ),
            );
        }

        break;

      default:
        return Left(ServerFailure(
            errorMessage: "Server error"));
    }
  }
  return Left(ServerFailure(errorMessage:  'Server error'));
}

extension RetrofitResponse on HttpResponse {
  bool isSuccessful() {
    return response.statusCode! >= 200 && response.statusCode! < 300;
  }
}