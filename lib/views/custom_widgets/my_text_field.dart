import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  MyTextField({Key? key,required this.controller,required this.text,this.line,this.value}) : super(key: key);

  final TextEditingController controller;
  final String text;
  final int? line;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        maxLines: line??1,
        validator: (value){
          if(value!.isEmpty){
            return 'This field is required';
          }
        },
        decoration:InputDecoration (
          label: Text(text??''),
          border: OutlineInputBorder(borderSide: BorderSide()),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
