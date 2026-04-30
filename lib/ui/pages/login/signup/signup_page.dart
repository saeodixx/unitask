import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:unitask/app/extensions/snackbar_extension.dart';
import 'package:unitask/services/api_service.dart';
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

  bool loading = false;
  void startLoading() => setState(() => loading = true);
  void stopLoading() => setState(() => loading = false);

  Future<void> onSignup() async {
    debugPrint('계정 만들기');

    //입력 확인
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      context.showSnackBar('정보가 올바르지 않습니다.', isError: true);
      return;
    }

    if (password != confirmPassword) {
      context.showSnackBar('비밀번호가 일치하지 않습니다.', isError: true);
      return;
    }

    startLoading();

    final signupResult = await ApiService.signup(
      email: email,
      password: password,
      name: name,
    );

    stopLoading();

    if (signupResult == null) return;

    if (!signupResult) {
      if (mounted) {
        context.showSnackBar('계정 생성에 실패했습니다.', isError: true);
      }
      return;
    }
    if (mounted) {
      context.pop();
    }
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
        child: SingleChildScrollView(
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
                    onSignup();
                  },
                  child: loading
                      ? const SizedBox.square(
                          dimension: 30,
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                      : const Text('계정 만들기'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
