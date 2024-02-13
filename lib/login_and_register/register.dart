import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/firebase_auth/firebase_auth_services.dart';
import 'package:myapp/login_and_register/customTextFormField.dart';
import 'package:myapp/login_and_register/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // TextEditingController nameController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  // TextEditingController mobileController = TextEditingController();
  // TextEditingController addressController = TextEditingController();
  // TextEditingController nicController = TextEditingController();

  String fname = "";
  String mail = "";
  String pswrd = "";
  String no = "";
  String adrs = "";
  String nic = "";
  String? errorMsg = "";

  final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  final myFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: content(),
    );
  }

  Widget content() {
    return SingleChildScrollView(
      child: Form(
        key: myFormKey,
        child: Column(
          children: [
            Container(
              height: 280,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.tealAccent,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.elliptical(80, 80),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Image.asset("assets/images/waterDrop.jpg"),
                  ),
                  Text(
                    "Register",
                    style: TextStyle(
                        fontSize: 30,
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // inputStyle("Full Name", "John", false, nameController),
            // inputStyle(
            //     "Email Address", "index@gmail.com", false, emailController),
            // inputStyle("Password", ".....", true, passwordController),
            // inputStyle("Mobile No", "+41789254161234", false, mobileController),
            // inputStyle(
            //     "Address", "No 45/A, colombo 11", false, addressController),
            // inputStyle("NIC", "200457892562V", true, nicController),

            customTextFormField(
              hinTxt: "Enter Full Name",
              isPasssword: false,
              onValidate: (String? value) {
                if (value != null) {
                  if (value.isEmpty) {
                    return "Enter Name";
                  }
                }
                return null;
              },
              onSaved: (String? value) {
                this.fname = value!;
              },
            ),

            customTextFormField(
              hinTxt: "Enter Email",
              isPasssword: false,
              onValidate: (String? value) {
                if (value != null) {
                  if (emailRegex.hasMatch(value) == false) {
                    return "Enter Valid Email";
                  }
                }
                return null;
              },
              onSaved: (String? value) {
                this.mail = value!;
              },
            ),
            customTextFormField(
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
                this.pswrd = value!;
              },
            ),
            customTextFormField(
              hinTxt: "Contact No",
              isPasssword: false,
              onValidate: (String? value) {
                if (value != null) {
                  if (value.isEmpty) {
                    return "Enter Contact Number";
                  }
                }
                return null;
              },
              onSaved: (String? value) {
                this.no = value!;
              },
            ),

            customTextFormField(
              hinTxt: "Enter Address",
              isPasssword: false,
              onValidate: (String? value) {
                if (value != null) {
                  if (value.isEmpty) {
                    return "Enter Valid Address";
                  }
                }
                return null;
              },
              onSaved: (String? value) {
                this.adrs = value!;
              },
            ),

            customTextFormField(
              hinTxt: "Enter NIC",
              isPasssword: false,
              onValidate: (String? value) {
                if (value != null) {
                  if (value.isEmpty) {
                    return "Enter Valid NIC";
                  }
                }
              },
              onSaved: (String? value) {
                this.nic = value!;
              },
            ),
            SizedBox(
              height: 15,
            ),

            Container(
              height: 60,
              width: 250,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.tealAccent),
                ),
                onPressed: () async {
                  await _Registeration();
                  await _AuthEmailAndPassword();
                },
                child: Text(
                  "Register",
                  style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 1, 0, 2),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              width: 250,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.lightBlueAccent)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                child: Text(
                  "Back",
                  style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 1, 0, 2),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  _Registeration() async {
    setState(() {
      errorMsg = "";
    });

    if (myFormKey.currentState!.validate() == false) {
      return;
    }

    print("Validation is passed!.");
    myFormKey.currentState!.save();
    try {
      Map<String, String> dataToSave = {
        'Full Name': fname,
        'Email': mail,
        'Password': pswrd,
        'Mobile': no,
        'Address': adrs,
        'NIC': nic,
      };
      await FirebaseFirestore.instance.collection('client').add(dataToSave);

      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    } on FirebaseException catch (error) {
      setState(() {
        errorMsg = error.message;
      });
    }
  }

  _AuthEmailAndPassword() async {
    setState(() {
      errorMsg = "";
    });

    try {
      await FirebaseAuthService()
          .signUpWithEmailAndPassword(email: mail, password: pswrd);
    } on FirebaseAuthException catch (err) {
      setState(() {
        errorMsg = err.message;
      });
    }
  }
}
