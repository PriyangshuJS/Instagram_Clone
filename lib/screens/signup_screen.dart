import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/resources/auth_methord.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/utility/colors.dart';
import 'package:instagram/utility/utils.dart';

import '../widgets/text_input_field.dart';

// ignore: camel_case_types
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

// ignore: camel_case_types
class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _biocontroller = TextEditingController();
  Uint8List? _image;
  @override
  void dispose() {
    super.dispose();

    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _emailcontroller.dispose();
    _biocontroller.dispose();
  }

  selectimage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
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
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64, backgroundImage: MemoryImage(_image!))
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            "https://cdn.pixabay.com/photo/2017/11/10/05/48/user-2935527_1280.png"),
                      ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: selectimage,
                    icon: const Icon(Icons.add_a_photo),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Text_Input_Field(
              hintText: 'Email',
              textInputType: TextInputType.emailAddress,
              textEditingController: _emailcontroller,
            ),

            const SizedBox(height: 10),
            Text_Input_Field(
              hintText: 'Username',
              textInputType: TextInputType.text,
              textEditingController: _usernamecontroller,
            ),
            const SizedBox(height: 10),

            Text_Input_Field(
              hintText: 'Bio',
              textInputType: TextInputType.text,
              textEditingController: _biocontroller,
            ),
            const SizedBox(height: 10),
            Text_Input_Field(
              hintText: 'Password',
              textInputType: TextInputType.text,
              textEditingController: _passwordcontroller,
              isPass: true,
            ),
            const SizedBox(height: 17),
            InkWell(
              onTap: () async {
                await AuthMethord().signUpUser(
                  email: _emailcontroller.text,
                  username: _usernamecontroller.text,
                  bio: _biocontroller.text,
                  password: _passwordcontroller.text,
                  file: _image!,
                );
              },
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
                child: const Text("Sign up"),
              ),
            ),
            Flexible(flex: 2, child: Container()),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text("Already have an account?  "),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      "Login.",
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
