import 'package:d_match/firestore/user_firestore.dart';
import 'package:d_match/pages/chat_list.dart';
import 'package:d_match/pages/profile_page.dart';
import 'package:d_match/pages/top_page.dart';
import 'package:d_match/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // firebase連携
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SharedPrefs.setPrefsInstance();
  String? uid = SharedPrefs.fetchUid();
  if (uid == null) await UserFirestore.createUser();
  print(uid);

  const app = MaterialApp(home: Root());

  const scope = ProviderScope(child: app);
  runApp(scope);
}

final indexProvider = StateProvider(
  (ref) {
    return 0;
  },
);

class Root extends ConsumerWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(indexProvider);

    const items = [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'ホーム',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.chat),
        label: 'トーク',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'プロフィール',
      ),
    ];

    final bar = BottomNavigationBar(
      items: items,
      backgroundColor: Colors.purple,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      currentIndex: index,
      onTap: (index) {
        ref.read(indexProvider.notifier).state = index;
      },
    );

    final pages = [
      const TopPage(),
      const ChatList(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: pages[index],
      bottomNavigationBar: bar,
    );
  }
}
