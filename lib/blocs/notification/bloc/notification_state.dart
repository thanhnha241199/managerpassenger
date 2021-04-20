part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  @override
  List<Object> get props => [];
}

class NotificationInitialState extends NotificationState {}

class LoadingState extends NotificationState {}

class AddLoadingState extends NotificationState {}

class SuccessState extends NotificationState {
  List<Notification> notification;

  SuccessState({this.notification});
}

class FailureState extends NotificationState {
  String msg;

  FailureState({this.msg});
}
