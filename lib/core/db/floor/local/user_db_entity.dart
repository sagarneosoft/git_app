import 'package:floor/floor.dart';
import 'package:github_user_listing_demo/core/db/floor/constants/database_tables.dart';
import 'package:github_user_listing_demo/core/utils/network/mapper/base_layer_transformer.dart';
import 'package:github_user_listing_demo/features/user_listing/data/models/user.dart';

@Entity(tableName: Table.USER, indices: [
  Index(value: ['id'], unique: true)
])

class UserDBEntity extends BaseLayerTransformer<UserDBEntity, User> {
  @primaryKey
  int? id;
  String? name;
  String? avatar;
   bool? isSelected;

  UserDBEntity({
     this.id,
     this.name,
     this.avatar,
    this.isSelected
});

  @override
  User transform() {
    return User(
      id: id?? 0,
      name: name ?? "sample",
      avatar: avatar?? "sample avatar",
      isSelected: isSelected ?? false
    );
  }

  @override
  UserDBEntity restore(User data) {
    id = data.id;
    name = data.name;
    avatar = data.avatar;
    isSelected = data.isSelected;
    return this;

  }





}