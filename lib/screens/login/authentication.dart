import 'package:flutter/material.dart';
import 'package:kanban/screens/main_screen/main_screen.dart';
import 'package:kanban/theme/color_theme.dart';

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({Key? key}) : super(key: key);

  @override
  _RegisterFormPageState createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.black,
      //backgroundColor: Colors.red,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Kanban'),
        backgroundColor: ColorPalette.grey,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Email Address
              TextFormField(
                controller: nameController,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorPalette.white,
                ),
                decoration: InputDecoration(
                  //labelText: 'Email Address',
                  hintText: 'Enter your username',
                  hintStyle: TextStyle(color: ColorPalette.grey),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: ColorPalette.red)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: ColorPalette.red)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: ColorPalette.turquoise)),

                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Color(0xff424242))),
                ),
                validator: (value) {
                  return _validateName(value);
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                //obscureText: _hidePass,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorPalette.white,
                ),
                decoration: InputDecoration(
                  //labelText: 'Email Address',
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(color: ColorPalette.grey),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: ColorPalette.red)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: ColorPalette.red)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: ColorPalette.turquoise)),

                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: ColorPalette.grey)),
                ),
                validator: (value) {
                  return _validatePassword(value);
                },
              ),
              SizedBox(height: 30),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(ColorPalette.turquoise),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  onPressed: _submitForm,
                  child: Text(
                    'Log in',
                    style: TextStyle(color: Color(0xff424242)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('Form is valid');
      print('Email: ${nameController.text}');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(name: nameController.text, password: passwordController.text,),
        ),
      );
    } else {
      return;
    }
  }

  _validateName(value) {
    if (nameController.text.length < 4) {
      return 'Minimum is 4 characters';
    } else {
      return null;
    }
  }

  _validatePassword(value) {
    if (passwordController.text.length < 8) {
      return 'Minimum is 8 characters';
    } else {
      return null;
    }
  }
}