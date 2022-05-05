import 'package:floor/floor.dart';
import 'package:github_user_listing_demo/core/db/floor/constants/database_tables.dart';
import 'package:github_user_listing_demo/core/db/floor/dao/base/base_dao.dart';
import 'package:github_user_listing_demo/core/db/floor/local/user_db_entity.dart';


@dao
abstract class UserDao extends BaseDao<UserDBEntity>{
  @Query("SELECT * FROM ${Table.USER}")
  Stream<List<UserDBEntity>> getUsers();

  @Query("SELECT * FROM ${Table.USER} WHERE id = :id")
  Future<UserDBEntity?> getCurrentUser(int id);


  @override
  @delete
  Future<int> deleteItem(UserDBEntity entity);

  @transaction
  Future<bool> insertUser(UserDBEntity user) async {
    try {
        int index = await insertData(user);
        return index > 0;
    } catch (exception) {
      print(exception);
      return false;
    }
  }

  @transaction
  Future<bool> deleteUser(int userId) async {
    try {
      UserDBEntity? userEntity = await getCurrentUser(userId);

     if(userEntity != null){
       int id = await deleteItem(userEntity);
       return Future.value(id > 0);
     }
     return false;
    } catch (exception) {
      print(exception);
      return false;
    }
  }

}