import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todolist19092022/data/datasources/remote/app_resources.dart';
import 'package:flutter_todolist19092022/data/model/post_model.dart';
import 'package:flutter_todolist19092022/presentation/feature/post/main/bloc/post_events.dart';
import 'package:flutter_todolist19092022/presentation/feature/post/main/bloc/post_states.dart';
import 'package:flutter_todolist19092022/presentation/feature/post/main/repositories/post_repository.dart';

class PostBloc extends Bloc<PostEventBase, PostStateBase> {
  late PostRepository _repository;
  PostBloc(PostRepository postRepository) : super(PostStateInit()) {
    _repository = postRepository;
    // on là lắng nghe tới event (giống stream)
    // event là lấy sự kiện do người truyền vô cho sự kiện này
    // emit là cập nhật cho sự kiện đó như thế nào
    on<FetchListPostEvent>((event, emit) async {
      try {
        Response response = await _repository.getListPosts();
        if (response.statusCode == 200) {
          List<PostModel> listModel = (response.data as List).map((e) {
            return PostModel.fromJson(e);
          }).toList();
          emit(PostResult(data: AppResources.success(listModel)));
        }
      } catch (e) {
        emit(PostResult(data: AppResources.error(e.toString())));
      }
    });
  }
}













////////////////////////////////////////////////////////////////////////////////////////////////////////
// import 'dart:async';

// import 'package:dio/dio.dart';
// import 'package:flutter_todolist19092022/data/datasources/remote/app_resources.dart';
// import 'package:flutter_todolist19092022/data/model/post_model.dart';
// import 'package:flutter_todolist19092022/presentation/feature/post/main/bloc/post_events.dart';
// import 'package:flutter_todolist19092022/presentation/feature/post/main/bloc/post_states.dart';
// import 'package:flutter_todolist19092022/presentation/feature/post/main/repositories/post_repository.dart';

// class PostBloc {
//   StreamController<PostEventBase> _eventController = StreamController();
//   StreamController<PostStateBase> _stateController = StreamController();

//   Sink<PostEventBase> get event => _eventController.sink;

//   Stream<PostStateBase> get state => _stateController.stream;

//   late PostRepository _postRepository;

//   PostBloc(PostRepository postRepository) {
//     _postRepository = postRepository;
//     _eventController.stream.listen((event) {
//       if (event is FetchListPostEvent) {
//         _handleFetchList(event);
//       }
//     });
//   }

//   void _handleFetchList(FetchListPostEvent event) async {
//     try {
//       Response response = await _postRepository.getListPosts();
//       if (response.statusCode == 200) {
//         List<PostModel> listModel = (response.data as List).map((e) {
//           return PostModel.fromJson(e);
//         }).toList();
//         _stateController.sink
//             .add(PostResult(data: AppResources.success(listModel)));
//       }
//     } catch (e) {
//       _stateController.sink
//           .addError(PostResult(data: AppResources.error(e.toString())));
//     }
//   }

//   void dispose() {
//     _eventController.close();
//     _stateController.close();
//   }
// }




