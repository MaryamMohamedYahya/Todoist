import 'package:flutter/material.dart';
import 'package:todoist/screens/task_details.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoist/models/task.dart';
import 'package:todoist/screens/add_task.dart';

class HomePage extends StatefulWidget {
   const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Tasks> _tasks=[];

  void addTasks(task){
    setState(() {
      _tasks.add(task);
    });

   
  }
  void deleteTasks(task){
    setState(() {
      _tasks.remove(task); 
    });


  }

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
      body: _tasks.isEmpty ? 
      Center(
        child: Text(
          "No tasks added yet!",
          style: GoogleFonts.sansita(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ) ,
        ),
      ) : ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: (){
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context)=>TaskDetails(
                    task: _tasks[index],
                  ),
                ),
              );
            },
            leading: Checkbox(
              value: _tasks[index].isDone, 
              onChanged: (value) {
                setState(() {
                  _tasks[index].isDone = value!;          
                });
              },
            ),
            title: Text(
              _tasks[index].title,
              style: GoogleFonts.sansita(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing:IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                deleteTasks(_tasks[index]);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()async {
        final newtasks = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddTask(),
          ),
        );

        if (newtasks != null){
          addTasks(newtasks);
        }
      }),
    );
  }
}