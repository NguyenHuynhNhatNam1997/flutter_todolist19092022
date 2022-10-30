import 'package:dio/dio.dart';
import 'package:flutter_todolist19092022/common/network/dio_client.dart';

class PostRequestApi {
  late Dio _dio;
  PostRequestApi() {
    _dio = DioClient.instance.dio;
  }
  Future<Response<dynamic>> getListPosts() {
    return _dio.get("posts");
  }
}
