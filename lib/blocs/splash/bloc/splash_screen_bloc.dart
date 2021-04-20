import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/repository/profile_repository.dart';

part 'splash_screen_event.dart';

part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  ProfileRepository profileRepository;
  SplashScreenBloc(SplashScreenState initialState, this.profileRepository)
      : super(initialState);

  @override
  Stream<SplashScreenState> mapEventToState(SplashScreenEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}
