import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:reefer_review_mobile/data/models/requests/send_email_verification_link_request.dart';
import 'package:reefer_review_mobile/repositories/account_repository/account_repository.dart';

import '../../data/models/requests/register_user_request.dart';
import '../../data/models/user.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository repository;

  AccountBloc(this.repository) : super(AccountInitial()) {
    on<RegisterUserUseCase>((event, emit) async {
      emit(AccountLoading());
      await (Future.delayed(const Duration(seconds: 1)));
      emit(AccountRequestSuccessful());
    });
    on<SendEmailVerifcationLinkUseCase>((event, emit) async {
      emit(AccountLoading());
      await repository.sendEmailVerificationLink(event.request);
      emit(AccountRequestSuccessful());
    });
    on<FetchUserDetails>((event, emit) async {
      // Handle the FetchUserDetails event
      emit(AccountLoading());

      User? user = await repository.getUserById(event.userId);
      if (user != null) {
        emit(UserDetailsFetched(user));
      } else {
        emit(UserNotFound());
      }
    });
  }
}
