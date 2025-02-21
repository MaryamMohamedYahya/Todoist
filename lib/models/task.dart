class Tasks{
  String id;
  String title;
  String description;
  bool isDone;

  Tasks({required this.id, required this.title, required this.description, this.isDone=false});
  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
    };
  }

  static Tasks fromMap(Map<String, dynamic> map, String docid){
    return Tasks(
      id: docid,
      title: map['title'],
      description: map['description'],
      isDone: map['isDone'],
    );
  }



}