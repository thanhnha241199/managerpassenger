part of 'chat_bloc.dart';

class ChatState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class InitialChatState extends ChatState {}

class LoadingState extends ChatState {}

class SuccessState extends ChatState {
  List<UserChat> user;

  SuccessState({this.user});
}

class FailureState extends ChatState {
  String msg;

  FailureState({this.msg});
}
