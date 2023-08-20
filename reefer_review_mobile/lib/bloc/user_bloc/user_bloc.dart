import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/user.dart';
import '../../repositories/user_repository/fake_user_repository_impl.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FakeUserRepository userRepository;

  UserBloc(this.userRepository) : super(UserInitial()) {
    on<FollowBrand>((event, emit) async {
      emit(UserLoading());
      await userRepository.followBrand(event.userId, event.brandId);
      User updatedUser = await userRepository.getUserById(event.userId);
      emit(UserUpdated(updatedUser));
    });

    on<UnfollowBrand>((event, emit) async {
      emit(UserLoading());
      await userRepository.unfollowBrand(event.userId, event.brandId);
      User updatedUser = await userRepository.getUserById(event.userId);
      emit(UserUpdated(updatedUser));
    });
  }
}
