import 'package:flutter/material.dart';
import 'package:rcss_frontend/auth_implemetation/auth_service.dart';
import 'package:rcss_frontend/pages/reset_password_page.dart';
import 'package:rcss_frontend/widgets/text_field_widget.dart';

class CheckEmailPage extends StatelessWidget {
  CheckEmailPage({super.key});

  final AuthService _authServiced = AuthService();

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("確認信箱/電話"),
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
          SizedBox(height: 32),
          GestureDetector(
            onTap: () => _emailChecked(context),
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

  void _emailChecked(BuildContext context) async {
    String email = emailController.text;

    await _authServiced.getVerificationCodeByPhoneOrEmail(email: email);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResetPasswordPage(email: email),
      ),
    );
  }
}
