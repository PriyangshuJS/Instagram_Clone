import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/text_field_input.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import '../resources/auth_methods.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  Future<Uint8List> convertNetworkImageToUint8List(String imageUrl) async {
    var response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load image: ${response.statusCode}');
    }
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    Uint8List imageBytes = await convertNetworkImageToUint8List(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfl57BUJYRzxh7tUOWK2J6wAXHdiQxM9n8uA&usqp=CAU');

    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image ?? imageBytes,
    );
    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      // ignore: use_build_context_synchronously
      showSnackbar(res, context);
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayoutScreen(
              webScreenlayout: WebScreenLayout(),
              mobileScreenlayout: MobileScreenLayout(),
            ),
          ),
          (route) => false);
    }
  }

  void navigateToLogin() async {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Builder(
          builder: (context) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                width: double.infinity,
                child: Container(
                  height: size.height,
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        color: primaryColor,
                        height: 100,
                      ),

                      const SizedBox(height: 30),
                      //Circular image to showw selected file
                      Stack(
                        children: [
                          _image != null
                              ? CircleAvatar(
                                  radius: 64,
                                  backgroundImage: MemoryImage(_image!),
                                )
                              : const CircleAvatar(
                                  radius: 64,
                                  backgroundImage: NetworkImage(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfl57BUJYRzxh7tUOWK2J6wAXHdiQxM9n8uA&usqp=CAU'),
                                ),
                          Positioned(
                            bottom: -10,
                            left: 80,
                            child: IconButton(
                              onPressed: selectImage,
                              icon: const Icon(Icons.add_a_photo),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      //Text Field for username
                      TextFieldInput(
                          textEditingController: _usernameController,
                          textInputType: TextInputType.text,
                          hintText: "Enter your Username"),

                      const SizedBox(height: 24),

                      //Text Field for Email
                      TextFieldInput(
                          textEditingController: _emailController,
                          textInputType: TextInputType.emailAddress,
                          hintText: "Enter your Email"),

                      const SizedBox(height: 24),

                      //Text Field for Password
                      TextFieldInput(
                        textEditingController: _passwordController,
                        textInputType: TextInputType.text,
                        hintText: "Enter your Password",
                        isPass: true,
                      ),
                      const SizedBox(height: 24),

                      //Text Field for bio
                      TextFieldInput(
                          textEditingController: _bioController,
                          textInputType: TextInputType.text,
                          hintText: "Enter your Bio"),

                      const SizedBox(height: 15),

                      InkWell(
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: signUpUser,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: thirdColor,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator(
                                      color: primaryColor,
                                    ),
                                  )
                                : const Text('Sign up'),
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: navigateToLogin,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: const Text("Don't have an account?   "),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: const Text(
                                "Log in",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
