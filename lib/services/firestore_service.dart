import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoist/models/task.dart';
class FirestoreService {
  final CollectionReference _taskCollection = FirebaseFirestore.instance.collection('tasks');


  //Fetch tasks
  Stream<List<Tasks>> getTasks(){
    return _taskCollection.snapshots().map(
      (snapshot){
        return snapshot.docs.map((doc){
        return Tasks.fromMap(doc.data() as Map<String, dynamic>,doc.id);
        }).toList();

      }
    );
  }


  //Add tasks
  Future<void> addTask(Tasks task) async{
    await _taskCollection.add(task.toMap());
  }

  //Update Tasks
  Future<void> updateTask(String id, bool isDone) async{
    await _taskCollection.doc(id).update({"isDone":isDone});
  }

  //Delete tasks
  Future<void> deleteTask(String id) async{
    await _taskCollection.doc(id).delete();
  }
}
