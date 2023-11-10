import 'package:flutter/material.dart';

@immutable
class UnsplashUser {
  final String id;
  final String? userName;
  final String? location;
  final UnsplashUserProfileImage profileImage;

  const UnsplashUser({
    required this.id,
    required this.userName,
    required this.location,
    required this.profileImage,
  });
}

@immutable
class UnsplashUserProfileImage {
  final String? small;
  final String? medium;
  final String? large;

  const UnsplashUserProfileImage({
    required this.small,
    required this.medium,
    required this.large,
  });
}
