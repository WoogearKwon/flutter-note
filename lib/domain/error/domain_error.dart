import 'package:flutter_note/exports.dart';

class DomainError extends Error {
  final ErrorCode errorCode;
  final dynamic cause;

  DomainError({
    this.errorCode = ErrorCode.unknown,
    this.cause,
  });
}
