import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  String name;
  String password;

  MainScreen({
    required this.name,
    required this.password,
});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override


  Future resp() async {
    final response = await http.post(Uri.parse('https://trello.backend.tests.nekidaem.ru/api/v1/users/login/'), body: {'username': widget.name, 'password': widget.password, } );
    final responseJson = jsonDecode(response.body);
    print(' response ===== ${response.body}');
    print(' response ===== ${response.statusCode}');
    var toc = responseJson['token'];
    print(toc);
    return toc;
  }


  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Color(0xff000000),
        appBar: AppBar(
          backgroundColor: Color(0xff424242),
          automaticallyImplyLeading: false,
          actions: [
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pop();
                resp();
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              backgroundColor: Color(0xff63ffd8),
            )
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text('On hold'),
              ),
              Tab(text: 'In progress'),
              Tab(text: 'Needs review'),
              Tab(text: 'Approved'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Text('On hold'),
            Text('In progress'),
            Text('Needs review'),
            Text('Approved'),
          ],
        ),
      ),
    );
  }
}

