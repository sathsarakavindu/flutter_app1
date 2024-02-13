import 'package:flutter/material.dart';
import 'package:myapp/login_and_register/customTextFormField.dart';

class editProfile extends StatefulWidget {
  const editProfile({super.key});

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  String newFName = "";
  String newMail = "";
  String newPassword = "";
  String newContact = "";
  String newAddress = "";
  String newNIC = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Center(
          child: Text(
            "Edit profile settings",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 50),
            child: Column(
              children: [
                customTextFormField(
                  hinTxt: "Enter New Name",
                  isPasssword: false,
                  onValidate: (String? value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return "";
                      }
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    this.newFName = value!;
                  },
                ),
                customTextFormField(
                  hinTxt: "Enter New Email",
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
                    this.newMail = value!;
                  },
                ),
                customTextFormField(
                  hinTxt: "Enter New Password",
                  isPasssword: true,
                  onValidate: (String? value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return "";
                      }
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    this.newPassword = value!;
                  },
                ),
                customTextFormField(
                  hinTxt: "New Contact No",
                  isPasssword: false,
                  onValidate: (String? value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return "";
                      }
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    this.newContact = value!;
                  },
                ),
                customTextFormField(
                  hinTxt: "Enter New Address",
                  isPasssword: false,
                  onValidate: (String? value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return "";
                      }
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    this.newAddress = value!;
                  },
                ),
                customTextFormField(
                  hinTxt: "Enter New NIC",
                  isPasssword: false,
                  onValidate: (String? value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return "";
                      }
                    }
                  },
                  onSaved: (String? value) {
                    this.newNIC = value!;
                  },
                ),
                Container(
                  height: 60,
                  width: 250,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.tealAccent),
                    ),
                    onPressed: () async {},
                    child: Text(
                      "Edit",
                      style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 1, 0, 2),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
