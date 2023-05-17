import 'dart:io';

import 'package:d_match/firestore/user_firestore.dart';
import 'package:d_match/model/user.dart';
import 'package:d_match/utils/shared_prefs.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? image;
  String imagePath = '';
  final ImagePicker _picker = ImagePicker();
  final TextEditingController controller = TextEditingController();

  Future<void> selectImage() async {
    PickedFile? pickedImage =
        await _picker.getImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    setState(() {
      image = File(pickedImage.path);
    });
  }

  Future<void> uplogadImage() async {
    String path = image!.path.substring(image!.path.lastIndexOf('/') + 1);
    final ref = FirebaseStorage.instance.ref(path);
    final storedImage = await ref.putFile(image!);
    imagePath = await storedImage.ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール編集'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // ここだけ教材とconstの位置が違う
            Row(
              children: [
                const SizedBox(width: 150, child: Text('名前')),
                Expanded(
                    child: TextField(
                  controller: controller,
                ))
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                const SizedBox(width: 150, child: Text('プロフィール画像')),
                Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                          onPressed: () async {
                            await selectImage();
                            uplogadImage();
                          },
                          child: const Text('画像を選択'))),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            image == null
                ? SizedBox()
                : SizedBox(
                    width: 200,
                    height: 200,
                    child: Image.file(image!, fit: BoxFit.cover)),
            const SizedBox(
              height: 150,
            ),
            SizedBox(
                width: 150,
                child: ElevatedButton(
                    onPressed: () async {
                      User newProfile = User(
                          name: controller.text,
                          imagePath: imagePath,
                          uid: SharedPrefs.fetchUid()!);
                      await UserFirestore.updateUser(newProfile);
                    },
                    child: const Text('編集')))
          ],
        ),
      ),
    );
  }
}
