import 'package:dio/dio.dart';

const baseUrl = "https://codevolution.ir/digikala/api/v1/";

class ApiProvider {

  ApiProvider._internal();

  static final ApiProvider _singleton = ApiProvider._internal();

  factory ApiProvider() {
    return _singleton;
  }

  static BaseOptions options = new BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: 90000,
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
    },
  );

  Dio dio = Dio(options);

  Future<dynamic> productbycatid(int catId) async {
        return dio.get("productbycatid/$catId");
  }

  Future<dynamic> productdetails(int id) async {
        return dio.get("productdetails/$id");
  }


}
