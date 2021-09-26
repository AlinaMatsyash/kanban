import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban/bloc/cards/cards_bloc.dart';
import 'package:kanban/repository/auth_repository.dart';
import 'package:kanban/theme/color_theme.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardsBloc(auth: context.read<AuthRepository>()),
      child: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  // String name;
  // String password;

  MainScreen();

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
                //resp();
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
        body: GestureDetector(
          onTap: () {
            context.read<CardsBloc>().fetch();
          },
          child: TabBarView(
            children: [
              buildTab(id: "0"),
              buildTab(id: "1"),
              buildTab(id: "2"),
              buildTab(id: "3"),

              // Text('On hold'),
              // Text('In progress'),
              // Text('Needs review'),
              // Text('Approved'),
            ],
          ),
        ),
      ),
    );
  }

  buildTab({String? id}) {
    return BlocBuilder<CardsBloc, CardsState>(
      builder: (context, state) {
        if (state is CardsReady) {
          final cards = state.cards[id] ?? [];

          return ListView.builder(
            itemCount: cards.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: ColorPalette.grey,
                  ),
                  child: ListTile(


                    title: Text('ID : ${cards[index].id}'),
                    subtitle: Text(Utf8Decoder().convert(cards[index].text.codeUnits)),
                  ),
                ),
              );
            },
          );
        } else {
          return GestureDetector(
              onTap: () {
                context.read<CardsBloc>().fetch();
              },
              child: Text('loading'));
        }
      },
    );
  }
}
