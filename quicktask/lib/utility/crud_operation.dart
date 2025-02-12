import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/todo_model.dart';
import '../providers/todo_provider.dart';

class CrudOperation {
  TextEditingController titleController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  void takeInput(BuildContext context) async {
    var uuid = const Uuid();
    final uid = uuid.v4();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add your task"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: titleController,
                enableIMEPersonalizedLearning: true,
                enableSuggestions: true,
                decoration: const InputDecoration(
                  hintText: "Title",
                ),
              ),
              TextFormField(
                controller: notesController,
                enableIMEPersonalizedLearning: true,
                enableSuggestions: true,
                decoration: const InputDecoration(
                  hintText: "Notes",
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          Consumer<TodoProvider>(
            builder: (context, value, child) {
              return TextButton(
                onPressed: () {
                  final todo = TodoModel(
                    uid: uid,
                    isSave: true,
                    title: titleController.text,
                    notes: notesController.text,
                    createdOn: Timestamp.now(),
                    editedOn: Timestamp.now(),
                  );
                  value.add(todo);
                  Navigator.pop(context);
                  titleController.clear();
                  notesController.clear();
                },
                child: const Text("Save"),
              );
            },
          ),
        ],
      ),
    );
  }

  void updateData(BuildContext context, String uid) {
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);

    // Show dialog to input new data
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit your task"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: titleController,
                enableIMEPersonalizedLearning: true,
                enableSuggestions: true,
                decoration: const InputDecoration(
                  hintText: "Title",
                ),
              ),
              TextFormField(
                controller: notesController,
                enableIMEPersonalizedLearning: true,
                enableSuggestions: true,
                decoration: const InputDecoration(
                  hintText: "Notes",
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          Consumer<TodoProvider>(
            builder: (context, value, child) {
              return TextButton(
                onPressed: () {
                  final updatedTodo = TodoModel(
                    uid: uid,
                    isSave: true,
                    title: titleController.text,
                    notes: notesController.text,
                    createdOn: Timestamp.now(), // Assume createdOn is now for simplicity
                    editedOn: Timestamp.now(),
                  );
                  value.update(uid, updatedTodo);
                  Navigator.pop(context);
                  titleController.clear();
                  notesController.clear();
                },
                child: const Text("Update"),
              );
            },
          ),
        ],
      ),
    );
  }

}
