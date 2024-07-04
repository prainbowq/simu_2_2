import 'package:flutter/material.dart';

void showSnackBar(final BuildContext context, final String text) =>
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
