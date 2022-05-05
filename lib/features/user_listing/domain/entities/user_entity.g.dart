// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
      id: json['id'] as int,
      name: json['login'] as String,
      avatar: json['avatar_url'] as String,
    );

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'login': instance.name,
      'avatar_url': instance.avatar,
    };
