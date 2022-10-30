import 'package:dio/dio.dart';
import 'package:flutter_todolist19092022/data/datasources/remote/api/post_request_api.dart';

class PostRepository {
  late PostRequestApi _api;

  PostRepository(PostRequestApi api) {
    _api = api;
  }

  Future<Response<dynamic>> getListPosts() {
    return _api.getListPosts();
  }
}
