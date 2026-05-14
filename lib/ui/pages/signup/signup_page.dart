import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:unitask/core/extensions/build_context_extension.dart';
import 'package:unitask/core/models/result.dart';
import 'package:unitask/features/auth/auth_provider.dart';
import 'package:unitask/ui/common/label_text_field.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
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

    final result = await ref
        .read(authProvider.notifier)
        .signup(email: email, password: password, name: name);

    switch (result) {
      case Success():
        if (mounted) {
          context.pop();
        }
      case Failure(:final exception):
        if (mounted) {
          context.showSnackBar(exception.toString(), isError: true);
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    //TODO: AsyncValue() 데이터 추출

    final loading = ref.watch(authProvider).isLoading;

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
