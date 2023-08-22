import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:reefer_review_mobile/data/models/user.dart';
import 'package:reefer_review_mobile/data/models/requests/login_user_request.dart';
import 'package:reefer_review_mobile/data/models/requests/send_email_verification_link_request.dart';
import 'package:reefer_review_mobile/repositories/user_repository/user_repository.dart';

import '../../data/models/requests/register_user_request.dart';
import '../../data/models/requests/update_profile_request.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;

  UserBloc(this.repository) : super(UserInitial()) {
    on<RegisterUserUsecase>((event, emit) async {
      emit(UserLoading());
      await (Future.delayed(const Duration(seconds: 1)));
      emit(UserRequestSuccessful());
    });
    on<SendEmailVerifcationLinkUseCase>((event, emit) async {
      emit(UserLoading());
      await repository.sendEmailVerificationLink(event.request);
      emit(UserRequestSuccessful());
    });
    on<UpdateUserprofileUsecase>((event, emit) async {
      emit(UserLoading());
      await repository.updateProfile(event.request);
      if (repository.currentAccount != null) {
        emit(UserLoaded(repository.currentAccount!));
      }
    });

    on<LogoutUserUsecase>((event, emit) async {
      emit(UserLoading());
      await repository.logout();
      emit(UserInitial());
    });

    on<LoginUserUsecase>((event, emit) async {
      emit(UserLoading());
      await repository.login(event.request);
      if (repository.currentAccount != null) {
        emit(UserLoaded(repository.currentAccount!));
      }
    });
    on<ToggleFollowBrand>((event, emit) async {
      emit(UserLoading());

      User user = await repository.getUserById(event.uid);

      if (user.followedBrands.contains(event.brandId)) {
        await repository.unfollowBrand(event.uid, event.brandId);
      } else {
        await repository.followBrand(event.uid, event.brandId);
      }

      User updatedUser = await repository.getUserById(event.uid);
      emit(UserUpdated(updatedUser));
    });
  }
}
