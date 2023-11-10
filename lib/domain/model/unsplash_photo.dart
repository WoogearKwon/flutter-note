import 'package:flutter/material.dart';
import 'package:flutter_note/exports.dart';

@immutable
class UnsplashPhoto {
  final String? id;
  final String? createdAt;
  final int width;
  final int height;
  final String? color;
  final UnsplashPhotoUrls urls;
  final int likes;
  final bool likedByUser;
  final String? description;
  final UnsplashUser user;

  const UnsplashPhoto({
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
}

@immutable
class UnsplashPhotoUrls {
  final String raw;
  final String full;
  final String regular;
  final String thumb;
  final String smallS3;

  const UnsplashPhotoUrls({
    required this.full,
    required this.thumb,
    required this.raw,
    required this.regular,
    required this.smallS3,
  });
}
