import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myapp/The%20owner/ownerRegister.dart';
import 'package:myapp/firebase_auth/firebase_auth_services.dart';
import 'package:myapp/login_and_register/customTextFormField.dart';
import 'package:myapp/login_and_register/login.dart';
import 'package:myapp/qr_code/qr_scanner.dart';

class ownerLogin extends StatefulWidget {
  const ownerLogin({super.key});

  @override
  State<ownerLogin> createState() => _ownerLoginState();
}

class _ownerLoginState extends State<ownerLogin> {
  final formKey = GlobalKey<FormState>();
  String ownerEmail = "";
  String ownerPassword = "";
  String? errorMsg = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
            icon: Icon(Icons.arrow_back_ios_new)),
        backgroundColor: const Color.fromARGB(255, 117, 162, 239),
        centerTitle: true,
        title: Text(
          "The owner",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 50, 50, 10),
                    child: Image.asset("assets/images/waterDrop.jpg"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: customTextFormField(
                        hinTxt: "Enter Email",
                        isPasssword: false,
                        onValidate: (String? value) {
                          if (value != null) {
                            if (value.isEmpty) {
                              return "Enter Your Email";
                            }
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          this.ownerEmail = value!;
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: customTextFormField(
                        hinTxt: "Enter Password",
                        isPasssword: true,
                        onValidate: (String? value) {
                          if (value != null) {
                            if (value.isEmpty) {
                              return "Enter Valid Password";
                            }
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          this.ownerPassword = value!;
                        }),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("${errorMsg}"),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 60,
                    width: 300,
                    decoration: BoxDecoration(
                      //color: Colors.tealAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                      onPressed: () async {
                        try {
                          if (formKey.currentState!.validate() == false) {
                            return;
                          }

                          formKey.currentState!.save();

                          await FirebaseAuthService()
                              .loginUserWithEmailAndPassword(
                                  email: ownerEmail, password: ownerPassword);
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Qr_scanner()));
                        } on FirebaseAuthException catch (err) {
                          setState(() {
                            errorMsg = err.message;
                          });
                          print(errorMsg);
                        }
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 249, 249, 251),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(
                        text: "Create Account",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.orangeAccent[700],
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OwnerRegister()));
                          }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
