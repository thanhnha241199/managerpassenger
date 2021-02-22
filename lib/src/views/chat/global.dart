import 'package:managepassengercar/src/views/chat/user.dart';

import 'SocketUtils.dart';

class G {
  // Socket
  static SocketUtils socketUtils;
  static List<User> dummyUsers;

  // Logged In User
  static User loggedInUser;

  // Single Chat - To Chat User
  static User toChatUser;

  static initSocket() {
    if (null == socketUtils) {
      socketUtils = SocketUtils();
    }
  }

  static void initDummyUsers() {
    User userA = new User(id: 1000, name: 'A', email: 'testa@gmail.com');
    User userB = new User(id: 1001, name: 'B', email: 'testb@gmail.com');
    User userC = new User(id: 1002, name: 'C', email: 'testc@gmail.com');
    User userD = new User(id: 1003, name: 'D', email: 'testd@gmail.com');
    dummyUsers = List<User>();
    dummyUsers.add(userA);
    dummyUsers.add(userB);
    dummyUsers.add(userC);
    dummyUsers.add(userD);
  }

  static List<User> getUsersFor(User user) {
    List<User> filteredUsers = dummyUsers
        .where((u) => (!u.name.toLowerCase().contains(user.name.toLowerCase())))
        .toList();
    return filteredUsers;
  }
}
