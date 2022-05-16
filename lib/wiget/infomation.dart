import 'package:demo_app1/utility/my_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Info extends StatefulWidget {
  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  String displayName; // ตัวแปรเก็บค่า ชื่อผู้ใช้

  @override
  void initState() {
    super.initState();
    findDisplayName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        width: 350,
        alignment: Alignment.center,
        child: ListTile(
          onTap: () {
            editContainer();
          },
          trailing: IconButton(
              icon: Icon(
            Icons.edit,
            color: Colors.black,
            size: 36,
          )),
          leading: Icon(
            Icons.account_box,
            size: 72,
            color: Colors.teal,
          ),
          title: Text(
            displayName == null ? 'user' : displayName,
            style: TextStyle(
                fontSize: 32, color: Colors.teal, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Display User Name',
            style: TextStyle(
                fontSize: 18,
                color: Colors.lightGreen,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ));
  }

  Future<Null> findDisplayName() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        print("...................................${displayName}");

        setState(() {
          displayName = event.displayName;
        });

        print("...................................${displayName}");
      }).onError((handleError) {
        print("...........................${handleError.toString()}");
      });
    }).catchError((onError) {
      print("...........................${onError.toString()}");
    });
  }

  Future<Null> editContainer() async {
    showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              title: Container(
                child: ListTile(
                  leading: MyStyle().showLogo(),
                  title: Text('Edit Display Name'),
                  subtitle: Text('place fill display name is blank'),
                ),
              ),
              children: [
                Container(
                  decoration: MyStyle().boxDecoration(),
                  padding: EdgeInsets.fromLTRB(25, 7, 25, 7),
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (value) => displayName = value.trim(),
                        style: TextStyle(
                            fontSize: 24, color: MyStyle().primaryColor),
                        decoration: InputDecoration(
                            hintStyle: TextStyle(
                                fontSize: 24, color: MyStyle().darkColor),
                            hintText: 'User',
                            prefixIcon: Icon(Icons.account_box_outlined),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(width: 2))),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                              onPressed: () async {
                                print(".......................${displayName}");
                                await Firebase.initializeApp()
                                    .then((value) async {
                                  await FirebaseAuth.instance
                                      .authStateChanges()
                                      .listen((event) {
                                    setState(() {
                                      event
                                          .updateDisplayName(displayName)
                                          .then((value) {
                                        Navigator.pop(context);
                                      }).catchError((e) {
                                        print(
                                            "..........................${e.toString()}");
                                      });
                                    });
                                  });
                                }).catchError((e) {
                                  print(
                                      "..........................${e.toString()}");
                                });
                              },
                              child: MyStyle().textButton('edit Display')),
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: MyStyle().textButton('Cancel')),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ));
  }
}
