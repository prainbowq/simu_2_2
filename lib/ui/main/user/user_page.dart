import 'package:flutter/material.dart';
import 'package:igo/main.dart';
import 'package:igo/ui/login/login_screen.dart';
import 'package:igo/ui/show_snack_bar.dart';
import 'package:igo/ui/track/track_screen.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        Text(user == null ? '未登入' : user!.number),
        const Spacer(),
        TextButton.icon(
          onPressed: user == null
              ? () async => await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      ) ==
                      true
                  ? setState(() {})
                  : null
              : () {
                  user = null;
                  showSnackBar(context, '已登出。');
                  setState(() {});
                },
          icon: const Icon(Icons.navigate_next),
          label: Text('點我登${user == null ? '入' : '出'}'),
        )
      ]),
      if (user != null)
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Column(children: const [
                ImageIcon(AssetImage('$imagesPrefix/tracking.png')),
                Text('訂單查詢'),
              ]),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Column(children: const [
                ImageIcon(AssetImage('$imagesPrefix/return-on-investment.png')),
                Text('退訂/退款'),
              ]),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => TrackScreen()),
              ),
              child: Column(children: const [
                ImageIcon(AssetImage('$imagesPrefix/heart.png')),
                Text('追蹤清單'),
              ]),
            ),
          ],
        ),
    ]);
  }
}
