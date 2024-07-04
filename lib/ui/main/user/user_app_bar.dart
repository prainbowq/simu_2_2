import 'package:flutter/material.dart';
import 'package:igo/main.dart';

AppBar userAppBar() => AppBar(
      title: const Text('顧客中心'),
      actions: [
        IconButton(
          onPressed: () {},
          icon: ImageIcon(AssetImage('$imagesPrefix/settings.png')),
        ),
      ],
      centerTitle: true,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      elevation: 0,
    );
