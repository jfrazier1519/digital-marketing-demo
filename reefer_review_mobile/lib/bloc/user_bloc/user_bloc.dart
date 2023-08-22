import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:reefer_review_mobile/data/models/user/user.dart';
import 'package:reefer_review_mobile/data/models/requests/login_user_request.dart';
import 'package:reefer_review_mobile/data/models/requests/send_email_verification_link_request.dart';
import 'package:reefer_review_mobile/repositories/user_repository/user_repository.dart';

import '../../data/models/requests/register_user_request.dart';
import '../../data/models/requests/update_profile_request.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;
  final Map<String, User> _cachedUsers = {};

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
        _cachedUsers[repository.currentAccount!.uid] =
            repository.currentAccount!;
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

      if (event.user.followedBrands.contains(event.brandId)) {
        await repository.unfollowBrand(event.user, event.brandId);
      } else {
        await repository.followBrand(event.user, event.brandId);
      }

      final updatedUser = _cachedUsers[event.user.uid] ??
          await repository.getUserById(event.user.uid);
      emit(UserUpdated(updatedUser));
      emit(UserLoaded(updatedUser));

      _cachedUsers[updatedUser.uid] = updatedUser;
    });

    on<GetUserById>((event, emit) async {
      final uid = event.uid;
      if (_cachedUsers.containsKey(uid)) {
        emit(UserLoaded(_cachedUsers[uid]!));
      } else {
        emit(UserLoading());
        try {
          User user = await repository.getUserById(uid);
          _cachedUsers[uid] = user;
          emit(UserLoaded(user));
        } catch (e) {
          // You might want to create a new error state
          // to handle errors for better UX
          print("Error fetching user: $e");
        }
      }
    });
  }
}
