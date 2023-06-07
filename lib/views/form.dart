import 'package:flutter/material.dart';
import 'package:todo_app/core/constant.dart';
import 'package:todo_app/views/custom_widgets/my_text_field.dart';
import 'package:todo_app/views/todos.dart';


class FormTodo extends StatefulWidget {
  const FormTodo({Key? key,this.index,this.title,this.description,this.complete}) : super(key: key);

  final int? index;
  final String? title;
  final String? description;
  final bool? complete;

  @override
  State<FormTodo> createState() => _FormTodoState();
}

class _FormTodoState extends State<FormTodo> {
  final formKey=GlobalKey<FormState>();

  TextEditingController titleField=TextEditingController();
  TextEditingController descField=TextEditingController();

  bool isChecked = false;

  @override
  void initState() {
    titleField..text = widget.title??'';
    descField..text = widget.description??'';
    isChecked=widget.complete??false;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(bottom:30,end:10,start:10,top:65),
                child: Text(widget.index!=null?'Edit Item':'Add New',style:TextStyle(fontSize: 30,color: MyColors.text_color1,fontWeight:FontWeight.w600) ,),
              ),
              Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(bottom:15,end:20,start:20,top:0),
                      child: Column(
                          children: [
                            MyTextField(
                              controller:titleField,
                              text:'Title',
                              value:widget.title
                            ),
                            MyTextField(
                              controller:descField,
                              text:'Description',
                              line: 4,
                              value:widget.description
                            ),
                            CheckboxListTile(
                              checkColor: Colors.white,
                              title: Text('Complete'),
                              value: isChecked,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                            ),
                            SizedBox(height: 35,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: (MediaQuery.of(context).size.width/2)-30,
                                  child: FilledButton(
                                      onPressed: (){
                                        if(formKey.currentState!.validate()){
                                          Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => Todos(index:widget.index,formValue:{
                                            'title':titleField.text,
                                            'description':descField.text,
                                            'complete':isChecked,
                                          }),));
                                        }
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStatePropertyAll<Color>(MyColors.purple),
                                      ),
                                      child: Text('submit')
                                  ),
                                ),
                               SizedBox(
                                  width: (MediaQuery.of(context).size.width/2)-30,
                                  child: OutlinedButton(
                                      onPressed: (){Navigator.pop(context);},
                                      style: OutlinedButton.styleFrom(
                                        padding: EdgeInsetsDirectional.symmetric(vertical: 13,horizontal: 15),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        side: BorderSide(color: MyColors.purple),
                                        textStyle: TextStyle(color: MyColors.purple),
                                        foregroundColor: MyColors.purple,
                                      ),
                                      child: Text('cancel')
                                  ),
                                ),
                              ],
                            )

                          ],
                        ),
                  )
              )
            ],
          ),
        ),
      ),

    );
  }
}


