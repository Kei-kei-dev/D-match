import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_match/firestore/room_firestore.dart';
import 'package:d_match/model/user.dart';
import 'package:d_match/utils/shared_prefs.dart';

class UserFirestore {
  static final FirebaseFirestore _firebaseFirestoreInstance =
      FirebaseFirestore.instance;
  static final _userCollection = _firebaseFirestoreInstance.collection('user');

  static Future<String?> insertNewAccount() async {
    try {
      final newDoc = await _userCollection.add({
        'name': '名無し',
        'image_path':
            'https://thumb.photo-ac.com/05/05b73f7797034e6adf179f8727f718cc_t.jpeg',
      });

      print('アカウント作成完了');
      return newDoc.id;
    } catch (e) {
      print('アカウント作成失敗 ===== $e');
      return null;
    }
  }

  static Future<void> createUser() async {
    final myUid = await UserFirestore.insertNewAccount();
    if (myUid != null) {
      await RoomFirestore.createRoom(myUid);
      await SharedPrefs.setUid(myUid);
    }
  }

  static Future<List<QueryDocumentSnapshot>?> fetchUsers() async {
    try {
      final snapshot = await _userCollection.get();

      return snapshot.docs;
    } catch (e) {
      print('ユーザー情報の取得失敗 ===== $e');
      return null;
    }
  }

  static Future<User?> fetchProfile(String uid) async {
    try {
      final snapshot = await _userCollection.doc(uid).get();
      User user = User(
          name: snapshot.data()!['name'],
          imagePath: snapshot.data()!['image_path'],
          uid: uid);

      return user;
    } catch (e) {
      print('自分のユーザー情報の取得失敗 ----- $e');
      return null;
    }
  }
}
