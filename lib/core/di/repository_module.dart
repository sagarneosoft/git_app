


import 'package:github_user_listing_demo/core/db/database_properties.dart';
import 'package:github_user_listing_demo/core/db/floor_db_service.dart';
import 'package:github_user_listing_demo/core/di/network_module.dart';
import 'package:github_user_listing_demo/features/user_listing/data/datasource/local/user_local_data_source.dart';
import 'package:github_user_listing_demo/features/user_listing/data/datasource/remote/user_remote_datasource.dart';
import 'package:github_user_listing_demo/features/user_listing/data/repository/user_repository_impl.dart';
import 'package:riverpod/riverpod.dart';


final userDataSourceProvider = Provider((ref){
  return UserListingDataSourceImpl(apiService: ref.read(apiServiceProvider));
});


final floorAppDatabase = Provider<FloorDbService>(
      (ref) => FloorDbService(
    DatabaseProperties.DB_NAME,
  ),
);

final userLocalDSProvider = Provider((ref){
  return UserLocalDSImpl(floorDbService: ref.read(floorAppDatabase));

});


final repositoryProvider = Provider((ref){
  return UserListingRepositoryImpl(
    userListingDataSource: ref.read(userDataSourceProvider), localDS: ref.read(userLocalDSProvider),
  );
});
