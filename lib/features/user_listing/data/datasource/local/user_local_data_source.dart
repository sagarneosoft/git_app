import 'package:github_user_listing_demo/core/db/app_database.dart';
import 'package:github_user_listing_demo/core/db/floor/local/user_db_entity.dart';
import 'package:github_user_listing_demo/core/db/floor_db_service.dart';

abstract class UserLocalDS{
  Future<bool> saveUser(UserDBEntity userDBEntity);
  Future<bool> deleteUser(int userId);
  Future<Stream<List<UserDBEntity>>> getStreamedUser();
}


class UserLocalDSImpl extends UserLocalDS{

  final FloorDbService floorDbService;

  UserLocalDSImpl({required this.floorDbService});

  Future<AppDatabase> _getAppDatabase() {
    return floorDbService.db;
  }

  @override
  Future<bool> saveUser(UserDBEntity userDBEntity) async{
    return (await (await _getAppDatabase()).userDao.insertUser(userDBEntity));
  }

  @override
  Future<bool> deleteUser(int userId) async{
   return (await(await _getAppDatabase()).userDao.deleteUser(userId));
  }

  @override
  Future<Stream<List<UserDBEntity>>> getStreamedUser()async {
   return  ((await _getAppDatabase()).userDao.getUsers());
  }

}