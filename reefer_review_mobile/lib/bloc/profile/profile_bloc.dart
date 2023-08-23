import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reefer_review_mobile/data/models/profile/profile.dart';
import 'package:reefer_review_mobile/data/models/requests/get_profile_by_id_request.dart';
import 'package:reefer_review_mobile/repositories/profile_repository/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;

  ProfileBloc(this.repository) : super(ProfileInitial()) {
    on<GetProfileByIdUsecase>((event, emit) async {
      emit(ProfileLoading());
      await repository.fetchProfileByTypeAndId(event.request);
      if (repository.currentProfile != null) {
        emit(ProfileLoaded(repository.currentProfile!));
      }
    });
  }
}
