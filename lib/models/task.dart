class Tasks{
  // String id;
  String title;
  String description;
  bool isDone;

  Tasks({required this.title, required this.description, this.isDone=false});
  Map<String, dynamic> toMap(){
    return {
      // 'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
    };
  }



}