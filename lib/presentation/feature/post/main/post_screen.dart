import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todolist19092022/data/datasources/remote/api/post_request_api.dart';
import 'package:flutter_todolist19092022/presentation/feature/post/main/repositories/post_repository.dart';

import 'package:provider/provider.dart';

import 'bloc/post_bloc.dart';
import 'bloc/post_events.dart';
import 'bloc/post_states.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Screen"),
      ),
      body: MultiProvider(
        providers: [
          Provider(create: (context) => PostRequestApi()),
          ProxyProvider<PostRequestApi, PostRepository>(
            create: (context) => PostRepository(context.read<PostRequestApi>()),
            update: (context, api, repository) {
              return PostRepository(api);
            },
          ),
          ProxyProvider<PostRepository, PostBloc>(
            create: (context) => PostBloc(context.read<PostRepository>()),
            update: (context, repository, bloc) {
              return PostBloc(repository);
            },
          )
        ],
        child: PostContainerWidget(),
      ),
    );
  }
}

class PostContainerWidget extends StatefulWidget {
  const PostContainerWidget({Key? key}) : super(key: key);

  @override
  _PostContainerWidgetState createState() => _PostContainerWidgetState();
}

class _PostContainerWidgetState extends State<PostContainerWidget> {
  late PostBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<PostBloc>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc.add(FetchListPostEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostStateBase>(
        bloc: bloc,
        builder: (context, state) {
          if (state is PostResult) {
            return state.data.when(success: (postModel) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("userId: " + postModel[0].userId.toString()),
                  SizedBox(
                    height: 10,
                  ),
                  Text("id: " + postModel[0].id.toString()),
                  SizedBox(
                    height: 10,
                  ),
                  Text("title: " + postModel[0].title),
                  SizedBox(
                    height: 10,
                  ),
                  Text("body: " + postModel[0].body),
                ],
              );
            }, error: ([String? message]) {
              return Text(message!);
            });
          }
          return CircularProgressIndicator();
        },
        listener: (context, state) {});
  }
}

 



// import 'package:flutter/material.dart';
// import 'package:flutter_todolist19092022/data/datasources/remote/api/post_request_api.dart';
// import 'package:flutter_todolist19092022/presentation/feature/post/main/bloc/post_bloc.dart';
// import 'package:flutter_todolist19092022/presentation/feature/post/main/bloc/post_events.dart';
// import 'package:flutter_todolist19092022/presentation/feature/post/main/bloc/post_states.dart';
// import 'package:flutter_todolist19092022/presentation/feature/post/main/repositories/post_repository.dart';
// import 'package:provider/provider.dart';

// class PostScreen extends StatefulWidget {
//   const PostScreen({Key? key}) : super(key: key);

//   @override
//   State<PostScreen> createState() => _PostScreenState();
// }

// class _PostScreenState extends State<PostScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Demo Post Screen"),
//       ),
//       body: MultiProvider(
//         providers: [
//           Provider(create: (context) => PostRequestApi()),
//           ProxyProvider<PostRequestApi, PostRepository>(
//             create: (context) => PostRepository(context.read<PostRequestApi>()),
//             update: (context, api, repository) {
//               return PostRepository(api);
//             },
//           ),
//           ProxyProvider<PostRepository, PostBloc>(
//             create: (context) => PostBloc(context.read<PostRepository>()),
//             update: (context, repository, bloc) {
//               return PostBloc(repository);
//             },
//           ),
//         ],
//         child: PostContainerWidget(),
//       ),
//     );
//   }
// }

// class PostContainerWidget extends StatefulWidget {
//   const PostContainerWidget({Key? key}) : super(key: key);

//   @override
//   State<PostContainerWidget> createState() => _PostContainerWidgetState();
// }

// class _PostContainerWidgetState extends State<PostContainerWidget> {
//   late PostBloc bloc;
//   @override
//   void initState() {
//     super.initState();
//     bloc = context.read<PostBloc>();
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     Future.delayed(
//         Duration(seconds: 6), () => bloc.event.add(FetchListPostEvent()));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<PostStateBase>(
//       stream: bloc.state,
//       builder: (context, snapshot) {
//         if (snapshot.data is PostResult) {
//           return (snapshot.data as PostResult).data.when(success: (postModel) {
//             return Container(
//               //constraints: BoxConstraints.expand(),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("userId: " + postModel[0].userId.toString()),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Text("id: " + postModel[0].id.toString()),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Text("title: " + postModel[0].title),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Text("body: " + postModel[0].body),
//                 ],
//               ),
//             );
//           }, error: ([String? message]) {
//             return Text(message!);
//           });
//         }
//         return CircularProgressIndicator(); // nay la nut loading
//       },
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     bloc.dispose();
//   }
// }
