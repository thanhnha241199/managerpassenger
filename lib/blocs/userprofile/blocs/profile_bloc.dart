import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/savelocation/savelocation.dart';
import 'package:managepassengercar/repository/profile_repository.dart';
import 'package:managepassengercar/src/models/profile_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileRepository profileRepository;

  ProfileBloc(ProfileState initialState, this.profileRepository)
      : super(initialState);

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent profileEvent) async* {
    // TODO: implement mapEventToState
    if (profileEvent is DoFetchEvent) {
      yield LoadingProfileState();
      try {
        var profile =
            await profileRepository.fetchProfileUser(profileEvent.token);
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("name", profile.name);
        pref.setString("email", profile.email);
        pref.setString("phone", profile.phone);
        print("success");
        yield SuccessProfileState(profile: profile);
      } catch (e) {
        yield FailureProfileState(msg: e.toString());
      }
    }
    if (profileEvent is UpdateEvent) {
      yield UpdateLoadingProfileState();
      try {
        String msg = await profileRepository.updateProfile(profileEvent.id,
            profileEvent.name, profileEvent.phone, profileEvent.image);
        print("msg: ${msg}");
        if (msg == "true") {
          yield UpdateProfileState();
          yield LoadingProfileState();
          try {
            var profile =
                await profileRepository.fetchProfileUser(profileEvent.token);
            yield SuccessProfileState(profile: profile);
          } catch (e) {
            yield FailureProfileState(msg: e.toString());
          }
        }
      } catch (error) {
        yield UpdateFailureProfileState(msg: error.toString());
      }
    }
  }
}
