import 'package:flutter/material.dart';

Future<Null> normalDiolog(
    BuildContext context, String title, String msg) async {
  showDialog(
      context: context,
      builder: (context) => SimpleDialog(
            title: ListTile(
              leading: Image.asset("images/logo/logo2.png"),
              title: Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                msg,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Colors.red),
              ),
            ),
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Ok"),
              )
            ],
          ));
}
