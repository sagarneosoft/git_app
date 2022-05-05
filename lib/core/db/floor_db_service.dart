import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';
import 'package:github_user_listing_demo/core/db/app_database.dart';

class FloorDbService{
  static final FloorDbService connect  = FloorDbService._internal();
  FloorDbService._internal();

  static String? dbName;

  factory FloorDbService(String databaseName) {
    dbName = databaseName;
    return connect;
  }

  static AppDatabase? _database;

  Future<AppDatabase> get db async {
    _database ??= await _initializeDatabase();
    return _database!;
  }

  final dbCallBack = Callback(
    onCreate: (database, version) async {
      print("created");
      /* database has been created */
      print("Database Path: ${database.path}");
    },
    onOpen: (database) async {
      /* database has been opened */
    },
    onUpgrade: (database, startVersion, endVersion) {
      /* database has been upgraded */
    },
  );

  Future<String> getDbPath() async {
    if (kReleaseMode) {
      return '';
    } else {
      return '';
    }
  }

  Future<AppDatabase> _initializeDatabase() async {
    return await $FloorAppDatabase
        .databaseBuilder((await getDbPath()) + dbName!)
        .addCallback(dbCallBack)
        .build();
  }

}