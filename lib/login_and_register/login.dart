import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myapp/The%20owner/ownerLogin.dart';
import 'package:myapp/firebase_auth/firebase_auth_services.dart';
import 'package:myapp/login_and_register/customTextFormField.dart';
import 'package:myapp/login_and_register/register.dart';
import 'package:myapp/pages/dashboard.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // final mailController = TextEditingController();
  // final passController = TextEditingController();

  String newMail = "";
  String newPassword = "";

  String? err = "";

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Content(),
        ),
      ),
    );
  }

  Widget Content() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.tealAccent,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.elliptical(80, 80),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Image.asset(
                "assets/images/waterDrop.jpg",
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "User Login",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 40,
          ),

          customTextFormField(
              hinTxt: "Enter email",
              isPasssword: false,
              onValidate: (String? value) {
                if (value != null) {
                  if (value.isEmpty) {
                    return "Enter Email";
                  }
                }
                return null;
              },
              onSaved: (String? value) {
                this.newMail = value!;
              }),
          SizedBox(
            height: 20,
          ),

          customTextFormField(
            hinTxt: "Enter password",
            isPasssword: true,
            onValidate: (String? value) {
              if (value != null) {
                if (value.isEmpty) {
                  return "Enter password";
                }
              }
              return null;
            },
            onSaved: (String? value) {
              this.newPassword = value!;
            },
          ),

          // inputStyle(
          //   "Email",
          //   "Enter your email",
          //   false,
          //   mailController,
          // ),

          // inputStyle(
          //   "Password",
          //   "Enter password",
          //   true,
          //   passController,
          // ),
          SizedBox(
            height: 40,
          ),

          Container(
            child: Text(
              "${err}",
              style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),

          Container(
            height: 60,
            width: 300,
            decoration: BoxDecoration(
              //color: Colors.tealAccent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ElevatedButton(
              onPressed: _loginUser,
              child: Text(
                "Login",
                style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 41, 6, 236),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Don't have an account ?   ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.grey[850],
                  ),
                ),
                TextSpan(
                    text: "Register",
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
                                builder: (context) => Register()));
                      }),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "As an Owner ? ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: const Color.fromARGB(255, 17, 15, 15),
                  ),
                ),
                TextSpan(
                  text: "   The Owner",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ownerLogin()));
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _loginUser() async {
    setState(() {
      err = "";
    });

    if (formKey.currentState!.validate() == false) {
      return;
    }

    print("Validation is passed");
    formKey.currentState!.save();

    try {
      await FirebaseAuthService()
          .loginUserWithEmailAndPassword(email: newMail, password: newPassword);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    } on FirebaseAuthException catch (er) {
      setState(() {
        err = er.message;
      });
    }
  }
}

// Widget inputStyle(
//     String title, String hinTxt, bool isPassword, final newController) {

//       final formKey = GlobalKey<FormState>();

//   return Padding(
//     padding: const EdgeInsets.fromLTRB(30, 5, 50, 10),
//     child: Row(
//       children: [
//         Text("${title} : "),
//         SizedBox(
//           width: 10,
//         ),
//         Expanded(
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 2,
//                   blurRadius: 5,
//                   offset: Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: Form(
//               key: formKey,
//               child: TextFormField(
//                 controller: newController,
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.only(left: 10),
//                   hintText: hinTxt,
//                 ),
//                 obscureText: isPassword,

//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
