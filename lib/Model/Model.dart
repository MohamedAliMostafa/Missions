
class TaskModel
{
  String id;
  String title ;
  String description;
  bool status;
  String Userid;
  int date;


  TaskModel({this.id=" ", required this.title, required this.description, required this.status, required this.Userid,
      required this.date});

  static TaskModel FromJson(Map<String ,dynamic>json)
  {
    TaskModel taskModel=TaskModel(id:json['id'],title: json['title'], description: json['description'], status: json['status'], date: json['date'], Userid: json['Userid']);
    return taskModel;
  }

   Map<String,dynamic>toJson()
  {
   return{
     "id":id,
     "title":title,
     "description":description,
     "status":status,
     "date":date,
     "Userid":Userid,
   };
  }


}