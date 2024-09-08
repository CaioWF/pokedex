import 'package:dartz/dartz.dart';
import 'package:pokedex/src/core/errors/exceptions.dart';
import 'package:pokedex/src/core/errors/failure.dart';

abstract class BaseRepository {
  Future<Either<Failure, T>> safeFetch<T>(Future<T> Function() fetch) async {
    try {
      final result = await fetch();
      return Right(result);
    } catch (e) {
      return Left(_mapExceptionToFailure(e as Exception));
    }
  }

  Failure _mapExceptionToFailure(Exception e) {
    if (e is NetworkException) {
      return const NetworkFailure('No internet connection');
    } else if (e is ServerException) {
      return const ServerFailure('Failed to fetch data from server');
    } else if (e is CacheException) {
      return const CacheFailure('Failed to access cache');
    } else {
      return const UnexpectedFailure('Unexpected error occurred');
    }
  }
}