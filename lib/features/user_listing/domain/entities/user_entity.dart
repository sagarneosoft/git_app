import 'package:github_user_listing_demo/core/utils/network/mapper/base_layer_transformer.dart';
import 'package:github_user_listing_demo/features/user_listing/data/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity implements BaseLayerTransformer<UserEntity, User>{
  @JsonKey(name:'id')
  final int id;
  @JsonKey(name:'login')
  final String name;
  @JsonKey(name:'avatar_url')
  final String avatar;

  UserEntity({required this.id, required this.name, required this.avatar});


  factory UserEntity.fromJson(Map<String,dynamic> json){
    return _$UserEntityFromJson(json);
  }

  Map<String,dynamic> toJson() => _$UserEntityToJson(this);

  @override
  UserEntity restore(User data) {
    // TODO: implement restore
    throw UnimplementedError();
  }

  @override
  User transform() {
    return User(
      name: name,
      avatar: avatar,
      id: id,
    );
  }

}