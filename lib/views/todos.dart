import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/constant.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/views/custom_widgets/my_listile.dart';
import 'package:todo_app/views/form.dart';

class Todos extends StatefulWidget {
  const Todos({Key? key,this.formValue,this.index}) : super(key: key);

  final Map<String,dynamic>? formValue;
  final int? index;

  @override
  State<Todos> createState() => _TodosState();
}

class _TodosState extends State<Todos> {

  // @override
  // void didChangeDependencies(){
  //   if(widget.formValue!=null){
  //     print(widget.index);
  //     if(widget.index!=null){
  //       print('if');
  //       setState(() {
  //
  //       todoList[widget.index!]=Todo.fromMap(widget.formValue!);
  //       });
  //     }else{
  //       print('else');
  //       setState(() {
  //
  //       todoList.add(Todo.fromMap(widget.formValue!));
  //       });
  //     }
  //   }
  // }

  @override
  void initState() {
    _initSh();
    super.initState();
  }

  SharedPreferences? prefs;

  void _initSh() async {
    prefs = await SharedPreferences.getInstance();
    List<Todo>? temp=prefs?.getStringList('list')?.map((e) => Todo.fromMap(json.decode(e))).toList();
    print('temp................ $temp');
    setState(() {
      if(temp!=null) todoList=temp;
    });
  }

  static List<Todo> todoList = [
    {
      'title':'Default Item 1',
      'description':'This is a test case.',
      'complete':false
    },
    {
      'title':'Default Item 2',
      'description':'This is a test case.This is a test case.This is a test case.This is a test case.This is a test case.',
      'complete':true
    },
  ].map<Todo>((e)=>Todo.fromMap(e)).toList();

  void addNew(Todo value){
    setState(() {
      todoList.add(value);
      prefs?.setStringList('list', todoList.map((e) => json.encode(e.toJson())).toList());
    });
  }

  void remove(int index){
    setState(() {
      todoList.removeAt(index);
      prefs?.setStringList('list', todoList.map((e) => json.encode(e.toJson())).toList());
    });
  }

  void edit(int index){
    Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => FormTodo(
      index:index,
      item:todoList[index]
    ),)).then((value) => {
      setState((){
        todoList[value[0]]=value[1];
        prefs?.setStringList('list', todoList.map((e) => json.encode(e.toJson())).toList());
      })
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
       Column(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom:0,end:10,start:10,top:65),
              child: Text('Todo List',style:TextStyle(fontSize: 30,color: MyColors.text_color1,fontWeight:FontWeight.w600) ,),
            ),
            Expanded(
              child:
                ListView.builder(
                  itemCount: todoList.length,
                  itemBuilder: (context,index)=>
                      Padding(
                        padding: const EdgeInsetsDirectional.only(bottom:15,end:15,start:15,top:0),
                        child: MyLisTile(
                          index: index,
                          item:todoList[index],
                          remove:this.remove,
                          edit:this.edit,
                          ),
                      ),
                  ),
                ),
          ],
        ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final newItem= await Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => FormTodo(),));
          addNew(newItem[1]);
        },
        backgroundColor: MyColors.purple,
        tooltip: 'Add New',
        icon: const Icon(Icons.add),
        label: const Text('Add New'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
