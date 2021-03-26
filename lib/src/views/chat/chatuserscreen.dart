import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/chat/bloc/chat_bloc.dart';
import 'package:managepassengercar/src/views/chat/chatscreen.dart';
import 'package:managepassengercar/src/views/chat/global.dart';
import 'package:managepassengercar/src/views/chat/user.dart';

class ChatUsersScreen extends StatefulWidget {
  ChatUsersScreen() : super();

  @override
  _ChatUsersScreenState createState() => _ChatUsersScreenState();
}

class _ChatUsersScreenState extends State<ChatUsersScreen> {
  UserChat _chatUsers;
  bool _connectedToSocket;
  String _errorConnectMessage;
  List<UserChat> list;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChatBloc>(context).add(DoFetchEvent());
    _chatUsers = G.loggedInUser;
    print("chat user ${_chatUsers.id}");
    _connectedToSocket = false;
    _errorConnectMessage = 'Connecting...';
    _connectSocket();
  }

  _connectSocket() {
    Future.delayed(Duration(seconds: 2), () async {
      print(
          "Connecting Logged In User: ${G.loggedInUser.name}, ID: ${G.loggedInUser.id}");
      G.initSocket();
      await G.socketUtils.initSocket(G.loggedInUser);
      G.socketUtils.connectToSocket();
      G.socketUtils.setConnectListener(onConnect);
      G.socketUtils.setOnDisconnectListener(onDisconnect);
      G.socketUtils.setOnErrorListener(onError);
      G.socketUtils.setOnConnectionErrorListener(onConnectError);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Chat",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0.0,
        actionsIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            G.socketUtils.closeConnection();
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
        if (state is LoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is FailureState) {
          return Scaffold(
            body: Center(
              child: Text(state.msg),
            ),
          );
        }
        if (state is SuccessState) {
          list = state.user;
          return Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    height: 20,
                    width: MediaQuery.of(context).size.width,
                    color: _connectedToSocket ? Colors.green : Colors.redAccent,
                    child: Center(
                      child: Text(_connectedToSocket
                          ? 'Connected'
                          : _errorConnectMessage),
                    )),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.user.length,
                    itemBuilder: (_, index) {
                      UserChat user = state.user[index];
                      return _chatUsers.email != user.email
                          ? GestureDetector(
                              onTap: () {
                                G.toChatUser = user;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatScreen()));
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 4),
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12)),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 35.0,
                                    child: user.image != ""
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(45)),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: FadeInImage.assetNetwork(
                                                placeholder:
                                                    'assets/images/small_icon/loading.gif',
                                                image: user.image,
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(45)),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: FadeInImage.assetNetwork(
                                                placeholder:
                                                    'assets/images/small_icon/loading.gif',
                                                image:
                                                    "https://i.pinimg.com/originals/51/f6/fb/51f6fb256629fc755b8870c801092942.png",
                                              ),
                                            ),
                                          ),
                                    backgroundColor: Colors.black,
                                  ),
                                  title: Text(
                                    user.name.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  subtitle: Text(
                                    'ID: ${user.id.substring(0,10)}... - ${user.email}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            )
                          : Container();
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      }),
    );
  }

  onConnect(data) {
    print('Connected $data');
    setState(() {
      _connectedToSocket = true;
    });
  }

  onConnectError(data) {
    print('onConnectError $data');
    setState(() {
      _connectedToSocket = false;
      _errorConnectMessage = 'Failed to Connect';
    });
  }

  onConnectTimeout(data) {
    print('onConnectTimeout $data');
    setState(() {
      _connectedToSocket = false;
      _errorConnectMessage = 'Connection timeout';
    });
  }

  onError(data) {
    print('onError $data');
    setState(() {
      _connectedToSocket = false;
      _errorConnectMessage = 'Connection Failed';
    });
  }

  onDisconnect(data) {
    print('onDisconnect $data');
    setState(() {
      _connectedToSocket = false;
      _errorConnectMessage = 'Disconnected';
    });
  }
}
