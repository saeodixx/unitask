import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:unitask/ui/common/label_text_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  void _onSignup() {
    debugPrint('계정 만들기');

    //입력 확인
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    debugPrint(
      'name: $name, email: $email, password: $password, confirmPassword: $confirmPassword',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '회원가입',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 25,

          children: [
            LabelTextField(
              controller: _nameController,
              label: '이름',
              icon: LucideIcons.userRoundPen,
            ),
            LabelTextField(
              controller: _emailController,
              label: '이메일',
              icon: LucideIcons.mail,
            ),
            LabelTextField(
              controller: _passwordController,
              label: '비밀번호',
              enableObscure: true,
              icon: LucideIcons.lockKeyhole,
            ),
            LabelTextField(
              controller: _confirmPasswordController,
              label: '비밀번호 확인',
              enableObscure: true,
              icon: LucideIcons.lockKeyholeOpen,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _onSignup();
                },
                child: const Text('계정 만들기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
