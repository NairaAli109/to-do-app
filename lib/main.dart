import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/screens/home_screen.dart';
import 'bloc_observer.dart';


void main() {

  // ErrorWidget.builder=(details)=>MaterialApp(
  //   debugShowCheckedModeBanner: false,
  //   home: Scaffold(
  //     backgroundColor: Colors.purple,
  //     body: SizedBox.expand(
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           const Icon(
  //               Icons.warning_rounded,
  //             color: Colors.white,
  //             size: 50,
  //           ),
  //           const SizedBox(height: 10,),
  //           Text(
  //             details.exception.toString(),
  //             style: const TextStyle(
  //               color: Colors.white,
  //               fontSize: 16,
  //               fontWeight: FontWeight.w600,
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   ),
  // );

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
