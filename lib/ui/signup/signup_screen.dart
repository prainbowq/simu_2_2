import 'package:flutter/material.dart';
import 'package:igo/data/user.dart';
import 'package:igo/main.dart';
import 'package:igo/ui/show_snack_bar.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final numberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmationController = TextEditingController();

  void signUp() async {
    final number = numberController.text;
    final password = passwordController.text;
    final confirmation = confirmationController.text;
    if (number.isEmpty) {
      showSnackBar(context, '錯誤：手機號碼不可為空。');
      return;
    }
    if (password.isEmpty) {
      showSnackBar(context, '錯誤：密碼不可為空。');
      return;
    }
    if (confirmation.isEmpty) {
      showSnackBar(context, '錯誤：確認密碼不可為空。');
      return;
    }
    if (confirmation != password) {
      showSnackBar(context, '錯誤：確認密碼不相符。');
      return;
    }
    final result = await database.query(
      'users',
      where: 'number = ?',
      whereArgs: [number],
    );
    if (result.isNotEmpty) {
      if (mounted) showSnackBar(context, '錯誤：電話號碼已被使用。');
      return;
    }
    await database.insert(
      'users',
      User(
        number: number,
        password: password,
        favorites: [],
        cart: [],
      ).toMap(),
    );
    if (!mounted) return;
    showSnackBar(context, '註冊成功。');
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    numberController.dispose();
    passwordController.dispose();
    confirmationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('會員註冊'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context)
              ..pop()
              ..pop(),
            icon: const Icon(Icons.close),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          const Text(
            '立即登入',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('已經擁有iGO購物帳號嗎？'),
              TextButton(
                onPressed: Navigator.of(context).pop,
                child: const Text('立即登入'),
              ),
            ],
          ),
          TextField(
            controller: numberController,
            decoration: const InputDecoration(hintText: '請輸入手機號碼'),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              hintText: '請輸入密碼（6~16位英數底線混合）',
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.visibility),
              ),
            ),
          ),
          TextField(
            controller: confirmationController,
            decoration: InputDecoration(
              hintText: '確認密碼',
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.visibility),
              ),
            ),
          ),
          ElevatedButton(onPressed: signUp, child: Text('註冊'))
        ],
      ),
    );
  }
}
