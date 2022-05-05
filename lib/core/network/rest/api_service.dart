import 'package:dio/dio.dart';
import 'package:github_user_listing_demo/features/user_listing/domain/entities/user_entity.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';
part 'api_service.g.dart';

@RestApi()
abstract class ApiService{
  factory ApiService(Dio dio,{String? baseUrl}){
    return _ApiService(dio, baseUrl: baseUrl);
  }

  @GET('/users')
  Future<HttpResponse<List<UserEntity>>> getUsers({@Queries() required Map<String, dynamic> body}
  );
}