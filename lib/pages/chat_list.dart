import 'package:d_match/model/user.dart';
import 'package:d_match/pages/talk_room_page.dart';
import 'package:flutter/material.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  List<User> userList = [
    User(
        name: '田中',
        uid: 'abc',
        imagePath:
            'https://thumb.photo-ac.com/05/05b73f7797034e6adf179f8727f718cc_t.jpeg',
        lastMessage: 'こんにちは'),
    User(name: '佐藤', uid: 'def', lastMessage: 'ありがとう'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('チャットアプリ'),
      ),
      body: ListView.builder(
          itemCount: userList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            TalkRoomPage(userList[index].name)));
              },
              child: SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: userList[index].imagePath == null
                            ? null
                            : NetworkImage(userList[index].imagePath!),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          userList[index].name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          userList[index].lastMessage,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
