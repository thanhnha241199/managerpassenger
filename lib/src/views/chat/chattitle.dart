import 'package:flutter/material.dart';
import 'package:managepassengercar/src/views/chat/chatscreen.dart';
import 'package:managepassengercar/src/views/chat/user.dart';

class ChatTitle extends StatelessWidget {
  const ChatTitle({
    Key key,
    @required this.chatUser,
    @required this.userOnlineStatus,
  }) : super(key: key);

  final UserChat chatUser;
  final UserOnlineStatus userOnlineStatus;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          chatUser.name.toUpperCase(),
          style: TextStyle(
            fontSize: 17.0,
            color: Colors.black,
          ),
        ),
        Text(
          _getStatusText(),
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.black,
          ),
        )
      ],
    );
  }

  _getStatusText() {
    if (userOnlineStatus == UserOnlineStatus.connecting) {
      return 'connecting...';
    }
    if (userOnlineStatus == UserOnlineStatus.online) {
      return 'online';
    }
    if (userOnlineStatus == UserOnlineStatus.not_online) {
      return 'not online';
    }
  }
}
