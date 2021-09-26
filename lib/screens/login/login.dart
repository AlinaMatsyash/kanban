import 'package:flutter/material.dart';
import 'package:kanban/bloc/auth/auth_bloc.dart';
import 'package:kanban/screens/login/auth_form.dart';
import 'package:provider/src/provider.dart';

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({Key? key}) : super(key: key);

  @override
  _RegisterFormPageState createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000000),
      //backgroundColor: Colors.red,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Kanban'),
        backgroundColor: Color(0xff424242),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
            key: _formKey,
            child:
                // Email Address
                AuthForm(
              onSubmit: (username, pass) =>
                  context.read<AuthBloc>().login(username, pass),
            )),
      ),
    );
  }

// void _submitForm() {
//   if (_formKey.currentState!.validate()) {
//     _formKey.currentState!.save();
//     print('Form is valid');
//     print('Email: ${nameController.text}');
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => MainScreen(
//           name: nameController.text,
//           password: passwordController.text,
//         ),
//       ),
//     );
//   } else {
//     return;
//   }
// }

}
