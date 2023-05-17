import 'package:flutter/material.dart';
import 'package:d_match/pages/side_menu.dart';

final drawer = Drawer(
  child: SideMenu(),
);

class TopPage extends StatefulWidget {
  const TopPage({super.key});

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ホーム画面'),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(onPressed: () => {}, icon: const Icon(Icons.search))
        ],
      ),
      drawer: drawer,
      body: const Center(child: Text('開発中です')),
    );
  }
}
