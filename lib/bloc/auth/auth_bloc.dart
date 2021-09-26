import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:kanban/repository/auth_repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.repository) : super(Initial());

  AuthRepository repository;

  var token;

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is SignIn) {
      yield Loading();
      token = await repository.logIn(
        event.username,
        event.password,
      );
      if (token != null) {
        saveToken(token);
        yield Authenticated(token);
      } else {
        yield Unauthenticated();
      }
    }

    if (event is CheckToken) {
      yield Loading();
      final token = await loadCachedToken();
      if (token == null || isExpired(token)) {
        yield Unauthenticated();
      } else {
        yield Authenticated(token);
      }
    }
  }

  login(username, pass) {
    add(SignIn(username, pass));
  }

// try to load last token from preferences
  Future<String?> loadCachedToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    // check whether the token is still valid
    if (token != null) isExpired(token);

    return token;
    // add(SignIn(username, pass));
  }

  // check whether jwt is expired
  bool isExpired(String token) {
    // decodes block with expiration date
    final data = decodeJWT(token);
    final expiration = data['exp'];

    final time = DateTime.fromMillisecondsSinceEpoch(expiration * 1000);

    final diff = time.difference(DateTime.now());
    return diff.isNegative;
  }

  decodeJWT(String jwt) {
    String tokenData = jwt.split('.')[1];

    if (tokenData.length % 4 > 0) {
      tokenData +=
          '=' * (4 - tokenData.length % 4); // as suggested by Albert221
    }
    Uint8List bytes = base64.decode(tokenData);

    final data = utf8.decode(bytes, allowMalformed: true);
    final decoded = jsonDecode(data);

    return decoded;
  }

  @override
  void onChange(Change<AuthState> change) {
    print('onchange ${change.nextState.runtimeType}');
    super.onChange(change);
  }

  void saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
}
