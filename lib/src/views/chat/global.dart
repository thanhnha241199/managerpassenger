import 'package:managepassengercar/repository/chat_repository.dart';
import 'package:managepassengercar/src/views/chat/user.dart';

import 'SocketUtils.dart';

class G {
  // Socket
  static SocketUtils socketUtils;
  static List<UserChat> dummyUsers;

  // Logged In User
  static UserChat loggedInUser;

  // Single Chat - To Chat User
  static UserChat toChatUser;
  static ChatRepository chatRepository;

  static initSocket() {
    if (null == socketUtils) {
      socketUtils = SocketUtils();
    }
  }

  static void initDummyUsers() {
    // User userA = new User(id: "1000", name: 'A', email: 'testa@gmail.com');
    // User userB = new User(id: "9999", name: 'nha', email: 'nha@gmail.com');
    // User userC = new User(id: "1002", name: 'C', email: 'testc@gmail.com');
    // User userD = new User(id: "1003", name: 'D', email: 'testd@gmail.com');
    // User userE = new User(id: "1000", name: 'E', email: 'teste@gmail.com');
    // User userF = new User(id: "1001", name: 'F', email: 'testf@gmail.com');
    // User userG = new User(id: "1002", name: 'G', email: 'testg@gmail.com');
    // User userH = new User(id: "1003", name: 'H', email: 'testh@gmail.com');
    // dummyUsers = List<User>();
    // dummyUsers.add(userA);
    // dummyUsers.add(userB);
    // dummyUsers.add(userC);
    // dummyUsers.add(userD);
    // dummyUsers.add(userE);
    // dummyUsers.add(userF);
    // dummyUsers.add(userG);
    // dummyUsers.add(userH);
  }

  static List<UserChat> getUsersFor(UserChat user) {
    List<UserChat> filteredUsers = dummyUsers
        .where((u) => (!u.name.toLowerCase().contains(user.name.toLowerCase())))
        .toList();
    return filteredUsers;
  }
}
