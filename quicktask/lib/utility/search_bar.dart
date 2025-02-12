import 'package:flutter/material.dart';
import 'package:quicktask/models/todo_model.dart';

class MySearchBar extends SearchDelegate {
  final List<TodoModel> todoList;

  MySearchBar(this.todoList);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        query = "";
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<TodoModel> result = todoList.where((event) {
      String titleLower = event.title?.toLowerCase()?? '';
      String notesLower = event.notes?.toLowerCase()?? '';
      final queryLower = query.toLowerCase();
      return titleLower.contains(queryLower) || notesLower.contains(queryLower);
    }).toList();

    if (result.isEmpty) {
      return const Center(
        child: Text(
          "No matching todo found.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (context,index){
        final TodoModel suggest = result[index];
        return Card(
          child: ListTile(
            title: Text(suggest.title ?? 'No match found'),
            subtitle: Text(suggest.notes ?? 'No match found'),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    List<String> suggestionsItems = [  // this is our suggestion list
      "Good morning",
      "Playing",
      "Meeting",
      "Shopping",
      "Exercise"
    ];

    if (query.isEmpty) {
      return ListView.builder(
        itemCount: suggestionsItems.length,
        itemBuilder: (context,index){
          return ListTile(
              title: Text(suggestionsItems[index]),
              onTap: (){
                query = suggestionsItems[index];
                showResults(context);
              },
          );
        },
      );
    }

    List<TodoModel> suggestions = todoList.where((event) {
      String titleLower = event.title?.toLowerCase()??'';
      String notesLower = event.notes?.toLowerCase()??'';
      final queryLower = query.toLowerCase();
      return titleLower.contains(queryLower) || notesLower.contains(queryLower);
    }).toList();

    if (suggestions.isEmpty) {
      return const Center(
        child: Text("No matching todo found.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final TodoModel suggest = suggestions[index];
        return Card(
          child: ListTile(
            title: Text(suggest.title??'No match found'),
            subtitle: Text(suggest.notes??'No match found'),
            onTap: (){
              query=suggest.title??'';
              showResults(context);
            },
          ),
        );
      },
    );
  }


}

