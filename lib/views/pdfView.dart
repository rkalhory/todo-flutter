import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:todo_app/models/todo.dart';

Future<Uint8List> makePdf(Todo todo) async {

  final pdf = Document();
  final image1 = await imageFromAssetBundle('assets/images/complete.png');
  final image2 = await imageFromAssetBundle('assets/images/Work-In-Progress.png');


  pdf.addPage(
    Page(
      build: (context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(todo.title,style: TextStyle(fontSize: 16,fontWeight:FontWeight.bold)),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image(todo.complete?image1:image2),
                )
              ],
            ),
            SizedBox(height: 40),
            Padding(
              child: Row(
              children: [
                Expanded(child:  Text(todo.description,
                  style: TextStyle(fontSize: 14,),
                ),)
                ]
              ),
              padding: EdgeInsets.all(5),
            ),
          ],
        );
      },
    ),
  );
  return pdf.save();
}