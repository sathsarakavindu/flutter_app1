import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/The%20owner/ownerLogin.dart';
import 'package:myapp/firebase_auth/firebase_auth_services.dart';
import 'package:myapp/login_and_register/customTextFormField.dart';
import 'package:myapp/qr_code/qr_scanner.dart';

class OwnerRegister extends StatefulWidget {
  const OwnerRegister({super.key});

  @override
  State<OwnerRegister> createState() => _OwnerRegisterState();
}

class _OwnerRegisterState extends State<OwnerRegister> {
  String company = "";
  String serviceNo = "";
  String ownerFname = "";
  String ownerMail = "";
  String ownerPassword = "";
  String contact = "";
  String ownerAddress = "";
  String nic = "";

  final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  final formKeyOwner = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 229, 220, 255),
      body: SingleChildScrollView(
        child: Form(
          key: formKeyOwner,
          child: Column(
            children: [
              Container(
                height: 270,
                width: 390,
                color: Colors.tealAccent,
                child: Container(
                  padding: EdgeInsets.only(top: 40),
                  child: Column(
                    children: [
                      Text(
                        "Owner Registration",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        "assets/images/waterLogo1.jpg",
                        height: 100,
                        width: 200,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: customTextFormField(
                  hinTxt: "Enter Company Name",
                  isPasssword: false,
                  onValidate: (String? value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return "Enter Company Name";
                      }
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    this.company = value!;
                  },
                ),
              ),
              customTextFormField(
                hinTxt: "Enter Service No",
                isPasssword: false,
                onValidate: (String? value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return "Enter service number";
                    }
                  }
                  return null;
                },
                onSaved: (String? value) {
                  this.serviceNo = value!;
                },
              ),
              customTextFormField(
                hinTxt: "Enter Your Full Name",
                isPasssword: false,
                onValidate: (String? value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return "Enter Full Name";
                    }
                  }
                  return null;
                },
                onSaved: (String? value) {
                  this.ownerFname = value!;
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
                  this.ownerMail = value!;
                },
              ),
              customTextFormField(
                hinTxt: "Enter Password",
                isPasssword: false,
                onValidate: (String? value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return "Enter valid passwrod";
                    }
                  }
                  return null;
                },
                onSaved: (String? value) {
                  this.ownerPassword = value!;
                },
              ),
              customTextFormField(
                hinTxt: "Enter Your Contact No",
                isPasssword: false,
                onValidate: (String? value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return "Enter Contact No";
                    }
                  }
                  return null;
                },
                onSaved: (String? value) {
                  this.contact = value!;
                },
              ),
              customTextFormField(
                hinTxt: "Enter Valid Address",
                isPasssword: false,
                onValidate: (String? value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return "Enter Address";
                    }
                  }
                  return null;
                },
                onSaved: (String? value) {
                  this.ownerAddress = value!;
                },
              ),
              customTextFormField(
                hinTxt: "Enter NIC",
                isPasssword: false,
                onValidate: (String? value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return "Enter NIC";
                    }
                  }
                  return null;
                },
                onSaved: (String? value) {
                  this.nic = value!;
                },
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                height: 60,
                width: 200,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.tealAccent)),
                  onPressed: () async {
                    if (formKeyOwner.currentState!.validate() == false) {
                      return;
                    }
                    formKeyOwner.currentState!.save();

                    try {
                      await FirebaseAuthService().signUpWithEmailAndPassword(
                          email: ownerMail, password: ownerPassword);

                      Map<String, String> ownerData = {
                        "company name": company,
                        "service number": serviceNo,
                        "full name": ownerFname,
                        "email": ownerMail,
                        "password": ownerPassword,
                        "mobile": contact,
                        "address": ownerAddress,
                        "nic": nic
                      };

                      await FirebaseFirestore.instance
                          .collection('owner')
                          .add(ownerData);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Qr_scanner()));
                    } on FirebaseException catch (e) {
                      print(e.toString());
                    }
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 60,
                width: 200,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.lightBlueAccent)),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ownerLogin()));
                  },
                  child: Text(
                    "Back",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
