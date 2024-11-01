
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/resgister_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:chat_app/widgets/custom_text_field_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  static String id = 'login page';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  final TextEditingController _textController = TextEditingController(text: 'This is a standard value');

  GlobalKey<FormState> formKey = GlobalKey();

  String? email, password;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // Background image (replace with your image path)
            Image.asset(
              'assets/WhatsApp Image 2024-04-03 at 1.22.30 AM.jpeg', // Replace with your image path
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Padding(
              
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
               const SizedBox(
                  height: 250,
                ),
                
               const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Do You Miss me 💕",
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontFamily: 'pacifico',
                      ),
                    ),
                  ],
                ),
              const   SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                
                CustomFormTextField(
                  onChanged: (data) 
                  {
                    email = data;
                  },
                  hintText: 'Email',
                  
                  
                ),
               const SizedBox(
                  height: 10,
                ),
                CustomFormTextFieldPassword(
                  obscureText: true,
                  
                  onChanged: (data) {
                    password = data;

                  },
                  hintText: 'Password',
                ),
               const SizedBox(
                  height: 20,
                ),
                CustomButon(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await loginUser();
                        Navigator.pushNamed(context, ChatPage.id,
                            arguments: email);
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'user-not-found') {
                          showSnackBar(context, 'user not found');
                        } else if (ex.code == 'wrong-password') {
                          showSnackBar(context, 'wrong password');
                        }
                      } catch (ex) {
                        print(ex);
                        showSnackBar(context, 'there was an error');
                      }

                      isLoading = false;
                      setState(() {});
                    } else {}
                  },
                  text: 'LOGIN',
                ),
               const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  const  Text(
                      'dont\'t have an account?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: const Text(
                        '  Register',
                        style: TextStyle(
                          color: Color(0xffC7EDE6),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    ));
  }

  Future<void> loginUser() async {
    UserCredential users = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}