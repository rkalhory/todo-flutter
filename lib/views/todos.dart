import 'package:flutter/material.dart';
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

  @override
  void didChangeDependencies(){
    if(widget.formValue!=null){
      print(widget.index);
      if(widget.index!=null){
        print('if');
        setState(() {

        todoList[widget.index!]=Todo.fromMap(widget.formValue!);
        });
      }else{
        print('else');
        setState(() {

        todoList.add(Todo.fromMap(widget.formValue!));
        });
      }
    }
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

  void remove(int index){
    setState(() {
      todoList.removeAt(index);
    });
  }

  void edit(int index){
    Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => FormTodo(
      index:index,
      title: todoList[index].title,
      description: todoList[index].description,
      complete: todoList[index].complete,
    ),));
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
                          title: todoList[index].title,
                          subtitle: todoList[index].description,
                          complete: todoList[index].complete,
                          remove:this.remove,
                          edit:this.edit,
                          ),
                      ),
                  ),
                ),
          ],
        ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => FormTodo(),));
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
