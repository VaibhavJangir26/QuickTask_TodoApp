import 'package:cloud_firestore/cloud_firestore.dart';
class TodoModel{

  String uid;
  bool? isSave;
  String? title;
  String? notes;
  Timestamp? createdOn;
  Timestamp? editedOn;

  TodoModel({
    required this.uid,
    required this.isSave,
    required this.title,
    required this.notes,
    required this.createdOn,
    required this.editedOn,
  });

  factory TodoModel.fromJson(Map<String,dynamic> json){
    return TodoModel(
        uid: json['uid'],
        isSave: json['isSave'],
        title: json['title'],
        notes: json['notes'],
        createdOn: json['createdOn'],
        editedOn: json['editedOn']
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'uid': uid,
      'isSave': isSave,
      'title': title,
      'notes': notes,
      'createdOn': createdOn,
      'editedOn': editedOn,
    };
  }


}