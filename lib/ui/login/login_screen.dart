import 'package:flutter/material.dart';
import 'package:igo/data/user.dart';
import 'package:igo/main.dart';
import 'package:igo/ui/show_snack_bar.dart';
import 'package:igo/ui/signup/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final numberController = TextEditingController();
  final passwordController = TextEditingController();

  void logIn() async {
    final number = numberController.text;
    final password = passwordController.text;
    if (number.isEmpty) {
      showSnackBar(context, '錯誤：手機號碼不可為空。');
      return;
    }
    if (password.isEmpty) {
      showSnackBar(context, '錯誤：密碼不可為空。');
      return;
    }
    final result = await database.query(
      'users',
      where: 'number = ?',
      whereArgs: [number],
    );
    User gotUser;
    if (result.isEmpty ||
        password != (gotUser = User.fromMap(result.first)).password) {
      if (mounted) showSnackBar(context, '錯誤：手機號碼或密碼錯誤。');
      return;
    }
    user = gotUser;
    if (!mounted) return;
    showSnackBar(context, '登入成功。');
    Navigator.of(context).pop(true);
  }

  @override
  void dispose() {
    numberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('會員登入'),
        actions: [
          IconButton(
            onPressed: Navigator.of(context).pop,
            icon: const Icon(Icons.close),
          ),
        ],
        automaticallyImplyLeading: false,
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
              const Text('還沒擁有iGO購物帳號嗎？'),
              TextButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SignupScreen()),
                ),
                child: const Text('立即註冊'),
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
          ElevatedButton(onPressed: logIn, child: const Text('登入'))
        ],
      ),
    );
  }
}
