import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:reefer_review_mobile/data/models/account.dart';
import 'package:reefer_review_mobile/data/models/requests/login_user_request.dart';
import 'package:reefer_review_mobile/data/models/requests/send_email_verification_link_request.dart';
import 'package:reefer_review_mobile/repositories/account_repository/account_repository.dart';

import '../../data/models/requests/register_user_request.dart';
import '../../data/models/requests/update_profile_request.dart';

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
    on<UpdateProfileUsecase>((event, emit) async {
      emit(AccountLoading());
      await repository.updateProfile(event.request);
      if (repository.currentAccount != null) {
        emit(AccountLoaded(repository.currentAccount!));
      }
    });

    on<LogoutUserUsecase>((event, emit) async {
      emit(AccountLoading());
      await repository.logout();
      emit(AccountInitial());
    });

    on<LoginUserUsecase>((event, emit) async {
      emit(AccountLoading());
      await repository.login(event.request);
      if (repository.currentAccount != null) {
        emit(AccountLoaded(repository.currentAccount!));
      }
    });
  }
}
