import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/src/core/errors/exceptions.dart';
import 'package:pokedex/src/core/errors/failure.dart';

abstract class BaseRepository {
  Future<Either<Failure, T?>> safeFetch<T>(Future<T> Function() fetch) async {
    try {
      final result = await fetch();
      return Right(result);
    } catch (e) {
      if (e is DioException && CancelToken.isCancel(e)) {
        debugPrint('Request was cancelled');
        return const Right(null);
      }
      return Left(_mapExceptionToFailure(e));
    }
  }

  Failure _mapExceptionToFailure(dynamic e) {
    switch (e) {
    case NetworkException _:
      return const NetworkFailure('No internet connection');
    case ServerException _:
      return const ServerFailure('Failed to fetch data from server');
    case CacheException _:
      return const CacheFailure('Failed to access cache');
    default:
      return const UnexpectedFailure('Unexpected error occurred');
  }
  }
}