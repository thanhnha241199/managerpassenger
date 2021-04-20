import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/notification/model/notification.dart';
import 'package:managepassengercar/repository/notification_repository.dart';
part 'notification_state.dart';
part 'notification_event.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationRepository notificationRepository;
  NotificationBloc(NotificationState initialState, this.notificationRepository)
      : super(initialState);

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    // TODO: implement mapEventToState
    if (event is DoFetchEvent) {
      try {
        yield LoadingState();
        var notification = await notificationRepository.fetchNotification();
        print(notification);
        yield SuccessState(notification: notification);
      } catch (e) {
        yield FailureState(msg: e.toString());
      }
    }
  }
}
