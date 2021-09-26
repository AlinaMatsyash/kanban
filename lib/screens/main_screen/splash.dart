import 'package:flutter/material.dart';
import 'package:kanban/bloc/auth/auth_bloc.dart';
import 'package:provider/src/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

        //context.read<AuthBloc>().login('armada', 'FSH6zBZ0p9yH');
      },
      child: Center(
        child: Container(
          color: Colors.green,
        ),
      ),
    );
  }
}
