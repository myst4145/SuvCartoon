import 'package:demo_app1/routes.dart';
import 'package:demo_app1/utility/dialog.dart';
import 'package:demo_app1/utility/my_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  double screen = 0;
  bool statusRedEye = true;
  String user, password;
  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: registerButton(),
      body: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
                center: Alignment(0, -0.3),
                colors: [Colors.white, MyStyle().primaryColor],
                radius: 1.0)),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: screen * 0.4, child: MyStyle().showLogo()),
                MyStyle().titleH1("SuviP Cartoon"),
                userContainer(),
                passwordContainer(),
                loginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container registerButton() {
    return Container(
      child: TextButton(
          onPressed: () => Navigator.pushNamed(context, '/register'),
          child: Text(
            "New Register",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          )),
    );
  }

  Future<Null> checkAuthen() async {
    try {
      await Firebase.initializeApp().then((value) async {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: user, password: password)
            .then((value) {
          Navigator.pushNamed(context, '/myService');
        });
      });
    } on FirebaseAuthException catch (e) {
      print(".......................${e.toString()}");
      String message = '';
      String title = '';
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
      } else if (e.code == 'user-not-found') {
        message = 'ไม่พบผู้ใช้นี้ในระบบ';
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

  Container loginButton() {
    return Container(
      padding: EdgeInsets.only(top: 12),
      width: screen * 0.6,
      child: ElevatedButton(
        onPressed: () {
          if ((user == null) || (password == null)) {
            if ((user == null) && (password == null)) {
              normalDiolog(context, "user or password ",
                  "user and password is null value");
            } else if ((user == null) || (password == null)) {
              if (password == null) {
                normalDiolog(context, "password", "password is null value");
              } else {
                normalDiolog(context, "user", "user is null value");
              }
            }
          } else {
            checkAuthen();
          }
        },
        child: Text("Login"),
        style: ElevatedButton.styleFrom(
            primary: MyStyle().darkColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            )),
      ),
    );
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

  Container passwordContainer() {
    return Container(
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18), color: Colors.white),
        width: screen * 0.6,
        child: TextField(
          keyboardType: TextInputType.text,
          onChanged: (value) {
            password = value.trim();
          },
          style: TextStyle(
            color: MyStyle().primaryColor,
            fontSize: 24,
          ),
          obscureText: statusRedEye,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: statusRedEye
                    ? Icon(
                        Icons.remove_red_eye,
                      )
                    : Icon(
                        Icons.remove_red_eye_outlined,
                      ),
                onPressed: () {
                  setState(() {
                    statusRedEye = !statusRedEye;
                  });
                  print("stutus : ${statusRedEye}");
                },
              ),
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
