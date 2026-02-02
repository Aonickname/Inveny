import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inveny 회원가입')),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 아이디 입력창
              TextField(
                controller: _idController,
                decoration: const InputDecoration(
                  labelText: '새로운 아이디',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              // 비밀번호 입력창
              TextField(
                controller: _pwController,
                decoration: const InputDecoration(
                  labelText: '비밀번호',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 40),
              // 가입하기 버튼
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () async {
                  if (_idController.text.isEmpty || _pwController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('아이디와 비밀번호를 모두 입력해주세요.')),
                    );
                    return;
                  }

                  bool success = await _authService.register(
                    _idController.text,
                    _pwController.text,
                  );

                  if (success) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('회원가입 성공! 로그인해주세요.')),
                    );
                    Navigator.pop(context); 
                  } else {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('이미 있는 아이디거나 가입에 실패했습니다.')),
                    );
                  }
                },
                child: const Text('가입하기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}