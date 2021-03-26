import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/repository/chat_repository.dart';
import 'package:managepassengercar/src/views/chat/user.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatRepository chatRepository;

  ChatBloc(ChatState initialState, this.chatRepository) : super(initialState);

  @override
  Stream<ChatState> mapEventToState(ChatEvent addressEvent) async* {
    // TODO: implement mapEventToState
    if (addressEvent is DoFetchEvent) {
      yield LoadingState();
      try {
        List<UserChat> user = await chatRepository.fetchUser();
        yield SuccessState(user: user);
      } catch (e) {
        yield FailureState(msg: e.toString());
      }
    }
  }
}
