import 'package:flutter/foundation.dart';

@immutable
sealed class Result<T> {
  const Result();

  R fold<R>({
    required R Function(T value) onSuccess,
    required R Function(AppError error) onFailure,
  });
}

class Success<T> extends Result<T> {
  final T value;

  const Success(this.value);

  @override
  R fold<R>({
    required R Function(T value) onSuccess,
    required R Function(AppError error) onFailure,
  }) =>
      onSuccess(value);
}

class Failure<T> extends Result<T> {
  final AppError error;

  const Failure(this.error);

  @override
  R fold<R>({
    required R Function(T value) onSuccess,
    required R Function(AppError error) onFailure,
  }) =>
      onFailure(error);
}

@immutable
class AppError {
  final String message;
  final StackTrace? stackTrace;
  final Object? error;

  const AppError(this.message, [this.error, this.stackTrace]);

  @override
  String toString() => message;
}
