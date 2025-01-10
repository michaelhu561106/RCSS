import "package:flutter/material.dart";
import "package:rcss_frontend/auth_implemetation/auth_service.dart";
import "package:rcss_frontend/pages/check_email_page.dart";
import "package:rcss_frontend/pages/sign_up_page.dart";
import "package:rcss_frontend/widgets/text_field_widget.dart";

import "home_page.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _authService = AuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("歡迎使用註冊寶"),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "登入",
              style: TextStyle(
                  color: Colors.red, fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            TextFieldWidget(
                controller: emailController,
                hintText: "Email",
                obscureText: false),
            SizedBox(height: 12),
            TextFieldWidget(
                controller: passwordController,
                hintText: "Password",
                obscureText: true),
            SizedBox(height: 32),
            GestureDetector(
              onTap: _signIn,
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    "登入",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "尚未註冊?",
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
                SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpPage(),
                      ),
                    );
                  },
                  child: Text(
                    "立即註冊!",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '忘記密碼?',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
                SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckEmailPage(),
                      ),
                    );
                  },
                  child: Text(
                    "點我重設密碼!",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            GestureDetector(
              // onTap: () => _thirdPartySignIn(context),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    '使用Google登入',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signIn() async {
    String email = emailController.text;
    String password = passwordController.text;

    Map<String, dynamic> responseBody = await _authService
        .loginWithEmailAndPassword(email: email, password: password);


    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          uuid: responseBody['uuid'],
          userName: responseBody['user_name'],
        ),
      ),
    );
  }

  // void _thirdPartySignIn(BuildContext context) async {
  //   await _authService.thirdPartyRegistration();
  //
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => HomePage(),
  //     ),
  //   );
  // }
}
