import 'package:floor/floor.dart';
import 'package:github_user_listing_demo/core/db/floor/dao/user_dao.dart';
import 'package:github_user_listing_demo/core/db/floor/local/user_db_entity.dart';
import 'database_properties.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'app_database.g.dart';



@Database(version: DatabaseProperties.DB_VERSION,entities:[UserDBEntity])
abstract class AppDatabase extends FloorDatabase{
  UserDao get userDao;
}
