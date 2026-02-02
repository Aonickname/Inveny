import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'stock_list_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final AuthService _authService = AuthService();

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inveny 로그인')),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center( 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              TextField(
                controller: _idController, 
                decoration: const InputDecoration(labelText: '아이디'),
              ),
              const SizedBox(height: 20), 
              TextField(
                controller: _pwController, 
                decoration: const InputDecoration(labelText: '비밀번호'), 
                obscureText: true,
              ),
              const SizedBox(height: 40),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50), 
                ),
                onPressed: () async {
                  bool success = await _authService.login(_idController.text, _pwController.text);
                  if (success) {
                    if (!context.mounted) return;
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const StockListScreen()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('아이디 또는 비밀번호가 틀렸습니다.')),
                    );
                  }
                },
                child: const Text('로그인'),
              ),

              const SizedBox(height: 10),

              // 회원가입 버튼
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const RegisterScreen()),
                  );
                }, 
                child: const Text('계정이 없으신가요? 회원가입',
                  style: TextStyle(color: Colors.black),)
              )
            ],
          ),
        ),
      ),
    );
  }
}