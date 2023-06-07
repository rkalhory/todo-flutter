
class Todo {

  String title;
  String description;
  bool complete;

  Todo({required this.title,required this.description,required this.complete});

  factory Todo.fromMap(Map<String,dynamic> val){
    return Todo(
        title:val['title'],
        description:val['description'],
        complete:val['complete'],
    );
  }

}