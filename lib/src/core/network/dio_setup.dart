import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Dio setupDio() {
  final dio = Dio();

  dio.interceptors.add(LogInterceptor(
    request: true,
    responseBody: true,
    requestBody: true,
    responseHeader: true,
    requestHeader: true,
    error: true,
    logPrint: (o) => debugPrint(o.toString())
  ));

  return dio;
}
