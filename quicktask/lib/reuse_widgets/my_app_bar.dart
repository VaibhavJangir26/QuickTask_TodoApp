import 'package:flutter/material.dart';
import 'package:quicktask/utility/search_bar.dart';
import '../models/todo_model.dart';



class MyAppBar extends StatefulWidget {
  const MyAppBar({super.key, required this.title,required this.todoList});
  final String title;
  final List<TodoModel> todoList;
  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {

  @override
  Widget build(BuildContext context) {

    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      centerTitle: true,
      title: Text(widget.title),
      actions: [

        Container(
          width: 150,
          height: 42,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor,
            borderRadius: BorderRadius.circular(15)
          ),

          child: InkWell(
            onTap: ()=>showSearch(context: context,delegate: MySearchBar(widget.todoList)),
            child: const Row(
              children: [
                SizedBox(width: 8,),
                Icon(Icons.search,size: 32,),
                SizedBox(width: 12,),
                Text("Search",textAlign: TextAlign.center,style: TextStyle(fontSize: 18),)
              ],
            ),
          ),

        ),
      ],
    );
  }
}
