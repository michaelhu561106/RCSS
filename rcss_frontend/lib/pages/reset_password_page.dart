import 'package:flutter/material.dart';
import 'package:rcss_frontend/auth_implemetation/auth_service.dart';
import 'package:rcss_frontend/pages/login_page.dart';
import 'package:rcss_frontend/widgets/text_field_widget.dart';

class ResetPasswordPage extends StatefulWidget {
  final String email;
  const ResetPasswordPage({super.key, required String this.email});

  @override
  State<ResetPasswordPage> createState() =>
      _ResetPasswordPageState(email: email);
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final String email;
  _ResetPasswordPageState({required String this.email});

  final AuthService _authService = AuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.text = email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("重設密碼"),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFieldWidget(
              controller: emailController,
              hintText: "Email",
              obscureText: false),
          SizedBox(height: 12),
          TextFieldWidget(
              controller: codeController, hintText: "驗證碼", obscureText: true),
          SizedBox(height: 12),
          TextFieldWidget(
              controller: passwordController,
              hintText: "新密碼",
              obscureText: true),
          SizedBox(height: 32),
          GestureDetector(
            onTap: _resetPassword,
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  "確認",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _resetPassword() async {
    String email = emailController.text;
    String code = codeController.text;
    String password = passwordController.text;

    Map<String, dynamic> responseBody = await _authService.resetPassword(
        email: email, code: code, password: password);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}
