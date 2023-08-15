import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:reefer_review_mobile/repositories/auth_repository/auth_repository.dart';

import '../../data/models/requests/login_user_request.dart';
import '../../data/models/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  AuthBloc(this.repository) : super(AuthInitial()) {
    on<LoginUserUsecase>((event, emit) async {
      emit(AuthLoading());
      await repository.login(event.request);
      emit(AuthUserLoggedIn(repository.user!));
    });
    on<LogoutUserUsecase>((event, emit) async {
      emit(AuthLoading());
      await repository.logout();
      emit(AuthInitial());
    });
  }
}
