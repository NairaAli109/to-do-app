import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/screens/home_screen.dart';
import 'bloc_observer.dart';


void main() {

  Bloc.observer = const SimpleBlocObserver();

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  HomeScreen(),
    );
  }
}
