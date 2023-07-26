import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/layout/home_layout.dart';
import 'package:untitled3/shared/bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? s;
    return Provider(
      create: (context) {
        return s;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeLayout(),
      ),
    );
  }
}
