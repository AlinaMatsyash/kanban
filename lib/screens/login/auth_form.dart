import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban/bloc/auth_form/auth_form_cubit.dart';
import 'package:kanban/bloc/auth/auth_bloc.dart';
import 'package:kanban/screens/login/form_field.dart';
import 'package:kanban/screens/main_screen/main_screen.dart';

class AuthForm extends StatelessWidget {
  final Function(String, String)? onSubmit;

  const AuthForm({
    Key? key,
    this.onSubmit,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthFormCubit(),
      child: AuthFormView(
        onSubmit: onSubmit,
      ),
    );
  }
}

class AuthFormView extends StatefulWidget {
  AuthFormView({Key? key, this.onSubmit}) : super(key: key);

  final Function(String, String)? onSubmit;

  @override
  State<AuthFormView> createState() => _AuthFormViewState();
}

class _AuthFormViewState extends State<AuthFormView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (ctx, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // name
            AuthField(
              hintText: 'Enter your username',
              validator: _validateName,
              onChanged: context.read<AuthFormCubit>().setName,

              // validator:,
            ),
            SizedBox(height: 20),
            // password
            AuthField(
              hintText: 'Enter your password',
              onChanged: context.read<AuthFormCubit>().setPassword,
              validator: _validatePassword,
            ),
            SizedBox(height: 30),
            // button
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xff63ffd8)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => MainPage()),
                  );
                  final state = context.read<AuthFormCubit>().state;
                  if (widget.onSubmit != null) {
                    widget.onSubmit!(
                      state.username!,
                      state.password!,
                    );
                  }
                },
                child: Text(
                  'Log in',
                  style: TextStyle(color: Color(0xff424242)),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String? _validateName(String? value) {
    if ((value?.length ?? 0)  < 4) {
      return 'Minimum is 4 characters';
    } else {
      return null;
    }
  }

  String? _validatePassword(String? value) {
    if ((value?.length ?? 0) < 8) {
      return 'Minimum is 8 characters';
    } else {
      return null;
    }
  }
}
