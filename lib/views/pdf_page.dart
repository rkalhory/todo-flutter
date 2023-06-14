import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:printing/printing.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/views/pdfView.dart';

class PdfPreviewPage extends StatelessWidget {
  final Todo item;
  const PdfPreviewPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => makePdf(item),
      ),
    );
  }
}