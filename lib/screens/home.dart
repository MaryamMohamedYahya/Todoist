import 'package:flutter/material.dart';
import 'package:todoist/screens/task_details.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoist/models/task.dart';
import 'package:todoist/screens/add_task.dart';
import 'package:todoist/services/firestore_service.dart';

class HomePage extends StatefulWidget {
   const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  final FirestoreService _firestoreService = FirestoreService();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todoist",
        style: GoogleFonts.sansita(
          fontSize: 27,
          fontWeight: FontWeight.bold,
        ),
        ),
      ),
      body: StreamBuilder<List<Tasks>>(
        stream: _firestoreService.getTasks(),
        builder: (context,snapshot){

          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }



          final tasks = snapshot.data!;
          if(tasks.isEmpty){
            return const Center(
              child: Text("No tasks"),
            );
          }
          return ListView.builder(itemCount:tasks.length,itemBuilder: (context, index){
            return ListTile(
              title: Text(tasks[index].title),
              subtitle: Text(tasks[index].description),
              leading: Checkbox(
                value: tasks[index].isDone,
                onChanged: (value) {
                  _firestoreService.updateTask(tasks[index].id, value!);
                },
              ),
              trailing: IconButton(onPressed: (){
                _firestoreService.deleteTask(tasks[index].id);
              }, 
              icon: Icon(Icons.delete)),


              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskDetails(
                      task: tasks[index],
                    ),
                  ),
                );
              },
            );
          },);
        }),
    floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => AddTask(),
            ),
          );
  
        }),
    );
  }
}