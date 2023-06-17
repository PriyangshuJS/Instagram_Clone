import 'package:flutter/material.dart';
import 'package:instagram/resources/auth_methord.dart';
import 'package:instagram/screens/signup_screen.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/utility/colors.dart';
import 'package:instagram/utility/utils.dart';

import '../responsive/mobile_layout.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/web_layout.dart';
import '../widgets/text_input_field.dart';

// ignore: camel_case_types
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// ignore: camel_case_types
class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();

    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethord().loginInUser(
      email: _emailcontroller.text,
      password: _passwordcontroller.text,
    );
    setState(() {
      _isLoading = false;
    });
    if (res != "Success") {
      // ignore: use_build_context_synchronously
      showSnackBar(res, context);
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const Responsive_Layout(
            mobileScreenLayout: Mobile_Layout(),
            webScreenLayout: Web_Layout(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(flex: 2, child: Container()),
            // SvgPicture.asset(
            //   "assets/Instagram_logo.svg",
            //   color: primaryColor,
            // )
            Image.asset(
              "assets/PngItem_676474.png",
              color: primaryColor,
              height: 64,
            ),
            const SizedBox(height: 50),
            Text_Input_Field(
              hintText: 'Email',
              textInputType: TextInputType.emailAddress,
              textEditingController: _emailcontroller,
            ),
            const SizedBox(height: 10),
            Text_Input_Field(
              hintText: 'Password',
              textInputType: TextInputType.emailAddress,
              textEditingController: _passwordcontroller,
              isPass: true,
            ),
            const SizedBox(height: 17),
            InkWell(
              onTap: loginUser,
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  color: blueColor,
                ),
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Text("Log In"),
              ),
            ),
            Flexible(flex: 2, child: Container()),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text("Don't have an account?  "),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SignupScreen(),
                  )),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      "Sign up.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: blueColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7),
          ],
        ),
      )),
    );
  }
}
