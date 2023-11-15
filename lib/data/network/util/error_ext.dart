import 'package:dio/dio.dart';
import 'package:flutter_note/exports.dart';

extension DioErrorExtension on DioException {
  Error asNetworkError() {
    switch (type) {
      case DioExceptionType.badResponse:
        {
          final errorResponse = response;
          if (errorResponse == null) {
            return DomainError(errorCode: ErrorCode.unknown, cause: this);
          }

          if (errorResponse.statusCode != null) {
            final statusCode = errorResponse.statusCode!;
            if (statusCode >= 400 && statusCode < 500) {
              return DomainError(errorCode: ErrorCode.badRequest, cause: this);
            }

            if (statusCode >= 500) {
              return DomainError(errorCode: ErrorCode.serverError, cause: this);
            }
          }

          return DomainError(errorCode: ErrorCode.unknown, cause: this);
        }

      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return DomainError(errorCode: ErrorCode.networkError, cause: this);

      case DioExceptionType.unknown:
      case DioExceptionType.cancel:
      default:
        return DomainError(errorCode: ErrorCode.unknown, cause: this);
    }
  }
}