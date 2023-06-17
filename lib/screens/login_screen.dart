import 'package:flutter/material.dart';
import 'package:instagram/resources/auth_methord.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/utility/colors.dart';
import 'package:instagram/utility/utils.dart';

import '../widgets/text_input_field.dart';

// ignore: camel_case_types
class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

// ignore: camel_case_types
class _Login_ScreenState extends State<Login_Screen> {
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

    if (res == "Success") {
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
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
              textEditingController: _emailcontroller,
              isPass: true,
            ),
            const SizedBox(height: 17),
            InkWell(
              onTap: null,
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
                  onTap: null,
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
