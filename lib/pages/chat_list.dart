import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_match/firestore/room_firestore.dart';
import 'package:d_match/model/talk_room.dart';
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
    ),
    User(name: '佐藤', uid: 'def'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('チャットアプリ'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: RoomFirestore.joinedRoomSnapshot,
          builder: (context, streamSnapshot) {
            if (streamSnapshot.hasData) {
              return FutureBuilder<List<TalkRoom>?>(
                  future: RoomFirestore.fetchJoinedRooms(streamSnapshot.data!),
                  builder: (context, futureSnapshot) {
                    if (futureSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      if (futureSnapshot.hasData) {
                        List<TalkRoom> talkRooms = futureSnapshot.data!;
                        return ListView.builder(
                            itemCount: talkRooms.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TalkRoomPage(
                                              talkRooms[index].talkUser.name)));
                                },
                                child: SizedBox(
                                  height: 70,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: CircleAvatar(
                                          radius: 30,
                                          backgroundImage: talkRooms[index]
                                                      .talkUser
                                                      .imagePath ==
                                                  null
                                              ? null
                                              : NetworkImage(talkRooms[index]
                                                  .talkUser
                                                  .imagePath!),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            talkRooms[index].talkUser.name,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            talkRooms[index].lastMessage ?? '',
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      } else {
                        return const Center(child: Text('トークルームの取得に失敗しました'));
                      }
                    }
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
