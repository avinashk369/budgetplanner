import 'dart:io';

import 'package:dio/dio.dart';
import 'package:budgetplanner/models/CaffairModel.dart';
import 'package:retrofit/retrofit.dart';
part 'ApiClient.g.dart';

@RestApi(baseUrl: "https://tdaacademy.in/tda_app/api/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("caffairs")
  Future<CaffairModel> getCurrentAffairs(@Query("page") int page);
}
