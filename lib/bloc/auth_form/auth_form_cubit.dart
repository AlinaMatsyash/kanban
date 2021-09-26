import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_form_state.dart';

class AuthFormCubit extends Cubit<AuthFormState> {


  AuthFormCubit() : super(AuthFormState(username: '', password: ''));

  setName(val) => emit(state.copyWith(
        username: val,
      ));

  setPassword(val) => emit(state.copyWith(
        password: val,
      ));


}
