import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:demo_app1/model/mountain_model.dart';
import 'package:flutter/material.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

class PDFView extends StatefulWidget {
  MountainModel mountainModel;
  PDFView({this.mountainModel});
  @override
  State<PDFView> createState() => _PDFViewState();
}

class _PDFViewState extends State<PDFView> {
  MountainModel model;
  PDFDocument doc;
  Future<Null> createPDF() async {
    try {
      var result = await PDFDocument.fromURL(model.pdf);
      print("......................${result}");

      setState(() async {
        print('.............................model.pdf : ${model.pdf}');
        doc = result;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = widget.mountainModel;
    print("................................${model.toString()}");
    createPDF();
    print('...........................${doc.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.name == null ? 'mountian' : model.name),
      ),
      body: Center(
          child: doc == null
              ? CircularProgressIndicator()
              : PDFViewer(document: doc)),
    );
  }
}
