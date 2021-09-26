import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban/bloc/auth/auth_bloc.dart';
import 'package:kanban/repository/auth_repository.dart';
import 'package:kanban/screens/login/login.dart';
import 'package:kanban/screens/main_screen/main_screen.dart';
import 'package:kanban/screens/main_screen/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) =>
            AuthBloc(RepositoryProvider.of<AuthRepository>(context)),
        child: MaterialApp(
          navigatorKey: _navigatorKey,
          onGenerateRoute: (_) => MaterialPageRoute(
            builder: (_) => RegisterFormPage(),
          ),
          theme: ThemeData.dark(),
          // builder: (ctx, child) {
          //   return BlocListener<AuthBloc, AuthState>(
          //     listener: (context, state) {
          //       // opens auth page
          //       if (state is Authenticated) {
          //         _navigator.push(
          //           MaterialPageRoute(builder: (_) => MainPage()),
          //         );
          //       } else {
          //         // opens auth page
          //         _navigator.push(
          //           MaterialPageRoute(builder: (_) => RegisterFormPage()),
          //         );
          //       }
          //     },
          //     child: child,
          //   );
          // }
        ),
      ),
    );
    // routes: {
    // // When navigating to the "/" route, build the FirstScreen widget.
    // '/': (context) => BlocProvider(
    // create: (context) => AuthBloc(),
    // child: RegisterFormPage(),
    // ),
    // // When navigating to the "/second" route, build the SecondScreen widget.
    // // '/second': (context) => const SecondScreen(),
    // },
    // theme: ThemeData.dark(),
    // // home: BlocProvider<AuthBloc>(
    // //   create: (context) => AuthBloc(),
    // //   child: RegisterFormPage(),
    // // ),
    // );
  }
}
