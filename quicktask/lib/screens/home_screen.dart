import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quicktask/reuse_widgets/my_app_bar.dart';
import 'package:quicktask/utility/loading_shimmer.dart';
import '../models/todo_model.dart';
import '../providers/todo_provider.dart';
import '../utility/crud_operation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: MyAppBar(title: "Home",todoList: todoProvider.todoList,)
      ),
      body: SafeArea(
        child: StreamBuilder<List<TodoModel>>(
            stream: todoProvider.readData(),
            builder: (context, snapshot) {
          
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingShimmer();
              }
          
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return  const Center(child: Text("No todos available"));
              }
          
              final todos = snapshot.data!;
          
              return buildUI(todos, todoProvider);
          
            },
          ),
        ),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CrudOperation().takeInput(context);
        },
        child: const Icon(Icons.add),
      ),

    );
  }

  Widget buildUI(final todos,final todoProvider){
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return Dismissible(
          key: ValueKey(todo.uid),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 16),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          confirmDismiss: (direction) async {
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Confirm Deletion"),
                  content: const Text("Are you sure you want to delete this task?"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                        todoProvider.delete(todo.uid);
                      },
                      child: const Text("Delete"),
                    ),
                  ],
                );
              },
            );
            return null;
          },
          onDismissed: (direction) {
            todoProvider.delete(todo.uid);
          },
          child: Card(
            elevation: 5,
            margin: const EdgeInsets.all(5),
            child: ListTile(
              title: Text(todo.title.toString()),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(todo.notes.toString()),
                  Text(DateFormat('dd/MM/yyyy').format(todo.editedOn?.toDate() ?? DateTime.now()),style: const TextStyle(color: Colors.pink),),
                ],
              ),
              trailing: IconButton(onPressed: (){
                CrudOperation().updateData(context, todo.uid);
              }, icon: const Icon(Icons.edit),),
            ),
          ),
        );
      },
    );
  }

}
