
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/custom_button.dart';
import '../widget/custom_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? isLogin = prefs.getBool('isLogin');
    if (isLogin!) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
        (route) => false,
      );
    }
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: const [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 15.0, bottom: 50, top: 50),
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: CustomFormTextField(
                      hintText: 'User Name',
                      
                      icon: Icons.account_box_rounded,
                      isNumber: false,
                      isPassword: false,
                      size: size,
                      controller: emailController,
                      onTap: () {},
                      validator: (value) {
                        if (value != 'test') {
                          return 'Invalid User Name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: CustomFormTextField(
                      controller: passwordController,
                      icon: Icons.lock_outline,
                      hintText: 'Password',
                      isPassword: true,
                      isNumber: false,
                      onTap: () {},
                      validator: (value) {
                        if (value != '1234') return 'Invalid Password';
                        return null;
                      },
                      size: size,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(70.0),
                    child: CustomButton(
                      title: "Sign-In",
                      size: size,
                      onPressed: () async {
                        bool valid = _formKey.currentState!.validate();
                        if (valid) {
                          HapticFeedback.lightImpact();
                          Fluttertoast.showToast(
                            msg: 'Sign-In',
                          );
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool('isLogin', true);
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                            (route) => false,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
