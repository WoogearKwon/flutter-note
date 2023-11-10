import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_note/exports.dart';

part 'network_unsplash_user.g.dart';

@JsonSerializable()
class NetworkUnsplashUser {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'username')
  final String? userName;

  @JsonKey(name: 'location')
  final String? location;

  @JsonKey(name: 'profile_image')
  final NetworkUnsplashUserProfile profileImage;

  NetworkUnsplashUser({
    required this.id,
    required this.userName,
    required this.location,
    required this.profileImage,
  });

  factory NetworkUnsplashUser.fromJson(Map<String, dynamic> json) =>
      _$NetworkUnsplashUserFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkUnsplashUserToJson(this);

  UnsplashUser asDomainModel() {
    return UnsplashUser(
        id: id,
        userName: userName,
        location: location,
        profileImage: profileImage.asDomainModel(),
    );
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

@JsonSerializable()
class NetworkUnsplashUserProfile {
  @JsonKey(name: 'small')
  final String? small;

  @JsonKey(name: 'medium')
  final String? medium;

  @JsonKey(name: 'large')
  final String? large;

  NetworkUnsplashUserProfile({
    required this.small,
    required this.medium,
    required this.large,
  });

  factory NetworkUnsplashUserProfile.fromJson(Map<String, dynamic> json) =>
      _$NetworkUnsplashUserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkUnsplashUserProfileToJson(this);

  UnsplashUserProfileImage asDomainModel() {
    return UnsplashUserProfileImage(
        small: small,
        medium: medium,
        large: large,
    );
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
