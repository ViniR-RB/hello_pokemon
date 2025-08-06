import 'dart:async';

import 'package:hello_pokemon/app/modules/core/either/either.dart';
import 'package:hello_pokemon/app/modules/core/exceptions/app_exception.dart';

typedef AsyncResult<L extends AppException, R> = Future<Either<L, R>>;

extension AsyncResultExtension<L extends AppException, R> on AsyncResult<L, R> {
  AsyncResult<L, W> map<W extends Object>(FutureOr<W> Function(R success) fn) {
    return then(
      (result) => result
          .map(fn)
          .when(
            onSuccess: (success) async => Success<L, W>(await success),
            onFailure: (failure) => Failure<L, W>(failure),
          ),
    );
  }

  Future<W> when<W>({
    required W Function(R value) onSuccess,
    required W Function(L exception) onFailure,
  }) {
    return then(
      (result) => result.when(
        onSuccess: (value) => onSuccess(value),
        onFailure: (exception) => onFailure(exception),
      ),
    );
  }

  Future<R> getOrThrow() {
    return then((result) => result.getOrThrow());
  }
}
