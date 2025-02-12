// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import '../models/todo_model.dart';
//
// class TodoProvider extends ChangeNotifier {
//
//   final _auth = FirebaseAuth.instance;
//   late CollectionReference _collectionReference;
//
//   TodoProvider() {
//     _auth.authStateChanges().listen((User? user) {
//       if (user != null) {
//         _collectionReference = FirebaseFirestore.instance.collection(user.uid);
//         notifyListeners();
//       }
//     });
//   }
//
//
//   Future<void> add(TodoModel todo) async {
//     await _collectionReference.doc(todo.uid).set(todo.toJson());
//     notifyListeners();
//   }
//
//   Future<void> delete(String uid) async {
//       await _collectionReference.doc(uid).delete();
//       notifyListeners();
//   }
//
//
//   Future<void> update(String uid, TodoModel todo) async {
//       await _collectionReference.doc(uid).update(todo.toJson());
//       notifyListeners();
//   }
//
//
//   // Stream<List<TodoModel>> readData() {
//   //   return _collectionReference.snapshots().map((snapshot) {
//   //     return snapshot.docs.map((doc) {
//   //       return TodoModel.fromJson(doc.data() as Map<String, dynamic>);
//   //     }).toList();
//   //   });
//   //   }
//
//   Stream<List<TodoModel>> readData() {
//     if (_collectionReference == null) {
//       return const Stream.empty(); // Return an empty stream if not initialized
//     }
//     return _collectionReference.snapshots().map((snapshot) {
//       return snapshot.docs.map((doc) {
//         return TodoModel.fromJson(doc.data() as Map<String, dynamic>);
//       }).toList();
//     });
//   }
//
//
//
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  late CollectionReference _collectionReference;
  List<TodoModel> _todoList = [];

  TodoProvider() {
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        _collectionReference = FirebaseFirestore.instance.collection(user.uid);
        // Listen to changes in the collection and update _todoList
        _collectionReference.snapshots().listen((snapshot) {
          _todoList = snapshot.docs.map((doc) {
            return TodoModel.fromJson(doc.data() as Map<String, dynamic>);
          }).toList();
          notifyListeners();
        });
      }
    });
  }

  List<TodoModel> get todoList => _todoList;

  Future<void> add(TodoModel todo) async {
    await _collectionReference.doc(todo.uid).set(todo.toJson());
    notifyListeners();
  }

  Future<void> delete(String uid) async {
    await _collectionReference.doc(uid).delete();
    notifyListeners();
  }

  Future<void> update(String uid, TodoModel todo) async {
    await _collectionReference.doc(uid).update(todo.toJson());
    notifyListeners();
  }

  // Stream<List<TodoModel>> readData() {
  //   return _collectionReference.snapshots().map((snapshot) {
  //     return snapshot.docs.map((doc) {
  //       return TodoModel.fromJson(doc.data() as Map<String, dynamic>);
  //     }).toList();
  //   });
  // }

  Stream<List<TodoModel>> readData() {
    if (_collectionReference == null) {
      return const Stream.empty(); // Return an empty stream if not initialized
    }
    return _collectionReference.orderBy('editedOn',descending: true).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return TodoModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
