import 'package:dio/dio.dart';
import 'package:budgetplanner/models/BaseModel.dart';
import 'package:budgetplanner/models/CaffairModel.dart';
import 'package:budgetplanner/models/ServerError.dart';
import 'package:budgetplanner/rest_client/ApiClient.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'caffair_repository.dart';

class CaffairRepositoryImpl implements CaffairRepository {
  late Dio dio;
  late ApiClient apiClient;

  CaffairRepositoryImpl() {
    dio = new Dio();
    //dio.options.headers["Content-Type"] = "application/json";
    dio.interceptors.add(PrettyDioLogger());
    /*dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options){
      options.headers["Authorization"] = "Bearer " + accessToken;
      return options;
    },
        onResponse: (Response response){},
        onError: (DioError error){}) );*/
    apiClient = new ApiClient(dio);
  }

  @override
  Future<BaseModel<CaffairModel>> getCaffairList(int pageNumber) async {
    CaffairModel blogList;
    try {
      blogList = await apiClient.getCurrentAffairs(pageNumber);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      //print(error.toString());
      BaseModel()..setErrorMessage("message");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = blogList;
  }
}
