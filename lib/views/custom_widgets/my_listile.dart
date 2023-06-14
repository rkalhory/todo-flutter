import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/constant.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/views/pdfView.dart';
import 'package:todo_app/views/pdf_page.dart';


enum SampleItem { edit, pdf,save, remove }

class MyLisTile extends StatelessWidget {
  MyLisTile({
    Key? key,
    required this.index,
    required this.item,
    required this.remove,
    required this.edit,
  }) : super(key: key);

  final int index;
  final Todo item;

  final Function remove;
  final Function edit;

  SampleItem? selectedMenu;

  void savePdf() async{
    Uint8List file=await makePdf(item);

    print('.......................................... $file');
    String path = await FileSaver.instance.saveFile(
      name: item.title,
      bytes: Uint8List.fromList(file),
      ext: 'pdf',
      mimeType:MimeType.pdf
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding:EdgeInsetsDirectional.only(bottom:9,end:10,start:10,top:9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          )]
        ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width:50,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 10),
              child: CircleAvatar(
                backgroundColor: item.complete?MyColors.green:MyColors.red,
                child: Icon(
                    color: Colors.white,
                    item.complete?Icons.check:Icons.close
                ),

              ),
            ),
          ),
          Expanded(
            // width: MediaQuery.of(context).size.width-200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title,style: TextStyle(fontSize: 16,color: MyColors.text_color1,fontWeight: FontWeight.w600),),
                SizedBox(height: 7,),
                Text(item.description,style: TextStyle(fontSize: 15,color: MyColors.text_color2,overflow:TextOverflow.ellipsis ),),
              ],
            ),
          ),
          PopupMenuButton<SampleItem>(
            // initialValue: selectedMenu,
            onSelected: (SampleItem item) {
              // setState(() {
              //   selectedMenu = item;
              // });
              if(item==SampleItem.edit) edit(index);
              if(item==SampleItem.remove) remove(index);
              if(item==SampleItem.pdf) Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => PdfPreviewPage(item:this.item),));
              if(item==SampleItem.save) savePdf();

            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
              PopupMenuItem<SampleItem>(
                  value: SampleItem.edit,
                  child: RichText(
                    text:TextSpan(
                      children: [
                        WidgetSpan(
                          child: Padding(
                              padding: const EdgeInsetsDirectional.only(end:10),
                              child: Icon(Icons.edit,color: Colors.blue)
                          ),
                        ),
                        TextSpan(text: 'Edit',style: TextStyle(fontSize: 16,color: MyColors.text_color1)),
                      ],
                    ),
                  )
              ),
              PopupMenuItem<SampleItem>(
                  value: SampleItem.pdf,
                  child: RichText(
                    text:TextSpan(
                      children: [
                        const WidgetSpan(
                          child: Padding(
                              padding: const EdgeInsetsDirectional.only(end:10),
                              child: Icon(Icons.picture_as_pdf,color: Colors.amberAccent)
                          ),
                        ),
                        TextSpan(text: 'Print Pdf',style: TextStyle(fontSize: 16,color: MyColors.text_color1)),
                      ],
                    ),
                  )
              ),
              PopupMenuItem<SampleItem>(
                  value: SampleItem.save,
                  child: RichText(
                    text:TextSpan(
                      children: [
                        const WidgetSpan(
                          child: Padding(
                              padding: const EdgeInsetsDirectional.only(end:10),
                              child: Icon(Icons.picture_as_pdf,color: Colors.greenAccent)
                          ),
                        ),
                        TextSpan(text: 'save Pdf',style: TextStyle(fontSize: 16,color: MyColors.text_color1)),
                      ],
                    ),
                  )
              ),

              PopupMenuItem<SampleItem>(
                  value: SampleItem.remove,
                  child: RichText(
                    text:TextSpan(
                      children: [
                        const WidgetSpan(
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(end:10),
                              child: Icon(Icons.remove_circle,color: Colors.red),)
                        ),
                        TextSpan(text: 'Remove',style: TextStyle(fontSize: 16,color: MyColors.text_color1)),
                      ],
                    ),
                  )
              ),
            ],
          )
        ],
      ),
    );
  }
}
