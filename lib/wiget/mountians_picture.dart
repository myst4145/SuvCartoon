import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app1/wiget/show_pdf_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:demo_app1/model/mountain_model.dart';

class MountainsPicture extends StatefulWidget {
  @override
  State<MountainsPicture> createState() => _MountainsPictureState();
}

class _MountainsPictureState extends State<MountainsPicture> {
  List<Widget> widgets = [];
  List<MountainModel> mountains = [];
  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<Null> readData() async {
    await Firebase.initializeApp().then((value) async {
      print(".................................success");
      await FirebaseFirestore.instance
          .collection('moutain')
          .orderBy('name', descending: false)
          .snapshots()
          .listen((event) {
        print("snapshot : ................................${event.docs}");
        int index = 0;
        for (var item in event.docs) {
          Map<String, dynamic> map = item.data();
          // print("........................name : ${map['name']}");
          // print("........................cover : ${map['cover']}");
          // print("........................pdf : ${map['pdf']}");
          MountainModel model = MountainModel.fromMap(map);
          mountains.add(model);
          print("........................pdf : ${model.name}");
          print("........................pdf : ${model.cover}");
          print("........................pdf : ${model.pdf}");
          setState(() {
            widgets.add(createWidget(model, index));
          });
          index++;
        }
      });
    }).catchError((onError) {
      print("...........................${onError}");
    });
  }

  Widget createWidget(MountainModel model, int index) => GestureDetector(
        onTap: () {
          print('index ${index}');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PDFView(mountainModel: mountains[index])));
        },
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  child: Image.network(
                model.cover,
              )),
              Text(model.name,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold))
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: widgets.length != 0
            ? Container(
                child: GridView.extent(
                  maxCrossAxisExtent: 300,
                  children: widgets,
                ),
              )
            : Center(child: CircularProgressIndicator()));
  }
}
