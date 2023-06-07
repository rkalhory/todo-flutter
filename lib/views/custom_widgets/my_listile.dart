import 'package:flutter/material.dart';
import 'package:todo_app/core/constant.dart';

class MyLisTile extends StatelessWidget {
  const MyLisTile({
    Key? key,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.complete,
    required this.remove,
    required this.edit,
  }) : super(key: key);

  final int index;
  final String title;
  final String subtitle;
  final bool complete;

  final Function remove;
  final Function edit;


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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width:50,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(end: 10),
                    child: CircleAvatar(
                        backgroundColor: complete?MyColors.green:MyColors.red,
                        child: Icon(
                          color: Colors.white,
                            complete?Icons.check:Icons.close
                        ),

                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width-200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,style: TextStyle(fontSize: 16,color: MyColors.text_color1,fontWeight: FontWeight.w600),),
                      SizedBox(height: 7,),
                      Text(subtitle,style: TextStyle(fontSize: 15,color: MyColors.text_color2,overflow:TextOverflow.ellipsis ),),
                    ],
                  ),
                ),
              ],
            ),
          SizedBox(
            width: 100,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed:()=>edit(index), icon: Icon(Icons.edit,color: Colors.blue,)),
                IconButton(onPressed:()=>remove(index), icon: Icon(Icons.remove_circle,color: Colors.red)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
