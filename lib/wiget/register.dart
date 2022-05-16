import 'package:demo_app1/utility/dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../utility/my_style.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  double screen = 0;
  bool statusRedEye = true;
  String name, user, password;
  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Center(
        child: Column(
          children: [
            nameContainer(),
            userContainer(),
            passwordContainer(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('name : ${name} user : ${user} password : ${password}');
          if ((name?.isEmpty ?? true) ||
              (user?.isEmpty ?? true) ||
              (password.isEmpty)) {
            normalDiolog(context, 'Have', 'Have space place Fill');
          } else {
            validateData();
          }
        },
        child: uploadButton(),
      ),
    );
  }

  // Future<Null> registerFirebase() async {
  //   await Firebase.initializeApp()
  //       .then((value) =>  {print("Fire initializeApp Success")});
  // }
  Future<Null> validateData() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: user, password: password)
          .then((value) async {
        print("....................................${name}");
        normalDiolog(context, "Success", "create success");
        await value.user.updateDisplayName(name).then((value) {
          Navigator.pushNamed(context, '/myService');
        }).catchError((value) {
          print(value.toString());
        });
      });
    } on FirebaseAuthException catch (e) {
      String message = '';
      String title = '';
      print("....................................${e.code}");
      print(".........................${e.message}");
      if (e.code == 'email-already-in-use') {
        message = "ไม่สามารถใช้ e-mail นี้ได้เนื่องจากมีในระบบแล้ว";
        title = e.code.toString();
      } else if (e.code == 'weak-password') {
        message = 'รหัสผ่านต้องมีความยาว  6 ตัวอักษรขึ้นไป';
        title = e.code.toString();
      } else if (e.code == 'is not a subtype of type String') {
        message = 'รหัสผ่านต้องมี ตัวอักษรประกอบด้วย';
        title = e.code.toString();
      } else if (e.code == 'erroe have spacing') {
        message = 'กรุณากรอกข้อมูลให้ครบ';
        title = e.code.toString();
      } else if (e.code == 'The email address is badly formatted.') {
        message = 'รูปแบบของอีเมลไม่ถูกต้อง';
        title = e.code.toString();
      } else {
        message = e.message.toString();
        title = e.code.toString();
      }
      if (title.contains("-")) {
        title = title.replaceAll("-", " ");
      }
      normalDiolog(context, title, message);
    }
  }

  Container uploadButton() {
    return Container(
      child: Icon(
        Icons.cloud_upload,
        size: screen * 0.1,
        color: Colors.white,
      ),
    );
  }

  static showError(FirebaseApp value) {
    print(" messege : ${value}");
  }

  Container userContainer() {
    return Container(
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18), color: Colors.white),
        width: screen * 0.6,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            user = value.trim();
          },
          style: TextStyle(color: MyStyle().primaryColor, fontSize: 24),
          decoration: InputDecoration(
              hintText: "user",
              hintStyle: TextStyle(
                fontSize: 16,
                color: MyStyle().darkColor,
              ),
              prefixIcon: Icon(
                Icons.perm_identity,
                color: MyStyle().darkColor,
                size: 20,
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: MyStyle().darkColor,
                      style: BorderStyle.solid,
                      width: 1),
                  borderRadius: BorderRadius.circular(18)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: MyStyle().secondaryColor,
                      width: 2,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(18))),
        ));
  }

  Container nameContainer() {
    return Container(
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18), color: Colors.white),
        width: screen * 0.6,
        child: TextField(
          keyboardType: TextInputType.name,
          onChanged: (value) => name = value.trim(),
          style: TextStyle(color: MyStyle().primaryColor, fontSize: 24),
          decoration: InputDecoration(
              hintText: "name",
              hintStyle: TextStyle(
                fontSize: 16,
                color: MyStyle().darkColor,
              ),
              prefixIcon: Icon(
                Icons.fingerprint,
                color: MyStyle().darkColor,
                size: 20,
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: MyStyle().darkColor,
                      style: BorderStyle.solid,
                      width: 1),
                  borderRadius: BorderRadius.circular(18)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: MyStyle().secondaryColor,
                      width: 2,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(18))),
        ));
  }

  Container passwordContainer() {
    return Container(
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18), color: Colors.white),
        width: screen * 0.6,
        child: TextField(
          keyboardType: TextInputType.visiblePassword,
          onChanged: (value) {
            password = value.trim();
          },
          style: TextStyle(
            color: MyStyle().primaryColor,
            fontSize: 24,
          ),
          decoration: InputDecoration(
              hintText: "password",
              hintStyle: TextStyle(
                fontSize: 16,
                color: MyStyle().darkColor,
              ),
              prefixIcon: Icon(
                Icons.lock_outline,
                color: MyStyle().darkColor,
                size: 20,
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: MyStyle().darkColor,
                      style: BorderStyle.solid,
                      width: 1),
                  borderRadius: BorderRadius.circular(18)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: MyStyle().secondaryColor,
                      width: 2,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(18))),
        ));
  }
}
