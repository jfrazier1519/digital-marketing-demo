import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'venue_event.dart';
part 'venue_state.dart';

class VenueBloc extends Bloc<VenueEvent, VenueState> {
  VenueBloc() : super(VenueInitial()) {
    on<VenueEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
