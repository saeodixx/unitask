import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:unitask/app/extensions/sized_box_extension.dart';
import 'package:unitask/app/extensions/snackbar_extension.dart';
import 'package:unitask/app/router/app_page.dart';
import 'package:unitask/services/api_service.dart';
import 'package:unitask/ui/common/label_text_field.dart';
import 'package:unitask/ui/common/text_divider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = .new();
  final TextEditingController _passwordController = .new();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    //이메일/비밀번호 값 검증
    if (email.isEmpty || password.isEmpty) {
      return context.showSnackBar('이메일 또는 비밀번호를 입력해주세요.', isError: true);
    }

    final response = await ApiService.login(email: email, password: password);
    debugPrint('$response');

    if (response == null) {
      if (mounted) {
        context.showSnackBar('로그인에 실패했습니다.', isError: true);
      }
    }

    //TODO: 로그인 성공 -> 메인화면 이동
    if (mounted) {
      context.goNamed(AppPage.home.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(LucideIcons.graduationCap, size: 60),
                Text(
                  'UniTask',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                Text(
                  '과제 관리를 스마트하게',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                50.heightBox,
                //이메일
                LabelTextField(
                  controller: _emailController,
                  label: '이메일',
                  hintText: 'example@university.edu',
                  icon: LucideIcons.mail,
                ),
                20.heightBox,
                //비밀번호
                LabelTextField(
                  controller: _passwordController,
                  label: '비밀번호',
                  hintText: '000000',
                  icon: LucideIcons.lockKeyhole,
                  enableObscure: true,
                ),
                20.heightBox,
                //패스워드 잊음
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      context.showSnackBar('곧 기능을 출시합니다!');
                    },
                    child: const Text('비밀번호를 잊으셨나요?'),
                  ),
                ),
                20.heightBox,
                //로그인 버튼
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _onLogin,
                    child: const Text(
                      '로그인',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                20.heightBox,
                //또는
                const TextDivider(text: '또는'),
                20.heightBox,
                //소셜 로그인
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('계정이 없으신가요?'),
                    TextButton(
                      onPressed: () {
                        context.pushNamed(
                          AppPage.signup.name,
                        ); //pushNamed: 스택쌓이면서 뒤로가기 버튼 생성
                      },
                      child: Text('회원가입'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
