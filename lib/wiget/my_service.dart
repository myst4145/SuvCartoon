import 'package:demo_app1/utility/my_style.dart';
import 'package:demo_app1/wiget/infomation.dart';
import 'package:demo_app1/wiget/mountians_picture.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyService extends StatefulWidget {
  @override
  State<MyService> createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  String user = '', name = '';

  @override
  void initState() {
    super.initState();
    findNameAndEmail();
  }

  Future<Null> findNameAndEmail() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          name = event.displayName.toString();
          user = event.email.toString();
        });
      });
    }).catchError((value) {});
  }

  @override
  Widget currentWiget = MountainsPicture();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Service"),
      ),
      drawer: drawerContainerHeader(),
      body: currentWiget,
    );
  }

  Widget drawerContainerHeader() {
    return Drawer(
        child: Stack(children: [
      Column(
        children: [
          userAccountsDrawerHeader(),
          mountainsPicture(),
          infomationContianer(),
        ],
      ),
      signOutButton(),
    ]));
  }

  Widget mountainsPicture() {
    return ListTile(
      onTap: () {
        setState(() {
          currentWiget = MountainsPicture();
        });
        Navigator.pop(context);
      },
      leading: Icon(
        Icons.photo_camera_back,
        size: 54,
        color: Colors.teal,
      ),
      title: Text(
        "Mountains",
        style: TextStyle(
            fontSize: 18, color: Colors.teal, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "List moutains Pictures",
        style: TextStyle(
            fontSize: 14,
            color: Colors.lightGreen,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget infomationContianer() {
    return ListTile(
      onTap: () {
        setState(() {
          currentWiget = Info();
        });
        Navigator.pop(context);
      },
      leading: Icon(
        Icons.info_outline,
        size: 54,
        color: Colors.teal,
      ),
      title: Text(
        "info",
        style: TextStyle(
            fontSize: 18, color: Colors.teal, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "inmation person",
        style: TextStyle(
            fontSize: 14,
            color: Colors.lightGreen,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget userAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage('images/nature-3082832.jpg'))),
      accountName: Text(
        name,
        style: TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      accountEmail: Text(
        user,
        style: TextStyle(
            fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      currentAccountPicture: Image.asset("images/logo/logo2.png"),
    );
  }

  Widget signOutButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          onTap: () async {
            await Firebase.initializeApp().then((value) async {
              await FirebaseAuth.instance.signOut().then((value) =>
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/auther', (route) => false));
            });
          },
          leading: Icon(Icons.exit_to_app, color: Colors.white),
          title: Text(
            "Sign Out ",
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          tileColor: MyStyle().secondaryColor,
          subtitle: Text(
            "Sign Out  & goto Authen ",
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
