
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

  // Map<String, dynamic> toJson() => {
  //   "title": title,
  //   "description": description,
  //   "complete": complete,
  // };

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    map['complete'] = complete;
    return map;
  }

}




/// title : ""
/// no : false

// class Todo {
//   Todo({
//     String? title,
//     bool? no,}){
//     _title = title;
//     _no = no;
//   }
//
//   Todo.fromJson(dynamic json) {
//     _title = json['title'];
//     _no = json['no'];
//   }
//   String? _title;
//   bool? _no;
//   Todo copyWith({  String? title,
//     bool? no,
//   }) => Todo(  title: title ?? _title,
//     no: no ?? _no,
//   );
//   String? get title => _title;
//   bool? get no => _no;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['title'] = _title;
//     map['no'] = _no;
//     return map;
//   }
//
// }




