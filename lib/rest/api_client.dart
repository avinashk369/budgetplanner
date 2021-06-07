import 'package:dio/dio.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/poc/datamodel.dart';
import 'package:retrofit/http.dart';

@RestApi(baseUrl: "https://5d42a6e2bc64f90014a56ca0.mockapi.io/api/v1/")
abstract class RestClient {
  //factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/tasks")
  Future<List<DataModel>> getTasks();
}
