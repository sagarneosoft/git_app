import 'package:github_user_listing_demo/core/network/rest/api_service.dart';
import 'package:github_user_listing_demo/features/user_listing/domain/entities/user_entity.dart';
import 'package:retrofit/dio.dart';

abstract class UserListingDataSource{
  Future<HttpResponse<List<UserEntity>>> fetchUsers(int fromId);
}

class UserListingDataSourceImpl extends UserListingDataSource{
  final ApiService apiService;
  UserListingDataSourceImpl({required this.apiService});

  @override
  Future<HttpResponse<List<UserEntity>>> fetchUsers(int fromId) {

    final body = <String, dynamic>{};
    body['since'] = fromId;
    body['per_page'] = 10;
    return apiService.getUsers(body: body);
  }

}