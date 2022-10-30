import 'package:flutter/material.dart';
import 'package:flutter_todolist19092022/presentation/feature/post/detail/post_detail_screen.dart';
import 'package:flutter_todolist19092022/presentation/feature/post/main/post_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/post": (context) => PostScreen(),
        "/post-detail": (context) => PostDetailScreen()
      },
      initialRoute: "/post",
    );
  }
}
