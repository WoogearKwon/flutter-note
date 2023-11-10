import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_note/exports.dart';

part 'network_unsplash_photo.g.dart';

@JsonSerializable()
class NetworkUnsplashPhoto {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'width')
  final int width;

  @JsonKey(name: 'height')
  final int height;

  @JsonKey(name: 'color')
  final String? color;

  @JsonKey(name: 'urls')
  final NetworkUnsplashPhotoUrls urls;

  @JsonKey(name: 'likes')
  final int likes;

  @JsonKey(name: 'liked_by_user')
  final bool likedByUser;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'user')
  final NetworkUnsplashUser user;

  NetworkUnsplashPhoto({
    required this.id,
    required this.createdAt,
    required this.width,
    required this.height,
    required this.color,
    required this.urls,
    required this.likes,
    required this.likedByUser,
    required this.description,
    required this.user,
  });

  factory NetworkUnsplashPhoto.fromJson(Map<String, dynamic> json) =>
      _$NetworkUnsplashPhotoFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkUnsplashPhotoToJson(this);

  UnsplashPhoto asDomainModel() {
    return UnsplashPhoto(
        id: id,
        createdAt: createdAt,
        width: width,
        height: height,
        color: color,
        urls: urls.asDomainModel(),
        likes: likes,
        likedByUser: likedByUser,
        description: description,
        user: user.asDomainModel(),
    );
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

@JsonSerializable()
class NetworkUnsplashPhotoUrls {
  @JsonKey(name: 'raw')
  final String raw;

  @JsonKey(name: 'full')
  final String full;

  @JsonKey(name: 'regular')
  final String regular;

  @JsonKey(name: 'thumb')
  final String thumb;

  @JsonKey(name: 'small_s3')
  final String smallS3;

  NetworkUnsplashPhotoUrls({
    required this.raw,
    required this.full,
    required this.regular,
    required this.thumb,
    required this.smallS3,
  });

  factory NetworkUnsplashPhotoUrls.fromJson(Map<String, dynamic> json) =>
      _$NetworkUnsplashPhotoUrlsFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkUnsplashPhotoUrlsToJson(this);

  UnsplashPhotoUrls asDomainModel() {
    return UnsplashPhotoUrls(
        full: full,
        thumb: thumb,
        raw: raw,
        regular: regular,
        smallS3: smallS3,
    );
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
