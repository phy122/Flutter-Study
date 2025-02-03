import 'package:flutter/material.dart';
import 'package:navigation_widget/models/community.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Community 객체
    // Community? community =
    //     ModalRoute.of(context)!.settings.arguments as Community;

    // Map 컬렉션
    final community =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: const Text("커뮤니티"),
      ),
      body: Center(
        child: Text(
          // "커뮤니티\n id: ${community.id}\n name: ${community.name} \n content: ${community.content}",
          "커뮤니티\n id: ${community['id']}\n name: ${community['name']} \n content: ${community['content']}",
          style: TextStyle(fontSize: 30.0),
        ),
      ),
      bottomSheet: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                onPressed: () {
                  // 1. 스택에 새 화면을 추가
                  // Navigator.pushNamed(context, "/home");
                  // 2. 현재 화면 제거 후, 새 화면을 추가
                  Navigator.pop(context);
                  // Navigator.pushNamed(context, "/home");
                  // 3. 현재 화면을 새 화면으로 대체
                  Navigator.pushReplacementNamed(context, "/home");
                },
                child: const Text("홈 화면")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/user",
                      arguments: 'user');
                },
                child: const Text("마이 페이지")),
          ],
        ),
      ),
    );
  }
}
