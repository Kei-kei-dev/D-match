import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DrawerHeader(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.all(0),
          child: Container(
            color: Colors.blue,
            alignment: Alignment.center,
            child: const Text('サイドメニューです'),
          ),
        ),
        ListTile(
          title: const Text('プロフィール設定'),
          onTap: () {
            debugPrint('リストタイル A をタップしました');
          },
        ),
        ListTile(
          title: const Text('プライバシーポリシー'),
          onTap: () {
            debugPrint('リストタイル B をタップしました');
          },
        ),
        ListTile(
          title: const Text('D-matchについて'),
          onTap: () {
            debugPrint('リストタイル C をタップしました');
          },
        ),
      ],
    );
  }
}
